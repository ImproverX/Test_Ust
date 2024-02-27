	.ORG    00100h
M_0000:	.equ    00000h
M_0001:	.equ    00001h
M_0002:	.equ    00002h
M_000A:	.equ    0000Ah
M_0010:	.equ    00010h
M_0038:	.equ    00038h
M_0039:	.equ    00039h
M_0080:	.equ    00080h
M_STEK:	.equ    07000h
M_8000:	.equ    08000h
M_E000:	.equ    0E000h
M_FFFF:	.equ    0FFFFh
;
L_0100:	DI
	MVI  A, 0C3h
	STA     M_0000	; ?
	LXI  H, L_0100
	SHLD    M_0001	; ?
	SPHL		;LXI  SP,L_0100
	XRA  A		;MVI  A, 000h
	OUT     010h
	OUT     011h
	MVI  A, 022h
	OUT     00Dh	; для ПК-6128ц
	OUT     00Eh
	CALL    L_0120
	JMP     L_2000
;
	.ORG	00120h
;
L_0120:	JMP     L_0622	; @INIT
;;L_0123:	JMP     L_0BA0	; @KEY -- не используется
L_0126:	JMP     L_0ADB	; @INTAP ввод байта с магнитной ленты
L_0129:	JMP     L_07EC	; @CONOUT вывод символа на дисплей
L_012C:	JMP     L_0B30	; @OUTAP вывод байта на магнитную ленту
L_012F:	JMP     L_0214	; @LIST вывод символа на печать
L_0132:	JMP     L_0B5E	; @CONIN ввод символа с клавиатуры
L_0135:	JMP     L_01C3	; @DUMP вывод содержимого регистра A в шестнадцатеричном виде
L_0138:	JMP     L_01B0	; @SPIC вывод сообщения по адресу, определенному регистрами H и L
L_013B:	JMP     L_0B7D	; @INKEY ввод символа с клавиатуры без ожидания ввода
L_013E:	JMP     L_050E	; @PLOT
L_0141:	JMP     L_052B	; @LINE
L_0144:	JMP     L_0FB5	; @CIRCLE
L_0147:	JMP     L_0F96	; @PCIRCLE
;;L_014A:	JMP     L_14F6	; @GET -- не используется
;;L_014D:	JMP     L_15AE	; @PUT -- не используется
L_0150:	JMP     L_025B	; @PAINT
L_0153:	JMP     L_01EF	; @PGET определение цвета текущей точки
L_0156:	JMP     L_04F9	; @COLOR
L_0159:	JMP     L_04F1	; @FON
L_015C:	JMP     L_04F5	; @BORD
;;L_015F:	JMP     L_019C	; @SCROL -- не используется
L_0162:	JMP     L_0481	; @PLAY
L_0165:	JMP     L_047D	; @FPLAY
L_0168:	JMP     L_0DEE	; @PLOFF
;;L_016B:	JMP     L_01E3	; @TIME -- не используется
;;L_016E:	JMP     L_019B	; @MASC -- не используется
L_0171:	JMP     L_165D	; @EADD сложение двоичных чисел -- не используется
;;L_0174:	JMP     L_1673	; @ESUB -- не используется
L_0177:	JMP     L_1695	; @EMULT умножение двоичных чисел -- не используется
L_017A:	JMP     L_16DC	; @EDIVM деление двоичных чисел
L_017D:	JMP     L_166B	; @ESIGN определение знака двоичного числа -- не используется
;;L_0180:	JMP     L_1744	; @DECBIN -- не используется
L_0183:	JMP     L_179C	; @BINDEC преобразование двоичного числа в строку
L_0186:	JMP     L_1657	; @CMPHD -- не используется
L_0189:	JMP     L_033E	; @SCOLOR установка физических цветов
L_018C:	JMP     L_036B	; @SPLAN установка экранных областей
L_018F:	JMP     L_14C8	; @SCONR установка скорости обмена информацией с магнитной лентой
L_0192:	JMP     L_03DC	; @SLIST установка типа принтера
L_0195:	JMP     L_03E2	; @LSCR печать экрана в графическом режиме
;;L_0198:	JMP     L_0354	; ??? -- не используется
;;;
;;L_019B:	RET		; << L_016E
;;;
;;L_019C:	PUSH PSW	; << L_015F
;;	PUSH B
;;	MOV  C, A
;;	LDA     D_1A8A
;;	ADD  C
;;	STA     D_1A8A
;;	LDA     D_1C13
;;	ADD  C
;;	STA     D_1C13
;;	POP  B
;;	POP  PSW
;;	RET
;
L_01B0:	PUSH B		; << L_0138
	PUSH PSW
	CALL    L_01B8
	POP  PSW
	POP  B
	RET
;
L_01B8:	MOV  A, M
	ANA  A
	RZ
	MOV  C, A
	CALL    L_07EC
	INX  H
	JMP     L_01B8
;
L_01C3:	PUSH B		; << L_0135
	PUSH PSW
	CALL    L_01CB
	POP  PSW
	POP  B
	RET
;
L_01CB:	MOV  B, A
	RLC
	RLC
	RLC
	RLC
	CALL    L_01D4
	MOV  A, B
L_01D4:	ANI     00Fh
L_01D6:	CPI     00Ah
	JM      L_01DD
	ADI     007h
L_01DD:	ADI     030h
	MOV  C, A
	JMP     L_07EC
;
;;L_01E3:	ANA  A		; << L_016B
;;	JZ      L_01EB
;;	SHLD    D_1A88
;;	RET
;;;
;;L_01EB:	LHLD    D_1A88
;;	RET
;
L_01EF:	PUSH H		; << L_0153
	PUSH B
	LDA     D_1C36
	MOV  L, A
	LDA     D_1C38
	MOV  H, A
	CALL    L_02F8
	POP  B
	POP  H
	RET
;
L_01FF:	PUSH PSW
L_0200:	IN      005h
	ANI     001h
	JNZ     L_0200
	MOV  A, C
	OUT     007h
	MVI  A, 0EFh
	OUT     005h
	MVI  A, 0FFh
	OUT     005h
	POP  PSW
	RET
;
L_0214:	PUSH H		; << L_012F
	PUSH D
	PUSH B
	PUSH PSW
	MOV  A, C
	CPI     060h
	JC      L_0233
	LDA     D_1C18
	CPI     001h
	MOV  A, C
	JNZ     L_0233
	LXI  H, D_023B
	MVI  D, 000h
	ANI     07Fh
	SUI     060h
	MOV  E, A
	DAD  D
	MOV  C, M
L_0233:	CALL    L_01FF
	POP  PSW
	POP  B
	POP  D
	POP  H
	RET
;
D_023B:	.db 0C0h	; "└" - |■■      | (offset 023Bh)
	.db 0A1h	; "б" - |■ ■    ■| (offset 023Ch)
	.db 0A2h	; "в" - |■ ■   ■ | (offset 023Dh)
	.db 0B8h	; "╕" - |■ ■■■   | (offset 023Eh)
	.db 0A5h	; "е" - |■ ■  ■ ■| (offset 023Fh)
	.db 0A6h	; "ж" - |■ ■  ■■ | (offset 0240h)
	.db 0B6h	; "╢" - |■ ■■ ■■ | (offset 0241h)
	.db 0A4h	; "д" - |■ ■  ■  | (offset 0242h)
	.db 0B7h	; "╖" - |■ ■■ ■■■| (offset 0243h)
	.db 0AAh	; "к" - |■ ■ ■ ■ | (offset 0244h)
	.db 0ABh	; "л" - |■ ■ ■ ■■| (offset 0245h)
	.db 0ACh	; "м" - |■ ■ ■■  | (offset 0246h)
	.db 0ADh	; "н" - |■ ■ ■■ ■| (offset 0247h)
	.db 0AEh	; "о" - |■ ■ ■■■ | (offset 0248h)
	.db 0AFh	; "п" - |■ ■ ■■■■| (offset 0249h)
	.db 0B0h	; "░" - |■ ■■    | (offset 024Ah)
	.db 0B1h	; "▒" - |■ ■■   ■| (offset 024Bh)
	.db 0C1h	; "┴" - |■■     ■| (offset 024Ch)
	.db 0B2h	; "▓" - |■ ■■  ■ | (offset 024Dh)
	.db 0B3h	; "│" - |■ ■■  ■■| (offset 024Eh)
	.db 0B4h	; "┤" - |■ ■■ ■  | (offset 024Fh)
	.db 0B5h	; "╡" - |■ ■■ ■ ■| (offset 0250h)
	.db 0A8h	; "и" - |■ ■ ■   | (offset 0251h)
	.db 0A3h	; "г" - |■ ■   ■■| (offset 0252h)
	.db 0BEh	; "╛" - |■ ■■■■■ | (offset 0253h)
	.db 0BDh	; "╜" - |■ ■■■■ ■| (offset 0254h)
	.db 0A9h	; "й" - |■ ■ ■  ■| (offset 0255h)
	.db 0BAh	; "║" - |■ ■■■ ■ | (offset 0256h)
	.db 0BFh	; "┐" - |■ ■■■■■■| (offset 0257h)
	.db 0BBh	; "╗" - |■ ■■■ ■■| (offset 0258h)
	.db 0B9h	; "╣" - |■ ■■■  ■| (offset 0259h)
	.db 05Fh	; "_" - | ■ ■■■■■| (offset 025Ah)
;
L_025B:	PUSH H		; << L_0150
	PUSH D
	PUSH B
	PUSH PSW
	LDA     D_036A
	MOV  L, A
	MOV  A, E
	ANI     00Fh
	ANA  L
	STA     D_1C10
	MOV  A, D
	ANI     00Fh
	ANA  L
	STA     D_1C0F
	MOV  E, A
	CALL    L_0774
	LXI  D, L_027F
	PUSH D
	LXI  D, L_0284
	PUSH B
	PUSH D
	RET
;
L_027F:	POP  PSW
	POP  B
	POP  D
	POP  H
	RET
;
L_0284:	POP  H
	CALL    L_02F8
	RZ
	PUSH H
	CALL    L_0334
L_028D:	DCR  L
	CALL    L_02F8
	CNZ     L_0334
	JNZ     L_028D
	INR  L
	SHLD    D_1C39
	POP  H
L_029C:	INR  L
	CALL    L_02F8
	CNZ     L_0334
	JNZ     L_029C
	DCR  L
	SHLD    D_1C3B
	LDA     D_1C39
	MOV  D, A
	INR  H
	MVI  E, 000h
L_02B1:	CALL    L_02F8
	JZ      L_02CC
	XRA  A
	CMP  E
	JNZ     L_02C3
	LXI  B, L_0284
	PUSH H
	PUSH B
	MVI  E, 001h
L_02C3:	MOV  A, L
	CMP  D
	JZ      L_02D1
	DCR  L
	JMP     L_02B1
;
L_02CC:	MVI  E, 000h
	JMP     L_02C3
;
L_02D1:	LHLD    D_1C3B
	DCR  H
	MVI  E, 000h
L_02D7:	CALL    L_02F8
	JZ      L_02F2
	XRA  A
	CMP  E
	JNZ     L_02E9
	LXI  B, L_0284
	PUSH H
	PUSH B
	MVI  E, 001h
L_02E9:	MOV  A, L
	CMP  D
	JZ      L_02F7
	DCR  L
	JMP     L_02D7
;
L_02F2:	MVI  E, 000h
	JMP     L_02E9
;
L_02F7:	RET
;
L_02F8:	PUSH D
	PUSH H
	MOV  C, L
	MOV  L, H
	MVI  B, (D_1D00 / 0100h)	; 01Dh
	LDAX B
	MOV  H, A
	INR  B
	LDAX B
	MOV  B, A
	LXI  D, 02000h	;+
	MVI  C, 000h
	ANA  M
	JZ      L_030E
X_030C:	MVI  C, 008h
L_030E:	DAD  D
	MOV  A, B
	ANA  M
	JZ      L_0318
L_0314:	INR  C
L_0315:	INR  C
L_0316:	INR  C
L_0317:	INR  C
L_0318:	DAD  D
	MOV  A, B
	ANA  M
	JZ      L_0320
L_031E:	INR  C
L_031F:	INR  C
L_0320:	DAD  D
	MOV  A, B
	ANA  M
	JZ      L_0327
L_0326:	INR  C
L_0327:	MOV  A, C
	LXI  H, D_1C0F
	CMP  M
	JZ      L_0331
	INX  H
	CMP  M
L_0331:	POP  H
	POP  D
	RET
;
L_0334:	PUSH PSW
	PUSH H
	MOV  C, L
	MOV  L, H
	CALL    L_07B4
	POP  H
	POP  PSW
	RET
;
L_033E:	PUSH H		; << L_0189
	PUSH D
	PUSH B
	PUSH PSW
	MVI  C, 010h
	LXI  H, D_0BB1
L_0347:	LDAX D
	MOV  M, A
	INX  D
	INX  H
	DCR  C
	JNZ     L_0347
	POP  PSW
	POP  B
	POP  D
	POP  H
	RET
;
;;L_0354:	PUSH H		; << L_0198
;;	PUSH D
;;	PUSH B
;;	PUSH PSW
;;	MVI  C, 008h
;;	LXI  H, D_1800
;;L_035D:	LDAX D
;;	MOV  M, A
;;	INX  D
;;	INX  H
;;	DCR  C
;;	JNZ     L_035D
;;	POP  PSW
;;	POP  B
;;	POP  D
;;	POP  H
;;	RET
;;;
D_036A:	.db 00Fh	; "_" - |    ■■■■| (offset 036Ah)
;
L_036B:	PUSH B		; << L_018C
	PUSH PSW
	ANI     00Fh
	MOV  B, A
	STA     D_036A
	CALL    L_03D2
	STA     L_07EA
	STA     L_07CF
	STA     L_0955
	JNC     L_0384
	MVI  A, 00Ch
L_0384:	STA     L_0326
	CALL    L_03D2
	STA     L_07E6
	STA     L_07CA
	STA     L_0950
	JNC     L_0398
	MVI  A, 00Ch
L_0398:	STA     L_031E
	STA     L_031F
	CALL    L_03D2
	STA     L_07E2
	STA     L_07C5
	STA     L_094B
	JNC     L_03AF
	MVI  A, 00Ch
L_03AF:	STA     L_0314
	STA     L_0315
	STA     L_0316
	STA     L_0317
	CALL    L_03D2
	STA     L_07DE
	STA     L_07C0
	STA     L_0946
	JNC     L_03CC
	MVI  A, 008h
L_03CC:	STA     X_030C+1
	POP  PSW
	POP  B
	RET
;
L_03D2:	MOV  A, B
	RRC
	MOV  B, A
	MVI  A, 077h
	JC      L_03DB
	XRA  A
L_03DB:	RET
;
L_03DC:	ANI     001h	; << L_0192
	STA     D_1C18
	RET
;
L_03E2:	PUSH H		; << L_0195
	PUSH D
	PUSH B
	PUSH PSW
	ANI     00Fh
	STA     D_0432
	LDA     D_1C18
	PUSH PSW
	MVI  D, 020h
	MVI  E, 000h
L_03F3:	LDA     D_1A8A
	SUB  E
	STA     D_1C38
	CALL    L_0436
	XRA  A
L_03FE:	STA     D_1C36
	PUSH PSW
	CALL    L_0445
	MOV  C, H
	CALL    L_01FF
	MOV  C, L
	CALL    L_01FF
	POP  PSW
	INR  A
	JNZ     L_03FE
	MOV  A, E
	ADI     008h
	MOV  E, A
	DCR  D
	JNZ     L_03F3
	MVI  C, 01Bh
	CALL    L_01FF
	MVI  C, 032h
	CALL    L_01FF
	POP  PSW
	POP  PSW
	POP  B
	POP  D
	POP  H
	RET
;
D_042B:	.db 00Dh, 00Ah
	.db 01Bh, 041h
	.db 008h
	.db 01Bh, 02Ah
D_0432:	.db 001h
	.db 000h
	.db 002h
	.db 0FFh
;
L_0436:	LXI  H, D_042B
L_0439:	MOV  A, M
	CPI     0FFh
	RZ
	MOV  C, A
	CALL    L_01FF
	INX  H
	JMP     L_0439
;
L_0445:	PUSH D
	LDA     D_1C38
	PUSH PSW
	LXI  D, L_0880
	LXI  H, M_0000	; ?
L_0450:	PUSH D
	CALL    L_01EF
	POP  D
	CPI     000h
	JZ      L_0467
	PUSH PSW
	MOV  A, H
	ORA  E
	MOV  H, A
	POP  PSW
	CPI     007h
	JC      L_0467
	MOV  A, L
	ORA  E
	MOV  L, A
L_0467:	MOV  A, E
	STC
	CMC
	RAR
	MOV  E, A
	LDA     D_1C38
	DCR  A
	STA     D_1C38
	DCR  D
	JNZ     L_0450
	POP  PSW
	STA     D_1C38
	POP  D
	RET
;
L_047D:	LDA     D_1A8B	; << L_0165
	RET
;
	; /// PLAY переключить на АУ
L_ToAY:	LXI H,	L_AYPL
	SHLD	X_0F17+1
	LXI H,	D_NAY
	SHLD	X_0EA4+1
	MVI  A, 007h	; включение AY
	OUT     015h
	MVI  A, 038h
	OUT     014h
	RET
;
	; /// PLAY переключить на ВИ
L_ToVI:	LXI H,	L_0F4A
	SHLD	X_0F17+1
	LXI H,	D_0DD4
	SHLD	X_0EA4+1
	MVI  A, 007h	; выключение AY
	OUT     015h
	MVI  A, 03Fh
	OUT     014h
	RET
;
L_0481:	PUSH H		; << L_0162 (PLAY)
	PUSH D
	PUSH B
	PUSH PSW
	PUSH H
	PUSH D
	PUSH B
	POP  H
	LXI  D, M_0000	; ?
	CALL    L_1657
	LXI  D, D_1A8F
	MVI  C, 001h
	DI
	CNZ     L_04BC
	POP  H
	LXI  D, M_0000	; ?
	CALL    L_1657
	LXI  D, D_1B0F
	MVI  C, 002h
	CNZ     L_04BC
	POP  H
	LXI  D, M_0000	; ?
	CALL    L_1657
	LXI  D, D_1B8F
	MVI  C, 004h
	CNZ     L_04BC
	EI
	POP  PSW
	POP  B
	POP  D
	POP  H
	RET
;
L_04BC:	LDA     D_1A8B
	ORA  C
	STA     D_1A8B
	PUSH H
	LXI  H, D_1A8C
	DCR  C
	JNZ     L_04CD
	MVI  M, 000h
L_04CD:	INX  H
	DCR  C
	JNZ     L_04D4
	MVI  M, 000h
L_04D4:	INX  H
	DCR  C
	DCR  C
	JNZ     L_04DC
	MVI  M, 000h
L_04DC:	POP  H
	MVI  C, 080h
L_04DF:	MOV  A, M
	CPI     020h
	JNZ     L_04E9
	INX  H
	JMP     L_04DF
;
L_04E9:	STAX D
	INX  H
	INX  D
	DCR  C
	JNZ     L_04DF
	RET
;
L_04F1:	STA     D_0BB1	; << L_0159
	RET
;
L_04F5:	STA     D_0D50	; << L_015C
	RET
;
L_04F9:	PUSH PSW	; << L_0156
	PUSH D
	PUSH PSW
	ANI     0F0h
	STA     D_1C61
	POP  PSW
	ANI     00Fh
	STA     D_0D51
	MOV  E, A
	CALL    L_0774
	POP  D
	POP  PSW
	RET
;
L_050E:	PUSH PSW	; << L_013E
	PUSH D
	PUSH B
	CPI     002h
	STA     D_052A
	JZ      L_051E
	MOV  E, A
	MOV  A, B
	CALL    L_064C
L_051E:	MOV  A, B
	STA     D_1C38
	MOV  A, C
	STA     D_1C36
	POP  B
	POP  D
	POP  PSW
	RET
;
D_052A:	.db 001h	; "_" - |       ■| (offset 052Ah)
;
L_052B:	PUSH PSW	; << L_0141
	PUSH D
	PUSH B
	CALL    L_0535
	POP  B
	POP  D
	POP  PSW
	RET
;
L_0535:	MOV  D, A
	MOV  A, B
	PUSH PSW
	MOV  A, D
	CPI     000h
	JZ      L_055E
	CPI     002h
	JZ      L_058F
	CPI     001h
	JZ      L_0563
	POP  PSW
	STA     D_1C2F
	MOV  A, C
	STA     D_1C2E
	MVI  A, 0C3h	; JMP
	STA     L_07EC
	PUSH H
	LXI  H, L_0D53
	SHLD    L_07ED
	POP  H
	RET
;
L_055E:	POP  PSW
L_055F:	CALL    L_0677
	RET
;
L_0563:	POP  PSW
	MOV  B, A
	PUSH D
	LDA     D_1C36
	MOV  E, A
	LDA     D_1C38
	MOV  D, A
	PUSH B
	MOV  C, E
	MOV  A, B
	CALL    L_0677
	POP  B
	PUSH B
	MOV  A, B
	CALL    L_0677
	POP  B
	PUSH B
	MOV  A, D
	CALL    L_0677
	MOV  C, E
	CALL    L_0677
	POP  B
	MOV  A, B
	STA     D_1C38
	MOV  A, C
	STA     D_1C36
	POP  D
	RET
;
L_058F:	POP  PSW
	INX  H
L_0591:	PUSH H
	PUSH D
	PUSH PSW
	LXI  H, D_1C36
	MOV  D, A
	MOV  A, M
	CMP  C
	JZ      L_05E4
	LXI  H, D_1C38
	MOV  A, D
	SUB  M
	JZ      L_05E4
	JNC     L_05EA
	MOV  A, M
	SUB  D
	MOV  E, A
	MOV  A, M
L_05AC:	MOV  M, D
	LXI  H, D_1C36
	PUSH PSW
	MOV  A, C
	SUB  M
	JNC     L_05EF
	MOV  A, M
	SUB  C
	MOV  B, A
	MOV  M, C
L_05BA:	LDA     D_1C61
	STA     D_05F6
	LDA     D_0D51
	RLC
	RLC
	RLC
	RLC
	STA     D_1C61
	LDA     D_05E3
	CPI     000h
	JNZ     L_05D5
	STA     D_1C61
L_05D5:	POP  PSW
	CALL    L_05F7
	LDA     D_05F6
	STA     D_1C61
	POP  PSW
	POP  D
	POP  H
	RET
;
D_05E3:	.db 001h	; "_" - |       ■| (offset 05E3h)
;
L_05E4:	POP  PSW
	POP  D
	POP  H
	JMP     L_055F
;
L_05EA:	MOV  E, A
	MOV  A, D
	JMP     L_05AC
;
L_05EF:	MOV  B, A
	MOV  A, M
	MOV  M, C
	MOV  C, A
	JMP     L_05BA
;
D_05F6:	.db 000h	; "_" - |        | (offset 05F6h)
;
L_05F7:	INR  B
	INR  E
	PUSH D
	PUSH PSW
L_05FB:	CALL    L_0910
	MOV  D, A
	STC
	CMC
L_0601:	RAR
	INR  C
	DCR  B
	JC      L_0611
	JZ      L_0611
	PUSH PSW
	ADD  D
	MOV  D, A
	POP  PSW
	JMP     L_0601
;
L_0611:	MOV  A, D
	CALL    L_091A
	XRA  A
	CMP  B
	JZ      L_061F
	POP  PSW
	PUSH PSW
	JMP     L_05FB
;
L_061F:	POP  PSW
	POP  D
	RET
;
L_0622:	MVI  A, 081h	; << L_0120
	OUT     004h
	MVI  A, 0C3h
	STA     M_0038	; ?
	LXI  H, L_0BC1
	SHLD    M_0039	; ?
	EI
	LXI  B, D_1D00
	LXI  H, 08080h	; ?
L_0638:	MVI  D, 008h
L_063A:	MOV  A, H
	STAX B
	MOV  A, L
	INR  B
	STAX B
	DCR  B
	RRC
	MOV  L, A
	INR  C
	RZ
	DCR  D
	JNZ     L_063A
	INR  H
	JMP     L_0638
;
L_064C:	PUSH PSW
	PUSH D
	PUSH H
	STA     D_1C38
	MOV  A, E
	STA     D_05E3
	XRA  A
	CMP  E
	JNZ     L_066E
	LXI  H, L_07D1
	SHLD    X_076F+1
L_0661:	MVI  H, 000h
	MOV  L, C
	SHLD    D_1C36
	CALL    L_076A
	POP  H
	POP  D
	POP  PSW
	RET
;
L_066E:	LXI  H, L_07B3
	SHLD    X_076F+1
	JMP     L_0661
;
L_0677:	PUSH PSW
	PUSH B
	PUSH D
	PUSH H
	MVI  B, 000h
	LXI  H, D_1C38
	MOV  D, A
	SUB  M
	MVI  E, 034h
	JNC     L_068B
	CMA
	INR  A
	MVI  E, 035h
L_068B:	STA     D_1C30
	MOV  A, E
	STA     L_075C
	STA     L_074E
	LHLD    D_1C36
	MOV  A, C
	SUB  L
	MOV  L, A
	MOV  A, B
	SBB  H
	MOV  H, A
	MVI  E, 023h
	JNC     L_06AB
	CMA
	MOV  H, A
	MOV  A, L
	CMA
	MOV  L, A
	INX  H
	MVI  E, 02Bh
L_06AB:	SHLD    D_1C31
	MOV  A, E
	STA     L_0766
	STA     L_0752
	MVI  D, 000h
	LDA     D_1C30
	MOV  E, A
	DAD  D
	MOV  C, L
	MOV  B, H
	MOV  A, L
	ORA  H
	JZ      L_0746
	LXI  H, M_0000	; ?
	SHLD    D_1C33
L_06C9:	LDA     D_1C30
	CPI     000h
	JZ      L_0710
	LHLD    D_1C31
	MOV  A, H
	ORA  L
	JZ      L_06E9
	LHLD    D_1C33
	XRA  A
	XRA  H
	JP      L_0704
	XCHG
	LHLD    D_1C31
	DAD  D
	SHLD    D_1C33
L_06E9:	LDA     D_1C35
	CPI     002h
	JNZ     L_06F7
	CALL    L_0759
	JMP     L_072C
;
L_06F7:	ORI     002h
	CPI     003h
	JNZ     L_0729
	CALL    L_074B
	JMP     L_0728
;
L_0704:	MVI  D, 0FFh
	LDA     D_1C30
	CMA
	MOV  E, A
	INX  D
	DAD  D
	SHLD    D_1C33
L_0710:	LDA     D_1C35
	CPI     001h
	JNZ     L_071E
	CALL    L_0763
	JMP     L_072C
;
L_071E:	ORI     001h
	CPI     003h
	JNZ     L_0729
	CALL    L_074B
L_0728:	XRA  A
L_0729:	STA     D_1C35
L_072C:	DCX  B
	MOV  A, B
	ORA  C
	JNZ     L_06C9
	LDA     D_1C35
	CPI     001h
	CZ      L_0763
	LDA     D_1C35
	CPI     002h
	CZ      L_0759
	XRA  A
	STA     D_1C35
L_0746:	POP  H
	POP  D
	POP  B
	POP  PSW
	RET
;
L_074B:	LXI  H, D_1C38
L_074E:	NOP
	LHLD    D_1C36
L_0752:	NOP
	SHLD    D_1C36
	JMP     L_076A
;
L_0759:	LXI  H, D_1C38
L_075C:	NOP
	LHLD    D_1C36
	JMP     L_076A
;
L_0763:	LHLD    D_1C36
L_0766:	NOP
	SHLD    D_1C36
L_076A:	PUSH B
	MOV  C, L
	LDA     D_1C38
X_076F:	CALL    L_07B3
	POP  B
	RET
;
L_0774:	PUSH PSW
	PUSH H
	PUSH D
	LXI  H, L_0786
	PUSH H		; адрес возврата
	PUSH PSW
	PUSH H
	LDA     D_1C61
	LXI  H, L_0944
	JMP     L_0792
;
L_0786:	POP  D
	MOV  A, E
	STA     D_1C66
	RLC
	RLC
	RLC
	RLC
	LXI  H, L_07BE
L_0792:	PUSH D
	MVI  D, 004h
L_0795:	RLC
	JC      L_07A2
	MVI  M, 02Fh
	INX  H
	MVI  M, 0A6h
	INX  H
	JMP     L_07A8
;
L_07A2:	MVI  M, 0B6h
	INX  H
	MVI  M, 000h
	INX  H
L_07A8:	INX  H
	INX  H
	INX  H
	DCR  D
	JNZ     L_0795
	POP  D
	POP  H
	POP  PSW
	RET
;
L_07B3:	MOV  L, A
L_07B4:	MVI  B, (D_1D00 / 0100h)	; 01Dh
	LDAX B
	MOV  H, A
	INR  B
	LDAX B
	MOV  D, A
	LXI  B, 02000h	;+
L_07BE:	ORA  M
	NOP
L_07C0:	MOV  M, A
	DAD  B
	MOV  A, D
	ORA  M
	NOP
L_07C5:	MOV  M, A
	DAD  B
	MOV  A, D
	ORA  M
	NOP
