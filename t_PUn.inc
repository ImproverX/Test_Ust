M_FFEF:	.equ    0FFEFh
;
L_391C:	MVI  A, 017h
	CALL    L_0156
	LXI  H, D_3C57
	CALL    L_0138
	LDA     D_3C56
	CALL    L_0135
	LXI  H, D_3F18
	CALL    L_0138
	XRA  A
	STA     D_3C53
	STA     D_588A
L_393A:	LXI  D, 00BB8h	;+
L_393D:	DCX  D
	HLT
	EI
	MOV  A, D
	ORA  E
	JZ      L_3B49
	CALL    L_013B
	CPI     003h	; "F4" / "УС"+"С"
	JZ      L_3B51
	CPI     01Fh	; "СТР"
	JZ      L_3A06	; >> тест ШАВВ и ШУ ??
	CPI     00Dh	; "ВК"
	JZ      L_3974
	CPI     020h	; " "
	JNZ     L_393D
L_395C:	LXI  B, 03821h	;+
	CALL    L_2220
	LXI  H, D_3F30
	CALL    L_0138
	CALL    L_RHEX
	JNZ     L_395C
	CPI     010h
	JNZ     L_N10	; не 10h
	CMP  H		; проверка, если был пустой ввод
	JZ      L_N10
	MVI  A, 004h	; если просто ВК, то порт = 4
L_N10:	STA     D_3C56
L_3974:	LXI  B, 01200h	;+00A00h
	LXI  H, 0C408h	;+
	CALL    L_226E
	MVI  A, 0D0h
	CALL    L_0156
	LXI  B, 02420h	;+
	CALL    L_2220
	LXI  H, D_58CF
	CALL    L_0138
	MVI  A, 001h
	STA     D_3C53
	MVI  A, 0F1h
	CALL    L_0156
	LXI  B, 02720h
	CALL    L_2220
	LXI  H, D_3F5E
	CALL    L_0138
	LDA     D_3C56
	CALL    L_0135
	LXI  H, D_3FAB
	CALL    L_0138
	INR  A
	CALL    L_0135
	MVI  C, 02Ch
	CALL    L_0129
	INR  A
	CALL    L_0135
	CALL    L_0129
	INR  A
	CALL    L_0135
	LXI  H, D_BOTS	; нижняя строка
	CALL    L_0138
	MVI  A, 00Ah
	CALL    L_0156
	LXI  H, D_3FC8	; выводы ПУ
	CALL    L_0138
	MVI  A, 007h
	CALL    L_0156
	LDA     D_3C56
	STA     X_3BC0+1
	INR  A
	STA     L_3BAC+1
	STA     X_3BA6+1
	INR  A
	STA     L_3BA9+1
	INR  A
	STA     L_3B95+1
	MVI  A, 083h
	MVI  C, 000h
	CALL    L_3BBF
	LDA     D_3C56
	INR  A
	INR  A
	STA     L_3B95+1
	INR  A
	STA     L_3BA9+1
	MVI  A, 098h
	MVI  C, 001h
	CALL    L_3BBF
	JMP     L_393A
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
	JMP     L_393A
;
L_3B49:	LDA     D_3C53
	CPI     000h
	JZ      L_3974
L_3B51:	LDA     D_588A
	RET
;
L_3B95:	OUT     007h
	RET
;
L_3B98:	PUSH PSW
	MOV  A, C
	CPI     001h
	JNZ     L_3BA5
	POP  PSW
	RLC
	RLC
	RLC
	RLC
	PUSH PSW
L_3BA5:	POP  PSW
X_3BA6:	OUT     005h
	RET
;
L_3BA9:	IN      006h
	RET
;
L_3BAC:	IN      005h
	PUSH PSW
	MOV  A, C
	CPI     001h
	JZ      L_3BBB
	POP  PSW
	RLC
	RLC
	RLC
	RLC
	PUSH PSW
L_3BBB:	POP  PSW
	ORI     00Fh
	RET
;
L_3BBF:	PUSH D
X_3BC0:	OUT     004h
	LXI  H, M_FFEF	; ?
	MVI  B, 000h
