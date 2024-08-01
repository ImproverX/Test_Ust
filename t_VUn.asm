	.ORG	06E00h
L_0120:	.EQU	00120h	; @INIT
L_0126:	.EQU	00123h	; @INTAP ввод байта с магнитной ленты
L_0129:	.EQU	00126h	; @CONOUT вывод символа на дисплей
L_012C:	.EQU	00129h	; @OUTAP вывод байта на магнитную ленту
L_012F:	.EQU	0012Ch	; @LIST вывод символа на печать
L_0132:	.EQU	0012Fh	; @CONIN ввод символа с клавиатуры
L_0135:	.EQU	00132h	; @DUMP вывод содержимого регистра A в шестнадцатеричном виде
L_0138:	.EQU	00135h	; @SPIC вывод сообщения по адресу, определенному регистрами H и L
L_013B:	.EQU	00138h	; @INKEY ввод символа с клавиатуры без ожидания ввода
L_013E:	.EQU	0013Bh	; @PLOT
L_0141:	.EQU	0013Eh	; @LINE
L_0144:	.EQU	00141h	; @CIRCLE
L_0147:	.EQU	00144h	; @PCIRCLE
L_0150:	.EQU	00147h	; @PAINT
L_0153:	.EQU	0014Ah	; @PGET определение цвета текущей точки
L_0156:	.EQU	0014Dh	; @COLOR
L_0159:	.EQU	00150h	; @FON
L_015C:	.EQU	00153h	; @BORD
L_0162:	.EQU	00156h	; @PLAY
L_0165:	.EQU	00159h	; @FPLAY
L_0168:	.EQU	0015Ch	; @PLOFF
L_0171:	.EQU	0015Fh	; @EADD сложение двоичных чисел -- не используется
L_0177:	.EQU	00162h	; @EMULT умножение двоичных чисел -- не используется
L_017A:	.EQU	00165h	; @EDIVM деление двоичных чисел
L_017D:	.EQU	00168h	; @ESIGN определение знака двоичного числа -- не используется
L_0183:	.EQU	0016Bh	; @BINDEC преобразование двоичного числа в строку
L_0186:	.EQU	0016Eh	; @CMPHD -- не используется
L_0189:	.EQU	00171h	; @SCOLOR установка физических цветов
L_018C:	.EQU	00174h	; @SPLAN установка экранных областей
L_018F:	.EQU	00177h	; @SCONR установка скорости обмена информацией с магнитной лентой
L_0192:	.EQU	0017Ah	; @SLIST установка типа принтера
L_0195:	.EQU	0017Dh	; @LSCR печать экрана в графическом режиме
;
L_2220:	.EQU	0216Bh
L_226E:	.EQU	021B9h
L_ENTS:	.EQU	02595h
;
M_0000:	.EQU	00000h
M_0002:	.EQU	00002h
M_FFFF:	.EQU	0FFFFh
;
L_391C:	MVI  A, 017h
	CALL    L_0156
	XRA  A
	STA     D_588A
;	JMP	L_3A06	; >> тест ШАВВ и ШУ
;
L_3A06:	LXI  B, 00000h	;+00A00h
	LXI  H, 0C408h	;+
	CALL    L_226E
	MVI  A, 0D0h
	CALL    L_0156
	LXI  B, 02420h	;+
	CALL    L_2220
	LXI  H, D_58FA
	CALL    L_0138
	MVI  A, 017h
	CALL    L_0156
	CALL    L_5D2E	; >> сохранение SP (в тесте КД)
	LXI  SP,M_FFFF	; ?
	OUT     0FFh
	POP  D
	IN      0FFh
	DCX  SP
	DCX  SP
	POP  B
	XRA  A
	XRA  E
	JZ      L_3A40	;> E=00
	MOV  A, E
	XRA  C
	JNZ     L_3B04	;>> "неисправна ШАП или ШД"
	JMP     L_3ADC	;>> "неисправна ШАВВ или ШУ"
;
L_3A40:	CMA
	XRA  D
	JZ      L_3A4D	;> D=FF
	MOV  A, B
	XRA  D
	JNZ     L_3B04	;>> "неисправна ШАП или ШД"
	JMP     L_3ADC	;>> "неисправна ШАВВ или ШУ"
;
L_3A4D:	MVI  A, 0FEh
	STA     X_3A58+1
	STA     X_3A5B+1
L_3A55:	LXI  SP,M_FFFF	; ?
X_3A58:	OUT     000h
	POP  D
X_3A5B:	IN      000h
	DCX  SP
	DCX  SP
	POP  B
	LDA     X_3A58+1
	RLC		; = 0FDh
	STA     X_3A58+1
	STA     X_3A5B+1
	XRA  A
	XRA  E
	JNZ     L_3A74
	MOV  A, E
	XRA  C
	JNZ     L_3ADC	;>> "неисправна ШАВВ или ШУ"
L_3A74:	MVI  A, 0FFh
	XRA  D
	JNZ     L_3A7F
	MOV  A, D
	XRA  B
	JNZ     L_3ADC	;>> "неисправна ШАВВ или ШУ"