L_07CA:	MOV  M, A
	DAD  B
	MOV  A, D
	ORA  M
	NOP
L_07CF:	MOV  M, A
	RET
;
L_07D1:	MOV  L, A
	MVI  B, (D_1D00 / 0100h)	; 01Dh
	LDAX B
	MOV  H, A
	INR  B
	LDAX B
	LXI  B, 02000h	;+
	CMA
	MOV  D, A
	ANA  M
L_07DE:	MOV  M, A
	DAD  B
	MOV  A, D
	ANA  M
L_07E2:	MOV  M, A
	DAD  B
	MOV  A, D
	ANA  M
L_07E6:	MOV  M, A
	DAD  B
	MOV  A, D
	ANA  M
L_07EA:	MOV  M, A
	RET
;
L_07EC:	NOP		; << L_0129
L_07ED:	NOP
	NOP
	PUSH PSW
	PUSH B
	PUSH D
	PUSH H
	MVI  A, 002h
	STA     D_0D52
	MOV  A, C
	ANI     07Fh
	MOV  C, A
	LXI  H, D_1C12
	MOV  A, M
	ORA  A
	JNZ     L_080E
	MOV  A, C
	CPI     01Bh
	JNZ     L_0870
L_080A:	INR  M
	JMP     L_0AA5
;
L_080E:	CPI     001h
	JNZ     L_081C
	MOV  A, C
	CPI     059h
	JNZ     L_0837
	JMP     L_080A
;
L_081C:	CPI     002h
	MOV  A, C
	JZ      L_0845
	SUI     020h
	JC      L_083C
	CPI     02Ah
	JNC     L_0840
	MOV  C, A
	ADD  A
	ADD  A
	ADD  A
	SUB  C
	SUB  C
L_0832:	ADI     002h
L_0834:	STA     D_1C14
L_0837:	MVI  M, 000h
	JMP     L_0AA5
;
L_083C:	XRA  A
	JMP     L_0832
;
L_0840:	MVI  A, 0F8h
	JMP     L_0834
;
L_0845:	SUI     020h
	JC      L_085D
	CPI     019h
	JNC     L_0868
	MOV  C, A
	ADD  A
	ADD  A
	ADD  A
	ADD  C
	ADD  C
	MOV  B, A
	LDA     D_1A8A
	SUB  B
	JMP     L_0860
;
L_085D:	LDA     D_1A8A
L_0860:	SUI     003h
L_0862:	STA     D_1C13
	JMP     L_080A
;
L_0868:	LDA     D_1A8A
	ADI     00Dh
	JMP     L_0862
;
L_0870:	MOV  A, C
	CPI     01Fh
	JZ      L_095F
	JM      L_09AC
L_0879:	MOV  C, A
	MVI  B, 000h
	LXI  H, M_0000	; ?
	DAD  B
L_0880:	DAD  H
	DAD  H
	DAD  B
	LXI  B, D_1808
	DAD  B
	XCHG
	MVI  C, 005h
	PUSH D
	PUSH B
	LHLD    D_1C13
	MOV  A, L
	MOV  C, H
	CALL    L_0910
	LXI  B, D_0900
	ANA  A
L_0898:	RRC
	JC      L_08A1
	INX  B
	INX  B
	JMP     L_0898
;
L_08A1:	INR  L
	LDAX B
	CALL    L_093A
	INR  H
	INX  B
	LDAX B
	ANA  A
	CNZ     L_093A
	POP  B
	POP  D
L_08AF:	LHLD    D_1C13
	INR  L
	LDAX D
	ANA  A
	JZ      L_08E3
	PUSH B
	PUSH D
	MOV  E, A
	MOV  C, H
	MVI  B, (D_1D00 / 0100h)	; 01Dh
	LDAX B
	MOV  H, A
	INR  B
	LDAX B
	MOV  D, A
	MOV  A, E
	LXI  B, 02000h	;+
	ANA  A
L_08C8:	RAR
	JC      L_08D4
	DCR  L
	ANA  A
	JNZ     L_08C8
	JMP     L_08E1
;
L_08D4:	PUSH H
	MOV  E, A
	MOV  A, D
	CALL    L_07BE
	MOV  A, E
	POP  H
	DCR  L
	ANA  A
	JNZ     L_08C8
L_08E1:	POP  D
	POP  B
L_08E3:	INX  D
	LXI  H, D_1C14
	INR  M
	DCR  C
	JNZ     L_08AF
	INR  M
	MOV  A, M
	CPI     0FAh
	JC      L_0AA5
	MVI  C, 00Dh
	CALL    L_07EC
	MVI  C, 00Ah
	CALL    L_07EC
	JMP     L_0AA5
;
D_0900:	.db 001h	; "_" - |       ■| (offset 0900h)
	.db 0F8h	; "°" - |■■■■■   | (offset 0901h)
	.db 003h	; "_" - |      ■■| (offset 0902h)
	.db 0F8h	; "°" - |■■■■■   | (offset 0903h)
	.db 007h	; "_" - |     ■■■| (offset 0904h)
	.db 0E0h	; "р" - |■■■     | (offset 0905h)
	.db 00Fh	; "_" - |    ■■■■| (offset 0906h)
	.db 0C0h	; "└" - |■■      | (offset 0907h)
	.db 01Fh	; "_" - |   ■■■■■| (offset 0908h)
	.db 080h	; "А" - |■       | (offset 0909h)
	.db 03Fh	; "?" - |  ■■■■■■| (offset 090Ah)
	.db 000h	; "_" - |        | (offset 090Bh)
	.db 07Eh	; "~" - | ■■■■■■ | (offset 090Ch)
	.db 000h	; "_" - |        | (offset 090Dh)
	.db 0FCh	; "№" - |■■■■■■  | (offset 090Eh)
	.db 000h	; "_" - |        | (offset 090Fh)
;
L_0910:	PUSH B
	MOV  L, A
	MVI  B, (D_1D00 / 0100h)	; 01Dh
	LDAX B
	MOV  H, A
	INR  B
	LDAX B
	POP  B
	RET
;
L_091A:	PUSH B
	PUSH H
	PUSH D
	MOV  D, A
L_091E:	PUSH D
	MOV  A, L
	MVI  B, (D_1800 / 0100h)	;018h	; часть адреса 1800h
	ANI     007h
	MOV  C, A
	LDAX B
	ANA  D
	MOV  D, A
	LXI  B, 02000h
	PUSH H
	CALL    L_07BE
	POP  H
	POP  D
	DCR  L
	DCR  E
	JNZ     L_091E
	POP  D
	POP  H
	POP  B
	RET
;
L_093A:	PUSH B
	PUSH H
	MVI  E, 009h
	LXI  B, 02000h
	MOV  D, A
L_0942:	MOV  A, D
	PUSH H
L_0944:	ORA  M
	NOP
L_0946:	MOV  M, A
	DAD  B
	MOV  A, D
	ORA  M
	NOP
L_094B:	MOV  M, A
	DAD  B
	MOV  A, D
	ORA  M
	NOP
L_0950:	MOV  M, A
	DAD  B
	MOV  A, D
	ORA  M
	NOP
L_0955:	MOV  M, A
	POP  H
	DCR  L
	DCR  E
	JNZ     L_0942
	POP  H
	POP  B
	RET
;
L_095F:	LDA     D_036A
	LXI  D, M_E000	; ?
	LXI  H, 02000h	;+
	MVI  C, 004h
L_096A:	DAD  D
	SHLD    X_0989+1
	RRC
	CC      L_097E
	DCR  C
	JNZ     L_096A
	MVI  A, 0FFh
	STA     D_1A8A
	JMP     L_0A9A
;
L_097E:	PUSH B
	PUSH H
	PUSH D
	LXI  H, M_0000	; ?
	DAD  SP
	SHLD    X_09A4+1
	DI
X_0989:	LXI  SP,M_0000	; ?
	LXI  B, M_0000	; ?
	MOV  D, B
L_0990:	PUSH B
	PUSH B
	PUSH B
	PUSH B
	PUSH B
	PUSH B
	PUSH B
	PUSH B
	PUSH B
	PUSH B
	PUSH B
	PUSH B
	PUSH B
	PUSH B
	PUSH B
	PUSH B
	DCR  D
	JNZ     L_0990
X_09A4:	LXI  SP,M_0000	; ?
	EI
	POP  D
	POP  H
	POP  B
	RET
;
L_09AC:	LHLD    D_1C13
	CPI     008h
	JNZ     L_09C4
	MOV  A, H
	SUI     006h
	JNC     L_09D1
	MVI  H, 0F8h
	SHLD    D_1C13
	MVI  A, 019h
	JMP     L_09D5
;
L_09C4:	CPI     018h
	JNZ     L_09D5
	MOV  A, H
	ADI     006h
	CPI     0FCh
	JNC     L_0A0F
L_09D1:	MOV  H, A
	JMP     L_0AA2
;
L_09D5:	CPI     019h
	JNZ     L_09EC
	MOV  D, H
	MOV  A, L
	LXI  H, D_1A8A
	ADI     003h
	CMP  M
	JNZ     L_09E7
	ADI     006h
L_09E7:	ADI     007h
	JMP     L_0A00
;
L_09EC:	CPI     01Ah
	JNZ     L_0A05
	MOV  D, H
	MOV  A, L
	LXI  H, D_1A8A
	SUI     00Dh
	CMP  M
	JNZ     L_09FE
	SUI     006h
L_09FE:	ADI     003h
L_0A00:	MOV  E, A
	XCHG
	JMP     L_0AA2
;
L_0A05:	CPI     00Dh
	JNZ     L_0A13
	MVI  H, 002h
	JMP     L_0AA2
;
L_0A0F:	MVI  H, 002h
	MVI  A, 00Ah
L_0A13:	CPI     00Ah
	JNZ     L_0A95
	MOV  A, L
	XCHG
	LXI  H, D_1A8A
	SUB  M
	CPI     017h
	MOV  A, E
	JNC     L_0A45
	MOV  A, M
	SUI     003h
	MOV  L, A
	MVI  H, 0E0h
	MVI  C, 004h
	LDA     D_036A
L_0A2F:	RRC
	CC      L_0A4C
	PUSH PSW
	MOV  A, H
	SUI     020h
	MOV  H, A
	POP  PSW
	DCR  C
	JNZ     L_0A2F
	MOV  A, L
	SUI     007h
	STA     D_1A8A
	ADI     017h
L_0A45:	SUI     00Ah
	MOV  E, A
	XCHG
	JMP     L_0AA2
;
L_0A4C:	PUSH H
	PUSH PSW
	PUSH B
	MVI  B, 000h
	MOV  A, L
	MVI  C, 020h
L_0A54:	MOV  L, A
	MOV  M, B
	DCR  L
	MOV  M, B
	DCR  L
	MOV  M, B
	DCR  L
	MOV  M, B
	DCR  L
	MOV  M, B
	DCR  L
	MOV  M, B
	DCR  L
	MOV  M, B
	DCR  L
	MOV  M, B
	DCR  L
	MOV  M, B
	DCR  L
	MOV  M, B
	INR  H
	DCR  C
	JNZ     L_0A54
	POP  B
	POP  PSW
	POP  H
	RET
;
L_0A71:	CPI     007h
	JNZ     L_0879
	LDA     D_1A88
	ADI     00Fh
	MOV  D, A
	PUSH PSW
L_0A7D:	POP  PSW
	MVI  E, 078h
	ANI     001h
	OUT     000h
L_0A84:	DCR  E
	JNZ     L_0A84
	INR  A
	PUSH PSW
	LDA     D_1A88
	CMP  D
	JNZ     L_0A7D
	POP  PSW
	JMP     L_0AA5
;
L_0A95:	CPI     00Ch
	JNZ     L_0A71
L_0A9A:	MVI  H, 002h
	LDA     D_1A8A
	SUI     003h
	MOV  L, A
L_0AA2:	SHLD    D_1C13
L_0AA5:	POP  H
	POP  D
	POP  B
	POP  PSW
	RET
;
L_0AAA:	PUSH PSW
	PUSH B
	PUSH D
	PUSH H
	LHLD    D_1C13
	MOV  A, L
	SUI     008h
	MOV  C, H
	INR  B
	MVI  B, 005h
	JZ      L_0ACA
L_0ABB:	PUSH B
	PUSH PSW
	CALL    L_07B3
	POP  PSW
	POP  B
	INR  C
	DCR  B
	JNZ     L_0ABB
	JMP     L_0AD6
;
L_0ACA:	PUSH B
	PUSH PSW
	CALL    L_07D1
	POP  PSW
	POP  B
	INR  C
	DCR  B
	JNZ     L_0ACA
L_0AD6:	POP  H
	POP  D
	POP  B
	POP  PSW
	RET
;
L_0ADB:	PUSH B		; << L_0126
	PUSH D
	MVI  C, 000h
	MOV  D, A
	IN      001h
	ANI     010h
	MOV  E, A
L_0AE5:	IN      001h
	ANI     010h
	CMP  E
	JZ      L_0AE5
	RLC
	RLC
	RLC
	RLC
	MOV  A, C
	RAL
	MOV  C, A
	CALL    L_0B25
	IN      001h
	ANI     010h
	MOV  E, A
	MOV  A, D
	ORA  A
	JP      L_0B1A
	MOV  A, C
	CPI     0E6h
	JNZ     L_0B0E
	XRA  A
	STA     D_1C11
	JMP     L_0B18
;
L_0B0E:	CPI     019h
	JNZ     L_0AE5
	MVI  A, 0FFh
	STA     D_1C11
L_0B18:	MVI  D, 009h
L_0B1A:	DCR  D
	JNZ     L_0AE5
	LDA     D_1C11
	XRA  C
	POP  D
	POP  B
	RET
;
L_0B25:	PUSH PSW
	LDA     D_0B5D
L_0B29:	MOV  B, A
	POP  PSW
L_0B2B:	DCR  B
	JNZ     L_0B2B
	RET
;
L_0B30:	PUSH B		; << L_012C
	PUSH D
	PUSH PSW
	MOV  D, A
	MVI  C, 008h
L_0B36:	MOV  A, D
	RLC
	MOV  D, A
	MVI  A, 001h
	XRA  D
	ANI     001h
	OUT     000h
	CALL    L_0B55
	MVI  A, 000h
	XRA  D
	ANI     001h
	OUT     000h
	CALL    L_0B55
	DCR  C
	JNZ     L_0B36
	POP  PSW
	POP  D
	POP  B
	RET
;
L_0B55:	PUSH PSW
	LDA     D_0B5C
	JMP     L_0B29
;
D_0B5C:	.db 032h	; "2" - |  ■■  ■ | (offset 0B5Ch)
D_0B5D:	.db 04Bh	; "K" - | ■  ■ ■■| (offset 0B5Dh)
;
L_0B5E:	PUSH B		; << L_0132
L_0B5F:	MVI  B, 000h
	LDA     D_1A88
	ANI     008h
	JNZ     L_0B6B
	MVI  B, 0FFh
L_0B6B:	CALL    L_0AAA
	CALL    L_0B7D
	CPI     0FFh
	JZ      L_0B5F
	MVI  B, 0FFh
	CALL    L_0AAA
	POP  B
	RET
;
L_0B7D:	PUSH B		; << L_013B
	PUSH H
	LXI  H, D_1C1B
	MOV  A, M
	ORA  A
	JNZ     L_0B8B
	DCR  A
	POP  H
	POP  B
	RET
;
L_0B8B:	DCR  M
	LXI  H, D_1C1E
	LDA     D_1C1D
	MOV  C, A
	MVI  B, 000h
	DAD  B
	INR  A
	ANI     00Fh
	STA     D_1C1D
	MOV  A, M
	POP  H
	POP  B
	RET
;
;;L_0BA0:	IN      001h	; << L_0123
;;	ANI     040h
;;	JNZ     L_0BA9
;;	CMA
;;	RET
;;;
;;L_0BA9:	LDA     D_1C1B
;;	ANA  A
;;	RZ
;;	MVI  A, 0FFh
;;	RET
;
D_0BB1:	.db 080h	; "А" - |■       | (offset 0BB1h) палитра ?
	.db 080h	; "А" - |■       | (offset 0BB2h)
	.db 080h	; "А" - |■       | (offset 0BB3h)
	.db 080h	; "А" - |■       | (offset 0BB4h)
	.db 080h	; "А" - |■       | (offset 0BB5h)
	.db 080h	; "А" - |■       | (offset 0BB6h)
	.db 080h	; "А" - |■       | (offset 0BB7h)
	.db 080h	; "А" - |■       | (offset 0BB8h)
	.db 080h	; "А" - |■       | (offset 0BB9h)
	.db 080h	; "А" - |■       | (offset 0BBAh)
	.db 080h	; "А" - |■       | (offset 0BBBh)
	.db 080h	; "А" - |■       | (offset 0BBCh)
	.db 080h	; "А" - |■       | (offset 0BBDh)
	.db 080h	; "А" - |■       | (offset 0BBEh)
	.db 080h	; "А" - |■       | (offset 0BBFh)
D_0BC0:	.db 080h	; "А" - |■       | (offset 0BC0h)
;
L_0BC1:	PUSH PSW	; обработчик прерывания
	PUSH B
	PUSH D
	PUSH H
	LXI  D, 0100Fh
	LXI  H, D_0BC0
L_0BCB:	MOV  A, E
	OUT     002h
	MOV  A, M
	OUT     00Ch
	DCR  C
	OUT     00Ch
	DCX  H
	OUT     00Ch
	DCR  E
	DCR  D
	OUT     00Ch
	JNZ     L_0BCB
	MVI  B, 003h
	LXI  H, D_1A88
L_0BE3:	INR  M
	JNZ     L_0BEF
	DCR  B
	JZ      L_0BEF
	INX  H
	JMP     L_0BE3
;
L_0BEF:	MVI  A, 08Ah
	OUT     000h
	LDA     D_0D52
	OUT     001h
	IN      001h
	ANI     080h
	LXI  H, D_1C1A
	JNZ     L_0C13
	MOV  A, M
	ORA  A
	JZ      L_0C15
	MVI  M, 000h
	LXI  H, D_0D4F
	MOV  A, M
	XRI     008h
	MOV  M, A
	JMP     L_0C15
;
L_0C13:	MVI  M, 0FFh
L_0C15:	XRA  A
	OUT     003h
	IN      002h
	CPI     0FFh
	JZ      L_0C39
	LXI  B, 0FE08h	; ?
	LXI  D, 00800h	;+
	MOV  A, B
L_0C26:	OUT     003h
	IN      002h
	CPI     0FFh
	JNZ     L_0C47
	MOV  A, E
	ADD  D
	MOV  E, A
	MOV  A, B
	RLC
	MOV  B, A
	DCR  C
	JNZ     L_0C26
L_0C39:	CALL    L_0D0D
	XRA  A
	STA     D_1C16
	CMA
	STA     D_1C19
;	JMP     L_0D2E
L_0D2E:	LDA     D_1A8B
	RRC
	RRC
	RRC
	LXI  B, M_0002	; ?
L_0D37:	RLC
	PUSH PSW
	CC      L_0E03
	POP  PSW
	DCR  C
	JP      L_0D37
L_0D41:	POP  H
	POP  D
	POP  B
	POP  PSW
	EI
	RET
;
L_0C47:	RAR
	JNC     L_0C4F
	INR  E
	JMP     L_0C47
;
L_0C4F:	CALL    L_0D0D
	LXI  H, L_0CCA
	PUSH H
	IN      001h
	ANI     060h
	JNZ     L_0C5F
	MVI  A, 060h
L_0C5F:	MOV  B, A
	MOV  A, E
	CPI     03Fh
	MVI  A, 020h
	RZ
	MOV  A, E
	CPI     010h
	JNC     L_0C7E
	LXI  H, D_0CBA
	MVI  D, 000h
	DAD  D
	MOV  A, M
	CPI     07Fh
	RNZ
	MOV  A, B
	ANI     020h
	MVI  A, 05Fh
	RZ
	MOV  A, M
	RET
;
L_0C7E:	CPI     020h
	JNC     L_0C9D
	CPI     01Ch
	MOV  A, B
	JNC     L_0C94
	ANI     020h
	MOV  A, E
	JZ      L_0C91
L_0C8F:	ADI     010h
L_0C91:	ADI     010h
	RET
;
L_0C94:	ANI     020h
	MOV  A, E
	JNZ     L_0C91
	JMP     L_0C8F
;
L_0C9D:	MOV  A, B
	ANI     040h
	JNZ     L_0CA7
	MOV  A, E
	ANI     01Fh
	RET
;
L_0CA7:	MOV  A, B
	ANI     020h
	MOV  B, A
	LDA     D_0D4F
	ANI     008h
	ORA  B
	MOV  A, E
	JPO     L_0CB7
	ADI     020h
L_0CB7:	ADI     020h
	RET
;
D_0CBA:	.db 009h	; "_" - |    ■  ■| (offset 0CBAh)
	.db 00Ah, 00Dh
	.db 07Fh	; "" - | ■■■■■■■| (offset 0CBDh)
	.db 008h	; "_" - |    ■   | (offset 0CBEh)
	.db 019h	; "_" - |   ■■  ■| (offset 0CBFh)
	.db 018h	; "_" - |   ■■   |
	.db 01Ah	; "_" - |   ■■ ■ | (offset 0CC1h)
	.db 00Ch	; "_" - |    ■■  | (offset 0CC2h)
	.db 01Fh	; "_" - |   ■■■■■| (offset 0CC3h)
	.db 01Bh	; "_" - |   ■■ ■■| (offset 0CC4h)
	.db 000h
	.db 001h
	.db 002h	; "_" - |      ■ | (offset 0CC7h)
	.db 003h	; "_" - |      ■■| (offset 0CC8h)
	.db 004h	; "_" - |     ■  | (offset 0CC9h)
;
L_0CCA:	LXI  H, L_0D2E
	PUSH H
	MOV  B, A
	LDA     D_1C19
	CPI     0FFh
	JZ      L_0CEF
	CMP  B
	RNZ
	LXI  H, D_1C16
	MOV  A, M
	CPI     032h
	JZ      L_0CE4
L_0CE2:	INR  M
	RET
;
L_0CE4:	LXI  H, D_1C15
	MOV  A, M
	CPI     00Ah
	JNZ     L_0CE2
	MVI  M, 000h
L_0CEF:	MOV  A, B
	STA     D_1C19
	LXI  H, D_1C1B
	MOV  A, M
	CPI     010h
	RNC
	INR  M
	LDA     D_1C1C
	MOV  E, A
	MVI  D, 000h
	LXI  H, D_1C1E
	DAD  D
	INR  A
	ANI     00Fh
	STA     D_1C1C
	MOV  M, B
	RET
;
L_0D0D:	LDA     D_0D4F
	ANI     009h
	MOV  H, A
	LDA     D_0D52
	ANI     002h
	ADD  H
	MOV  H, A
	MVI  A, 088h
	OUT     000h
	MOV  A, H
	OUT     001h
	LDA     D_1A8A
	OUT     003h
	LDA     D_0D50
	ANI     00Fh
	OUT     002h
	RET
;
D_0D4F:	.db 002h	; "_" - |      ■ | (offset 0D4Fh)
D_0D50:	.db 001h	; "_" - |       ■| (offset 0D50h)
D_0D51:	.db 000h	; "_" - |        | (offset 0D51h)
D_0D52:	.db 002h	; "_" - |      ■ | (offset 0D52h)
;
L_0D53:	PUSH PSW
	PUSH B
	PUSH D
	PUSH H
	MOV  A, C
	CPI     00Dh
	JNZ     L_0D69
	LXI  H, M_0000	; ?
	SHLD    L_07EC
	SHLD    L_07ED
	JMP     L_0DC6
;
L_0D69:	ANI     07Fh
	MOV  C, A
	MVI  B, 000h
	LXI  H, M_0000	; ?
	DAD  B
	DAD  H
	DAD  H
	DAD  B
	LXI  B, D_1808
	DAD  B
	MVI  C, 005h
L_0D7B:	LDA     D_1C38
	PUSH PSW
	MVI  B, 007h
	LDA     D_1C36
	PUSH PSW
	MOV  A, M
	MOV  E, A
L_0D87:	LDA     D_1C2E
	MOV  D, A
	POP  PSW
	STA     D_1C36
	PUSH PSW
	ADD  D
	PUSH B
	MOV  C, A
	LDA     D_1C38
	MOV  D, A
	LDA     D_1C2F
	ADD  D
	MOV  B, A
	MOV  A, E
	RLC
	MOV  E, A
	MOV  A, B
	CC      L_0591
	STA     D_1C38
	MOV  A, C
	STA     D_1C36
	POP  B
	DCR  B
	JNZ     L_0D87
	POP  PSW
	POP  PSW
	STA     D_1C38
	INX  H
	DCR  C
	JNZ     L_0D7B
	LDA     D_1C36
	MOV  D, A
	LDA     D_1C2E
	ADD  D
	ADI     002h
	STA     D_1C36
L_0DC6:	JMP     L_0D41
;
D_0DC9:	.db 004h	; "_" - |     ■  | (offset 0DC9h)
	.db 004h	; "_" - |     ■  | (offset 0DCAh)
	.db 004h	; "_" - |     ■  | (offset 0DCBh)
;
D_0DCC:	.db 001h	; "_" - |       ■| (offset 0DCCh)
	.db 001h	; "_" - |       ■| (offset 0DCDh)
	.db 001h	; "_" - |       ■| (offset 0DCEh)
;
D_0DCF:	.db 005h	; "_" - |     ■ ■| (offset 0DCFh)
	.db 005h	; "_" - |     ■ ■| (offset 0DD0h)
	.db 005h	; "_" - |     ■ ■| (offset 0DD1h)
	.db 0BDh	; "╜" - |■ ■■■■ ■| (offset 0DD2h)
	.db 0D2h	; "╥" - |■■ ■  ■ | (offset 0DD3h)
;
	; делители для нот
D_0DD4:	.db 02Bh, 0B3h, 01Ch, 0A9h	;ВИ
	.db 09Eh, 09Fh, 0A9h, 096h
	.db 034h, 08Eh
	.db 039h, 086h, 0B0h, 07Eh
	.db 094h, 077h, 0DEh, 070h
	.db 088h, 06Ah, 08Eh, 064h
	.db 0E9h, 05Eh, 095h, 059h
;	
D_NAY:	.db 03Dh, 00Dh, 007F, 00Ch	;AY8910
	.db 0CBh, 00Bh, 022h, 00Bh
	.db 082h, 00Ah
	.db 0EBh, 009h, 05Ch, 009h
	.db 0D6h, 008h, 057h, 008h
	.db 0DFh, 007h, 06Eh, 007h
	.db 003h, 007h, 09Fh, 006h
;
L_0DEE:	PUSH PSW	; << L_0168
	PUSH B
	PUSH H
	LXI  B, 00002h	;+
L_0DF4:	LXI  H, D_1A8C
	DAD  B
	CALL    L_0E13
	DCR  C
	JP      L_0DF4
	POP  H
	POP  B
	POP  PSW
	RET
;
L_0E03:	LXI  H, D_0DCC
	DAD  B
	DCR  M
	RNZ
	LXI  H, D_1A8C
	DAD  B
	MOV  A, M
	CPI     080h
	JC      L_0E41
L_0E13:	MVI  M, 000h
	LXI  H, D_0DCF
	DAD  B
	MVI  M, 005h
	LXI  H, D_0DC9
	DAD  B
	MVI  M, 004h
	PUSH B
	MVI  A, 07Fh
L_0E24:	RLC
	DCR  C
	JP      L_0E24
	LXI  H, D_1A8B
	ANA  M
	MOV  M, A
	POP  B
L_0E2F:	LXI  H, D_0DCC
	DAD  B
	MVI  M, 001h
L_0E35:	MOV  A, C	;!!!
	INR  A		;!!!
	CMA		;!!!
	RRC		;!!!
	RRC		;!!!
	ANI     0C0h	;!!!
	ORI     030h	;!!!
	OUT     008h	;!!!
	MVI  A, 008h	; для AY8910
	ADD  C		;
	OUT     015h	;
	XRA  A		;
	OUT     014h	;
	RET		;!!!
;
L_0E41:	PUSH H
	PUSH H
	MOV  A, C
	LXI  D, 00080h	;+
	LXI  H, (D_1A8F-080h)
L_0E4A:	DAD  D
	DCR  A
	JP      L_0E4A
	POP  D
	LDAX D
	MOV  E, A
	MVI  D, 000h
	DAD  D
	MOV  A, M
	ORA  A
	XCHG
	POP  H
	JZ      L_0E13
	CPI     04Ch
	JNZ     L_0E7E
	INR  M
	INX  D
	LDAX D
	CPI     030h
	JC      L_0E74
	CPI     03Ah
	JNC     L_0E74
	CALL    L_0F67
	JMP     L_0E76
;
L_0E74:	MVI  A, 004h
L_0E76:	PUSH H
	LXI  H, D_0DC9
	DAD  B
	MOV  M, A
	POP  H
	LDAX D
L_0E7E:	CPI     04Fh
	JNZ     L_0E9C
	INR  M
	INX  D
	LDAX D
	CPI     030h
	JC      L_0E9C
	CPI     039h
	JNC     L_0E9C
	PUSH H
	LXI  H, D_0DCF
	DAD  B
	SUI     02Fh
	MOV  M, A
	POP  H
	INR  M
	INX  D
	LDAX D