L_3BC7:	PUSH H
	PUSH B
	POP  H
	SHLD    D_3C54
	POP  H
	MVI  A, 0FFh
	CALL    L_3B95
	CALL    L_3B98
	CALL    L_3BA9
	MOV  D, A
	CALL    L_3BAC
	MOV  E, A
	MOV  A, H
	CALL    L_3B95
	MOV  A, L
	CALL    L_3B98
	PUSH H
	CALL    L_3BA9
	MOV  H, A
	CALL    L_3BAC
	MOV  L, A
	PUSH B
	MVI  C, 010h
	MVI  B, 000h
L_3BF4:	MOV  A, L
	XRA  E
	ANA  C
	CNZ     L_3C1B
	MOV  A, C
	RLC
	MOV  C, A
	INR  B
	MOV  A, B
	CPI     004h
	CZ      L_3C16
	CPI     00Ch
	JNZ     L_3BF4
	POP  B
	POP  H
	DAD  H
	INX  H
	INR  B
	MOV  A, B
	CPI     00Ch
	JNZ     L_3BC7
	POP  D
	RET
;
L_3C16:	MVI  C, 001h
	MOV  L, H
	MOV  E, D
	RET
;
L_3C1B:	PUSH H
	PUSH B
	PUSH D
	PUSH PSW
	MOV  D, B
	LHLD    D_3C54
	MOV  A, L
	CPI     001h
	JNZ     L_3C2B
	MVI  A, 084h
L_3C2B:	ADI     04Bh
	MOV  C, A
	MOV  A, D
	ADD  A
	MOV  B, A
	ADD  A
	ADD  A
	ADD  B
	ADI     027h
	MOV  B, A
	MVI  A, 001h
	CALL    L_013E
	MOV  A, C
	SUI     01Ah
	MOV  C, A
	MOV  A, H
	ADD  A
	MOV  B, A
	ADD  A
	ADD  A
	ADD  B
	ADI     027h
	MOV  B, A
	MVI  A, 000h
	CALL    L_0141
	POP  PSW
	POP  D
	POP  B
	POP  H
	RET
;
D_3C53:	.db 000h	; "_" - |        | (offset 3C53h)
D_3C54:	.db 000h	; "_" - |        | (offset 3C54h)
	.db 000h	; "_" - |        | (offset 3C55h)
D_3C56:	.db 004h	; "_" - |     ■  | (offset 3C56h)
;
D_3C57:	.db "    prowerka interfejsa"
	.db " sostoit iz wywoda"
	.db 00Ah, 00Dh
	.db " w  prowerqemyj   port "
	.db " testowyh  kodow :"
	.db 00Ah, 00Dh
	.db " "
	.db 022h	; "
	.db "edinica"
	.db 022h	; "
	.db " (kod 0FFH), "
	.db 022h	; "
	.db "begu}ij nolx"
	.db 022h	; "
	.db ", i "
	.db 00Ah, 00Dh
	.db " kontrolq  wywodimoj "
	.db " informacii   ~erez "
	.db 00Ah, 00Dh
	.db " whody drugogo porta"
	.db " podkl`~aemye paral- "
	.db 00Ah, 00Dh
	.db " lelxno s portom wywoda."
	.db "                 "
	.db 00Ah, 00Dh
	.db "    neobhodimye soedineniq"
	.db " mevdu kanalami"
	.db 00Ah, 00Dh
	.db " dolven obespe~iwatx "
	.db " specialxnyj zamyka-"
	.db 00Ah, 00Dh
	.db " telx podkl`~ennyj k"
	.db " razxemu prowqrqemogo"
	.db 00Ah, 00Dh
	.db " kanala parallelxnogo"
	.db " interfejsa.        "
	.db 00Ah, 00Dh
	.db "    test movet bytx"
	.db " nastroen na prowerku "
	.db 00Ah, 00Dh
	.db " kanalow  interfejsnyh "
	.db " bis - kr580ww55a "
	.db 00Ah, 00Dh
	.db " podkl`~aemyh k bp|wm"
	.db " dopolnitelxno. pri "
	.db 00Ah, 00Dh
	.db " |tom,  neobhodimo  "
	.db " soob}itx  programme "
	.db 00Ah, 00Dh
	.db " nowyj adres registra"
	.db " uprawlq`}ego slowa "
	.db 00Ah, 00Dh
	.db " podkl`~ennoj interfejsnoj"
	.db " bis.          "
	.db 00Ah, 00Dh
	.db "  itak, adres = "
	.db 000h