L_3A7F:	LDA     X_3A58+1
	CPI     0FEh
	JNZ     L_3A55
	MVI  A, 001h
	STA     D_5877
	LXI  H, D_587A
	SHLD    D_5878
L_3A92:	LHLD    D_5878
	XCHG
	LDAX D
	MOV  H, A
	INX  D
	LDAX D
	MOV  L, A
	INX  D
	XCHG
	SHLD    D_5878
	XCHG
	SPHL
L_3AA2:	OUT     0FFh
	POP  D
	IN      0FFh
	DCX  SP
	DCX  SP
	POP  B
	LDA     D_5877
	XRA  E
	JNZ     L_3B04	;>> "неисправна ШАП или ШД"
	LDA     D_5877
	XRA  C
	JNZ     L_3ACD
	DCX  SP
	DCX  SP
	LXI  H, M_0000	; ?
	DAD  SP
	MOV  A, H
	ADI     001h
	MOV  H, A
	ANI     03Fh
	CPI     03Fh
	JZ      L_3ACD
	SPHL
	JMP     L_3AA2
;
L_3ACD:	LDA     D_5877
	RLC
	STA     D_5877
	CPI     001h
	JZ      L_3B2C	;>> "системная шина исправна"
	JMP     L_3A92
;
L_3ADC:	SHLD    D_5DFC
	LHLD    D_5DFE
	SPHL
	LHLD    D_5DFC
	LXI  B, 02920h	;+
	CALL    L_2220
	MVI  A, 0C6h
	CALL    L_0156
	LXI  H, D_588B	; "неисправна ШАВВ или ШУ"
	CALL    L_0138
	MVI  A, 017h
	CALL    L_0156
	MVI  A, 001h
	STA     D_588A
	JMP     L_393A
;
L_3B04:	SHLD    D_5DFC
	LHLD    D_5DFE
	SPHL
	LHLD    D_5DFC
	LXI  B, 02920h	;+
	CALL    L_2220
	MVI  A, 0C6h
	CALL    L_0156
	LXI  H, D_58AD	; "неисправна ШАП или ШД"
	CALL    L_0138
	MVI  A, 017h
	CALL    L_0156
	MVI  A, 001h
	STA     D_588A
	JMP     L_393A
;
L_3B2C:	SHLD    D_5DFC
	LHLD    D_5DFE
	SPHL
	LHLD    D_5DFC
	LXI  B, 02924h	;+
	CALL    L_2220
	LXI  H, D_5925	; "системная шина исправна"
	CALL    L_0138
	XRA  A
	STA     D_588A
;	JMP     L_393A
;
L_393A:	CALL    L_ENTS	; >>
	CPI     00Dh
	JZ      L_391C	; повтор
	LDA     D_588A
	RET
;
L_5D2E:	SHLD    D_5DFC	; сохранение указателя стека
	LXI  H, M_0002	; ?
	DAD  SP
	SHLD    D_5DFE
	LHLD    D_5DFC
	RET
;
D_5877:	.db 000h	; "_" - |        | (offset 5877h)
D_5878:	.dw 00000h
;
D_587A:	.db 0C0h	; "└" - |■■      | (offset 587Ah)
	.db 0F8h	; "°" - |■■■■■   | (offset 587Bh)
	.db 0C0h	; "└" - |■■      | (offset 587Ch)
	.db 0F4h	; "Ї" - |■■■■ ■  | (offset 587Dh)
	.db 0C0h	; "└" - |■■      | (offset 587Eh)
	.db 0ECh	; "ь" - |■■■ ■■  | (offset 587Fh)
	.db 0C0h	; "└" - |■■      | (offset 5880h)
	.db 0DCh	; "▄" - |■■ ■■■  | (offset 5881h)
	.db 0C0h	; "└" - |■■      | (offset 5882h)
	.db 0BCh	; "╝" - |■ ■■■■  | (offset 5883h)
	.db 0C0h	; "└" - |■■      | (offset 5884h)
	.db 07Ch	; "|" - | ■■■■■  | (offset 5885h)
	.db 040h	; "@" - | ■      | (offset 5886h)
	.db 0FCh	; "№" - |■■■■■■  | (offset 5887h)
	.db 080h	; "А" - |■       | (offset 5888h)
	.db 0FCh	; "№" - |■■■■■■  | (offset 5889h)
;
D_588A:	.db 000h	;
;
D_588B:	.db 018h, 018h, 018h, 018h
	.db 018h, 018h, 018h, 018h
	.db " neisprawna {aBB ili {u  "
	.db 000h
;
D_58AD:	.db 018h, 018h, 018h, 018h
	.db 018h, 018h, 018h, 018h
	.db "  neisprawna {ap ili {d  "
	.db 000h
;
D_58CF:	.db 018h, 018h
	.db "      parallelxnogo"
	.db " interfejsa        "
	.db 00Ah, 00Dh
	.db 000h
;
D_58FA:	.db 018h, 018h
	.db "           sistemnoj"
	.db "  {iny            "
	.db 00Ah, 00Dh
	.db 000h
;
D_5925:	.db 018h, 018h, 018h, 018h
	.db "sistemnaq  {ina  isprawna"
	.db 000h
;
D_5DFC:	.dw 00000h
D_5DFE:	.dw 00000h
;
	.END