L_0E9C:	INR  M
	INX  D
	PUSH H
	PUSH D
	LXI  H, L_0EDE
	PUSH H
X_0EA4:	LXI  H, D_0DD4	; делители для нот
	LXI  D, 00004h	;+
	CPI     043h	;C
	RZ
	DAD  D
	CPI     044h	;D
	RZ
	DAD  D
	CPI     045h	;E
	RZ
	INX  H
	INX  H
	CPI     046h	;F
	RZ
	DAD  D
	CPI     047h	;G
	RZ
	DAD  D
	CPI     041h	;A
	RZ
	DAD  D
	CPI     042h	;B
	RZ
	POP  H
	POP  D
	POP  H
	CPI     050h
	JZ      L_0ED8
	CPI     052h
	JNZ     L_0E2F
	MVI  M, 000h
	JMP     L_0E2F
;
L_0ED8:	CALL    L_0E35
	JMP     L_0F1B
;
L_0EDE:	POP  D
	LDAX D
	CPI     023h
	INX  H
	INX  H
	JZ      L_0EF5
	CPI     02Bh
	JZ      L_0EF5
	CPI     02Dh
	DCX  H
	DCX  H
	JNZ     L_0EF9
	DCX  H
	DCX  H
L_0EF5:	XTHL
	INR  M
	XTHL
	INX  D
L_0EF9:	SHLD    X_0EFC+1
X_0EFC:	LHLD    M_0000	; ?
	PUSH H
	LXI  H, D_0DCF
	DAD  B
	MOV  A, M
	POP  H
	PUSH B
	MOV  C, A
L_0F08:	DCR  C
	JZ      L_0F16
	MOV  A, H
	ORA  A
	RAR
	MOV  H, A
	MOV  A, L
	RAR
	MOV  L, A
	JMP     L_0F08
;
L_0F16:	POP  B
X_0F17:	CALL    L_0F4A	;!!!
	POP  H
L_0F1B:	LDAX D
	CPI     030h
	JC      L_0F2C
	CPI     03Ah
	JNC     L_0F2C
	CALL    L_0F67
	JMP     L_0F33
;
L_0F2C:	PUSH H
	LXI  H, D_0DC9
	DAD  B
	MOV  A, M
	POP  H
L_0F33:	PUSH H
	LXI  H, D_0DCC
	DAD  B
	MOV  M, A
	LDAX D
	CPI     02Eh
	MOV  A, M
	JNZ     L_0F48
	ADD  A
	ADD  M
	ORA  A
	RAR
	MOV  M, A
	POP  H
	INR  M
	RET
;
L_0F48:	POP  H
	RET
;
L_0F4A:	PUSH PSW	; PLAY для ВИ
	MVI  A, 009h
	ADD  C
	STA     X_0F60+1
	STA     X_0F63+1
	MOV  A, C
	INR  A
	CMA
	RRC
	RRC
	ANI     0C0h
	ORI     036h
	OUT     008h
	MOV  A, L
X_0F60:	OUT     009h
	MOV  A, H
X_0F63:	OUT     009h
	POP  PSW
	RET
;
L_AYPL: PUSH PSW	; PLAY для AY
	MVI  A, 008h
	ADD  C
	OUT     015h
	MVI  A, 00Dh
	OUT     014h
	MOV  A, C
	ADD  A
	OUT     015h
	MOV  A, L
	OUT     014h
	MOV  A, C
	ADD  A
	INR  A
	OUT     015h
	MOV  A, H
	OUT     014h
	POP  PSW
	RET
;
L_0F67:	SUI     030h
	INR  M
	INX  D
	PUSH B
	MOV  C, A
	LDAX D
	CPI     030h
	JC      L_0F84
	CPI     03Ah
	JNC     L_0F84
	SUI     030h
	MOV  B, A
	MOV  A, C
	ADD  A
	ADD  A
	ADD  C
	ADD  A
	ADD  B
	MOV  C, A
	INX  D
	INR  M
L_0F84:	MOV  A, C
	ORI     001h
	RLC
	MOV  B, A
	MVI  A, 080h
L_0F8B:	RLC
	MOV  C, A
	MOV  A, B
	RLC
	MOV  B, A
	MOV  A, C
	JNC     L_0F8B
	POP  B
	RET
;
L_0F96:	PUSH H		; << L_0147
	PUSH PSW
	PUSH D
	MOV  A, C
	STA     D_1C5F
	MOV  A, B
	STA     D_1C60
	XCHG
	MOV  A, H
	ANI     007h
	MOV  H, A
	SHLD    D_1C62
	XCHG
	MOV  A, H
	ANI     007h
	MOV  H, A
	SHLD    D_1C64
	POP  D
	POP  PSW
	POP  H
	RET
;
L_0FB5:	PUSH H		; << L_0144
	PUSH D
	PUSH B
	PUSH PSW
	CALL    L_0FC1
	POP  PSW
	POP  B
	POP  D
	POP  H
	RET
;
L_0FC1:	STA     D_1C46
	SHLD    D_1C48
	XCHG
	SHLD    D_1C4A
	LHLD    D_1C62
	SHLD    D_1C52
	LHLD    D_1C64
	SHLD    D_1C54
	CALL    L_11E8
	XRA  A
	MOV  L, A
	MOV  H, A
	SHLD    D_1C41
	LHLD    D_1C46
	SHLD    D_1C43
	MOV  B, A
	MOV  C, A
	DAD  H
	MVI  A, 003h
	SUB  L
	MOV  L, A
	MVI  A, 000h
	SBB  H
	MOV  H, A
	XCHG
	LHLD    D_1C43
L_0FF5:	PUSH B
	PUSH D
	PUSH H
	CALL    L_1037
	POP  H
	POP  D
	POP  B
	XRA  A
	ORA  D
	JM      L_101B
	PUSH H
	MOV  A, C
	SUB  L
	MOV  L, A
	MOV  A, B
	SBB  H
	MOV  H, A
	DAD  H
	DAD  H
	DAD  D
	MOV  A, L
	ADI     00Ah
	MOV  L, A
	MVI  A, 000h
	ADC  H
	MOV  H, A
	POP  D
	XCHG
	DCX  H
	JMP     L_102E
;
L_101B:	PUSH H
	XRA  A
	MOV  H, A
	MOV  L, A
	DAD  B
	DAD  B
	DAD  B
	DAD  B
	MVI  A, 006h
	ADD  L
	MOV  L, A
	MVI  A, 000h
	ADC  H
	MOV  H, A
	DAD  D
	POP  D
	XCHG
L_102E:	INX  B
	MOV  A, L
	SUB  C
	MOV  A, H
	SBB  B
	JP      L_0FF5
	RET
;
L_1037:	LDA     D_1C57
	LXI  D, L_1102
	CALL    L_1098
	PUSH B
	XTHL
	POP  B
	LDA     D_1C56
	LXI  D, L_10C3
	CALL    L_1098
	PUSH H
	XRA  A
	SUB  L
	MOV  L, A
	MVI  A, 000h
	SBB  H
	MOV  H, A
	LDA     D_1C5D
	LXI  D, L_10C3
	CALL    L_1098
	PUSH B
	XTHL
	POP  B
	LDA     D_1C58
	LXI  D, L_1102
	CALL    L_1098
	XRA  A
	SUB  L
	MOV  L, A
	MVI  A, 000h
	SBB  H
	MOV  H, A
	LDA     D_1C5B
	LXI  D, L_117B
	CALL    L_1098
	PUSH B
	XTHL
	POP  B
	LDA     D_1C5A
	LXI  D, L_1146
	CALL    L_1098
	POP  H
	LDA     D_1C59
	LXI  D, L_1146
	CALL    L_1098
	PUSH B
	XTHL
	POP  B
	LDA     D_1C5C
	LXI  D, L_117B
L_1098:	XCHG
	CPI     003h
	JZ      L_10A4
	ORA  A
	JNZ     L_10AD
	XCHG
	RET
;
L_10A4:	XCHG
	PUSH B
	PUSH H
	CALL    L_11B7
	POP  H
	POP  B
	RET
;
L_10AD:	PUSH D
	DCR  A
	MOV  E, A
	MVI  D, 000h
	DAD  D
	DAD  D
	DAD  D
	POP  D
	PUSH D
	PUSH B
	PUSH H
	LXI  H, L_10C0
	XTHL
	PUSH H
	XCHG
	RET
;
L_10C0:	POP  B
	POP  H
	RET
;
L_10C3:	JMP     L_10D5
P_10C6:	JMP     L_10E1
P_10C9:	JMP     L_11B7
P_10CC:	JMP     L_10ED
P_10CF:	CALL    L_10E1
	JMP     L_10D5
;
L_10D5:	XCHG
	LHLD    D_1C4E
L_10D9:	CALL    L_1657
	XCHG
	JP      L_11B7
	RET
;
L_10E1:	XCHG
	LHLD    D_1C4C
L_10E5:	XCHG
	CALL    L_1657
	JP      L_11B7
	RET
;
L_10ED:	XCHG
	LHLD    D_1C4C
	XCHG
	CALL    L_1657
	RM
	XCHG
	LHLD    D_1C4E
	CALL    L_1657
	RM
	XCHG
	JMP     L_11B7
;
L_1102:	JMP     L_1114
P_1105:	JMP     L_1122
P_1108:	JMP     L_11B7
P_110B:	JMP     L_112C
P_110E:	CALL    L_1122
	JMP     L_1114
;
L_1114:	MOV  D, B
	MOV  E, C
	PUSH H
	LHLD    D_1C4C
L_111A:	CALL    L_1657
	POP  H
	JP      L_11B7
	RET
;
L_1122:	PUSH H
	MOV  D, B
	MOV  E, C
	LHLD    D_1C4E
	XCHG
	JMP     L_111A
;
L_112C:	PUSH H
	MOV  D, B
	MOV  E, C
	LHLD    D_1C4E
	XCHG
	CALL    L_1657
	POP  H
	RM
	PUSH H
	MOV  D, B
	MOV  E, C
	LHLD    D_1C4C
	CALL    L_1657
	POP  H
	RM
	JMP     L_11B7
;
L_1146:	JMP     L_1158
P_1149:	JMP     L_115F
P_114C:	JMP     L_11B7
P_114F:	JMP     L_1166
P_1152:	CALL    L_115F
	JMP     L_1158
;
L_1158:	XCHG
	LHLD    D_1C4C
	JMP     L_10D9
;
L_115F:	XCHG
	LHLD    D_1C4E
	JMP     L_10E5
;
L_1166:	XCHG
	LHLD    D_1C4E
	XCHG
	CALL    L_1657
	RM
	XCHG
	LHLD    D_1C4C
	CALL    L_1657
	XCHG
	RM
	JMP     L_11B7
;
L_117B:	JMP     L_118D
P_117E:	JMP     L_1196
P_1181:	JMP     L_11B7
P_1184:	JMP     L_11A0
P_1187:	CALL    L_1196
	JMP     L_118D
;
L_118D:	PUSH H
	MOV  D, B
	MOV  E, C
	LHLD    D_1C4E
	JMP     L_111A
;
L_1196:	PUSH H
	MOV  D, B
	MOV  E, C
	LHLD    D_1C4C
	XCHG
	JMP     L_111A
;
L_11A0:	PUSH H
	MOV  D, B
	MOV  E, C
	LHLD    D_1C4C
	XCHG
	CALL    L_1657
	POP  H
	RM
	PUSH H
	MOV  D, B
	MOV  E, C
	LHLD    D_1C4E
	CALL    L_1657
	POP  H
	RM
L_11B7:	PUSH B
	MOV  D, H
	MOV  E, L
	LDA     D_1C60
	ORA  A
	JZ      L_11C6
	CALL    L_1396
	MOV  E, D
	MOV  D, C
L_11C6:	LHLD    D_1C4A
	DAD  D
	XTHL
	MOV  D, H
	MOV  E, L
	LDA     D_1C5F
	ORA  A
	JZ      L_11D9
	CALL    L_1396
	MOV  E, D
	MOV  D, C
L_11D9:	LHLD    D_1C48
	DAD  D
	POP  D
	XRA  A
	CMP  H
	RNZ
	CMP  D
	RNZ
	MOV  C, L
	MOV  L, E
	JMP     L_07B4
;
L_11E8:	LHLD    D_1C52
	XCHG
	LHLD    D_1C54
	CALL    L_1657
	JC      L_12C6
	JNZ     L_1202
	XRA  A
	LXI  B, 00703h	;+
	CALL    L_1380
	JMP     L_12EE
;
L_1202:	LDA     D_1C53
	MOV  B, A
	LDA     D_1C55
	SUB  B
	JNZ     L_1220
	PUSH B
	MVI  B, 007h
	MOV  C, A
	CALL    L_1380
	POP  B
	LXI  H, D_1C56
	MOV  C, B
	MOV  B, A
	DAD  B
	MVI  M, 004h
	JMP     L_12B3
;
L_1220:	LDA     D_1C53
	MOV  B, A
	LDA     D_1C55
	DCR  A
	SUB  B
	JNZ     L_1235
	MOV  C, A
	MVI  B, 007h
	CALL    L_1380
	JMP     L_1277
;
L_1235:	LDA     D_1C55
	DCR  A
	MOV  B, A
	LDA     D_1C53
	INR  A
	MVI  C, 003h
	CALL    L_1380
	LDA     D_1C53
	ORA  A
	JNZ     L_1252
	MVI  A, 002h
	STA     D_1C56
	JMP     L_125C
;
L_1252:	LDA     D_1C53
	DCR  A
	MOV  B, A
	XRA  A
	MOV  C, A
	CALL    L_1380
L_125C:	LDA     D_1C55
	CPI     007h
	JNZ     L_126C
	MVI  A, 001h
	STA     D_1C5D
	JMP     L_1277
;
L_126C:	LDA     D_1C55
	INR  A
	MVI  B, 007h
	MVI  C, 000h
	CALL    L_1380
L_1277:	LDA     D_1C53
	LXI  H, D_1C56
	ORA  A
	JZ      L_128F
	CPI     005h
	JNC     L_128F
	MOV  C, A
	MVI  B, 000h
	DAD  B
	MVI  M, 001h
	JMP     L_1295
;
L_128F:	MOV  C, A
	MVI  B, 000h
	DAD  B
	MVI  M, 002h
L_1295:	LDA     D_1C55
	LXI  H, D_1C56
	ORA  A
	JZ      L_12AD
	CPI     005h
	JNC     L_12AD
	MOV  C, A
	MVI  B, 000h
	DAD  B
	MVI  M, 002h
	JMP     L_12B3
;
L_12AD:	MOV  C, A
	MVI  B, 000h
	DAD  B
	MVI  M, 001h
L_12B3:	CALL    L_12EE
	RET
;
L_12B7:	LXI  H, M_0000	; ?
	DAD  SP
	XCHG
	DI
	SPHL
	POP  H
	POP  B
	PUSH H
	PUSH B
	XCHG
	SPHL
	EI
	RET
;
L_12C6:	LXI  D, D_1C52
	PUSH D
	CALL    L_12B7
	CALL    L_11E8
	POP  D
	CALL    L_12B7
	MVI  B, 008h
	LXI  H, D_1C56
L_12D9:	MOV  C, M
	MVI  A, 003h
	SUB  C
	JP      L_12E2
	MVI  A, 005h
L_12E2:	MOV  M, A
	INX  H
	DCR  B
	JNZ     L_12D9
	LXI  D, D_1C4C
	JMP     L_12B7
;
L_12EE:	LHLD    D_1C54
	PUSH H
	LHLD    D_1C52
	SHLD    D_1C54
	CALL    L_1305
	LHLD    D_1C4E
	SHLD    D_1C4C
	POP  H
	SHLD    D_1C54
L_1305:	LXI  H, D_13C8
	LDA     D_1C55
	ORA  A
	JZ      L_132F
	DCR  A
	JZ      L_1342
	DCR  A
	JZ      L_132A
	DCR  A
	JZ      L_1342
	DCR  A
	JZ      L_132A
	DCR  A
	JZ      L_133D
	DCR  A
	JZ      L_132F
	JMP     L_133D
;
L_132A:	MVI  B, 0FFh
	JMP     L_1331
;
L_132F:	MVI  B, 000h
L_1331:	LDA     D_1C54
	CMA
L_1335:	MOV  E, A
	MVI  D, 000h
	DAD  D
	MOV  A, M
	JMP     L_134A
;
L_133D:	MVI  B, 0FFh
	JMP     L_1344
;
L_1342:	MVI  B, 000h
L_1344:	LDA     D_1C54
	JMP     L_1335
;
L_134A:	STA     D_1C50
	XRA  A
	STA     D_1C51
	LDA     D_1C54
	ORA  A
	JNZ     L_135F
	LHLD    D_1C50
	INX  H
	SHLD    D_1C50
L_135F:	MOV  A, B
	ORA  A
	JZ      L_1371
	LHLD    D_1C50
	XRA  A
	SUB  L
	MOV  L, A
	MVI  A, 000h
	SBB  H
	MOV  H, A
	SHLD    D_1C50
L_1371:	LHLD    D_1C50
	LDA     D_1C46
	CALL    L_1396
	MOV  H, C
	MOV  L, D
	SHLD    D_1C4E
	RET
;
L_1380:	LXI  H, D_1C56
	PUSH PSW
	ADD  L
	MOV  L, A
	MVI  A, 000h
	ADC  H
	MOV  H, A
	POP  PSW
L_138B:	MOV  M, C
	DCR  B
	CMP  B
	INX  H
	JM      L_138B
	JZ      L_138B
	RET
;
L_1396:	PUSH PSW
	MVI  A, 008h
	STA     D_1C45
	XRA  A
	MOV  B, A
	MOV  C, A
	MOV  D, A
	MOV  E, A
	MOV  A, H
	ORA  A
	JP      L_13A8
	MVI  B, 0FFh
L_13A8:	POP  PSW
	RAR
	PUSH PSW
	JNC     L_13B5
	PUSH H
	DAD  D
	XCHG
	MOV  A, C
	ADC  B
	MOV  C, A
	POP  H
L_13B5:	DAD  H
	MOV  A, B
	ADC  B
	MOV  B, A
	LDA     D_1C45
	DCR  A
	JZ      L_13C6
	STA     D_1C45
	JMP     L_13A8
;
L_13C6:	POP  PSW
	RET