;
D_3F18:	.db " ? <wk>, ina~e <probel>"
	.db 000h
;
D_3F30:	.db " wwedite {estnadcateri~noe"
	.db " ~islo -      "
	.db 008h, 008h, 008h, 008h, 008h
	.db 000h
;
D_3F5E:	.db 018h, 018h, 018h
	.db " prowerka kanalow  bis"
	.db " - kr580ww55a "
	.db 00Ah, 00Dh
	.db 018h, 018h, 018h, 018h
	.db " registr  uprawlq`}ego"
	.db " slowa - "
	.db 000h
;
D_3FAB:	.db 00Ah, 00Dh
	.db 018h, 018h, 018h, 018h, 018h, 018h
	.db " port <C>,<B>,<A> - "
	.db 000h
;
D_3FC8:	.db 01Bh, 059h, 02Ah, 020h
;00Ah, 00Dh
	.db " PA[7]->"
	.db 018h, 018h, 018h, 018h
	.db ">-PB[7] "
	.db 018h, 018h
	.db " PB[7]->"
	.db 018h, 018h, 018h, 018h
	.db ">-PA[7]  PA[6]->"
	.db 018h, 018h, 018h
	.db 018h
	.db ">-PB[6] "
	.db 018h, 018h
	.db " PB[6]->"
	.db 018h, 018h, 018h, 018h
	.db ">-PA[6]  PA[5]->"
	.db 018h, 018h, 018h, 018h
	.db ">-PB[5] "
	.db 018h, 018h
	.db " PB[5]->"
	.db 018h, 018h, 018h, 018h
	.db ">-PA[5]  PA[4]->"
	.db 018h, 018h, 018h, 018h
	.db ">-PB[4] "
	.db 018h, 018h
	.db " PB[4]->"
	.db 018h, 018h, 018h, 018h
	.db ">-PA[4]  PA[3]->"
	.db 018h, 018h, 018h, 018h
	.db ">-PB[3] "
	.db 018h, 018h
	.db " PB[3]->"
	.db 018h, 018h, 018h, 018h
	.db ">-PA[3]  PA[2]->"
	.db 018h, 018h, 018h, 018h
	.db ">-PB[2] "
	.db 018h, 018h
	.db " PB[2]->"
	.db 018h, 018h, 018h, 018h
	.db ">-PA[2]  PA[1]->"
	.db 018h, 018h, 018h, 018h
	.db ">-PB[1] "
	.db 018h, 018h
	.db " PB[1]->"
	.db 018h, 018h, 018h, 018h
	.db ">-PA[1]  PA[0]->"
	.db 018h, 018h, 018h, 018h
	.db ">-PB[0] "
	.db 018h, 018h
	.db " PB[0]->"
	.db 018h, 018h, 018h, 018h
	.db ">-PA[0]  PC[7]->"
	.db 018h, 018h, 018h, 018h
	.db ">-PC[3] "
	.db 018h
	.db 018h
	.db " PC[3]->"
	.db 018h, 018h, 018h, 018h
	.db ">-PC[7]  PC[6]->"
	.db 018h, 018h, 018h, 018h
	.db ">-PC[2] "
	.db 018h, 018h
	.db " PC[2]->"
	.db 018h, 018h, 018h, 018h
	.db ">-PC[6]  PC[5]->"
	.db 018h, 018h, 018h, 018h
	.db ">-PC[1] "
	.db 018h, 018h
	.db " PC[1]->"
	.db 018h, 018h, 018h, 018h
	.db ">-PC[5]  PC[4]->"
	.db 018h, 018h, 018h, 018h
	.db ">-PC[0] "
	.db 018h, 018h
	.db " PC[0]->"
	.db 018h, 018h, 018h, 018h
	.db ">-PA[4] "
	.db 000h
;
D_BOTS:	.db 01Bh, 059h, 038h, 021h
	.db "<probel>-dr.port,"
	.db "<wk>-powt.,"
	.db "<us+C>-dalee"
	.db 000h
;
D_5877:	.db 000h	; "_" - |        | (offset 5877h)
D_5878:	.dw 00000h
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
D_588A:	.db 000h	; "_" - |        | (offset 588Ah)
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