;
D_13C8:	.db 0B5h	; "╡" - |■ ■■ ■ ■| (offset 13C8h)
	.db 0B4h	; "┤" - |■ ■■ ■  | (offset 13C9h)
	.db 0B3h	; "│" - |■ ■■  ■■| (offset 13CAh)
	.db 0B3h	; "│" - |■ ■■  ■■| (offset 13CBh)
	.db 0B2h	; "▓" - |■ ■■  ■ | (offset 13CCh)
	.db 0B2h	; "▓" - |■ ■■  ■ | (offset 13CDh)
	.db 0B1h	; "▒" - |■ ■■   ■| (offset 13CEh)
	.db 0B1h	; "▒" - |■ ■■   ■| (offset 13CFh)
	.db 0B0h	; "░" - |■ ■■    | (offset 13D0h)
	.db 0AFh	; "п" - |■ ■ ■■■■| (offset 13D1h)
	.db 0AFh	; "п" - |■ ■ ■■■■| (offset 13D2h)
	.db 0AEh	; "о" - |■ ■ ■■■ | (offset 13D3h)
	.db 0AEh	; "о" - |■ ■ ■■■ | (offset 13D4h)
	.db 0ADh	; "н" - |■ ■ ■■ ■| (offset 13D5h)
	.db 0ADh	; "н" - |■ ■ ■■ ■| (offset 13D6h)
	.db 0ACh	; "м" - |■ ■ ■■  | (offset 13D7h)
	.db 0ABh	; "л" - |■ ■ ■ ■■| (offset 13D8h)
	.db 0ABh	; "л" - |■ ■ ■ ■■| (offset 13D9h)
	.db 0AAh	; "к" - |■ ■ ■ ■ | (offset 13DAh)
	.db 0AAh	; "к" - |■ ■ ■ ■ | (offset 13DBh)
	.db 0A9h	; "й" - |■ ■ ■  ■| (offset 13DCh)
	.db 0A8h	; "и" - |■ ■ ■   | (offset 13DDh)
	.db 0A8h	; "и" - |■ ■ ■   | (offset 13DEh)
	.db 0A7h	; "з" - |■ ■  ■■■| (offset 13DFh)
	.db 0A7h	; "з" - |■ ■  ■■■| (offset 13E0h)
	.db 0A6h	; "ж" - |■ ■  ■■ | (offset 13E1h)
	.db 0A6h	; "ж" - |■ ■  ■■ | (offset 13E2h)
	.db 0A5h	; "е" - |■ ■  ■ ■| (offset 13E3h)
	.db 0A4h	; "д" - |■ ■  ■  | (offset 13E4h)
	.db 0A4h	; "д" - |■ ■  ■  | (offset 13E5h)
	.db 0A3h	; "г" - |■ ■   ■■| (offset 13E6h)
	.db 0A3h	; "г" - |■ ■   ■■| (offset 13E7h)
	.db 0A2h	; "в" - |■ ■   ■ | (offset 13E8h)
	.db 0A1h	; "б" - |■ ■    ■| (offset 13E9h)
	.db 0A1h	; "б" - |■ ■    ■| (offset 13EAh)
	.db 0A0h	; "а" - |■ ■     | (offset 13EBh)
	.db 09Fh	; "Я" - |■  ■■■■■| (offset 13ECh)
	.db 09Fh	; "Я" - |■  ■■■■■| (offset 13EDh)
	.db 09Eh	; "Ю" - |■  ■■■■ | (offset 13EEh)
	.db 09Eh	; "Ю" - |■  ■■■■ | (offset 13EFh)
	.db 09Dh	; "Э" - |■  ■■■ ■| (offset 13F0h)
	.db 09Ch	; "Ь" - |■  ■■■  | (offset 13F1h)
	.db 09Ch	; "Ь" - |■  ■■■  | (offset 13F2h)
	.db 09Bh	; "Ы" - |■  ■■ ■■| (offset 13F3h)
	.db 09Bh	; "Ы" - |■  ■■ ■■| (offset 13F4h)
	.db 09Ah	; "Ъ" - |■  ■■ ■ | (offset 13F5h)
	.db 099h	; "Щ" - |■  ■■  ■| (offset 13F6h)
	.db 099h	; "Щ" - |■  ■■  ■| (offset 13F7h)
	.db 098h	; "Ш" - |■  ■■   | (offset 13F8h)
	.db 097h	; "Ч" - |■  ■ ■■■| (offset 13F9h)
	.db 097h	; "Ч" - |■  ■ ■■■| (offset 13FAh)
	.db 096h	; "Ц" - |■  ■ ■■ | (offset 13FBh)
	.db 095h	; "Х" - |■  ■ ■ ■| (offset 13FCh)
	.db 095h	; "Х" - |■  ■ ■ ■| (offset 13FDh)
	.db 094h	; "Ф" - |■  ■ ■  | (offset 13FEh)
	.db 094h	; "Ф" - |■  ■ ■  | (offset 13FFh)
	.db 093h	; "У" - |■  ■  ■■| (offset 1400h)
	.db 092h	; "Т" - |■  ■  ■ | (offset 1401h)
	.db 092h	; "Т" - |■  ■  ■ | (offset 1402h)
	.db 091h	; "С" - |■  ■   ■| (offset 1403h)
	.db 090h	; "Р" - |■  ■    | (offset 1404h)
	.db 090h	; "Р" - |■  ■    | (offset 1405h)
	.db 08Fh	; "П" - |■   ■■■■| (offset 1406h)
	.db 08Eh	; "О" - |■   ■■■ | (offset 1407h)
	.db 08Eh	; "О" - |■   ■■■ | (offset 1408h)
	.db 08Dh	; "Н" - |■   ■■ ■| (offset 1409h)
	.db 08Ch	; "М" - |■   ■■  | (offset 140Ah)
	.db 08Ch	; "М" - |■   ■■  | (offset 140Bh)
	.db 08Bh	; "Л" - |■   ■ ■■| (offset 140Ch)
	.db 08Ah	; "К" - |■   ■ ■ | (offset 140Dh)
	.db 08Ah	; "К" - |■   ■ ■ | (offset 140Eh)
	.db 089h	; "Й" - |■   ■  ■| (offset 140Fh)
	.db 088h	; "И" - |■   ■   | (offset 1410h)
	.db 088h	; "И" - |■   ■   | (offset 1411h)
	.db 087h	; "З" - |■    ■■■| (offset 1412h)
	.db 086h	; "Ж" - |■    ■■ | (offset 1413h)
	.db 086h	; "Ж" - |■    ■■ | (offset 1414h)
	.db 085h	; "Е" - |■    ■ ■| (offset 1415h)
	.db 084h	; "Д" - |■    ■  | (offset 1416h)
	.db 084h	; "Д" - |■    ■  | (offset 1417h)
	.db 083h	; "Г" - |■     ■■| (offset 1418h)
	.db 082h	; "В" - |■     ■ | (offset 1419h)
	.db 082h	; "В" - |■     ■ | (offset 141Ah)
	.db 081h	; "Б" - |■      ■| (offset 141Bh)
	.db 080h	; "А" - |■       | (offset 141Ch)
	.db 080h	; "А" - |■       | (offset 141Dh)
	.db 07Fh	; "" - | ■■■■■■■| (offset 141Eh)
	.db 07Eh	; "~" - | ■■■■■■ | (offset 141Fh)
	.db 07Eh	; "~" - | ■■■■■■ | (offset 1420h)
	.db 07Dh	; "}" - | ■■■■■ ■| (offset 1421h)
	.db 07Ch	; "|" - | ■■■■■  | (offset 1422h)
	.db 07Ch	; "|" - | ■■■■■  | (offset 1423h)
	.db 07Bh	; "{" - | ■■■■ ■■| (offset 1424h)
	.db 07Ah	; "z" - | ■■■■ ■ | (offset 1425h)
	.db 07Ah	; "z" - | ■■■■ ■ | (offset 1426h)
	.db 079h	; "y" - | ■■■■  ■| (offset 1427h)
	.db 078h	; "x" - | ■■■■   | (offset 1428h)
	.db 077h	; "w" - | ■■■ ■■■| (offset 1429h)
	.db 077h	; "w" - | ■■■ ■■■| (offset 142Ah)
	.db 076h	; "v" - | ■■■ ■■ | (offset 142Bh)
	.db 075h	; "u" - | ■■■ ■ ■| (offset 142Ch)
	.db 075h	; "u" - | ■■■ ■ ■| (offset 142Dh)
	.db 074h	; "t" - | ■■■ ■  | (offset 142Eh)
	.db 073h	; "s" - | ■■■  ■■| (offset 142Fh)
	.db 073h	; "s" - | ■■■  ■■| (offset 1430h)
	.db 072h	; "r" - | ■■■  ■ | (offset 1431h)
	.db 071h	; "q" - | ■■■   ■| (offset 1432h)
	.db 070h	; "p" - | ■■■    | (offset 1433h)
	.db 070h	; "p" - | ■■■    | (offset 1434h)
	.db 06Fh	; "o" - | ■■ ■■■■| (offset 1435h)
	.db 06Eh	; "n" - | ■■ ■■■ | (offset 1436h)
	.db 06Eh	; "n" - | ■■ ■■■ | (offset 1437h)
	.db 06Dh	; "m" - | ■■ ■■ ■| (offset 1438h)
	.db 06Ch	; "l" - | ■■ ■■  | (offset 1439h)
	.db 06Ch	; "l" - | ■■ ■■  | (offset 143Ah)
	.db 06Bh	; "k" - | ■■ ■ ■■| (offset 143Bh)
	.db 06Ah	; "j" - | ■■ ■ ■ | (offset 143Ch)
	.db 069h	; "i" - | ■■ ■  ■| (offset 143Dh)
	.db 069h	; "i" - | ■■ ■  ■| (offset 143Eh)
	.db 068h	; "h" - | ■■ ■   | (offset 143Fh)
	.db 067h	; "g" - | ■■  ■■■| (offset 1440h)
	.db 067h	; "g" - | ■■  ■■■| (offset 1441h)
	.db 066h	; "f" - | ■■  ■■ | (offset 1442h)
	.db 065h	; "e" - | ■■  ■ ■| (offset 1443h)
	.db 064h	; "d" - | ■■  ■  | (offset 1444h)
	.db 064h	; "d" - | ■■  ■  | (offset 1445h)
	.db 063h	; "c" - | ■■   ■■| (offset 1446h)
	.db 062h	; "b" - | ■■   ■ | (offset 1447h)
	.db 061h	; "a" - | ■■    ■| (offset 1448h)
	.db 061h	; "a" - | ■■    ■| (offset 1449h)
	.db 060h	; "`" - | ■■     | (offset 144Ah)
	.db 05Fh	; "_" - | ■ ■■■■■| (offset 144Bh)
	.db 05Fh	; "_" - | ■ ■■■■■| (offset 144Ch)
	.db 05Eh
	.db 05Dh
	.db 05Ch	; "\" - | ■ ■■■  | (offset 144Fh)
	.db 05Ch	; "\" - | ■ ■■■  | (offset 1450h)
	.db 05Bh	; "[" - | ■ ■■ ■■| (offset 1451h)
	.db 05Ah	; "Z" - | ■ ■■ ■ | (offset 1452h)
	.db 059h	; "Y" - | ■ ■■  ■| (offset 1453h)
	.db 059h	; "Y" - | ■ ■■  ■| (offset 1454h)
	.db 058h	; "X" - | ■ ■■   | (offset 1455h)
	.db 057h	; "W" - | ■ ■ ■■■| (offset 1456h)
	.db 056h	; "V" - | ■ ■ ■■ | (offset 1457h)
	.db 056h	; "V" - | ■ ■ ■■ | (offset 1458h)
	.db 055h	; "U" - | ■ ■ ■ ■| (offset 1459h)
	.db 054h	; "T" - | ■ ■ ■  | (offset 145Ah)
	.db 054h	; "T" - | ■ ■ ■  | (offset 145Bh)
	.db 053h	; "S" - | ■ ■  ■■| (offset 145Ch)
	.db 052h	; "R" - | ■ ■  ■ | (offset 145Dh)
	.db 051h	; "Q" - | ■ ■   ■| (offset 145Eh)
	.db 051h	; "Q" - | ■ ■   ■| (offset 145Fh)
	.db 050h	; "P" - | ■ ■    | (offset 1460h)
	.db 04Fh	; "O" - | ■  ■■■■| (offset 1461h)
	.db 04Eh	; "N" - | ■  ■■■ | (offset 1462h)
	.db 04Eh	; "N" - | ■  ■■■ | (offset 1463h)
	.db 04Dh	; "M" - | ■  ■■ ■| (offset 1464h)
	.db 04Ch	; "L" - | ■  ■■  | (offset 1465h)
	.db 04Bh	; "K" - | ■  ■ ■■| (offset 1466h)
	.db 04Bh	; "K" - | ■  ■ ■■| (offset 1467h)
	.db 04Ah	; "J" - | ■  ■ ■ | (offset 1468h)
	.db 049h	; "I" - | ■  ■  ■| (offset 1469h)
	.db 048h	; "H" - | ■  ■   | (offset 146Ah)
	.db 048h	; "H" - | ■  ■   | (offset 146Bh)
	.db 047h	; "G" - | ■   ■■■| (offset 146Ch)
	.db 046h	; "F" - | ■   ■■ | (offset 146Dh)
	.db 045h	; "E" - | ■   ■ ■| (offset 146Eh)
	.db 045h	; "E" - | ■   ■ ■| (offset 146Fh)
	.db 044h	; "D" - | ■   ■  | (offset 1470h)
	.db 043h	; "C" - | ■    ■■| (offset 1471h)
	.db 042h	; "B" - | ■    ■ | (offset 1472h)
	.db 042h	; "B" - | ■    ■ | (offset 1473h)
	.db 041h	; "A" - | ■     ■| (offset 1474h)
	.db 040h	; "@" - | ■      | (offset 1475h)
	.db 03Fh	; "?" - |  ■■■■■■| (offset 1476h)
	.db 03Eh	; ">" - |  ■■■■■ | (offset 1477h)
	.db 03Eh	; ">" - |  ■■■■■ | (offset 1478h)
	.db 03Dh	; "=" - |  ■■■■ ■| (offset 1479h)
	.db 03Ch	; "<" - |  ■■■■  | (offset 147Ah)
	.db 03Bh	; ";" - |  ■■■ ■■| (offset 147Bh)
	.db 03Bh	; ";" - |  ■■■ ■■| (offset 147Ch)
	.db 03Ah	; ":" - |  ■■■ ■ |
	.db 039h	; "8" - |  ■■■  ■|
	.db 038h	; "8" - |  ■■■   | (offset 147Fh)
	.db 037h	; "7" - |  ■■ ■■■|
	.db 036h	; "6" - |  ■■ ■■ |
	.db 035h	; "5" - |  ■■ ■ ■| (offset 1482h)
	.db 035h	; "5" - |  ■■ ■ ■| (offset 1483h)
	.db 034h	; "4" - |  ■■ ■  | (offset 1484h)
	.db 034h	; "4" - |  ■■ ■  | (offset 1485h)
	.db 033h	; "3" - |  ■■  ■■| (offset 1486h)
	.db 032h	; "2" - |  ■■  ■ | (offset 1487h)
	.db 031h	; "1" - |  ■■   ■| (offset 1488h)
	.db 031h	; "1" - |  ■■   ■| (offset 1489h)
	.db 030h	; "0" - |  ■■    | (offset 148Ah)
	.db 02Fh	; "/" - |  ■ ■■■■| (offset 148Bh)
	.db 02Eh	; "." - |  ■ ■■■ | (offset 148Ch)
	.db 02Eh	; "." - |  ■ ■■■ | (offset 148Dh)
	.db 02Dh	; "-" - |  ■ ■■ ■| (offset 148Eh)
	.db 02Ch	; "," - |  ■ ■■  | (offset 148Fh)
	.db 02Bh	; "+" - |  ■ ■ ■■| (offset 1490h)
	.db 02Ah	; "*" - |  ■ ■ ■ | (offset 1491h)
	.db 02Ah	; "*" - |  ■ ■ ■ | (offset 1492h)
	.db 029h	; ")" - |  ■ ■  ■| (offset 1493h)
	.db 028h	; "(" - |  ■ ■   | (offset 1494h)
	.db 027h	; "'" - |  ■  ■■■| (offset 1495h)
	.db 027h	; "'" - |  ■  ■■■| (offset 1496h)
	.db 026h	; "&" - |  ■  ■■ | (offset 1497h)
	.db 025h	; "%" - |  ■  ■ ■| (offset 1498h)
	.db 024h	; "$" - |  ■  ■  | (offset 1499h)
	.db 024h	; "$" - |  ■  ■  |
	.db 023h	; "#" - |  ■   ■■|
	.db 022h	; """ - |  ■   ■ | (offset 149Ch)
	.db 021h	; "!" - |  ■    ■| (offset 149Dh)
	.db 020h	; " " - |  ■     | (offset 149Eh)
	.db 020h	; " " - |  ■     | (offset 149Fh)
	.db 01Fh	; "_" - |   ■■■■■| (offset 14A0h)
	.db 01Eh	; "_" - |   ■■■■ | (offset 14A1h)
	.db 01Dh	; "_" - |   ■■■ ■| (offset 14A2h)
	.db 01Ch	; "_" - |   ■■■  | (offset 14A3h)
	.db 01Ch	; "_" - |   ■■■  | (offset 14A4h)
	.db 01Bh	; "_" - |   ■■ ■■| (offset 14A5h)
	.db 01Ah	; "_" - |   ■■ ■ | (offset 14A6h)
	.db 019h	; "_" - |   ■■  ■| (offset 14A7h)
	.db 019h	; "_" - |   ■■  ■| (offset 14A8h)
	.db 018h	; "_" - |   ■■   |
	.db 017h	; "_" - |   ■ ■■■| (offset 14AAh)
	.db 016h	; "_" - |   ■ ■■ | (offset 14ABh)
	.db 015h	; "_" - |   ■ ■ ■| (offset 14ACh)
	.db 015h	; "_" - |   ■ ■ ■| (offset 14ADh)
	.db 014h	; "_" - |   ■ ■  | (offset 14AEh)
	.db 013h	; "_" - |   ■  ■■| (offset 14AFh)
	.db 012h	; "_" - |   ■  ■ | (offset 14B0h)
	.db 012h	; "_" - |   ■  ■ | (offset 14B1h)
	.db 011h	; "_" - |   ■   ■| (offset 14B2h)
	.db 010h	; "_" - |   ■    | (offset 14B3h)
	.db 00Fh	; "_" - |    ■■■■| (offset 14B4h)
	.db 00Eh	; "_" - |    ■■■ | (offset 14B5h)
	.db 00Eh	; "_" - |    ■■■ | (offset 14B6h)
	.db 00Dh	; "_" - |    ■■ ■| (offset 14B7h)
	.db 00Ch	; "_" - |    ■■  | (offset 14B8h)
	.db 00Bh	; "_" - |    ■ ■■| (offset 14B9h)
	.db 00Ah	; "_" - |    ■ ■ | (offset 14BAh)
	.db 00Ah	; "_" - |    ■ ■ | (offset 14BBh)
	.db 009h	; "_" - |    ■  ■| (offset 14BCh)
	.db 008h	; "_" - |    ■   | (offset 14BDh)
	.db 007h	; "_" - |     ■■■| (offset 14BEh)
	.db 007h	; "_" - |     ■■■| (offset 14BFh)
	.db 006h	; "_" - |     ■■ | (offset 14C0h)
	.db 005h	; "_" - |     ■ ■| (offset 14C1h)
	.db 004h	; "_" - |     ■  | (offset 14C2h)
	.db 003h	; "_" - |      ■■|
	.db 003h	; "_" - |      ■■|
	.db 002h	; "_" - |      ■ | (offset 14C5h)
	.db 001h	; "_" - |       ■| (offset 14C6h)
	.db 000h	; "_" - |        | (offset 14C7h)
;
L_14C8:	CPI     028h	; << L_018F
	RC
	PUSH PSW
	PUSH B
	PUSH D
	PUSH H
	PUSH PSW
	MVI  D, 000h
	MOV  E, A
	LXI  H, 026ACh	;+
	CALL    L_16DC
	MOV  A, L
	INR  A
	INR  A
	STA     D_0B5D
	POP  PSW
	MVI  D, 000h
	MOV  E, A
	LXI  H, 01A0Ah	;+
	CALL    L_16DC
	MOV  A, L
	STA     D_0B5C
	POP  H
	POP  D
	POP  B
	POP  PSW
	RET
;
;;D_14F2:	.db 000h	; "_" - |        | (offset 14F2h)
;;D_14F3:	.db 000h	; "_" - |        | (offset 14F3h)
;;D_14F4:	.db 000h	; "_" - |        | (offset 14F4h)
;;D_14F5:	.db 000h	; "_" - |        | (offset 14F5h)
;;;
;;L_14F6:	PUSH D		; << L_014A
;;	PUSH B
;;	PUSH PSW
;;	CALL    L_1500
;;	POP  PSW
;;	POP  B
;;	POP  D
;;	RET
;;;
;;L_1500:	PUSH H
;;	MVI  H, 000h
;;	MOV  L, C
;;	SHLD    D_1C39
;;	MOV  L, B
;;	SHLD    D_1C3B
;;	XCHG
;;	SHLD    D_1C3D
;;	XCHG
;;	DCX  H
;;	DCX  H
;;	DCX  H
;;	SHLD    D_1C3F
;;	CALL    L_1657
;;	POP  H
;;	RC
;;	PUSH H
;;	LDA     D_1C36
;;	STA     D_1C3A
;;	LDA     D_1C39
;;	STAX D
;;	INX  D
;;	CALL    L_159C
;;	LXI  H, D_1C3B
;;	MOV  B, M
;;	INX  H
;;	MOV  A, B
;;	STAX D
;;	INX  D
;;	LDA     D_1C38
;;	MOV  M, A
;;	LXI  H, D_14F4
;;	MOV  M, A
;;	INX  H
;;	MVI  M, 000h
;;L_153D:	CALL    L_1560
;;	RLC
;;	RLC
;;	RLC
;;	RLC
;;	STA     X_154D+1
;;	CALL    L_156C
;;	CALL    L_1560
;;X_154D:	ORI     000h
;;	LHLD    D_1C3F
;;	STAX D
;;	INX  D
;;	CALL    L_1657
;;	POP  H
;;	RC
;;	PUSH H
;;	CALL    L_156C
;;	JMP     L_153D
;;;
;;L_1560:	LDA     D_14F5
;;	LXI  H, D_14F3
;;	ORA  M
;;	JZ      L_01EF
;;	XRA  A
;;	RET
;;;
;;L_156C:	LXI  H, D_1C36
;;	INR  M
;;	LHLD    D_14F2
;;	INX  H
;;	SHLD    D_14F2
;;	DCR  C
;;	RNZ
;;	CALL    L_159C
;;	LXI  H, D_1C38
;;	INR  M
;;	LHLD    D_14F4
;;	INX  H
;;	SHLD    D_14F4
;;	DCR  B
;;	RNZ
;;	LDA     D_1C3C
;;	STA     D_1C38
;;	LDA     D_1C3A
;;	STA     D_1C36
;;	LDA     X_154D+1
;;	STAX D
;;	POP  H
;;	POP  H
;;	RET
;;;
;;L_159C:	LDA     D_1C39
;;	MOV  C, A
;;	LXI  H, D_14F2
;;	LDA     D_1C3A
;;	STA     D_1C36
;;	MOV  M, A
;;	INX  H
;;	MVI  M, 000h
;;	RET
;;;
;;L_15AE:	PUSH PSW	; << L_014D
;;	PUSH B
;;	PUSH D
;;	PUSH H
;;	SHLD    D_1C3D
;;	XCHG
;;	SHLD    D_1C3B
;;	PUSH B
;;	POP  H
;;	SHLD    D_1C39
;;	ORA  A
;;	JZ      L_15D2
;;	DCR  A
;;	JZ      L_15CC
;;	LXI  H, M_0000	; ?
;;	JMP     L_15D5
;;;
;;L_15CC:	LXI  H, 000C8h	;+
;;	JMP     L_15D5
;;;
;;L_15D2:	LXI  H, 037C8h	;+
;;L_15D5:	SHLD    L_160C
;;	LHLD    D_1C3D
;;	MOV  C, M
;;	INX  H
;;	MOV  B, M
;;	XCHG
;;	INX  D
;;	LHLD    D_1C39
;;	SHLD    D_14F2
;;L_15E6:	LDAX D
;;	RRC
;;	RRC
;;	RRC
;;	RRC
;;	CALL    L_15F6
;;	LDAX D
;;	INX  D
;;	CALL    L_15F6
;;	JMP     L_15E6
;;;
;;L_15F6:	ANI     00Fh
;;	MOV  H, A
;;	LDA     D_1C3A
;;	MOV  L, A
;;	LDA     D_1C3C
;;	ORA  L
;;	JNZ     L_1635
;;	MOV  A, H
;;	LXI  H, L_1635
;;	PUSH H
;;	MOV  H, A
;;	MOV  A, H
;;	ORA  A
L_160C:	NOP
;;	NOP
;;	PUSH B
;;	PUSH D
;;	LDA     D_1C39
;;	MOV  C, A
;;	LDA     D_1C3B
;;	MOV  B, A
;;	JC      L_162F
;;	JZ      L_162F
;;	MOV  E, H
;;	LXI  H, D_14F4
;;	MOV  A, M
;;	CMP  E
;;	MOV  M, E
;;	CNZ     L_0774
;;	MOV  A, B
;;	CALL    L_07B3
;;	JMP     L_1632
;;;
;;L_162F:	CALL    L_07D1
;;L_1632:	POP  D
;;	POP  B
;;	POP  H
;;L_1635:	LHLD    D_1C39
;;	INX  H
;;	SHLD    D_1C39
;;	DCR  C
;;	RNZ
;;	LHLD    D_14F2
;;	SHLD    D_1C39
;;	LHLD    D_1C3D
;;	MOV  C, M
;;	LHLD    D_1C3B
;;	INX  H
;;	SHLD    D_1C3B
;;	DCR  B
;;	RNZ
;;	POP  H
;;	POP  H
;;	POP  D
;;	POP  B
;;	POP  PSW
;;	RET
;
L_1657:	MOV  A, H	; << L_0186
	SUB  D
	RNZ
	MOV  A, L
	SUB  E
	RET
;
L_165D:	XRA  A		; << L_0171
	MOV  A, H
	ANI     080h
	DAD  D
	JNZ     L_166B
	RAR
	XRA  H
	RAL
	CC      L_1734
L_166B:	XRA  A		; << L_017D
	ADD  H
	RNZ
	ADD  L
	RZ
	XRA  A
	INR  A
	RET
;
;;L_1673:	PUSH D		; << L_0174
;;	XCHG
;;	CALL    L_168D
;;	CALL    L_165D
;;	POP  D
;;	RET
;
L_168D:	MOV  A, H
	CMA
	MOV  H, A
	MOV  A, L
	CMA
	MOV  L, A
	INX  H
	RET
;
L_1695:	PUSH B		; << L_0177
	PUSH D
	CALL    L_16CC
	XRA  A
	ADD  H
	JZ      L_16A5
	XRA  A
	ADD  D
	CNZ     L_1734
	XCHG
L_16A5:	MOV  A, L
	LXI  H, M_0000	; ?
L_16A9:	STC
	CMC
	RAR
	JNC     L_16B3
	DAD  D
	CC      L_1734
L_16B3:	XCHG
	DAD  H
	CC      L_1734
	XCHG
	ORA  A
	JNZ     L_16A9
	POP  D
L_16BE:	MOV  A, H
	RLC
	CC      L_1734
	MOV  A, B
	RAL
	CC      L_168D
	POP  B
	JMP     L_166B
;
L_16CC:	MOV  B, H
	MOV  A, H
	RAL
	CC      L_168D
	XCHG
	MOV  A, H
	XRA  B
	MOV  B, A
	MOV  A, H
	RAL
	JC      L_168D
	RET
;
L_16DC:	PUSH B		; << L_017A
	XRA  A
	ORA  E
	ORA  D
	CZ      L_1734
	CALL    L_16CC
	MOV  A, H
	ORA  D
	RLC
	CC      L_1734
	PUSH B
	MOV  C, E
	MOV  B, D
	LXI  D, M_0000	; ?
	PUSH D
	XCHG
	LXI  H, M_0001	; ?
L_16F7:	DAD  H
	XCHG
	DAD  H
	CALL    L_1726
	XCHG
	JNC     L_16F7
	XCHG
L_1702:	XCHG
	CALL    L_172B
	JZ      L_171F
	XCHG
	CALL    L_172B
	CALL    L_1726
	JM      L_1702
	MOV  A, C
	SUB  L
	MOV  C, A
	MOV  A, B
	SBB  H
	MOV  B, A
	XTHL
	DAD  D
	XTHL
	JMP     L_1702
;
L_171F:	POP  H
	MOV  E, C
	MOV  D, B
	POP  B
	JMP     L_16BE
;
L_1726:	MOV  A, C
	SUB  L
	MOV  A, B
	SBB  H
	RET
;
L_172B:	XRA  A
	MOV  A, H
	RAR
	MOV  H, A
	MOV  A, L
	RAR
	MOV  L, A
	ORA  H
	RET
;
L_1734:	LXI  H, 07FFFh	;+
	RET
;
;;L_1744:	PUSH B		; << L_0180
;;	MVI  B, 000h
;;	LXI  H, M_0000	; ?
;;L_174A:	LDAX D
;;	SUI     030h
;;	MOV  C, A
;;	JM      L_176C
;;	CPI     00Ah
;;	JP      L_176C
;;	PUSH D
;;	LXI  D, M_000A	; ?
;;	CALL    L_1695
;;	MVI  D, 000h
;;	MOV  E, C
;;	CALL    L_165D
;;	POP  D
;;	INX  D
;;	MVI  A, 001h
;;	ORA  B
;;	MOV  B, A
;;	JMP     L_174A
;;;
;;L_176C:	MOV  A, C
;;	CPI     0F0h
;;	MOV  A, B
;;	RRC
;;	JC      L_16BE
;;	JNZ     L_177B
;;	INX  D
;;	JMP     L_174A
;;;
;;L_177B:	MOV  A, B
;;	RLC
;;	RLC
;;	CC      M_0000	; ?
;;	MOV  A, C
;;	CPI     0FDh
;;	JNZ     L_178F
;;	MVI  A, 0C0h
;;	ORA  B
;;	MOV  B, A
;;	INX  D
;;	JMP     L_174A
;;;
;;L_178F:	CPI     0FBh
;;	CNZ     M_0000	; ?
;;	MVI  A, 040h
;;	ORA  B
;;	MOV  B, A
;;	INX  D
;;	JMP     L_174A
;
L_179C:	PUSH B		; << L_0183
	PUSH H
	LXI  B, M_0000	; ?
	PUSH H
	DAD  H
	POP  H
	JNC     L_17AF
	MVI  A, 02Dh	; '-'
	STAX D
	INR  B
	INX  D
	CALL    L_168D
L_17AF:	XCHG
	SHLD    D_17F1
	XCHG
	LXI  D, 02710h	;=10000
	CALL    L_17DB
	LXI  D, 003E8h	;=1000
	CALL    L_17DB
	LXI  D, 00064h	;=100
	CALL    L_17DB
	LXI  D, 0000Ah	;=10
	CALL    L_17DB
	MOV  A, L
	ADI     030h
	INR  C
	LHLD    D_17F1
	XCHG
	STAX D
	MOV  A, C
	ADD  B
	INX  D
	POP  H
	POP  B
	RET
;
L_17DB:	CALL    L_16DC
	XCHG
	MOV  A, E
	ORA  C
	RZ
	MOV  A, E
	ADI     030h
	INR  C
	XCHG
	LHLD    D_17F1
	MOV  M, A
	INX  H
	SHLD    D_17F1
	XCHG
	RET
;
D_17F1:	.dw 00000h
;
D_1808:	.db 000h	; |        | (offset 1808h)
	.db 000h	; |        | (offset 1809h)
	.db 000h	; |        | (offset 180Ah)
	.db 000h	; |        | (offset 180Bh)
	.db 000h	; |        | (offset 180Ch)
	.db 07Ch	; | ■■■■■  | (offset 180Dh)
	.db 0AAh	; |■ ■ ■ ■ | (offset 180Eh)
	.db 0A2h	; |■ ■   ■ | (offset 180Fh)
	.db 0AAh	; |■ ■ ■ ■ | (offset 1810h)
	.db 07Ch	; | ■■■■■  | (offset 1811h)
	.db 07Ch	; | ■■■■■  | (offset 1812h)
	.db 0D6h	; |■■ ■ ■■ | (offset 1813h)
	.db 0DEh	; |■■ ■■■■ | (offset 1814h)
	.db 0D6h	; |■■ ■ ■■ | (offset 1815h)
	.db 07Ch	; | ■■■■■  | (offset 1816h)
	.db 018h	; |   ■■   |
	.db 03Ch	; |  ■■■■  | (offset 1818h)
	.db 078h	; | ■■■■   | (offset 1819h)
	.db 03Ch	; |  ■■■■  | (offset 181Ah)
	.db 018h	; |   ■■   |
	.db 010h	; |   ■    | (offset 181Ch)
	.db 038h	; |  ■■■   | (offset 181Dh)
	.db 07Ch	; | ■■■■■  | (offset 181Eh)
	.db 038h	; |  ■■■   | (offset 181Fh)
	.db 010h	; |   ■    | (offset 1820h)
	.db 038h	; |  ■■■   | (offset 1821h)
	.db 092h	; |■  ■  ■ | (offset 1822h)
	.db 0FEh	; |■■■■■■■ | (offset 1823h)
	.db 092h	; |■  ■  ■ | (offset 1824h)
	.db 038h	; |  ■■■   | (offset 1825h)
	.db 038h	; |  ■■■   | (offset 1826h)
	.db 01Dh	; |   ■■■ ■| (offset 1827h)
	.db 0FEh	; |■■■■■■■ | (offset 1828h)
	.db 01Dh	; |   ■■■ ■| (offset 1829h)
	.db 038h	; |  ■■■   | (offset 182Ah)
	.db 000h	; |        | (offset 182Bh)
	.db 010h	; |   ■    | (offset 182Ch)
	.db 038h	; |  ■■■   | (offset 182Dh)
	.db 010h	; |   ■    | (offset 182Eh)
	.db 000h	; |        | (offset 182Fh)
	.db 0FEh	; |■■■■■■■ | (offset 1830h)
	.db 0EEh	; |■■■ ■■■ | (offset 1831h)
	.db 0C6h	; |■■   ■■ | (offset 1832h)
	.db 0EEh	; |■■■ ■■■ | (offset 1833h)
	.db 0FEh	; |■■■■■■■ | (offset 1834h)
	.db 000h	; |        | (offset 1835h)
	.db 038h	; |  ■■■   | (offset 1836h)
	.db 028h	; |  ■ ■   | (offset 1837h)
	.db 038h	; |  ■■■   | (offset 1838h)
	.db 000h	; |        | (offset 1839h)
	.db 0FEh	; |■■■■■■■ | (offset 183Ah)
	.db 0C6h	; |■■   ■■ | (offset 183Bh)
	.db 0D6h	; |■■ ■ ■■ | (offset 183Ch)
	.db 0C6h	; |■■   ■■ | (offset 183Dh)
	.db 0FEh	; |■■■■■■■ | (offset 183Eh)
	.db 030h	; |  ■■    | (offset 183Fh)
	.db 048h	; | ■  ■   | (offset 1840h)
	.db 030h	; |  ■■    | (offset 1841h)
	.db 00Ch	; |    ■■  | (offset 1842h)
	.db 00Ch	; |    ■■  | (offset 1843h)
	.db 008h	; |    ■   | (offset 1844h)
	.db 054h	; | ■ ■ ■  | (offset 1845h)
	.db 0F2h	; |■■■■  ■ | (offset 1846h)
	.db 054h	; | ■ ■ ■  | (offset 1847h)
	.db 008h	; |    ■   | (offset 1848h)
	.db 080h	; |■       | (offset 1849h)
	.db 080h	; |■       | (offset 184Ah)
	.db 0FCh	; |■■■■■■  | (offset 184Bh)
	.db 012h	; |   ■  ■ | (offset 184Ch)
	.db 01Ch	; |   ■■■  | (offset 184Dh)
	.db 080h	; |■       | (offset 184Eh)
	.db 0FEh	; |■■■■■■■ | (offset 184Fh)
	.db 00Ah	; |    ■ ■ | (offset 1850h)
	.db 04Ah	; | ■  ■ ■ | (offset 1851h)
	.db 03Eh	; |  ■■■■■ | (offset 1852h)
	.db 054h	; | ■ ■ ■  | (offset 1853h)
	.db 038h	; |  ■■■   | (offset 1854h)
	.db 0EEh	; |■■■ ■■■ | (offset 1855h)
	.db 038h	; |  ■■■   | (offset 1856h)
	.db 054h	; | ■ ■ ■  | (offset 1857h)
	.db 000h	; |        | (offset 1858h)
	.db 0FEh	; |■■■■■■■ | (offset 1859h)
	.db 07Ch	; | ■■■■■  | (offset 185Ah)
	.db 038h	; |  ■■■   | (offset 185Bh)
	.db 010h	; |   ■    | (offset 185Ch)
	.db 010h	; |   ■    | (offset 185Dh)
	.db 038h	; |  ■■■   | (offset 185Eh)
	.db 07Ch	; | ■■■■■  | (offset 185Fh)
	.db 0FEh	; |■■■■■■■ | (offset 1860h)
	.db 000h	; |        | (offset 1861h)
	.db 028h	; |  ■ ■   | (offset 1862h)
	.db 06Ch	; | ■■ ■■  | (offset 1863h)
	.db 0FEh	; |■■■■■■■ | (offset 1864h)
	.db 06Ch	; | ■■ ■■  | (offset 1865h)
	.db 028h	; |  ■ ■   | (offset 1866h)
	.db 000h	; |        | (offset 1867h)
	.db 0BEh	; |■ ■■■■■ | (offset 1868h)
	.db 000h	; |        | (offset 1869h)
	.db 0BEh	; |■ ■■■■■ | (offset 186Ah)
	.db 000h	; |        | (offset 186Bh)
	.db 08Ch	; |■   ■■  | (offset 186Ch)
	.db 08Ah	; |■   ■ ■ | (offset 186Dh)
	.db 07Eh	; | ■■■■■■ | (offset 186Eh)
	.db 002h	; |      ■ | (offset 186Fh)
	.db 07Ah	; | ■■■■ ■ | (offset 1870h)
	.db 090h	; |■  ■    | (offset 1871h)
	.db 0ACh	; |■ ■ ■■  | (offset 1872h)
	.db 0AAh	; |■ ■ ■ ■ | (offset 1873h)
	.db 06Ah	; | ■■ ■ ■ | (offset 1874h)
	.db 012h	; |   ■  ■ | (offset 1875h)
	.db 0E0h	; |■■■     | (offset 1876h)
	.db 0E0h	; |■■■     | (offset 1877h)
	.db 0E0h	; |■■■     | (offset 1878h)
	.db 0E0h	; |■■■     | (offset 1879h)
	.db 0E0h	; |■■■     | (offset 187Ah)
	.db 008h	; |    ■   | (offset 187Bh)
	.db 0A4h	; |■ ■  ■  | (offset 187Ch)
	.db 0FEh	; |■■■■■■■ | (offset 187Dh)
	.db 0A4h	; |■ ■  ■  | (offset 187Eh)
	.db 008h	; |    ■   | (offset 187Fh)
	.db 008h	; |    ■   | (offset 1880h)
	.db 00Ch	; |    ■■  | (offset 1881h)
	.db 0FEh	; |■■■■■■■ | (offset 1882h)
	.db 00Ch	; |    ■■  | (offset 1883h)
	.db 008h	; |    ■   | (offset 1884h)
	.db 020h	; |  ■     | (offset 1885h)
	.db 060h	; | ■■     | (offset 1886h)
	.db 0FEh	; |■■■■■■■ | (offset 1887h)
	.db 060h	; | ■■     | (offset 1888h)
	.db 020h	; |  ■     | (offset 1889h)
	.db 010h	; |   ■    | (offset 188Ah)
	.db 010h	; |   ■    | (offset 188Bh)
	.db 07Ch	; | ■■■■■  | (offset 188Ch)
	.db 038h	; |  ■■■   | (offset 188Dh)
	.db 010h	; |   ■    | (offset 188Eh)
	.db 010h	; |   ■    | (offset 188Fh)
	.db 038h	; |  ■■■   | (offset 1890h)
	.db 07Ch	; | ■■■■■  | (offset 1891h)
	.db 010h	; |   ■    | (offset 1892h)
	.db 010h	; |   ■    | (offset 1893h)
	.db 070h	; | ■■■    | (offset 1894h)
	.db 040h	; | ■      | (offset 1895h)
	.db 040h	; | ■      | (offset 1896h)
	.db 040h	; | ■      | (offset 1897h)
	.db 040h	; | ■      | (offset 1898h)
	.db 010h	; |   ■    | (offset 1899h)
	.db 038h	; |  ■■■   | (offset 189Ah)
	.db 010h	; |   ■    | (offset 189Bh)
	.db 038h	; |  ■■■   | (offset 189Ch)
	.db 010h	; |   ■    | (offset 189Dh)
	.db 070h	; | ■■■    | (offset 189Eh)
	.db 078h	; | ■■■■   | (offset 189Fh)
	.db 07Ch	; | ■■■■■  | (offset 18A0h)
	.db 078h	; | ■■■■   | (offset 18A1h)
	.db 070h	; | ■■■    | (offset 18A2h)
	.db 01Ch	; |   ■■■  | (offset 18A3h)
	.db 03Ch	; |  ■■■■  | (offset 18A4h)
	.db 07Ch	; | ■■■■■  | (offset 18A5h)
	.db 03Ch	; |  ■■■■  | (offset 18A6h)
	.db 01Ch	; |   ■■■  | (offset 18A7h)
	.db 000h	; |        | (offset 18A8h)
	.db 000h	; |        | (offset 18A9h)
	.db 000h	; |        | (offset 18AAh)
	.db 000h	; |        | (offset 18ABh)
	.db 000h	; |        | (offset 18ACh)
	.db 000h	; |        | (offset 18ADh)
	.db 000h	; |        | (offset 18AEh)
	.db 0BEh	; |■ ■■■■■ | (offset 18AFh)
	.db 000h	; |        | (offset 18B0h)
	.db 000h	; |        | (offset 18B1h)
	.db 000h	; |        | (offset 18B2h)
	.db 006h	; |     ■■ | (offset 18B3h)
	.db 000h	; |        | (offset 18B4h)
	.db 006h	; |     ■■ | (offset 18B5h)
	.db 000h	; |        | (offset 18B6h)
	.db 028h	; |  ■ ■   | (offset 18B7h)
	.db 07Ch	; | ■■■■■  | (offset 18B8h)
	.db 028h	; |  ■ ■   | (offset 18B9h)
	.db 07Ch	; | ■■■■■  | (offset 18BAh)
	.db 028h	; |  ■ ■   | (offset 18BBh)
	.db 044h	; | ■   ■  | (offset 18BCh)
	.db 038h	; |  ■■■   | (offset 18BDh)
	.db 028h	; |  ■ ■   | (offset 18BEh)
	.db 038h	; |  ■■■   | (offset 18BFh)
	.db 044h	; | ■   ■  | (offset 18C0h)
	.db 046h	; | ■   ■■ | (offset 18C1h)
	.db 026h	; |  ■  ■■ | (offset 18C2h)
	.db 010h	; |   ■    | (offset 18C3h)
	.db 0C8h	; |■■  ■   | (offset 18C4h)
	.db 0C4h	; |■■   ■  | (offset 18C5h)
	.db 06Ch	; | ■■ ■■  | (offset 18C6h)
	.db 092h	; |■  ■  ■ | (offset 18C7h)
	.db 0ACh	; |■ ■ ■■  | (offset 18C8h)
	.db 040h	; | ■      | (offset 18C9h)
	.db 0A0h	; |■ ■     | (offset 18CAh)
	.db 000h	; |        | (offset 18CBh)
	.db 016h	; |   ■ ■■ | (offset 18CCh)
	.db 00Eh	; |    ■■■ | (offset 18CDh)
	.db 000h	; |        | (offset 18CEh)
	.db 000h	; |        | (offset 18CFh)
	.db 000h	; |        | (offset 18D0h)
	.db 038h	; |  ■■■   | (offset 18D1h)
	.db 044h	; | ■   ■  | (offset 18D2h)
	.db 082h	; |■     ■ | (offset 18D3h)
	.db 000h	; |        | (offset 18D4h)
	.db 000h	; |        | (offset 18D5h)
	.db 082h	; |■     ■ | (offset 18D6h)
	.db 044h	; | ■   ■  | (offset 18D7h)
	.db 038h	; |  ■■■   | (offset 18D8h)
	.db 000h	; |        | (offset 18D9h)
	.db 048h	; | ■  ■   | (offset 18DAh)
	.db 030h	; |  ■■    | (offset 18DBh)
	.db 0FCh	; |■■■■■■  | (offset 18DCh)
	.db 030h	; |  ■■    | (offset 18DDh)
	.db 048h	; | ■  ■   | (offset 18DEh)
	.db 010h	; |   ■    | (offset 18DFh)
	.db 010h	; |   ■    | (offset 18E0h)
	.db 07Ch	; | ■■■■■  | (offset 18E1h)
	.db 010h	; |   ■    | (offset 18E2h)
	.db 010h	; |   ■    | (offset 18E3h)
	.db 000h	; |        | (offset 18E4h)
	.db 0B0h	; |■ ■■    | (offset 18E5h)
	.db 070h	; | ■■■    | (offset 18E6h)
	.db 000h	; |        | (offset 18E7h)
	.db 000h	; |        | (offset 18E8h)
	.db 010h	; |   ■    | (offset 18E9h)
	.db 010h	; |   ■    | (offset 18EAh)
	.db 010h	; |   ■    | (offset 18EBh)
	.db 010h	; |   ■    | (offset 18ECh)
	.db 010h	; |   ■    | (offset 18EDh)
	.db 000h	; |        | (offset 18EEh)
	.db 0C0h	; |■■      | (offset 18EFh)
	.db 0C0h	; |■■      | (offset 18F0h)
	.db 000h	; |        | (offset 18F1h)
	.db 000h	; |        | (offset 18F2h)
	.db 040h	; | ■      | (offset 18F3h)
	.db 020h	; |  ■     | (offset 18F4h)
	.db 010h	; |   ■    | (offset 18F5h)
	.db 008h	; |    ■   | (offset 18F6h)
	.db 004h	; |     ■  | (offset 18F7h)
	.db 07Ch	; | ■■■■■  | (offset 18F8h)
	.db 0A2h	; |■ ■   ■ | (offset 18F9h)
	.db 092h	; |■  ■  ■ | (offset 18FAh)
	.db 08Ah	; |■   ■ ■ | (offset 18FBh)
	.db 07Ch	; | ■■■■■  | (offset 18FCh)
	.db 000h	; |        | (offset 18FDh)
	.db 008h	; |    ■   | (offset 18FEh)
	.db 004h	; |     ■  | (offset 18FFh)
	.db 0FEh	; |■■■■■■■ | (offset 1900h)
	.db 000h	; |        | (offset 1901h)
	.db 084h	; |■    ■  | (offset 1902h)
	.db 0C2h	; |■■    ■ | (offset 1903h)
	.db 0A2h	; |■ ■   ■ | (offset 1904h)
	.db 092h	; |■  ■  ■ | (offset 1905h)
	.db 08Ch	; |■   ■■  | (offset 1906h)
	.db 042h	; | ■    ■ | (offset 1907h)
	.db 082h	; |■     ■ | (offset 1908h)
	.db 092h	; |■  ■  ■ | (offset 1909h)
	.db 09Ah	; |■  ■■ ■ | (offset 190Ah)
	.db 066h	; | ■■  ■■ | (offset 190Bh)
	.db 030h	; |  ■■    | (offset 190Ch)
	.db 028h	; |  ■ ■   | (offset 190Dh)
	.db 024h	; |  ■  ■  | (offset 190Eh)
	.db 0FEh	; |■■■■■■■ | (offset 190Fh)
	.db 020h	; |  ■     | (offset 1910h)
	.db 04Eh	; | ■  ■■■ | (offset 1911h)
	.db 08Ah	; |■   ■ ■ | (offset 1912h)
	.db 08Ah	; |■   ■ ■ | (offset 1913h)
	.db 08Ah	; |■   ■ ■ | (offset 1914h)
	.db 072h	; | ■■■  ■ | (offset 1915h)
	.db 07Ch	; | ■■■■■  | (offset 1916h)
	.db 092h	; |■  ■  ■ | (offset 1917h)
	.db 092h	; |■  ■  ■ | (offset 1918h)
	.db 092h	; |■  ■  ■ | (offset 1919h)
	.db 064h	; | ■■  ■  | (offset 191Ah)
	.db 000h	; |        |
	.db 002h	; |      ■ |
	.db 0F2h	; |■■■■  ■ | (offset 191Dh)
	.db 00Ah	; |    ■ ■ | (offset 191Eh)
	.db 006h	; |     ■■ | (offset 191Fh)
	.db 06Ch	; | ■■ ■■  | (offset 1920h)
	.db 092h	; |■  ■  ■ | (offset 1921h)
	.db 092h	; |■  ■  ■ | (offset 1922h)
	.db 092h	; |■  ■  ■ | (offset 1923h)
	.db 06Ch	; | ■■ ■■  | (offset 1924h)
	.db 04Ch	; | ■  ■■  | (offset 1925h)
	.db 092h	; |■  ■  ■ | (offset 1926h)
	.db 092h	; |■  ■  ■ | (offset 1927h)
	.db 092h	; |■  ■  ■ | (offset 1928h)
	.db 07Ch	; | ■■■■■  | (offset 1929h)
	.db 000h	; |        | (offset 192Ah)
	.db 0CCh	; |■■  ■■  | (offset 192Bh)
	.db 0CCh	; |■■  ■■  | (offset 192Ch)
	.db 000h	; |        | (offset 192Dh)
	.db 000h	; |        | (offset 192Eh)
	.db 000h	; |        | (offset 192Fh)
	.db 0B6h	; |■ ■■ ■■ | (offset 1930h)
	.db 076h	; | ■■■ ■■ | (offset 1931h)
	.db 000h	; |        | (offset 1932h)
	.db 000h	; |        | (offset 1933h)
	.db 000h	; |        | (offset 1934h)
	.db 010h	; |   ■    | (offset 1935h)
	.db 028h	; |  ■ ■   | (offset 1936h)
	.db 044h	; | ■   ■  | (offset 1937h)
	.db 082h	; |■     ■ | (offset 1938h)
	.db 028h	; |  ■ ■   | (offset 1939h)
	.db 028h	; |  ■ ■   | (offset 193Ah)
	.db 028h	; |  ■ ■   | (offset 193Bh)
	.db 028h	; |  ■ ■   | (offset 193Ch)
	.db 028h	; |  ■ ■   | (offset 193Dh)
	.db 082h	; |■     ■ | (offset 193Eh)
	.db 044h	; | ■   ■  | (offset 193Fh)
	.db 028h	; |  ■ ■   | (offset 1940h)
	.db 010h	; |   ■    | (offset 1941h)
	.db 000h	; |        | (offset 1942h)
	.db 00Ch	; |    ■■  | (offset 1943h)
	.db 002h	; |      ■ | (offset 1944h)
	.db 0B2h	; |■ ■■  ■ | (offset 1945h)
	.db 012h	; |   ■  ■ | (offset 1946h)
	.db 00Ch	; |    ■■  | (offset 1947h)
	.db 07Ch	; | ■■■■■  | (offset 1948h)
	.db 082h	; |■     ■ | (offset 1949h)
	.db 0B2h	; |■ ■■  ■ | (offset 194Ah)
	.db 0AAh	; |■ ■ ■ ■ | (offset 194Bh)
	.db 03Ch	; |  ■■■■  | (offset 194Ch)
	.db 0F8h	; |■■■■■   | (offset 194Dh)
	.db 024h	; |  ■  ■  | (offset 194Eh)
	.db 022h	; |  ■   ■ | (offset 194Fh)
	.db 024h	; |  ■  ■  | (offset 1950h)
	.db 0F8h	; |■■■■■   | (offset 1951h)
	.db 0FEh	; |■■■■■■■ | (offset 1952h)
	.db 092h	; |■  ■  ■ | (offset 1953h)
	.db 092h	; |■  ■  ■ | (offset 1954h)
	.db 092h	; |■  ■  ■ | (offset 1955h)
	.db 06Ch	; | ■■ ■■  | (offset 1956h)
	.db 07Ch	; | ■■■■■  | (offset 1957h)
	.db 082h	; |■     ■ | (offset 1958h)
	.db 082h	; |■     ■ | (offset 1959h)
	.db 082h	; |■     ■ | (offset 195Ah)
	.db 044h	; | ■   ■  | (offset 195Bh)
	.db 082h	; |■     ■ | (offset 195Ch)
	.db 0FEh	; |■■■■■■■ | (offset 195Dh)
	.db 082h	; |■     ■ | (offset 195Eh)
	.db 082h	; |■     ■ | (offset 195Fh)
	.db 07Ch	; | ■■■■■  | (offset 1960h)
	.db 0FEh	; |■■■■■■■ | (offset 1961h)
	.db 092h	; |■  ■  ■ | (offset 1962h)
	.db 092h	; |■  ■  ■ | (offset 1963h)
	.db 092h	; |■  ■  ■ | (offset 1964h)
	.db 082h	; |■     ■ | (offset 1965h)
	.db 0FEh	; |■■■■■■■ | (offset 1966h)
	.db 012h	; |   ■  ■ | (offset 1967h)
	.db 012h	; |   ■  ■ | (offset 1968h)
	.db 012h	; |   ■  ■ | (offset 1969h)
	.db 002h	; |      ■ | (offset 196Ah)
	.db 07Ch	; | ■■■■■  | (offset 196Bh)
	.db 082h	; |■     ■ | (offset 196Ch)
	.db 082h	; |■     ■ | (offset 196Dh)
	.db 092h	; |■  ■  ■ | (offset 196Eh)
	.db 074h	; | ■■■ ■  | (offset 196Fh)
	.db 0FEh	; |■■■■■■■ | (offset 1970h)
	.db 010h	; |   ■    | (offset 1971h)
	.db 010h	; |   ■    | (offset 1972h)
	.db 010h	; |   ■    | (offset 1973h)
	.db 0FEh	; |■■■■■■■ | (offset 1974h)
	.db 000h	; |        | (offset 1975h)
	.db 082h	; |■     ■ | (offset 1976h)
	.db 0FEh	; |■■■■■■■ | (offset 1977h)
	.db 082h	; |■     ■ | (offset 1978h)
	.db 000h	; |        | (offset 1979h)
	.db 042h	; | ■    ■ | (offset 197Ah)
	.db 082h	; |■     ■ | (offset 197Bh)
	.db 082h	; |■     ■ | (offset 197Ch)
	.db 082h	; |■     ■ | (offset 197Dh)
	.db 07Eh	; | ■■■■■■ | (offset 197Eh)
	.db 0FEh	; |■■■■■■■ | (offset 197Fh)
	.db 010h	; |   ■    | (offset 1980h)
	.db 028h	; |  ■ ■   | (offset 1981h)
	.db 044h	; | ■   ■  | (offset 1982h)
	.db 082h	; |■     ■ | (offset 1983h)
	.db 0FEh	; |■■■■■■■ | (offset 1984h)
	.db 080h	; |■       | (offset 1985h)
	.db 080h	; |■       | (offset 1986h)
	.db 080h	; |■       | (offset 1987h)
	.db 0C0h	; |■■      | (offset 1988h)
	.db 0FEh	; |■■■■■■■ | (offset 1989h)
	.db 004h	; |     ■  | (offset 198Ah)
	.db 018h	; |   ■■   |
	.db 004h	; |     ■  | (offset 198Ch)
	.db 0FEh	; |■■■■■■■ | (offset 198Dh)
	.db 0FEh	; |■■■■■■■ | (offset 198Eh)
	.db 008h	; |    ■   | (offset 198Fh)
	.db 010h	; |   ■    | (offset 1990h)
	.db 020h	; |  ■     | (offset 1991h)
	.db 0FEh	; |■■■■■■■ | (offset 1992h)
	.db 07Ch	; | ■■■■■  | (offset 1993h)
	.db 082h	; |■     ■ | (offset 1994h)
	.db 082h	; |■     ■ | (offset 1995h)
	.db 082h	; |■     ■ | (offset 1996h)
	.db 07Ch	; | ■■■■■  | (offset 1997h)
	.db 0FEh	; |■■■■■■■ | (offset 1998h)
	.db 012h	; |   ■  ■ | (offset 1999h)
	.db 012h	; |   ■  ■ | (offset 199Ah)
	.db 012h	; |   ■  ■ | (offset 199Bh)
	.db 00Ch	; |    ■■  | (offset 199Ch)
	.db 07Ch	; | ■■■■■  | (offset 199Dh)
	.db 082h	; |■     ■ | (offset 199Eh)
	.db 0A2h	; |■ ■   ■ | (offset 199Fh)
	.db 0C2h	; |■■    ■ | (offset 19A0h)
	.db 0FCh	; |■■■■■■  | (offset 19A1h)
	.db 0FEh	; |■■■■■■■ | (offset 19A2h)
	.db 012h	; |   ■  ■ | (offset 19A3h)
	.db 032h	; |  ■■  ■ | (offset 19A4h)
	.db 052h	; | ■ ■  ■ | (offset 19A5h)
	.db 08Ch	; |■   ■■  | (offset 19A6h)
	.db 04Ch	; | ■  ■■  | (offset 19A7h)
	.db 092h	; |■  ■  ■ | (offset 19A8h)
	.db 092h	; |■  ■  ■ | (offset 19A9h)
	.db 092h	; |■  ■  ■ | (offset 19AAh)
	.db 064h	; | ■■  ■  | (offset 19ABh)
	.db 002h	; |      ■ | (offset 19ACh)
	.db 002h	; |      ■ | (offset 19ADh)
	.db 0FEh	; |■■■■■■■ | (offset 19AEh)
	.db 002h	; |      ■ | (offset 19AFh)
	.db 002h	; |      ■ | (offset 19B0h)
	.db 07Eh	; | ■■■■■■ | (offset 19B1h)
	.db 080h	; |■       | (offset 19B2h)
	.db 080h	; |■       | (offset 19B3h)
	.db 080h	; |■       | (offset 19B4h)
	.db 07Eh	; | ■■■■■■ | (offset 19B5h)
	.db 03Eh	; |  ■■■■■ | (offset 19B6h)
	.db 040h	; | ■      | (offset 19B7h)
	.db 080h	; |■       | (offset 19B8h)
	.db 040h	; | ■      | (offset 19B9h)
	.db 03Eh	; |  ■■■■■ | (offset 19BAh)
	.db 07Eh	; | ■■■■■■ | (offset 19BBh)
	.db 080h	; |■       | (offset 19BCh)
	.db 070h	; | ■■■    | (offset 19BDh)
	.db 080h	; |■       | (offset 19BEh)
	.db 07Eh	; | ■■■■■■ | (offset 19BFh)
	.db 0C6h	; |■■   ■■ | (offset 19C0h)
	.db 028h	; |  ■ ■   | (offset 19C1h)
	.db 010h	; |   ■    | (offset 19C2h)
	.db 028h	; |  ■ ■   | (offset 19C3h)
	.db 0C6h	; |■■   ■■ | (offset 19C4h)
	.db 006h	; |     ■■ | (offset 19C5h)
	.db 008h	; |    ■   | (offset 19C6h)
	.db 0F0h	; |■■■■    | (offset 19C7h)
	.db 008h	; |    ■   | (offset 19C8h)
	.db 006h	; |     ■■ | (offset 19C9h)
	.db 0C2h	; |■■    ■ | (offset 19CAh)
	.db 0B2h	; |■ ■■  ■ | (offset 19CBh)
	.db 092h	; |■  ■  ■ | (offset 19CCh)
	.db 09Ah	; |■  ■■ ■ | (offset 19CDh)
	.db 086h	; |■    ■■ | (offset 19CEh)
	.db 000h	; |        | (offset 19CFh)
	.db 0FEh	; |■■■■■■■ | (offset 19D0h)
	.db 082h	; |■     ■ | (offset 19D1h)
	.db 082h	; |■     ■ | (offset 19D2h)
	.db 000h	; |        | (offset 19D3h)
	.db 004h	; |     ■  | (offset 19D4h)
	.db 008h	; |    ■   | (offset 19D5h)
	.db 010h	; |   ■    | (offset 19D6h)
	.db 020h	; |  ■     | (offset 19D7h)
	.db 040h	; | ■      | (offset 19D8h)
	.db 000h	; |        | (offset 19D9h)
	.db 082h	; |■     ■ | (offset 19DAh)
	.db 082h	; |■     ■ | (offset 19DBh)
	.db 0FEh	; |■■■■■■■ | (offset 19DCh)
	.db 000h	; |        | (offset 19DDh)
	.db 008h	; |    ■   | (offset 19DEh)
	.db 004h	; |     ■  | (offset 19DFh)
	.db 002h	; |      ■ |
	.db 004h	; |     ■  |
	.db 008h	; |    ■   | (offset 19E2h)
	.db 080h	; |■       | (offset 19E3h)
	.db 080h	; |■       | (offset 19E4h)
	.db 080h	; |■       | (offset 19E5h)
	.db 080h	; |■       | (offset 19E6h)
	.db 080h	; |■       | (offset 19E7h)
	.db 0FEh	; |■■■■■■■ | (offset 19E8h)
	.db 010h	; |   ■    | (offset 19E9h)
	.db 07Ch	; | ■■■■■  | (offset 19EAh)
	.db 082h	; |■     ■ | (offset 19EBh)
	.db 07Ch	; | ■■■■■  | (offset 19ECh)
	.db 0F8h	; |■■■■■   | (offset 19EDh)
	.db 024h	; |  ■  ■  | (offset 19EEh)
	.db 022h	; |  ■   ■ | (offset 19EFh)
	.db 024h	; |  ■  ■  | (offset 19F0h)
	.db 0F8h	; |■■■■■   | (offset 19F1h)
	.db 0FEh	; |■■■■■■■ | (offset 19F2h)
	.db 092h	; |■  ■  ■ | (offset 19F3h)
	.db 092h	; |■  ■  ■ | (offset 19F4h)
	.db 092h	; |■  ■  ■ | (offset 19F5h)
	.db 062h	; | ■■   ■ | (offset 19F6h)
	.db 07Eh	; | ■■■■■■ | (offset 19F7h)
	.db 040h	; | ■      | (offset 19F8h)
	.db 040h	; | ■      | (offset 19F9h)
	.db 040h	; | ■      | (offset 19FAh)
	.db 0FEh	; |■■■■■■■ | (offset 19FBh)
	.db 0C0h	; |■■      | (offset 19FCh)
	.db 07Ch	; | ■■■■■  | (offset 19FDh)
	.db 042h	; | ■    ■ | (offset 19FEh)
	.db 07Eh	; | ■■■■■■ | (offset 19FFh)
	.db 0C0h	; |■■      | (offset 1A00h)
	.db 0FEh	; |■■■■■■■ | (offset 1A01h)
	.db 092h	; |■  ■  ■ | (offset 1A02h)
	.db 092h	; |■  ■  ■ | (offset 1A03h)
	.db 092h	; |■  ■  ■ | (offset 1A04h)
	.db 082h	; |■     ■ | (offset 1A05h)
	.db 038h	; |  ■■■   | (offset 1A06h)
	.db 044h	; | ■   ■  | (offset 1A07h)
	.db 0FEh	; |■■■■■■■ | (offset 1A08h)
	.db 044h	; | ■   ■  | (offset 1A09h)
	.db 038h	; |  ■■■   | (offset 1A0Ah)
	.db 0FEh	; |■■■■■■■ | (offset 1A0Bh)
	.db 002h	; |      ■ | (offset 1A0Ch)
	.db 002h	; |      ■ | (offset 1A0Dh)
	.db 002h	; |      ■ | (offset 1A0Eh)
	.db 006h	; |     ■■ | (offset 1A0Fh)
	.db 0C6h	; |■■   ■■ | (offset 1A10h)
	.db 028h	; |  ■ ■   | (offset 1A11h)
	.db 010h	; |   ■    | (offset 1A12h)
	.db 028h	; |  ■ ■   | (offset 1A13h)
	.db 0C6h	; |■■   ■■ | (offset 1A14h)
	.db 0FEh	; |■■■■■■■ | (offset 1A15h)
	.db 020h	; |  ■     | (offset 1A16h)
	.db 010h	; |   ■    | (offset 1A17h)
	.db 008h	; |    ■   | (offset 1A18h)
	.db 0FEh	; |■■■■■■■ | (offset 1A19h)
	.db 0FEh	; |■■■■■■■ | (offset 1A1Ah)
	.db 040h	; | ■      | (offset 1A1Bh)
	.db 026h	; |  ■  ■■ | (offset 1A1Ch)
	.db 010h	; |   ■    | (offset 1A1Dh)
	.db 0FEh	; |■■■■■■■ | (offset 1A1Eh)
	.db 0FEh	; |■■■■■■■ | (offset 1A1Fh)
	.db 010h	; |   ■    | (offset 1A20h)
	.db 028h	; |  ■ ■   | (offset 1A21h)
	.db 044h	; | ■   ■  | (offset 1A22h)
	.db 082h	; |■     ■ | (offset 1A23h)
	.db 080h	; |■       | (offset 1A24h)
	.db 0F8h	; |■■■■■   | (offset 1A25h)
	.db 004h	; |     ■  | (offset 1A26h)
	.db 002h	; |      ■ | (offset 1A27h)
	.db 0FEh	; |■■■■■■■ | (offset 1A28h)
	.db 0FEh	; |■■■■■■■ | (offset 1A29h)
	.db 004h	; |     ■  | (offset 1A2Ah)
	.db 018h	; |   ■■   |
	.db 004h	; |     ■  | (offset 1A2Ch)
	.db 0FEh	; |■■■■■■■ | (offset 1A2Dh)
	.db 0FEh	; |■■■■■■■ | (offset 1A2Eh)
	.db 010h	; |   ■    | (offset 1A2Fh)
	.db 010h	; |   ■    | (offset 1A30h)
	.db 010h	; |   ■    | (offset 1A31h)
	.db 0FEh	; |■■■■■■■ | (offset 1A32h)
	.db 07Ch	; | ■■■■■  | (offset 1A33h)
	.db 082h	; |■     ■ | (offset 1A34h)
	.db 082h	; |■     ■ | (offset 1A35h)
	.db 082h	; |■     ■ | (offset 1A36h)
	.db 07Ch	; | ■■■■■  | (offset 1A37h)
	.db 0FEh	; |■■■■■■■ | (offset 1A38h)
	.db 002h	; |      ■ | (offset 1A39h)
	.db 002h	; |      ■ | (offset 1A3Ah)
	.db 002h	; |      ■ | (offset 1A3Bh)
	.db 0FEh	; |■■■■■■■ | (offset 1A3Ch)
	.db 08Ch	; |■   ■■  | (offset 1A3Dh)
	.db 052h	; | ■ ■  ■ | (offset 1A3Eh)
	.db 032h	; |  ■■  ■ | (offset 1A3Fh)
	.db 012h	; |   ■  ■ | (offset 1A40h)
	.db 0FEh	; |■■■■■■■ | (offset 1A41h)
	.db 0FEh	; |■■■■■■■ | (offset 1A42h)
	.db 012h	; |   ■  ■ | (offset 1A43h)
	.db 012h	; |   ■  ■ | (offset 1A44h)
	.db 012h	; |   ■  ■ | (offset 1A45h)
	.db 00Ch	; |    ■■  | (offset 1A46h)
	.db 07Ch	; | ■■■■■  | (offset 1A47h)
	.db 082h	; |■     ■ | (offset 1A48h)
	.db 082h	; |■     ■ | (offset 1A49h)
	.db 082h	; |■     ■ | (offset 1A4Ah)
	.db 044h	; | ■   ■  | (offset 1A4Bh)
	.db 002h	; |      ■ | (offset 1A4Ch)
	.db 002h	; |      ■ | (offset 1A4Dh)
	.db 0FEh	; |■■■■■■■ | (offset 1A4Eh)
	.db 002h	; |      ■ | (offset 1A4Fh)
	.db 002h	; |      ■ | (offset 1A50h)
	.db 00Eh	; |    ■■■ | (offset 1A51h)
	.db 090h	; |■  ■    | (offset 1A52h)
	.db 090h	; |■  ■    | (offset 1A53h)
	.db 090h	; |■  ■    | (offset 1A54h)
	.db 07Eh	; | ■■■■■■ | (offset 1A55h)
	.db 0C6h	; |■■   ■■ | (offset 1A56h)
	.db 028h	; |  ■ ■   | (offset 1A57h)
	.db 0FEh	; |■■■■■■■ | (offset 1A58h)
	.db 028h	; |  ■ ■   | (offset 1A59h)
	.db 0C6h	; |■■   ■■ | (offset 1A5Ah)
	.db 0FEh	; |■■■■■■■ | (offset 1A5Bh)
	.db 092h	; |■  ■  ■ | (offset 1A5Ch)
	.db 092h	; |■  ■  ■ | (offset 1A5Dh)
	.db 092h	; |■  ■  ■ | (offset 1A5Eh)
	.db 06Ch	; | ■■ ■■  | (offset 1A5Fh)
	.db 0FEh	; |■■■■■■■ | (offset 1A60h)
	.db 090h	; |■  ■    | (offset 1A61h)
	.db 090h	; |■  ■    | (offset 1A62h)
	.db 090h	; |■  ■    | (offset 1A63h)
	.db 060h	; | ■■     | (offset 1A64h)
	.db 0FEh	; |■■■■■■■ | (offset 1A65h)
	.db 090h	; |■  ■    | (offset 1A66h)
	.db 060h	; | ■■     | (offset 1A67h)
	.db 000h	; |        | (offset 1A68h)
	.db 0FEh	; |■■■■■■■ | (offset 1A69h)
	.db 044h	; | ■   ■  | (offset 1A6Ah)
	.db 082h	; |■     ■ | (offset 1A6Bh)
	.db 082h	; |■     ■ | (offset 1A6Ch)
	.db 092h	; |■  ■  ■ | (offset 1A6Dh)
	.db 06Ch	; | ■■ ■■  | (offset 1A6Eh)
	.db 0FEh	; |■■■■■■■ | (offset 1A6Fh)
	.db 080h	; |■       | (offset 1A70h)
	.db 0FEh	; |■■■■■■■ | (offset 1A71h)
	.db 080h	; |■       | (offset 1A72h)
	.db 0FEh	; |■■■■■■■ | (offset 1A73h)
	.db 044h	; | ■   ■  | (offset 1A74h)
	.db 092h	; |■  ■  ■ | (offset 1A75h)
	.db 092h	; |■  ■  ■ | (offset 1A76h)
	.db 092h	; |■  ■  ■ | (offset 1A77h)
	.db 07Ch	; | ■■■■■  | (offset 1A78h)
	.db 07Eh	; | ■■■■■■ | (offset 1A79h)
	.db 040h	; | ■      | (offset 1A7Ah)
	.db 07Eh	; | ■■■■■■ | (offset 1A7Bh)
	.db 040h	; | ■      | (offset 1A7Ch)
	.db 0FEh	; |■■■■■■■ | (offset 1A7Dh)
	.db 01Eh	; |   ■■■■ | (offset 1A7Eh)
	.db 010h	; |   ■    | (offset 1A7Fh)
	.db 010h	; |   ■    | (offset 1A80h)
	.db 010h	; |   ■    | (offset 1A81h)
	.db 0FEh	; |■■■■■■■ | (offset 1A82h)
	.db 0FCh	; |■■■■■■  | (offset 1A83h)
	.db 0FCh	; |■■■■■■  | (offset 1A84h)
	.db 0FCh	; |■■■■■■  | (offset 1A85h)
	.db 0FCh	; |■■■■■■  | (offset 1A86h)
	.db 0FCh	; |■■■■■■  | (offset 1A87h)
;
	.db 0AAh	; |■ ■ ■ ■ |
	.db 000h	; |        |
	.db 055h	; | ■ ■ ■ ■|
	.db 000h	; |        |
	.db 0AAh	; |■ ■ ■ ■ |
	.db 0AAh	; |■ ■ ■ ■ |
	.db 055h	; | ■ ■ ■ ■|
	.db 0AAh	; |■ ■ ■ ■ |
	.db 055h	; | ■ ■ ■ ■|
	.db 0AAh	; |■ ■ ■ ■ |
	.db 048h	; | ■  ■   |
	.db 001h	; |       ■|
	.db 024h	; |  ■  ■  |
	.db 080h	; |■       |
	.db 012h	; |   ■  ■ |
	.db 000h	; |        |
	.db 000h	; |        |
	.db 0FFh	; |■■■■■■■■|
	.db 000h	; |        |
	.db 000h	; |        |
	.db 010h	; |   ■    |
	.db 010h	; |   ■    |
	.db 0FFh	; |■■■■■■■■|
	.db 000h	; |        |
	.db 000h	; |        |
	.db 014h	; |   ■ ■  |
	.db 014h	; |   ■ ■  |
	.db 0FFh	; |■■■■■■■■|
	.db 000h	; |        |
	.db 000h	; |        |
	.db 010h	; |   ■    |
	.db 0FFh	; |■■■■■■■■|
	.db 000h	; |        |
	.db 0FFh	; |■■■■■■■■|
	.db 000h	; |        |
	.db 010h	; |   ■    |
	.db 0F0h	; |■■■■    |
	.db 010h	; |   ■    |
	.db 0F0h	; |■■■■    |
	.db 000h	; |        |
	.db 014h	; |   ■ ■  |
	.db 014h	; |   ■ ■  |
	.db 0FFh	; |■■■■■■■■|
	.db 000h	; |        |
	.db 000h	; |        |
	.db 014h	; |   ■ ■  |
	.db 0F7h	; |■■■■ ■■■|
	.db 000h	; |        |
	.db 0FFh	; |■■■■■■■■|
	.db 000h	; |        |
	.db 000h	; |        |
	.db 0FFh	; |■■■■■■■■|
	.db 000h	; |        |
	.db 0FFh	; |■■■■■■■■|
	.db 000h	; |        |
	.db 014h	; |   ■ ■  |
	.db 0F4h	; |■■■■ ■  |
	.db 004h	; |     ■  |
	.db 0FCh	; |■■■■■■  |
	.db 000h	; |        |
	.db 014h	; |   ■ ■  |
	.db 017h	; |   ■ ■■■|
	.db 010h	; |   ■    |
	.db 01Fh	; |   ■■■■■|
	.db 000h	; |        |
	.db 010h	; |   ■    |
	.db 01Fh	; |   ■■■■■|
	.db 010h	; |   ■    |
	.db 01Fh	; |   ■■■■■|
	.db 000h	; |        |
	.db 014h	; |   ■ ■  |
	.db 014h	; |   ■ ■  |
	.db 01Fh	; |   ■■■■■|
	.db 000h	; |        |
	.db 000h	; |        |
	.db 010h	; |   ■    |
	.db 010h	; |   ■    |
	.db 0F0h	; |■■■■    |
	.db 000h	; |        |
	.db 000h	; |        |
	.db 000h	; |        |
	.db 000h	; |        |
	.db 01Fh	; |   ■■■■■|
	.db 010h	; |   ■    |
	.db 010h	; |   ■    |
	.db 010h	; |   ■    |
	.db 010h	; |   ■    |
	.db 01Fh	; |   ■■■■■|
	.db 010h	; |   ■    |
	.db 010h	; |   ■    |
	.db 010h	; |   ■    |
	.db 010h	; |   ■    |
	.db 0F0h	; |■■■■    |
	.db 010h	; |   ■    |
	.db 010h	; |   ■    |
	.db 000h	; |        |
	.db 000h	; |        |
	.db 0FFh	; |■■■■■■■■|
	.db 010h	; |   ■    |
	.db 010h	; |   ■    |
	.db 010h	; |   ■    |
	.db 010h	; |   ■    |
	.db 010h	; |   ■    |
	.db 010h	; |   ■    |
	.db 010h	; |   ■    |
	.db 010h	; |   ■    |
	.db 010h	; |   ■    |
	.db 0FFh	; |■■■■■■■■|
	.db 010h	; |   ■    |
	.db 010h	; |   ■    |
	.db 000h	; |        |
	.db 000h	; |        |
	.db 0FFh	; |■■■■■■■■|
	.db 014h	; |   ■ ■  |
	.db 014h	; |   ■ ■  |
	.db 000h	; |        |
	.db 0FFh	; |■■■■■■■■|
	.db 000h	; |        |
	.db 0FFh	; |■■■■■■■■|
	.db 010h	; |   ■    |
	.db 000h	; |        |
	.db 01Fh	; |   ■■■■■|
	.db 010h	; |   ■    |
	.db 017h	; |   ■ ■■■|
	.db 014h	; |   ■ ■  |
	.db 000h	; |        |
	.db 0FCh	; |■■■■■■  |
	.db 004h	; |     ■  |
	.db 0F4h	; |■■■■ ■  |
	.db 014h	; |   ■ ■  |
	.db 014h	; |   ■ ■  |
	.db 017h	; |   ■ ■■■|
	.db 014h	; |   ■ ■  |
	.db 017h	; |   ■ ■■■|
	.db 014h	; |   ■ ■  |
	.db 014h	; |   ■ ■  |
	.db 0F4h	; |■■■■ ■  |
	.db 014h	; |   ■ ■  |
	.db 0F4h	; |■■■■ ■  |
	.db 014h	; |   ■ ■  |
	.db 000h	; |        |
	.db 0FFh	; |■■■■■■■■|
	.db 000h	; |        |
	.db 0FFh	; |■■■■■■■ |
	.db 014h	; |   ■ ■  |
	.db 014h	; |   ■ ■  |
	.db 014h	; |   ■ ■  |
	.db 014h	; |   ■ ■  |
	.db 014h	; |   ■ ■  |
	.db 014h	; |   ■ ■  |
	.db 014h	; |   ■ ■  |
	.db 0F7h	; |■■■■ ■■■|
	.db 000h	; |        |
	.db 0F7h	; |■■■■ ■■■|
	.db 014h	; |   ■ ■  |
	.db 014h	; |   ■ ■  |
	.db 014h	; |   ■ ■  |
	.db 017h	; |   ■ ■■■|
	.db 014h	; |   ■ ■  |
	.db 014h	; |   ■ ■  |
	.db 038h	; |  ■■■   |
	.db 044h	; | ■   ■  |
	.db 03Eh	; |  ■■■■  |
	.db 07Fh	; | ■■■■■■■|
	.db 040h	; | ■      |
	.db 0FCh	; |■■■■■■  |
	.db 02Ah	; |  ■ ■ ■ |
	.db 02Ah	; |  ■ ■ ■ |
	.db 03Eh	; |  ■■■■■ |
	.db 014h	; |   ■ ■  |
	.db 07Eh	; | ■■■■■■ |
	.db 07Eh	; | ■■■■■■ |
	.db 002h	; |      ■ |
	.db 002h	; |      ■ |
	.db 006h	; |     ■■ |
	.db 063h	; | ■■   ■■|
	.db 055h	; | ■ ■ ■ ■|
	.db 049h	; | ■  ■  ■|
	.db 041h	; | ■     ■|
	.db 063h	; | ■■   ■■|
	.db 002h	; |      ■ |
	.db 07Eh	; | ■■■■■■ |
	.db 002h	; |      ■ |
	.db 07Eh	; | ■■■■■■ |
	.db 002h	; |      ■ |
	.db 038h	; |  ■■■   |
	.db 044h	; | ■   ■  |
	.db 044h	; | ■   ■  |
	.db 03Ch	; |  ■■■■  |
	.db 004h	; |     ■  |
	.db 080h	; |■       |
	.db 07Eh	; | ■■■■■■ |
	.db 020h	; |  ■     |
	.db 01Eh	; |   ■■■■ |
	.db 020h	; |  ■     |
	.db 004h	; |     ■  |
	.db 002h	; |      ■ |
	.db 07Eh	; | ■■■■■■ |
	.db 004h	; |     ■  |
	.db 002h	; |      ■ |
	.db 099h	; |■  ■■  ■|
	.db 0A5h	; |■ ■  ■ ■|
	.db 0E7h	; |■■■  ■■■|
	.db 0A5h	; |■ ■  ■ ■|
	.db 099h	; |■  ■■  ■|
	.db 03Eh	; |  ■■■■■ |
	.db 049h	; | ■  ■  ■|
	.db 049h	; | ■  ■  ■|
	.db 049h	; | ■  ■  ■|
	.db 03Eh	; |  ■■■■■ |
	.db 024h	; |  ■  ■  |
	.db 03Fh	; |  ■■■■■■|
	.db 001h	; |       ■|
	.db 03Fh	; |  ■■■■■■|
	.db 024h	; |  ■  ■  |
	.db 030h	; |  ■■    |
	.db 04Ah	; | ■  ■ ■ |
	.db 04Fh	; | ■  ■■■■|
	.db 04Dh	; | ■  ■■ ■|
	.db 039h	; |  ■■■  ■|
	.db 018h	; |   ■■   |
	.db 024h	; |  ■  ■  |
	.db 03Ch	; |  ■■■■  |
	.db 024h	; |  ■  ■  |
	.db 018h	; |   ■■   |
	.db 098h	; |■  ■■   |
	.db 0A4h	; |■ ■  ■  |
	.db 07Eh	; | ■■■■■■ |
	.db 025h	; |  ■  ■ ■|
	.db 019h	; |   ■■  ■|
	.db 01Ch	; |   ■■■  |
	.db 03Eh	; |  ■■■■■ |
	.db 06Bh	; | ■■ ■ ■■|
	.db 049h	; | ■  ■  ■|
	.db 049h	; | ■  ■  ■|
	.db 07Eh	; | ■■■■■■ |
	.db 003h	; |      ■■|
	.db 001h	; |       ■|
	.db 003h	; |      ■■|
	.db 07Eh	; | ■■■■■■ |
	.db 000h	; |        |
	.db 020h	; |  ■     |
	.db 0F0h	; |■■■■    |
	.db 0F8h	; |■■■■■   |
	.db 000h	; |        |
	.db 090h	; |■  ■    |
	.db 0D8h	; |■■ ■■   |
	.db 0E8h	; |■■■ ■   |
	.db 0B8h	; |■ ■■■   |
	.db 090h	; |■  ■    |
	.db 050h	; | ■ ■    |
	.db 0D8h	; |■■ ■■   |
	.db 0A8h	; |■ ■ ■   |
	.db 0F8h	; |■■■■■   |
	.db 050h	; | ■ ■    |
	.db 038h	; |  ■■■   |
	.db 038h	; |  ■■■   |
	.db 020h	; |  ■     |
	.db 0F8h	; |■■■■■   |
	.db 0F8h	; |■■■■■   |
	.db 0B8h	; |■ ■■■   |
	.db 0B8h	; |■ ■■■   |
	.db 0A8h	; |■ ■ ■   |
	.db 0E8h	; |■■■ ■   |
	.db 048h	; | ■  ■   |
	.db 070h	; | ■■■    |
	.db 0B8h	; |■ ■■■   |
	.db 0A8h	; |■ ■ ■   |
	.db 0E8h	; |■■■ ■   |
	.db 040h	; | ■      |
	.db 008h	; |    ■   |
	.db 088h	; |■   ■   |
	.db 0C8h	; |■■  ■   |
	.db 078h	; | ■■■■   |
	.db 038h	; |  ■■■   |
	.db 050h	; | ■ ■    |
	.db 0F8h	; |■■■■■   |
	.db 0A8h	; |■ ■ ■   |
	.db 0F8h	; |■■■■■   |
	.db 050h	; | ■ ■    |
	.db 010h	; |   ■    |
	.db 0B8h	; |■ ■■■   |
	.db 0A8h	; |■ ■ ■   |
	.db 0F8h	; |■■■■■   |
	.db 070h	; | ■■■    |
	.db 070h	; | ■■■    |
	.db 0F8h	; |■■■■■   |
	.db 088h	; |■   ■   |
	.db 0F8h	; |■■■■■   |
	.db 070h	; | ■■■    |
	.db 030h	; |  ■■    |
	.db 078h	; | ■■■■   |
	.db 048h	; | ■  ■   |
	.db 078h	; | ■■■■   |
	.db 030h	; |  ■■    |
	.db 00Eh	; |    ■■■ |
	.db 01Fh	; |   ■■■■■|
	.db 011h	; |   ■   ■|
	.db 01Fh	; |   ■■■■■|
	.db 00Eh	; |    ■■■ |
	.db 000h	; |        |
	.db 004h	; |     ■  |
	.db 01Eh	; |   ■■■■ |
	.db 01Fh	; |   ■■■■■|
	.db 000h	; |        |
	.db 012h	; |   ■  ■ |
	.db 01Bh	; |   ■■ ■■|
	.db 01Dh	; |   ■■■ ■|
	.db 017h	; |   ■ ■■■|
	.db 012h	; |   ■  ■ |
	.db 00Ah	; |    ■ ■ |
	.db 01Bh	; |   ■■ ■■|
	.db 015h	; |   ■ ■ ■|
	.db 01Fh	; |   ■■■■■|
	.db 00Ah	; |    ■ ■ |
	.db 007h	; |     ■■■|
	.db 007h	; |     ■■■|
	.db 004h	; |     ■  |
	.db 01Fh	; |   ■■■■■|
	.db 01Fh	; |   ■■■■■|
;
	.db 0F8h	; |■■■■■   |
	.db 020h	; |  ■     |
	.db 070h	; | ■■■    |
	.db 088h	; |■   ■   |
	.db 070h	; | ■■■    |
	.db 064h	; | ■■  ■  |
	.db 094h	; |■  ■ ■  |
	.db 094h	; |■  ■ ■  |
	.db 078h	; | ■■■■   |
	.db 080h	; |■       |
	.db 070h	; | ■■■    |
	.db 0A8h	; |■ ■ ■   |
	.db 0A8h	; |■ ■ ■   |
	.db 0A8h	; |■ ■ ■   |
	.db 044h	; | ■   ■  |
	.db 078h	; | ■■■■   |
	.db 040h	; | ■      |
	.db 040h	; | ■      |
	.db 078h	; | ■■■■   |
	.db 0C0h	; |■■      |
	.db 0C0h	; |■■      |
	.db 070h	; | ■■■    |
	.db 048h	; | ■  ■   |
	.db 078h	; | ■■■■   |
	.db 0C0h	; |■■      |
	.db 070h	; | ■■■    |
	.db 0A8h	; |■ ■ ■   |
	.db 0A8h	; |■ ■ ■   |
	.db 0A8h	; |■ ■ ■   |
	.db 030h	; |  ■■    |
	.db 030h	; |  ■■    |
	.db 048h	; | ■  ■   |
	.db 0FCh	; |■■■■■■  |
	.db 048h	; | ■  ■   |
	.db 030h	; |  ■■    |
	.db 0F8h	; |■■■■■   |
	.db 008h	; |    ■   |
	.db 008h	; |    ■   |
	.db 008h	; |    ■   |
	.db 008h	; |    ■   |
	.db 088h	; |■   ■   |
	.db 050h	; | ■ ■    |
	.db 020h	; |  ■     |
	.db 050h	; | ■ ■    |
	.db 088h	; |■   ■   |
	.db 078h	; | ■■■■   |
	.db 080h	; |■       |
	.db 080h	; |■       |
	.db 040h	; | ■      |
	.db 0F8h	; |■■■■■   |
	.db 078h	; | ■■■■   |
	.db 080h	; |■       |
	.db 084h	; |■    ■  |
	.db 040h	; | ■      |
	.db 0F8h	; |■■■■■   |
	.db 0F8h	; |■■■■■   |
	.db 020h	; |  ■     |
	.db 020h	; |  ■     |
	.db 050h	; | ■ ■    |
	.db 088h	; |■   ■   |
	.db 080h	; |■       |
	.db 070h	; | ■■■    |
	.db 008h	; |    ■   |
	.db 008h	; |    ■   |
	.db 0F8h	; |■■■■■   |
	.db 0F8h	; |■■■■■   |
	.db 010h	; |   ■    |
	.db 020h	; |  ■     |
	.db 010h	; |   ■    |
	.db 0F8h	; |■■■■■   |
	.db 0F8h	; |■■■■■   |
	.db 020h	; |  ■     |
	.db 020h	; |  ■     |
	.db 020h	; |  ■     |
	.db 0F8h	; |■■■■■   |
	.db 070h	; | ■■■    |
	.db 088h	; |■   ■   |
	.db 088h	; |■   ■   |
	.db 088h	; |■   ■   |
	.db 070h	; | ■■■    |
	.db 0F8h	; |■■■■■   |
	.db 008h	; |    ■   |
	.db 008h	; |    ■   |
	.db 008h	; |    ■   |
	.db 0F8h	; |■■■■■   |
	.db 090h	; |■  ■    |
	.db 068h	; | ■■ ■   |
	.db 028h	; |  ■ ■   |
	.db 028h	; |  ■ ■   |
	.db 0F8h	; |■■■■■   |
	.db 0FCh	; |■■■■■■  |
	.db 024h	; |  ■  ■  |
	.db 024h	; |  ■  ■  |
	.db 024h	; |  ■  ■  |
	.db 018h	; |   ■■   |
	.db 070h	; | ■■■    |
	.db 088h	; |■   ■   |
	.db 088h	; |■   ■   |
	.db 088h	; |■   ■   |
	.db 088h	; |■   ■   |
	.db 008h	; |    ■   |
	.db 008h	; |    ■   |
	.db 0F8h	; |■■■■■   |
	.db 008h	; |    ■   |
	.db 008h	; |    ■   |
	.db 000h	; |        |
	.db 098h	; |■  ■■   |
	.db 060h	; | ■■     |
	.db 020h	; |  ■     |
	.db 018h	; |   ■■   |
	.db 088h	; |■   ■   |
	.db 050h	; | ■ ■    |
	.db 0F8h	; |■■■■■   |
	.db 050h	; | ■ ■    |
	.db 088h	; |■   ■   |
	.db 0FCh	; |■■■■■■  |
	.db 094h	; |■  ■ ■  |
	.db 094h	; |■  ■ ■  |
	.db 098h	; |■  ■■   |
	.db 060h	; | ■■     |
	.db 000h	; |        |
	.db 0F8h	; |■■■■■   |
	.db 090h	; |■  ■    |
	.db 090h	; |■  ■    |
	.db 060h	; | ■■     |
	.db 0F8h	; |■■■■■   |
	.db 090h	; |■  ■    |
	.db 060h	; | ■■     |
	.db 000h	; |        |
	.db 0F8h	; |■■■■■   |
	.db 050h	; | ■ ■    |
	.db 088h	; |■   ■   |
	.db 0A8h	; |■ ■ ■   |
	.db 0A8h	; |■ ■ ■   |
	.db 050h	; | ■ ■    |
	.db 0F8h	; |■■■■■   |
	.db 080h	; |■       |
	.db 0F8h	; |■■■■■   |
	.db 080h	; |■       |
	.db 0F8h	; |■■■■■   |
	.db 088h	; |■   ■   |
	.db 0A8h	; |■ ■ ■   |
	.db 0A8h	; |■ ■ ■   |
	.db 0A8h	; |■ ■ ■   |
	.db 070h	; | ■■■    |
	.db 078h	; | ■■■■   |
	.db 040h	; | ■      |
	.db 078h	; | ■■■■   |
	.db 040h	; | ■      |
	.db 0F8h	; |■■■■■   |
	.db 038h	; |  ■■■   |
	.db 020h	; |  ■     |
	.db 020h	; |  ■     |
	.db 020h	; |  ■     |
	.db 0F8h	; |■■■■■   |
	.db 008h	; |    ■   |
	.db 0F8h	; |■■■■■   |
	.db 090h	; |■  ■    |
	.db 090h	; |■  ■    |
	.db 060h	; | ■■     |
;
	.db 000h	; |        |
	.db 002h	; |      ■ |
	.db 004h	; |     ■  |
	.db 000h	; |        |
	.db 000h	; |        |
	.db 064h	; | ■■  ■  |
	.db 094h	; |■  ■ ■  |
	.db 094h	; |■  ■ ■  |
	.db 078h	; | ■■■■   |
	.db 080h	; |■       |
	.db 0FCh	; |■■■■■■  |
	.db 090h	; |■  ■    |
	.db 090h	; |■  ■    |
	.db 090h	; |■  ■    |
	.db 060h	; | ■■     |
	.db 070h	; | ■■■    |
	.db 088h	; |■   ■   |
	.db 088h	; |■   ■   |
	.db 088h	; |■   ■   |
	.db 088h	; |■   ■   |
	.db 060h	; | ■■     |
	.db 090h	; |■  ■    |
	.db 090h	; |■  ■    |
	.db 090h	; |■  ■    |
	.db 0FCh	; |■■■■■■  |
	.db 070h	; | ■■■    |
	.db 0A8h	; |■ ■ ■   |
	.db 0A8h	; |■ ■ ■   |
	.db 0A8h	; |■ ■ ■   |
	.db 030h	; |  ■■    |
	.db 000h	; |        |
	.db 010h	; |   ■    |
	.db 0FCh	; |■■■■■■  |
	.db 012h	; |   ■  ■ |
	.db 012h	; |   ■  ■ |
	.db 018h	; |   ■■   |
	.db 024h	; |  ■  ■  |
	.db 0A4h	; |■ ■  ■  |
	.db 0A4h	; |■ ■  ■  |
	.db 0FCh	; |■■■■■■  |
	.db 0FEh	; |■■■■■■■ |
	.db 010h	; |   ■    |
	.db 008h	; |    ■   |
	.db 008h	; |    ■   |
	.db 0F0h	; |■■■■    |
	.db 000h	; |        |
	.db 090h	; |■  ■    |
	.db 0F4h	; |■■■■ ■  |
	.db 080h	; |■       |
	.db 000h	; |        |
	.db 080h	; |■       |
	.db 080h	; |■       |
	.db 088h	; |■   ■   |
	.db 07Ah	; | ■■■■ ■ |
	.db 000h	; |        |
	.db 000h	; |        |
	.db 0FEh	; |■■■■■■■ |
	.db 020h	; |  ■     |
	.db 050h	; | ■ ■    |
	.db 088h	; |■   ■   |
	.db 000h	; |        |
	.db 084h	; |■    ■  |
	.db 0FCh	; |■■■■■■  |
	.db 080h	; |■       |
	.db 000h	; |        |
	.db 0F8h	; |■■■■■   |
	.db 008h	; |    ■   |
	.db 0F0h	; |■■■■    |
	.db 008h	; |    ■   |
	.db 0F0h	; |■■■■    |
	.db 0F8h	; |■■■■■   |
	.db 010h	; |   ■    |
	.db 008h	; |    ■   |
	.db 008h	; |    ■   |
	.db 0F0h	; |■■■■    |
	.db 070h	; | ■■■    |
	.db 088h	; |■   ■   |
	.db 088h	; |■   ■   |
	.db 088h	; |■   ■   |
	.db 070h	; | ■■■    |
	.db 0FCh	; |■■■■■■  |
	.db 024h	; |  ■  ■  |
	.db 024h	; |  ■  ■  |
	.db 024h	; |  ■  ■  |
	.db 018h	; |   ■■   |
	.db 018h	; |   ■■   |
	.db 024h	; |  ■  ■  |
	.db 024h	; |  ■  ■  |
	.db 024h	; |  ■  ■  |
	.db 0FCh	; |■■■■■■  |
	.db 0F8h	; |■■■■■   |
	.db 010h	; |   ■    |
	.db 008h	; |    ■   |
	.db 008h	; |    ■   |
	.db 008h	; |    ■   |
	.db 010h	; |   ■    |
	.db 0A8h	; |■ ■ ■   |
	.db 0A8h	; |■ ■ ■   |
	.db 0A8h	; |■ ■ ■   |
	.db 040h	; | ■      |
	.db 008h	; |    ■   |
	.db 07Eh	; | ■■■■■■ |
	.db 088h	; |■   ■   |
	.db 088h	; |■   ■   |
	.db 040h	; | ■      |
	.db 078h	; | ■■■■   |
	.db 080h	; |■       |
	.db 080h	; |■       |
	.db 078h	; | ■■■■   |
	.db 080h	; |■       |
	.db 018h	; |   ■■   |
	.db 060h	; | ■■     |
	.db 080h	; |■       |
	.db 060h	; | ■■     |
	.db 018h	; |   ■■   |
	.db 078h	; | ■■■■   |
	.db 080h	; |■       |
	.db 070h	; | ■■■    |
	.db 080h	; |■       |
	.db 078h	; | ■■■■   |
	.db 088h	; |■   ■   |
	.db 050h	; | ■ ■    |
	.db 020h	; |  ■     |
	.db 050h	; | ■ ■    |
	.db 088h	; |■   ■   |
	.db 000h	; |        |
	.db 098h	; |■  ■■   |
	.db 060h	; | ■■     |
	.db 020h	; |  ■     |
	.db 018h	; |   ■■   |
	.db 088h	; |■   ■   |
	.db 0C8h	; |■■  ■   |
	.db 0A8h	; |■ ■ ■   |
	.db 098h	; |■  ■■   |
	.db 088h	; |■   ■   |
	.db 000h	; |        |
	.db 010h	; |   ■    |
	.db 06Ch	; | ■■ ■■  |
	.db 082h	; |■     ■ |
	.db 082h	; |■     ■ |
	.db 000h	; |        |
	.db 000h	; |        |
	.db 0DAh	; |■■ ■■ ■ |
	.db 000h	; |        |
	.db 000h	; |        |
	.db 082h	; |■     ■ |
	.db 082h	; |■     ■ |
	.db 06Ch	; | ■■ ■■  |
	.db 010h	; |   ■    |
	.db 000h	; |        |
	.db 030h	; |  ■■    |
	.db 008h	; |    ■   |
	.db 010h	; |   ■    |
	.db 020h	; |  ■     |
	.db 018h	; |   ■■   |
	.db 0FCh	; |■■■■■■  |
	.db 0FCh	; |■■■■■■  |
	.db 0FCh	; |■■■■■■  |
	.db 0FCh	; |■■■■■■  |
	.db 0FCh	; |■■■■■■  |
;
D_1A88:	.db 000h	; "_" - |        | (offset 1A88h)
	.db 000h	; "_" - |        | (offset 1A89h)
D_1A8A:	.db 000h	; "_" - |        | (offset 1A8Ah)
D_1A8B:	.db 000h	; "_" - |        | (offset 1A8Bh)
D_1A8C:	.db 000h	; "_" - |        | (offset 1A8Ch)
	.db 000h	; "_" - |        | (offset 1A8Dh)
	.db 000h	; "_" - |        | (offset 1A8Eh)
;
D_1C0F:	.db 000h	; "_" - |        | (offset 1C0Fh)
D_1C10:	.db 000h	; "_" - |        | (offset 1C10h)
D_1C11:	.db 000h	; "_" - |        | (offset 1C11h)
D_1C12:	.db 000h	; "_" - |        | (offset 1C12h)
D_1C13:	.db 000h	; "_" - |        | (offset 1C13h)
D_1C14:	.db 000h	; "_" - |        | (offset 1C14h)
D_1C15:	.db 000h	; "_" - |        | (offset 1C15h)
D_1C16:	.db 000h	; "_" - |        | (offset 1C16h)
	.db 000h	; "_" - |        | (offset 1C17h)
D_1C18:	.db 000h	; "_" - |        | (offset 1C18h)
D_1C19:	.db 000h	; "_" - |        | (offset 1C19h)
D_1C1A:	.db 000h	; "_" - |        | (offset 1C1Ah)
D_1C1B:	.db 000h	; "_" - |        | (offset 1C1Bh)
D_1C1C:	.db 000h	; "_" - |        | (offset 1C1Ch)
D_1C1D:	.db 000h	; "_" - |        | (offset 1C1Dh)
D_1C1E:	.ds 010h
;
D_1C2E:	.db 000h	; "_" - |        | (offset 1C2Eh)
D_1C2F:	.db 000h	; "_" - |        | (offset 1C2Fh)
D_1C30:	.db 000h	; "_" - |        | (offset 1C30h)
D_1C31:	.dw 00000h
D_1C33:	.dw 00000h
D_1C35:	.db 000h	; "_" - |        | (offset 1C35h)
D_1C36:	.db 000h	; "_" - |        | (offset 1C36h)
	.db 000h	; "_" - |        | (offset 1C37h)
D_1C38:	.db 000h	; "_" - |        | (offset 1C38h)
D_1C39:	.db 000h	; "_" - |        | (offset 1C39h)
D_1C3A:	.db 000h	; "_" - |        | (offset 1C3Ah)
D_1C3B:	.db 000h	; "_" - |        | (offset 1C3Bh)
D_1C3C:	.db 000h	; "_" - |        | (offset 1C3Ch)
D_1C3D:	.dw 00000h
D_1C3F:	.dw 00000h
D_1C41:	.dw 00000h
D_1C43:	.dw 00000h
D_1C45:	.db 000h	; "_" - |        | (offset 1C45h)
D_1C46:	.db 000h	; "_" - |        | (offset 1C46h)
	.db 000h	; "_" - |        | (offset 1C47h)
D_1C48:	.dw 00000h
D_1C4A:	.dw 00000h
D_1C4C:	.dw 00000h
D_1C4E:	.dw 00000h
D_1C50:	.db 000h	; "_" - |        | (offset 1C50h)
D_1C51:	.db 000h	; "_" - |        | (offset 1C51h)
D_1C52:	.db 000h	; "_" - |        | (offset 1C52h)
D_1C53:	.db 000h	; "_" - |        | (offset 1C53h)
D_1C54:	.db 000h	; "_" - |        | (offset 1C54h)
D_1C55:	.db 000h	; "_" - |        | (offset 1C55h)
D_1C56:	.db 000h	; "_" - |        | (offset 1C56h)
D_1C57:	.db 000h	; "_" - |        | (offset 1C57h)
D_1C58:	.db 000h	; "_" - |        | (offset 1C58h)
D_1C59:	.db 000h	; "_" - |        | (offset 1C59h)
D_1C5A:	.db 000h	; "_" - |        | (offset 1C5Ah)
D_1C5B:	.db 000h	; "_" - |        | (offset 1C5Bh)
D_1C5C:	.db 000h	; "_" - |        | (offset 1C5Ch)
D_1C5D:	.db 000h	; "_" - |        | (offset 1C5Dh)
;	.db 000h	; "_" - |        | (offset 1C5Eh)--
D_1C5F:	.db 000h	; "_" - |        | (offset 1C5Fh)
D_1C60:	.db 000h	; "_" - |        | (offset 1C60h)
D_1C61:	.db 000h	; "_" - |        | (offset 1C61h)
D_1C62:	.dw 00000h
D_1C64:	.dw 00000h
D_1C66:	.db 000h	; "_" - |        | (offset 1C66h)
D_TPPC:	.db 000h	; Тип ПК, 0=Вектор, {D_PC6 - D_VECT}=ПК-6128ц
;
D_1A8F:	.ds 080h
;
D_1B0F:	.ds 080h
;
D_1B8F:	.ds 080h
;
	.org (((($ - 1) / 0100h) + 1) * 0100h)	;01D00h
D_1D00:	.ds 0200h	; выравнивание по хх00
;
;v--L_091E
D_1800:	.db 0FFh	; " " - |■■■■■■■■| (offset 1800h)
	.db 0FFh	; " " - |■■■■■■■■| (offset 1801h)
	.db 0FFh	; " " - |■■■■■■■■| (offset 1802h)
	.db 0FFh	; " " - |■■■■■■■■| (offset 1803h)
	.db 0FFh	; " " - |■■■■■■■■| (offset 1804h)
	.db 0FFh	; " " - |■■■■■■■■| (offset 1805h)
	.db 0FFh	; " " - |■■■■■■■■| (offset 1806h)
	.db 0FFh	; " " - |■■■■■■■■| (offset 1807h)
;
L_2000:	LXI  SP,M_STEK	; ?
	CALL    L_221A	; очистка экрана
	; определяем ПК-6128ц по конфигурации памяти
	LXI  B, 02211h	; константы
	LXI  H, 0FF00h	; адрес для проверки переключения банков
	MOV  M, B	; <-22h в Банк 3
;	OUT  00Eh	; Банк памяти в 8000-FFFF:
			; 33h - Банк 2
			; 22h - Банк 3
			; 11h - Банк 0
			; 00h - Банк 1
	MVI  A, 033h
	OUT  00Eh	; Банк 2
	MOV  M, A	; <-33h
	SUB  C		; -011h
	OUT  00Eh	; Банк 3
	SUB  M		;
	JNZ	L_MTA	; <> 22h -- не ПК-6128ц
	OUT  00Eh	; =00h, Банк 1
	MVI  M, 044h
	MOV  A, B
	OUT  00Eh	; Банк 3
	SUB  M
	JNZ	L_MTA	; <> 22h -- не ПК-6128ц
	OUT  00Eh	; =00h, Банк 1
	MOV  A, M
	SUB  B		; -022h
	CMP  B		; -022h?
	JNZ	L_MTA	; <> 44h -- не ПК-6128ц
; проверку подключения банка 0 (011h) не делаем -- эмулятор глючит
	OUT  00Eh	; Банк 3
	MVI  A, (D_PC6-D_VECT)
	JMP	L_MTB
;
L_MTA:	XRA  A		; обнуляем -- переключение банок не работает, не ПК-6128ц
L_MTB:	STA	D_TPPC	; сохраняем тип ПК
	LXI  D, D_21B2
	CALL    L_0189
	MVI  A, 00Fh
	CALL    L_0156
	LXI  B, 00000h	;+
	MVI  A, 001h
	CALL    L_013E
	LXI  B, 0FFFFh	;+
	MVI  A, 001h
	CALL    L_0141
	LXI  B, 0911Eh	;+
	LXI  H, 0EB01h	;+
	CALL    L_226E
	MVI  A, 007h
	CALL    L_0156
	MVI  D, 000h
	LDA	D_TPPC
	MOV  E, A
	LXI  H, D_VECT
	DAD  D		; "Вектор-06ц" / "ПК-6128ц++"
	LXI  B, 0C12Dh
	LXI  D, 00202h
	CALL    L_2234
	CALL    L_2041
	JMP     L_2180
;
L_2041:	LXI  B, 05315h	;+
	LXI  H, 0AD06h	;+
	CALL    L_226E
	MVI  A, 007h
	CALL    L_0156
	LXI  B, 08628h
	LXI  D, 00202h
	LXI  H, D_21F1
	CALL    L_2234
	LXI  B, 0130Ch	;+
	LXI  H, 06D00h	;+
	CALL    L_226E
	MVI  A, 009h
	CALL    L_0156
	LXI  B, 0160Fh	;+
	MVI  A, 001h
	CALL    L_013E
	LXI  B, 06A52h	;+
	MVI  A, 002h
	CALL    L_0141
	MVI  A, 00Fh
	CALL    L_0156
	LXI  B, 0160Fh	;+
	MVI  A, 001h
	CALL    L_0141
	MVI  A, 007h
	CALL    L_0156
	LXI  B, 03723h	;+
	LXI  D, 00304h
	LXI  H, D_2218
	CALL    L_2234
	MVI  A, 007h
	CALL    L_0156
	LXI  D, 00041h	;+
	LXI  H, 0002Fh	;+
	MVI  A, 017h
	CALL    L_0144
	LXI  B, 0412Fh	;+
	LXI  D, 00207h	;+
	CALL    L_0150
	MVI  A, 004h
	CALL    L_0156
	LXI  B, 01655h	;+
	MVI  A, 001h
	CALL    L_013E
	LXI  B, 06AF0h	;+
	MVI  A, 002h
	CALL    L_0141
	MVI  A, 00Fh
	CALL    L_0156
	LXI  B, 01655h	;+
	MVI  A, 001h
	CALL    L_0141
	MVI  A, 001h
	CALL    L_0156
	LXI  B, 04A58h	;+
	MVI  A, 001h
	CALL    L_013E
	LXI  B, 063EDh	;+
	MVI  A, 002h
	CALL    L_0141
	MVI  A, 00Fh
	CALL    L_0156
	LXI  B, 04A58h	;+
	MVI  A, 001h
	CALL    L_0141
	MVI  A, 00Ah
	CALL    L_0156
	LXI  B, 05063h
	LXI  D, 00101h
	LXI  H, D_21FD
	CALL    L_2234
	MVI  A, 00Ah
	CALL    L_0156
	LXI  B, 05087h
	LXI  D, 00201h
	LXI  H, D_2201
	CALL    L_2234
	MVI  A, 001h
	CALL    L_0156
	LXI  B, 01B58h	;+
	MVI  A, 001h
	CALL    L_013E
	LXI  B, 03BEDh	;+
	MVI  A, 002h
	CALL    L_0141
	MVI  A, 00Fh
	CALL    L_0156
	LXI  B, 01B58h	;+
	MVI  A, 001h
	CALL    L_0141
	MVI  A, 007h
	CALL    L_0156
	LXI  B, 02461h
	LXI  D, 00201h
	LXI  H, D_220B
	CALL    L_2234
	MVI  A, 007h
	CALL    L_0156
	LXI  B, 024B9h
	LXI  D, 00201h
	LXI  H, D_2213
	CALL    L_2234
	CALL    L_013B
	CPI     041h	; = 'A'
	JNZ     L_217F
	MVI  A, 00Fh
	CALL    L_0156
	LXI  B, 02F23h	;+
	CALL    L_2220
	LXI  H, D_21D2
	CALL    L_0138
	LXI  B, 03623h	;+
	CALL    L_2220
	LXI  H, D_21DC
	CALL    L_0138
L_217F:	RET
;
L_2180:	LXI  H, D_2412
	SHLD    D_279A
	LXI  D, D_2192
	CALL    L_0189
	CALL    L_4BAC
	JMP     L_22F8
;
D_2192:	.db 000h	; "_" - |        | (offset 2192h)
	.db 080h	; "А" - |■       | (offset 2193h)
	.db 010h	; "_" - |   ■    | (offset 2194h)
	.db 0D0h	; "╨" - |■■ ■    | (offset 2195h)
	.db 006h	; "_" - |     ■■ | (offset 2196h)
	.db 086h	; "Ж" - |■    ■■ | (offset 2197h)
	.db 016h	; "_" - |   ■ ■■ | (offset 2198h)
	.db 036h	; "6" - |  ■■ ■■ | (offset 2199h)
	.db 000h	; "_" - |        | (offset 219Ah)
	.db 0C5h	; "┼" - |■■   ■ ■| (offset 219Bh)
	.db 022h	; """ - |  ■   ■ | (offset 219Ch)
	.db 0C0h	; "└" - |■■      | (offset 219Dh)
	.db 002h	; "_" - |      ■ | (offset 219Eh)
	.db 098h	; "Ш" - |■  ■■   | (offset 219Fh)
	.db 052h	; "R" - | ■ ■  ■ | (offset 21A0h)
	.db 0ADh	; "н" - |■ ■ ■■ ■| (offset 21A1h)
;
D_21A2:	.db 000h	; "_" - |        | (offset 21A2h)
	.db 080h	; "А" - |■       | (offset 21A3h)
	.db 010h	; "_" - |   ■    | (offset 21A4h)
	.db 012h	; "_" - |   ■  ■ | (offset 21A5h)
	.db 006h	; "_" - |     ■■ | (offset 21A6h)
	.db 086h	; "Ж" - |■    ■■ | (offset 21A7h)
	.db 016h	; "_" - |   ■ ■■ | (offset 21A8h)
	.db 036h	; "6" - |  ■■ ■■ | (offset 21A9h)
	.db 039h	; "9" - |  ■■■  ■| (offset 21AAh)
	.db 0D0h	; "╨" - |■■ ■    | (offset 21ABh)
	.db 022h	; """ - |  ■   ■ | (offset 21ACh)
	.db 0C0h	; "└" - |■■      | (offset 21ADh)
	.db 002h	; "_" - |      ■ | (offset 21AEh)
	.db 098h	; "Ш" - |■  ■■   | (offset 21AFh)
	.db 052h	; "R" - | ■ ■  ■ | (offset 21B0h)
	.db 0ADh	; "н" - |■ ■ ■■ ■| (offset 21B1h)
;
D_21B2:	.db 080h	; "А" - |■       | (offset 21B2h)
	.db 080h	; "А" - |■       | (offset 21B3h)
	.db 080h	; "А" - |■       | (offset 21B4h)
	.db 080h	; "А" - |■       | (offset 21B5h)
	.db 080h	; "А" - |■       | (offset 21B6h)
	.db 080h	; "А" - |■       | (offset 21B7h)
	.db 080h	; "А" - |■       | (offset 21B8h)
	.db 080h	; "А" - |■       | (offset 21B9h)
	.db 080h	; "А" - |■       | (offset 21BAh)
	.db 080h	; "А" - |■       | (offset 21BBh)
	.db 080h	; "А" - |■       | (offset 21BCh)
	.db 080h	; "А" - |■       | (offset 21BDh)
	.db 080h	; "А" - |■       | (offset 21BEh)
	.db 080h	; "А" - |■       | (offset 21BFh)
	.db 080h	; "А" - |■       | (offset 21C0h)
	.db 080h	; "А" - |■       | (offset 21C1h)
;
D_21C2:	.db 000h	; "_" - |        | (offset 21C2h)
	.db 0D0h	; "╨" - |■■ ■    | (offset 21C3h)
	.db 007h	; "_" - |     ■■■| (offset 21C4h)
	.db 0ADh	; "н" - |■ ■ ■■ ■| (offset 21C5h)
	.db 007h	; "_" - |     ■■■| (offset 21C6h)
	.db 0ADh	; "н" - |■ ■ ■■ ■| (offset 21C7h)
	.db 007h	; "_" - |     ■■■| (offset 21C8h)
	.db 0ADh	; "н" - |■ ■ ■■ ■| (offset 21C9h)
	.db 0D0h	; "╨" - |■■ ■    | (offset 21CAh)
	.db 0D0h	; "╨" - |■■ ■    | (offset 21CBh)
	.db 0ADh	; "н" - |■ ■ ■■ ■| (offset 21CCh)
	.db 0ADh	; "н" - |■ ■ ■■ ■| (offset 21CDh)
	.db 0ADh	; "н" - |■ ■ ■■ ■| (offset 21CEh)
	.db 0ADh	; "н" - |■ ■ ■■ ■| (offset 21CFh)
	.db 0ADh	; "н" - |■ ■ ■■ ■| (offset 21D0h)
	.db 0ADh	; "н" - |■ ■ ■■ ■| (offset 21D1h)
;
D_21D2:	.db "temirazow"
	.db 000h
;
D_21DC:	.db " &sokolow"
	.db 000h
;
D_VECT:	.db "wektor-06c"
	.db 000h
;
D_PC6:	.db "pk-6128c++"
	.db 000h
;
D_21F1:	.db "TEST V(1.2)"
	.db 000h
;
D_21FD:	.db "p/o"
	.db 000h
;
D_2201:	.db 022h	; "
	.db "s~etma{"
	.db 022h	; "
	.db 000h
;
D_220B:	.db "ki{inew"
	.db 000h
;
D_2213:	.db "1988"
	.db 000h
;
D_2218:	.db "C"
	.db 000h
;
L_221A:	MVI  C, 01Fh
	CALL    L_0129
	RET
;
L_2220:	PUSH B
	MVI  C, 01Bh
	CALL    L_0129
	MVI  C, 059h
	CALL    L_0129
	MOV  C, B
	CALL    L_0129
	POP  B
	CALL    L_0129
	RET
;
L_2234:	PUSH B
	PUSH D
	POP  B
	MVI  A, 003h
	CALL    L_0141
	POP  B
	DCR  B
	DCR  C
	CALL    L_2263
	INR  B
	INR  B
	CALL    L_2263
	INR  C
	INR  C
	DCR  B
	DCR  B
	CALL    L_2263
	INR  B
	INR  B
	CALL    L_2263
	DCR  C
	DCR  B
	MVI  A, 000h
	CALL    L_0156
	CALL    L_2263
	MVI  C, 00Dh
	CALL    L_0129
	RET
;
L_2263:	PUSH H
	MVI  A, 002h
	CALL    L_013E
	CALL    L_0138
	POP  H
	RET
;
L_226E:	MVI  A, 00Fh
	CALL    L_0156
	MVI  A, 001h
	CALL    L_013E
	MVI  A, 0FFh
	SUB  C
	PUSH B
	MOV  C, A
	MOV  B, H
	MVI  A, 001h
	CALL    L_0141
	POP  B
	MOV  A, L
	CALL    L_0156
	INR  C
	INR  B
	MVI  A, 001h
	CALL    L_013E
	MVI  A, 0FEh
	DCR  C
	SUB  C
	MOV  C, A
	DCR  H
	MOV  B, H
	MVI  A, 002h
	CALL    L_0141
	RET
;
L_229C:	HLT
	CALL    L_0165
	ORA  A
	RZ
	CALL    L_013B
	CPI     003h
	RZ
	CPI     00Dh
	RZ
	JMP     L_229C
;
L_22AE:	PUSH PSW
	PUSH B
L_22B0:	MOV  A, M
	INX  H
	CPI     0FFh
	JZ      L_22BE
	MOV  C, A
	CALL    L_012F
	JMP     L_22B0
;
L_22BE:	POP  B
	POP  PSW
	RET
;
L_22C1:	MVI  B, 004h
	MVI  H, 082h
	PUSH H
	POP  D
	MOV  A, L
	ADI     00Ah
	MOV  E, A
L_22CB:	PUSH B
	PUSH D
	PUSH H
	MVI  B, 01Eh
	MVI  C, 009h
L_22D2:	PUSH D
	PUSH H
	PUSH B
L_22D5:	MOV  B, M
	LDAX D
	MOV  M, A
	MOV  A, B
	STAX D
	INR  E
	INR  L
	DCR  C
	JNZ     L_22D5
	POP  B
	POP  H
	POP  D
	INR  H
	INR  D
	DCR  B
	JNZ     L_22D2
	POP  D
	POP  H
	LXI  B, 02000h	;+
	DAD  B
	XCHG
	DAD  B
	XCHG
	POP  B
	DCR  B
	JNZ     L_22CB
	RET
;
L_22F8:	CALL    L_243E
L_22FB:	CALL    L_250D
L_22FE:	CALL    L_2324
	LHLD    D_2798
	INX  H
	INX  H
	MVI  M, 001h
	CPI     000h
	JZ      L_2310
	INX  H
	MVI  M, 0C6h
L_2310:	MVI  B, 00Ah
L_2312:	HLT
	PUSH B
	CALL    L_013B
	CPI     003h
	POP  B
	JZ      L_2438
	DCR  B
	JNZ     L_2312
	JMP     L_22FE
;
L_2324:	MVI  B, 00Ch
	LXI  D, 0002Bh	;+
	LXI  H, D_27A1
L_232C:	MOV  A, M
	CPI     (L_2324 % 0100h)	;024h	;!!!!!!!
	JNZ     L_235D
	INX  H
	MOV  A, M
	DCX  H
	CPI     (L_2324 / 0100h)	;023h	;!!!!!!!
	JNZ     L_235D
L_233A:	DAD  D
	INX  H
	INX  H
	MOV  A, M
	DCX  H
	DCX  H
	CPI     000h
	JNZ     L_2362
	SHLD    D_2798
	PUSH H
	INX  H
	INX  H
	INX  H
	MOV  A, M
	CPI     0A0h
	POP  H
	PUSH H
	CNZ     L_2369
	POP  H
	XCHG
	LDAX D
	MOV  L, A
	INX  D
	LDAX D
	MOV  H, A
	PUSH H
	RET
;
L_235D:	DAD  D
	DCR  B
	JMP     L_232C
;
L_2362:	DCR  B
	JNZ     L_233A
	CALL    L_2429
L_2369:	CALL    L_0120
	CALL    L_221A
	MVI  A, 00Fh
	CALL    L_0156
	MVI  A, 000h
	CALL    L_0159
	LXI  B, 00000h	;+
	MVI  A, 001h
	CALL    L_013E
	LXI  B, 0FFFFh	;+
	MVI  A, 001h
	CALL    L_0141
	LXI  B, 0C505h	;+
	LXI  H, 0FA06h	;+
	CALL    L_226E
	LXI  B, 0DD1Eh	;+
	LXI  H, 0F601h	;+
	CALL    L_226E
	LXI  B, 0C90Bh	;+
	LXI  H, 0D802h	;+
	CALL    L_226E
	MVI  A, 007h
	CALL    L_0156
	LXI  B, 0E223h
	LXI  D, 00207h
	LXI  H, D_279C
	CALL    L_2234
	LXI  B, 02422h	;+
	CALL    L_2220
	LHLD    D_2798
	CALL    L_2653
	LXI  B, 02620h	;+
	CALL    L_2220
	MVI  A, 017h
	CALL    L_0156
	RET
;
D_23CD:	.db 000h, 000h, 000h
	.db 0A0h
	.db "  konec  cepo~ki  "
	.db 000h
;
D_23E4:	.db 000h, 000h, 000h
	.db 0C6h
	.db "prerywanie cepo~ki"
	.db 000h
;
	.db 000h, 000h, 000h
	.db 0C6h
	.db " pustaq   cepo~ka "
	.db 000h
;
D_2412:	.db 000h, 000h, 000h
	.db "аna~alo  wypolneniq"
	.db 000h
;
L_2429:	LXI  H, D_23CD
L_242C:	SHLD    D_279A
	CALL    L_265E
	CALL    L_243E
	JMP     L_22FB
;
L_2438:	LXI  H, D_23E4
	JMP     L_242C
;
N_STRK:	.equ	(D_29A4 - D_27A1 + 1)/02Bh	;00Eh	; количество строк
;
L_243E:	CALL    L_221A
	MVI  A, 00Fh
	CALL    L_0156
	LXI  B, 00000h	;+
	MVI  A, 001h
	CALL    L_013E
	LXI  B, 0FFFFh	;+
	MVI  A, 001h
	CALL    L_0141
	LXI  B, 0C505h	;+BF05
	LXI  H, 0FA01h	;+EB01
	CALL    L_226E
	MVI  A, 007h
	CALL    L_0156
	LXI  B, 0D50Fh	; CA0F
	LXI  D, 00202h
	LXI  H, D_263E	; "monitor"
	CALL    L_2234
	MVI  A, 007h
	CALL    L_0156
	LXI  B, 0D587h	; CA87
	LXI  D, 00302h
	LXI  H, D_2646	; "testow"
	CALL    L_2234
	MVI  A, 002h
	CALL    L_0156
	LXI  B, 02812h	;+
	MVI  A, 001h
	CALL    L_013E
	LXI  B, 0BBF9h	;+AAF9 -- прямоугольник под списком
	MVI  A, 002h
	CALL    L_0141
	MVI  A, 00Fh
	CALL    L_0156
	LXI  B, 02812h	;+
	MVI  A, 001h
	CALL    L_0141
	LXI  B, 00B1Bh	;+
	LXI  H, 01B02h	;+
	CALL    L_226E
	MVI  A, 002h
	CALL    L_0156
	LXI  H, 0BC0Eh - (N_STRK * 00A00h)	; 0300Eh	;+
	MVI  D, N_STRK	; количество строк
L_24B6:	PUSH D
	PUSH H
	PUSH H
	POP  B
	MVI  A, 001h
	CALL    L_013E
	INR  C
	INR  C
	INR  C
	INR  C
	INR  B
	INR  B
	MVI  A, 002h
	CALL    L_0141
	POP  H
	POP  D
	INR  H
	INR  H
	INR  H
	INR  H
	INR  H
	INR  H
	INR  H
	INR  H
	INR  H
	INR  H
	DCR  D
	JNZ     L_24B6	; цикл рисования чёрточек перед строками
	LXI  B, 03726h	;+
	CALL    L_2220
	LXI  H, D_262D	; "состояние"
	CALL    L_2653
	LHLD    D_279A
	CALL    L_2653
	LXI  B, 02620h	;+2820
	CALL    L_2220
	MVI  B, N_STRK	; количество строк
	LXI  D, 0002Bh	;+
	LXI  H, D_27A1	; ссылка на первый пункт
L_24FA:	PUSH H
	LXI  H, D_264D
	CALL    L_0138
	POP  H
	PUSH H
	CALL    L_2653
	POP  H
	DAD  D
	DCR  B
	JNZ     L_24FA
	RET
;
L_250D:	CALL    L_25F4
L_2510:	EI
	HLT
	EI
	HLT
	EI
	HLT
	EI
	HLT
	EI
	HLT
	IN      001h
	ANI     0E0h
	CPI     060h	; ст.вправо
	CZ      L_25E9
	CPI     0A0h	; ст.вверх
	CZ      L_25BE
	CPI     0C0h	; ст.вниз
	CZ      L_257E
	CALL    L_013B
	CPI     008h
	CZ      L_25E4
	CPI     018h
	CZ      L_25E9
	CPI     019h
	CZ      L_25BE
	CPI     01Ah
	CZ      L_257E
	CPI     00Dh
	RZ
	LHLD    D_25FE
	DCX  H
	SHLD    D_25FE
	MOV  A, L
	ORA  H
	RZ
	LDA     D_25FD
	INR  A
	STA     D_25FD
	MOV  H, A
	LDA     D_25FB
	ANI     002h
	ORA  H
	CALL    L_2568
	CALL    L_2600
	JMP     L_2510
;
L_2568:	LHLD    D_25FC
	PUSH PSW
	MOV  A, L
	ADD  A
	ADD  A
	ADD  A
	ADD  L
	ADD  L		; *10
	ADI     0ABh - (N_STRK * 00Ah)	;01Fh
	MOV  L, A
	POP  PSW
	RET
;
L_2577:	MVI  C, 007h
	CALL    L_0129
	POP  PSW
	RET
;
L_257E:	PUSH PSW	; движение жука вниз
	LDA     D_25FC
	CPI     000h
	JZ      L_2577
	POP  PSW
	LXI  H, L_2590
	PUSH H
	PUSH PSW
	JMP     L_25CB
;
L_2590:	PUSH PSW
	LDA     D_25FC
	DCR  A
	STA     D_25FC
	POP  PSW
	RET
;
L_259A:	LXI  H, D_29A4
	LXI  B, 0FFD5h	; -2Ah
	LDA     D_25FC
	DCR  A
L_25A4:	JZ      L_25AC
	DAD  B
	DCR  A
	JMP     L_25A4
;
L_25AC:	PUSH H
	POP  D
	DAD  B
	XCHG
	MVI  B, 02Bh
L_25B2:	MOV  C, M
	LDAX D
	MOV  M, A
	MOV  A, C
	STAX D
	DCX  H
	DCX  D
	DCR  B
	JNZ     L_25B2
	RET
;
L_25BE:	PUSH PSW	; движение жука вверх
	LDA     D_25FC
	CPI     N_STRK - 1	;00Dh	; самая верхняя позиция жука
	JZ      L_2577
	INR  A
	STA     D_25FC
L_25CB:	LDA     D_25FB
	CPI     002h
	JNZ     L_25E0
	CALL    L_2568
	MOV  A, L
	ADI     004h
	MOV  L, A
	CALL    L_22C1
	CALL    L_259A
L_25E0:	POP  PSW
	JMP     L_25F4
;
L_25E4:	PUSH PSW
	XRA  A
	JMP     L_25F0
;
L_25E9:	PUSH PSW	; захватить/отпустить строку
	LDA     D_25FB
	MVI  H, 002h
	XRA  H
L_25F0:	STA     D_25FB
	POP  PSW
L_25F4:	LXI  H, 001F4h
	SHLD    D_25FE
	RET
;
D_25FB:	.db 002h	; 2 = "жук" держит строку, "0" = отпустил
D_25FC:	.db 004h	; номер строки "жука", отсчёт снизу с 0
D_25FD:	.db 000h	; счётчик-таймер до запуска теста
D_25FE:	.dw 001F4h	; счётчик-таймер до запуска теста
;
L_2600:	PUSH H
	ANI     003h
	MVI  H, 000h
	LXI  D, D_2670	; ссылки на жука
	MOV  L, A
	DAD  H
	DAD  D
	MOV  E, M
	INX  H
	MOV  D, M
	POP  H
	PUSH H
	PUSH D
	MVI  H, 0A0h
	MVI  B, 024h
	INX  D
	CALL    L_2623
	POP  D
	POP  H
	MVI  H, 0A1h
	MVI  B, 024h
	CALL    L_2623
	RET
;
L_2623:	LDAX D
	MOV  M, A
	INX  D
	INX  D
	INR  L
	DCR  B
	JNZ     L_2623
	RET
;
L_2653:	INX  H
	INX  H
	INX  H
	MOV  A, M
	CALL    L_0156
	INX  H
	JMP     L_0138
;
L_265E:	LXI  H, D_27A1
	MVI  B, 00Ch
	INX  H
	INX  H
L_2665:	MVI  M, 000h
	LXI  D, 0002Bh	;+
	DAD  D
	DCR  B
	JNZ     L_2665
	RET
;
L_ENTS:	LXI  H, D_ENTS	; текст
	CALL    L_0138	; >>
	LXI  H, 03A98h
L_WHT:	SHLD    D_25FE	; счётчик ожидания
L_WHTC:	EI
	HLT
	CALL    L_013B	; >>
	CPI     00Dh
	RZ
	CPI     003h
	RZ
	LHLD    D_25FE	;
	DCX  H
	MOV  A, H
	ORA  L
	RZ
	SHLD    D_25FE	;
	JMP     L_WHTC
;
L_RHEX:	MVI  B, 000h
	LXI  H, 00010h	; чтобы не больше двух знаков, плюс по умлочанию для КД
L_3B5A:	CALL    L_0132
	CPI     00Dh
	JZ      L_3B8F
	MOV  C, A
	PUSH PSW
	CPI     01Fh
	JC      L_3B6C
	CALL    L_0129
L_3B6C:	POP  PSW
	SUI     030h
	JM      L_3B91
	CPI     00Ah
	JM      L_3B83
	CPI     011h
	JM      L_3B91
	CPI     017h
	JP      L_3B91
	SUI     007h
L_3B83:	MOV  C, A
	DAD  H
	DAD  H
	DAD  H
	DAD  H
	JC      L_3B91
	DAD  B
	JMP     L_3B5A
;
L_3B8F:	XRA  A		; уст.признак Z
	MOV  A, L
	RET
;
L_3B91:	MVI  A, 001h
	ANA  A
	RET		; Z не установлен
;
D_ENTS:	.db 01Bh, 059h, 038h, 021h
	.db " konec testa."
	.db "<wk>-powtor,<us>+<C>-dalee "
	.db 000h
;
D_262D:	.db 000h, 000h, 000h
	.db 0D0h
	.db " sostoqnie -"
	.db 000h
;
D_263E:	.db "monitor"
	.db 000h
;
D_2646:	.db "testow"
	.db 000h
;
D_264D:	.db 00Ah, 00Dh
	.db 018h, 018h
	.db 018h, 000h
;
D_2670:	.dw B_2678
	.dw B_26C0
	.dw B_2708
	.dw B_2750
;
B_2678:	.db 000h	; "_" - |        | (offset 2678h)
	.db 080h	; "А" - |■       | (offset 2679h)
	.db 000h	; "_" - |        | (offset 267Ah)
	.db 080h	; "А" - |■       | (offset 267Bh)
	.db 000h	; "_" - |        | (offset 267Ch)
	.db 080h	; "А" - |■       | (offset 267Dh)
	.db 000h	; "_" - |        | (offset 267Eh)
	.db 080h	; "А" - |■       | (offset 267Fh)
	.db 000h	; "_" - |        | (offset 2680h)
	.db 080h	; "А" - |■       | (offset 2681h)
	.db 000h	; "_" - |        | (offset 2682h)
	.db 080h	; "А" - |■       | (offset 2683h)
	.db 000h	; "_" - |        | (offset 2684h)
	.db 080h	; "А" - |■       | (offset 2685h)
	.db 000h	; "_" - |        | (offset 2686h)
	.db 080h	; "А" - |■       | (offset 2687h)
	.db 000h	; "_" - |        | (offset 2688h)
	.db 080h	; "А" - |■       | (offset 2689h)
	.db 000h	; "_" - |        | (offset 268Ah)
	.db 080h	; "А" - |■       | (offset 268Bh)
	.db 000h	; "_" - |        | (offset 268Ch)
	.db 080h	; "А" - |■       | (offset 268Dh)
	.db 010h	; "_" - |   ■    | (offset 268Eh)
	.db 08Bh	; "Л" - |■   ■ ■■| (offset 268Fh)
	.db 020h	; " " - |  ■     | (offset 2690h)
	.db 094h	; "Ф" - |■  ■ ■  | (offset 2691h)
	.db 04Ch	; "L" - | ■  ■■  | (offset 2692h)
	.db 092h	; "Т" - |■  ■  ■ | (offset 2693h)
	.db 094h	; "Ф" - |■  ■ ■  | (offset 2694h)
	.db 08Ah	; "К" - |■   ■ ■ | (offset 2695h)
	.db 090h	; "Р" - |■  ■    | (offset 2696h)
	.db 08Fh	; "П" - |■   ■■■■| (offset 2697h)
	.db 0B0h	; "░" - |■ ■■    | (offset 2698h)
	.db 09Fh	; "Я" - |■  ■■■■■| (offset 2699h)
	.db 0FCh	; "№" - |■■■■■■  | (offset 269Ah)
	.db 0BFh	; "┐" - |■ ■■■■■■| (offset 269Bh)
	.db 0F8h	; "°" - |■■■■■   | (offset 269Ch)
	.db 0BFh	; "┐" - |■ ■■■■■■| (offset 269Dh)
	.db 0B4h	; "┤" - |■ ■■ ■  | (offset 269Eh)
	.db 09Fh	; "Я" - |■  ■■■■■| (offset 269Fh)
	.db 090h	; "Р" - |■  ■    | (offset 26A0h)
	.db 08Fh	; "П" - |■   ■■■■| (offset 26A1h)
	.db 094h	; "Ф" - |■  ■ ■  | (offset 26A2h)
	.db 08Ah	; "К" - |■   ■ ■ | (offset 26A3h)
	.db 04Ch	; "L" - | ■  ■■  | (offset 26A4h)
	.db 092h	; "Т" - |■  ■  ■ | (offset 26A5h)
	.db 020h	; " " - |  ■     | (offset 26A6h)
	.db 091h	; "С" - |■  ■   ■| (offset 26A7h)
	.db 010h	; "_" - |   ■    | (offset 26A8h)
	.db 08Ah	; "К" - |■   ■ ■ | (offset 26A9h)
	.db 000h	; "_" - |        | (offset 26AAh)
	.db 080h	; "А" - |■       | (offset 26ABh)
	.db 000h	; "_" - |        | (offset 26ACh)
	.db 080h	; "А" - |■       | (offset 26ADh)
	.db 000h	; "_" - |        | (offset 26AEh)
	.db 080h	; "А" - |■       | (offset 26AFh)
	.db 000h	; "_" - |        | (offset 26B0h)
	.db 080h	; "А" - |■       | (offset 26B1h)
	.db 000h	; "_" - |        | (offset 26B2h)
	.db 080h	; "А" - |■       | (offset 26B3h)
	.db 000h	; "_" - |        | (offset 26B4h)
	.db 080h	; "А" - |■       | (offset 26B5h)
	.db 000h	; "_" - |        | (offset 26B6h)
	.db 080h	; "А" - |■       | (offset 26B7h)
	.db 000h	; "_" - |        | (offset 26B8h)
	.db 080h	; "А" - |■       | (offset 26B9h)
	.db 000h	; "_" - |        | (offset 26BAh)
	.db 080h	; "А" - |■       | (offset 26BBh)
	.db 000h	; "_" - |        | (offset 26BCh)
	.db 080h	; "А" - |■       | (offset 26BDh)
	.db 000h	; "_" - |        | (offset 26BEh)
	.db 080h	; "А" - |■       | (offset 26BFh)
;
B_26C0:	.db 000h	; "_" - |        | (offset 26C0h)
	.db 080h	; "А" - |■       | (offset 26C1h)
	.db 000h	; "_" - |        | (offset 26C2h)
	.db 080h	; "А" - |■       | (offset 26C3h)
	.db 000h	; "_" - |        | (offset 26C4h)
	.db 080h	; "А" - |■       | (offset 26C5h)
	.db 000h	; "_" - |        | (offset 26C6h)
	.db 080h	; "А" - |■       | (offset 26C7h)
	.db 000h	; "_" - |        | (offset 26C8h)
	.db 080h	; "А" - |■       | (offset 26C9h)
	.db 000h	; "_" - |        | (offset 26CAh)
	.db 080h	; "А" - |■       | (offset 26CBh)
	.db 000h	; "_" - |        | (offset 26CCh)
	.db 080h	; "А" - |■       | (offset 26CDh)
	.db 000h	; "_" - |        | (offset 26CEh)
	.db 080h	; "А" - |■       | (offset 26CFh)
	.db 000h	; "_" - |        | (offset 26D0h)
	.db 080h	; "А" - |■       | (offset 26D1h)
	.db 000h	; "_" - |        | (offset 26D2h)
	.db 080h	; "А" - |■       | (offset 26D3h)
	.db 000h	; "_" - |        | (offset 26D4h)
	.db 080h	; "А" - |■       | (offset 26D5h)
	.db 080h	; "А" - |■       | (offset 26D6h)
	.db 0A2h	; "в" - |■ ■   ■ | (offset 26D7h)
	.db 040h	; "@" - | ■      | (offset 26D8h)
	.db 0A1h	; "б" - |■ ■    ■| (offset 26D9h)
	.db 04Ch	; "L" - | ■  ■■  | (offset 26DAh)
	.db 092h	; "Т" - |■  ■  ■ | (offset 26DBh)
	.db 094h	; "Ф" - |■  ■ ■  | (offset 26DCh)
	.db 08Ah	; "К" - |■   ■ ■ | (offset 26DDh)
	.db 090h	; "Р" - |■  ■    | (offset 26DEh)
	.db 08Fh	; "П" - |■   ■■■■| (offset 26DFh)
	.db 0B4h	; "┤" - |■ ■■ ■  | (offset 26E0h)
	.db 09Fh	; "Я" - |■  ■■■■■| (offset 26E1h)
	.db 0F8h	; "°" - |■■■■■   | (offset 26E2h)
	.db 0BFh	; "┐" - |■ ■■■■■■| (offset 26E3h)
	.db 0FCh	; "№" - |■■■■■■  | (offset 26E4h)
	.db 0BFh	; "┐" - |■ ■■■■■■| (offset 26E5h)
	.db 0B0h	; "░" - |■ ■■    | (offset 26E6h)
	.db 09Fh	; "Я" - |■  ■■■■■| (offset 26E7h)
	.db 090h	; "Р" - |■  ■    | (offset 26E8h)
	.db 08Fh	; "П" - |■   ■■■■| (offset 26E9h)
	.db 094h	; "Ф" - |■  ■ ■  | (offset 26EAh)
	.db 08Ah	; "К" - |■   ■ ■ | (offset 26EBh)
	.db 04Ch	; "L" - | ■  ■■  | (offset 26ECh)
	.db 092h	; "Т" - |■  ■  ■ | (offset 26EDh)
	.db 080h	; "А" - |■       | (offset 26EEh)
	.db 0A4h	; "д" - |■ ■  ■  | (offset 26EFh)
	.db 040h	; "@" - | ■      | (offset 26F0h)
	.db 0A8h	; "и" - |■ ■ ■   | (offset 26F1h)
	.db 000h	; "_" - |        | (offset 26F2h)
	.db 080h	; "А" - |■       | (offset 26F3h)
	.db 000h	; "_" - |        | (offset 26F4h)
	.db 080h	; "А" - |■       | (offset 26F5h)
	.db 000h	; "_" - |        | (offset 26F6h)
	.db 080h	; "А" - |■       | (offset 26F7h)
	.db 000h	; "_" - |        | (offset 26F8h)
	.db 080h	; "А" - |■       | (offset 26F9h)
	.db 000h	; "_" - |        | (offset 26FAh)
	.db 080h	; "А" - |■       | (offset 26FBh)
	.db 000h	; "_" - |        | (offset 26FCh)
	.db 080h	; "А" - |■       | (offset 26FDh)
	.db 000h	; "_" - |        | (offset 26FEh)
	.db 080h	; "А" - |■       | (offset 26FFh)
	.db 000h	; "_" - |        | (offset 2700h)
	.db 080h	; "А" - |■       | (offset 2701h)
	.db 000h	; "_" - |        | (offset 2702h)
	.db 080h	; "А" - |■       | (offset 2703h)
	.db 000h	; "_" - |        | (offset 2704h)
	.db 080h	; "А" - |■       | (offset 2705h)
	.db 000h	; "_" - |        | (offset 2706h)
	.db 080h	; "А" - |■       | (offset 2707h)
;
B_2708:	.db 000h	; "_" - |        | (offset 2708h)
	.db 080h	; "А" - |■       | (offset 2709h)
	.db 000h	; "_" - |        | (offset 270Ah)
	.db 080h	; "А" - |■       | (offset 270Bh)
	.db 000h	; "_" - |        | (offset 270Ch)
	.db 080h	; "А" - |■       | (offset 270Dh)
	.db 000h	; "_" - |        | (offset 270Eh)
	.db 080h	; "А" - |■       | (offset 270Fh)
	.db 000h	; "_" - |        | (offset 2710h)
	.db 080h	; "А" - |■       | (offset 2711h)
	.db 000h	; "_" - |        | (offset 2712h)
	.db 080h	; "А" - |■       | (offset 2713h)
	.db 000h	; "_" - |        | (offset 2714h)
	.db 080h	; "А" - |■       | (offset 2715h)
	.db 000h	; "_" - |        | (offset 2716h)
	.db 080h	; "А" - |■       | (offset 2717h)
	.db 000h	; "_" - |        | (offset 2718h)
	.db 080h	; "А" - |■       | (offset 2719h)
	.db 000h	; "_" - |        | (offset 271Ah)
	.db 080h	; "А" - |■       | (offset 271Bh)
	.db 000h	; "_" - |        | (offset 271Ch)
	.db 080h	; "А" - |■       | (offset 271Dh)
	.db 040h	; "@" - | ■      | (offset 271Eh)
	.db 08Ah	; "К" - |■   ■ ■ | (offset 271Fh)
	.db 020h	; " " - |  ■     | (offset 2720h)
	.db 094h	; "Ф" - |■  ■ ■  | (offset 2721h)
	.db 040h	; "@" - | ■      | (offset 2722h)
	.db 092h	; "Т" - |■  ■  ■ | (offset 2723h)
	.db 08Eh	; "О" - |■   ■■■ | (offset 2724h)
	.db 08Ah	; "К" - |■   ■ ■ | (offset 2725h)
	.db 099h	; "Щ" - |■  ■■  ■| (offset 2726h)
	.db 08Fh	; "П" - |■   ■■■■| (offset 2727h)
	.db 0B0h	; "░" - |■ ■■    | (offset 2728h)
	.db 09Fh	; "Я" - |■  ■■■■■| (offset 2729h)
	.db 0FCh	; "№" - |■■■■■■  | (offset 272Ah)
	.db 0BFh	; "┐" - |■ ■■■■■■| (offset 272Bh)
	.db 0FCh	; "№" - |■■■■■■  | (offset 272Ch)
	.db 0BFh	; "┐" - |■ ■■■■■■| (offset 272Dh)
	.db 0B0h	; "░" - |■ ■■    | (offset 272Eh)
	.db 09Fh	; "Я" - |■  ■■■■■| (offset 272Fh)
	.db 099h	; "Щ" - |■  ■■  ■| (offset 2730h)
	.db 08Fh	; "П" - |■   ■■■■| (offset 2731h)
	.db 08Eh	; "О" - |■   ■■■ | (offset 2732h)
	.db 08Ah	; "К" - |■   ■ ■ | (offset 2733h)
	.db 040h	; "@" - | ■      | (offset 2734h)
	.db 092h	; "Т" - |■  ■  ■ | (offset 2735h)
	.db 020h	; " " - |  ■     | (offset 2736h)
	.db 091h	; "С" - |■  ■   ■| (offset 2737h)
	.db 020h	; " " - |  ■     | (offset 2738h)
	.db 0A2h	; "в" - |■ ■   ■ | (offset 2739h)
	.db 000h	; "_" - |        | (offset 273Ah)
	.db 080h	; "А" - |■       | (offset 273Bh)
	.db 000h	; "_" - |        | (offset 273Ch)
	.db 080h	; "А" - |■       | (offset 273Dh)
	.db 000h	; "_" - |        | (offset 273Eh)
	.db 080h	; "А" - |■       | (offset 273Fh)
	.db 000h	; "_" - |        | (offset 2740h)
	.db 080h	; "А" - |■       | (offset 2741h)
	.db 000h	; "_" - |        | (offset 2742h)
	.db 080h	; "А" - |■       | (offset 2743h)
	.db 000h	; "_" - |        | (offset 2744h)
	.db 080h	; "А" - |■       | (offset 2745h)
	.db 000h	; "_" - |        | (offset 2746h)
	.db 080h	; "А" - |■       | (offset 2747h)
	.db 000h	; "_" - |        | (offset 2748h)
	.db 080h	; "А" - |■       | (offset 2749h)
	.db 000h	; "_" - |        | (offset 274Ah)
	.db 080h	; "А" - |■       | (offset 274Bh)
	.db 000h	; "_" - |        | (offset 274Ch)
	.db 080h	; "А" - |■       | (offset 274Dh)
	.db 000h	; "_" - |        | (offset 274Eh)
	.db 080h	; "А" - |■       | (offset 274Fh)
;
B_2750:	.db 000h	; "_" - |        | (offset 2750h)
	.db 080h	; "А" - |■       | (offset 2751h)
	.db 000h	; "_" - |        | (offset 2752h)
	.db 080h	; "А" - |■       | (offset 2753h)
	.db 000h	; "_" - |        | (offset 2754h)
	.db 080h	; "А" - |■       | (offset 2755h)
	.db 000h	; "_" - |        | (offset 2756h)
	.db 080h	; "А" - |■       | (offset 2757h)
	.db 000h	; "_" - |        | (offset 2758h)
	.db 080h	; "А" - |■       | (offset 2759h)
	.db 000h	; "_" - |        | (offset 275Ah)
	.db 080h	; "А" - |■       | (offset 275Bh)
	.db 000h	; "_" - |        | (offset 275Ch)
	.db 080h	; "А" - |■       | (offset 275Dh)
	.db 000h	; "_" - |        | (offset 275Eh)
	.db 080h	; "А" - |■       | (offset 275Fh)
	.db 000h	; "_" - |        | (offset 2760h)
	.db 080h	; "А" - |■       | (offset 2761h)
	.db 000h	; "_" - |        | (offset 2762h)
	.db 080h	; "А" - |■       | (offset 2763h)
	.db 000h	; "_" - |        | (offset 2764h)
	.db 080h	; "А" - |■       | (offset 2765h)
	.db 090h	; "Р" - |■  ■    | (offset 2766h)
	.db 090h	; "Р" - |■  ■    | (offset 2767h)
	.db 010h	; "_" - |   ■    | (offset 2768h)
	.db 0A1h	; "б" - |■ ■    ■| (offset 2769h)
	.db 060h	; "`" - | ■■     | (offset 276Ah)
	.db 0B2h	; "▓" - |■ ■■  ■ | (offset 276Bh)
	.db 08Eh	; "О" - |■   ■■■ | (offset 276Ch)
	.db 08Ah	; "К" - |■   ■ ■ | (offset 276Dh)
	.db 099h	; "Щ" - |■  ■■  ■| (offset 276Eh)
	.db 08Fh	; "П" - |■   ■■■■| (offset 276Fh)
	.db 0B4h	; "┤" - |■ ■■ ■  | (offset 2770h)
	.db 09Fh	; "Я" - |■  ■■■■■| (offset 2771h)
	.db 0F8h	; "°" - |■■■■■   | (offset 2772h)
	.db 0BFh	; "┐" - |■ ■■■■■■| (offset 2773h)
	.db 0F8h	; "°" - |■■■■■   | (offset 2774h)
	.db 0BFh	; "┐" - |■ ■■■■■■| (offset 2775h)
	.db 0B4h	; "┤" - |■ ■■ ■  | (offset 2776h)
	.db 09Fh	; "Я" - |■  ■■■■■| (offset 2777h)
	.db 099h	; "Щ" - |■  ■■  ■| (offset 2778h)
	.db 08Fh	; "П" - |■   ■■■■| (offset 2779h)
	.db 08Eh	; "О" - |■   ■■■ | (offset 277Ah)
	.db 08Ah	; "К" - |■   ■ ■ | (offset 277Bh)
	.db 060h	; "`" - | ■■     | (offset 277Ch)
	.db 0B2h	; "▓" - |■ ■■  ■ | (offset 277Dh)
	.db 010h	; "_" - |   ■    | (offset 277Eh)
	.db 0A4h	; "д" - |■ ■  ■  | (offset 277Fh)
	.db 000h	; "_" - |        | (offset 2780h)
	.db 092h	; "Т" - |■  ■  ■ | (offset 2781h)
	.db 000h	; "_" - |        | (offset 2782h)
	.db 080h	; "А" - |■       | (offset 2783h)
	.db 000h	; "_" - |        | (offset 2784h)
	.db 080h	; "А" - |■       | (offset 2785h)
	.db 000h	; "_" - |        | (offset 2786h)
	.db 080h	; "А" - |■       | (offset 2787h)
	.db 000h	; "_" - |        | (offset 2788h)
	.db 080h	; "А" - |■       | (offset 2789h)
	.db 000h	; "_" - |        | (offset 278Ah)
	.db 080h	; "А" - |■       | (offset 278Bh)
	.db 000h	; "_" - |        | (offset 278Ch)
	.db 080h	; "А" - |■       | (offset 278Dh)
	.db 000h	; "_" - |        | (offset 278Eh)
	.db 080h	; "А" - |■       | (offset 278Fh)
	.db 000h	; "_" - |        | (offset 2790h)
	.db 080h	; "А" - |■       | (offset 2791h)
	.db 000h	; "_" - |        | (offset 2792h)
	.db 080h	; "А" - |■       | (offset 2793h)
	.db 000h	; "_" - |        | (offset 2794h)
	.db 080h	; "А" - |■       | (offset 2795h)
	.db 000h	; "_" - |        | (offset 2796h)
	.db 080h	; "А" - |■       | (offset 2797h)
;
D_2798:	.dw D_27A1	;
D_279A:	.dw D_2412	;
;
D_279C:	.db "test"
	.db 000h
;
D_27A1:	.dw L_2324
	.db 000h, 0A0h
	.db "***-----na~alo--cepo~ki"
	.db "--testow----***"
	.db 000h
;
	.dw L_29A5
	.db 000h, 0D0h
	.db "       bazowogo "
	.db " mikroprocessora      "
	.db 000h
;
	.dw L_2C10
	.db 000h, 0D0h
	.db " operatiwnogo zapomina`"
	.db "}ego ustrojstwa"
	.db 000h
;
	.dw L_2F83
	.db 000h, 0D0h
	.db "   __k__l__a__w__i__a_"
	.db "_t__u__r__y__   "
	.db 000h
;
	.dw L_334D
	.db 000h, 0D0h
	.db "  wwoda/wywoda  na  "
	.db "magnitnu`  lentu  "
	.db 000h
;
	.dw L_391C
	.db 000h, 0D0h
	.db "      parallelxnogo  "
	.db "interfejsa       "
	.db 000h
;
	.dw L_41C3
	.db 000h, 0D0h
	.db "  ustrojstwa OTObraveniq "
	.db " informacii  "
	.db 000h
;
	.dw L_4AB3
	.db 000h, 0D0h
	.db "  tajmera  i  zwukowogo "
	.db " sintezatora  "
	.db 000h
;
	.dw L_2429
	.db 000h, 0A0h
	.db "***-----konec--cepo~ki-"
	.db "-testow-----***"
	.db 000h
;
	.dw L_596A
	.db 000h, 0D0h
	.db " wne{nego ozu -"
	.db 022h	; "
	.db "|lektronnyj disk 256k"
	.db 022h	; "
	.db 000h
;
	.dw L_5751
	.db 000h, 0D0h
	.db "    manipulqtorow tipa "
	.db 022h	; "
	.db "dvojstik s"
	.db 022h	; "
	.db "   "
	.db 000h
;
;;	.dw L_6400
;;	.db 000h, 0D0h
;;	.db "     zwukowogo sintezatora"
;;	.db " AY8910     "
;;	.db 000h
;
	.dw L_50F3
	.db 000h, 0D0h
	.db " matri~nogo   pe~ata`}ego"
	.db "  ustrojstwa "
	.db 000h
;
	.dw L_6400
	.db 000h, 0D0h
	.db "   test  dopolnitelxnogo"
	.db " ustrojstwa   "
D_29A4:	.db 000h
;
D_CHIP:	.db 07Eh	; | ■■■■■■ |
	.db 0FFh	; |■■■■■■■■|
	.db 0FBh	; |■■■■■ ■■|
	.db 07Ah	; | ■■■■ ■ |
	.db 0FFh	; |■■■■■■■■|
	.db 0FFh	; |■■■■■■■■|
	.db 07Eh	; | ■■■■■■ |
	.db 0FFh	; |■■■■■■■■|
	.db 0FFh	; |■■■■■■■■|
	.db 07Eh	; | ■■■■■■ |
	.db 0FFh	; |■■■■■■■■|
	.db 0FFh	; |■■■■■■■■|
	.db 07Eh	; | ■■■■■■ |
	.db 0FFh	; |■■■■■■■■|
	.db 0FFh	; |■■■■■■■■|
	.db 07Eh	; | ■■■■■■ |
	.db 0FFh	; |■■■■■■■■|
	.db 0FFh	; |■■■■■■■■|
	.db 07Eh	; | ■■■■■■ |
	.db 0FFh	; |■■■■■■■■|
	.db 0FFh	; |■■■■■■■■|
	.db 07Eh	; | ■■■■■■ |
	.db 0FFh	; |■■■■■■■■|
	.db 0FFh	; |■■■■■■■■|
	.db 07Eh	; | ■■■■■■ |
;
D_BRAK:	.db 0FFh	; |■■■■■■■■|
	.db 081h	; |■      ■|
	.db 085h	; |■    ■ ■|
	.db 085h	; |■    ■ ■|
	.db 081h	; |■      ■|
	.db 081h	; |■      ■|
	.db 0BDh	; |■ ■■■■ ■|
	.db 0ADh	; |■ ■ ■■ ■|
	.db 0ADh	; |■ ■ ■■ ■|
	.db 081h	; |■      ■|
	.db 0BDh	; |■ ■■■■ ■|
	.db 0A9h	; |■ ■ ■  ■|
	.db 0B9h	; |■ ■■■  ■|
	.db 081h	; |■      ■|
	.db 09Dh	; |■  ■■■ ■|
	.db 0A9h	; |■ ■ ■  ■|
	.db 0BDh	; |■ ■■■■ ■|
	.db 081h	; |■      ■|
	.db 0BDh	; |■ ■■■■ ■|
	.db 099h	; |■  ■■  ■|
	.db 0B5h	; |■ ■■ ■ ■|
	.db 0A5h	; |■ ■  ■ ■|
	.db 081h	; |■      ■|
	.db 081h	; |■      ■|
	.db 0FFh	; |■■■■■■■■|
;
#include "t_CPUn.inc"
#include "t_RAM6n.inc"
#include "t_KBDn.inc"
#include "t_MAGn.inc"
#include "t_PUn.inc"
#include "t_MONn.inc"
#include "t_VIn.inc"
#include "t_PRNn.inc"
#include "t_KDn.inc"
#include "t_DJ2.inc"
	.org (((($ - 1) / 0100h) + 1) * 0100h)	;Выравнивание на адрес ХХ00h
#include "t_DOPn.inc"
;
	.END
