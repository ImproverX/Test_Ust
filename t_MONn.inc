M_7C00:	.equ    07C00h
M_7E00:	.equ    07E00h
;
L_41C3:	LXI  D, D_21A2
	CALL    L_0189
	MVI  A, 004h
	CALL    L_015C
	LXI  H, M_0080	; ?
	MVI  B, 00Fh
L_41D3:	MVI  C, 000h
	MVI  A, 009h
	STA     D_4A3B
L_41DA:	LDA     D_4A3B
	CPI     000h
	MVI  A, 009h
	JZ      L_41E6
	MVI  A, 000h
L_41E6:	STA     D_4A3B
	CALL    L_0156
	MVI  A, 001h
	CALL    L_013E
	PUSH H
	DAD  B
	PUSH H
	MOV  A, H
	ADI     008h
	MOV  H, A
	PUSH H
	POP  B
	DCR  C
	MVI  A, 002h
	CALL    L_0141
	POP  B
	POP  H
	MOV  A, C
	CPI     000h
	JNZ     L_41DA
	MOV  A, B
	ADI     009h
	MOV  B, A
	MOV  A, L
	STC
	CMC
	RRC
	MOV  L, A
	CPI     080h
	JNZ     L_41D3
	MVI  A, 00Fh
	CALL    L_0156
	LXI  B, 00000h	;+
	MVI  A, 001h
	CALL    L_013E
	LXI  B, 0FFFFh	;+
	MVI  A, 001h
	CALL    L_0141
	MVI  A, 0F0h
	CALL    L_0156
	LXI  B, 03046h
	CALL    L_2220
	LXI  H, D_4A68
	CALL    L_0138
	LXI  B, 0A007h	;+
	LXI  H, 0B909h	;+
	CALL    L_226E
	MVI  A, 006h
	CALL    L_0156
	LXI  B, 0A611h
	LXI  D, 00201h
	LXI  H, D_4A3C
	CALL    L_2234
	MVI  A, 006h
	CALL    L_0156
	LXI  B, 0AB35h	;+
	MVI  A, 001h
	CALL    L_013E
	LXI  B, 0AF35h	;+
	MVI  A, 000h
	CALL    L_0141
	LXI  B, 0821Fh	;+ 0820Fh
	LXI  D, 00010h	;+
L_4271:	MOV  A, D
	INR  D
	CALL    L_0156
	MVI  A, 001h
	CALL    L_013E
	PUSH B
	LXI  H, 0140Ah	;+
	DAD  B
	PUSH H
	POP  B
	MVI  A, 002h
	CALL    L_0141
	POP  B
	MVI  A, 00Fh
	CALL    L_0156
	MVI  A, 001h
	CALL    L_0141
	MOV  A, C
	ADI     00Ch
	MOV  C, A
	DCR  E
	JNZ     L_4271
	MVI  A, 00Fh
	CALL    L_0156
	LXI  B, 06633h	;06623h
	LXI  D, 00302h
	LXI  H, D_4AA1
	CALL    L_2234
	LXI  H, 00BB8h  ;+
        CALL    L_WHT
;	CALL    L_4BB2
	CPI     003h
	JZ      L_43D2
;	CALL    L_49F6
;L_49F6:
	MVI  L, 000h
	CALL    L_4A0E
	CALL    L_4A0E
	MVI  L, 0FFh
	CALL    L_4A0E
	MVI  L, 001h
	CALL    L_4A0E
	MVI  L, 000h
	CALL    L_4A0E
;	RET
	LXI  B, 0A007h	;+
	LXI  H, 0B909h	;+
	CALL    L_226E
	MVI  A, 006h
	CALL    L_0156
	LXI  B, 0A611h
	LXI  D, 00201h
	LXI  H, D_4A52
	CALL    L_2234
	MVI  A, 006h
	CALL    L_0156
	LXI  B, 0AB35h	;+
	MVI  A, 001h
	CALL    L_013E
	LXI  B, 0AF35h	;+
	MVI  A, 000h
	CALL    L_0141
	MVI  A, 000h
	CALL    L_0156
	LXI  B, 06401h	;+
	MVI  A, 000h
	CALL    L_013E
	LXI  B, 098FEh	;+
	MVI  A, 002h
	CALL    L_0141
	LXI  B, M_8000	; ?
	LXI  H, M_0000	; ?
	LXI  D, M_0000	; ?
	CALL    L_0147
	MVI  A, 00Fh
	CALL    L_0156
	LXI  D, 00084h	;+
	LXI  H, 0003Ch	;+
	MVI  A, 02Eh
	CALL    L_0144
	LXI  B, 0843Ch	;+
	LXI  D, 00F0Fh	;+
	CALL    L_0150
	MVI  A, 006h
	CALL    L_0156
	LXI  D, 00080h	;+
	LXI  H, 00038h	;+
	MVI  A, 022h
	CALL    L_0144
	LXI  B, 0843Ch	;+
	LXI  D, 00606h	;+
	CALL    L_0150
	MVI  A, 009h
	CALL    L_0156
	LXI  D, 0007Eh	;+
	LXI  H, 00036h	;+
	MVI  A, 01Ah
	CALL    L_0144
	LXI  B, 0843Ch	;+
	LXI  D, 00909h	;+
	CALL    L_0150
	MVI  A, 000h
	CALL    L_0156
	LXI  D, 0007Eh	;+
	LXI  H, 00034h	;+
	MVI  A, 00Ch
	CALL    L_0144
	LXI  B, 07E34h	;+
	LXI  D, 00000h	;+
	CALL    L_0150
	MVI  A, 00Fh
	CALL    L_0156
	LXI  B, 00000h	;+
	MVI  A, 001h
	CALL    L_013E
	LXI  B, 0FFFFh	;+
	MVI  A, 001h
	CALL    L_0141
	LXI  B, 07878h
	LXI  D, 00202h
	LXI  H, D_4AAB
	CALL    L_2234
	MVI  A, 001h
	CALL    L_0156
	LXI  B, 05F01h	;+
	MVI  A, 001h
	CALL    L_013E
	LXI  B, 067FEh	;+
	MVI  A, 002h
	CALL    L_0141
	MVI  A, 0F0h
	CALL    L_0156
	LXI  B, 02F46h	;+
	CALL    L_2220
	LXI  H, D_4A9D
	CALL    L_0138
	LXI  D, D_21C2
	CALL    L_0189
;	LXI  H, 00BB8h	;+
	CALL	L_WHTM
	CPI     003h
	JZ	L_477D	; выход по УС+С
;L_43BA:	HLT
;	MVI  A, 019h
;	OUT     002h	; 512*256
;	CALL    L_013B
;	CPI     003h
;	JZ      L_43D2
;	CPI     00Dh
;	JZ      L_43D2
;	DCX  H
;	MOV  A, L
;	ORA  H
;	JNZ     L_43BA
L_43D2:	LXI  H, M_0000	; ?
	LXI  B, M_0000	; ?
	LXI  D, M_0000	; ?
	CALL    L_0147
	LDA	D_TPPC	; Тип ПК
	ORA  A
	JNZ	L_M276	; -> ПК-6128ц
	LXI  D, D_2192	;==================================================
	CALL    L_0189
	MVI  A, 000h
	CALL    L_0159
	MVI  A, 000h
	CALL    L_015C
	CALL    L_221A
	MVI  A, 00Fh
	CALL    L_0156
	LXI  D, D_49B6
	CALL    L_0189
	LXI  B, 00000h	;+
	MVI  A, 001h
	CALL    L_013E
	LXI  B, 0FFFFh	;+
	MVI  A, 001h
	CALL    L_0141
	LXI  B, 0BE0Dh	;+
	MVI  A, 002h
	CALL    L_013E
	LXI  B, 00201h	;+
	MVI  A, 003h
	CALL    L_0141
	LXI  H, D_48A5
	CALL    L_0138
	LXI  B, 0A20Dh	;+
	MVI  A, 002h
	CALL    L_013E
	LXI  B, 00201h	;+
	MVI  A, 003h
	CALL    L_0141
	LXI  H, D_48BE
	CALL    L_0138
	LXI  B, 08D2Bh	;+
	MVI  A, 001h
	CALL    L_013E
	LXI  B, 04B2Bh	;+
	MVI  A, 000h
	CALL    L_0141
	LXI  B, 07355h	;+
	MVI  A, 001h
	CALL    L_0141
	LXI  B, 04B7Fh	;+
	MVI  A, 001h
	CALL    L_0141
	LXI  B, 073A9h	;+
	MVI  A, 001h
	CALL    L_0141
	LXI  B, 04BD3h	;+
	MVI  A, 001h
	CALL    L_0141
	LXI  B, 08DD3h	;+
	MVI  A, 000h
	CALL    L_0141
	LXI  B, 07355h	;+
	MVI  A, 001h
	CALL    L_013E
	LXI  B, 08355h	;+
	MVI  A, 000h
	CALL    L_0141
	LXI  B, 08A2Dh	;+
	MVI  A, 001h
	CALL    L_013E
	LXI  B, 08AD1h	;+
	MVI  A, 000h
	CALL    L_0141
	LXI  B, 0802Dh	;+
	MVI  A, 001h
	CALL    L_013E
	LXI  B, 08053h	;+
	MVI  A, 000h
	CALL    L_0141
	LXI  B, 01E00h	;+
	MVI  A, 001h
	CALL    L_013E
	LXI  B, 01EFFh	;+
	MVI  A, 000h
	CALL    L_0141
	LXI  B, 04B1Ah	;+
	MVI  A, 001h
	CALL    L_013E
	LXI  B, 04B2Bh	;+
	MVI  A, 000h
	CALL    L_0141
	LXI  B, 04D1Ch	;+
	MVI  A, 001h
	CALL    L_013E
	LXI  B, 0711Ch	;+
	MVI  A, 000h
	CALL    L_0141
	LXI  B, 0731Ah	;+
	MVI  A, 001h
	CALL    L_013E
	LXI  B, 0732Bh	;+
	MVI  A, 000h
	CALL    L_0141
	LXI  B, 02F23h	;+
	CALL    L_2220
	LXI  H, D_48DE
	CALL    L_0138
	LXI  B, 02B33h	;+
	CALL    L_2220
	LXI  H, D_48D7
	CALL    L_0138
	LXI  B, 02C29h	;+
	CALL    L_2220
	LXI  H, D_48DE
	CALL    L_0138
	MVI  A, 001h
	CALL    L_018C
	LXI  H, D_48E4
	CALL    L_0138
	LXI  B, 04D2Dh	;+
	MVI  A, 001h
	CALL    L_013E
	LXI  B, 07153h	;+
	MVI  A, 002h
	CALL    L_0141
	LXI  B, 01E00h	;+
	MVI  A, 001h
	CALL    L_013E
	LXI  B, 04A2Dh	;+
	MVI  A, 000h
	CALL    L_0141
	LXI  B, 01EFFh	;+
	MVI  A, 001h
	CALL    L_013E
	LXI  B, 04A52h	;+
	MVI  A, 000h
	CALL    L_0141
	LXI  B, 01F64h	;+
	LXI  D, 00101h	;+
	CALL    L_0150
	MVI  A, 00Fh
	CALL    L_0156
	MVI  A, 002h
	CALL    L_018C
	LXI  H, D_4915
	CALL    L_0138
	LXI  D, D_49C6
	CALL    L_0189
	LXI  B, 04D57h	;+
	MVI  A, 001h
	CALL    L_013E
	LXI  B, 0717Dh	;+
	MVI  A, 002h
	CALL    L_0141
	LXI  B, 01E00h	;+
	MVI  A, 001h
	CALL    L_013E
	LXI  B, 04A57h	;+
	MVI  A, 000h
	CALL    L_0141
	LXI  B, 01EFFh	;+
	MVI  A, 001h
	CALL    L_013E
	LXI  B, 04A7Dh	;+
	MVI  A, 000h
	CALL    L_0141
	LXI  B, 01F64h	;+
	LXI  D, 00202h	;+
	CALL    L_0150
	MVI  A, 00Fh
	CALL    L_0156
	MVI  A, 004h
	CALL    L_018C
	LXI  H, D_494A
	CALL    L_0138
	LXI  D, D_49D6
	CALL    L_0189
	LXI  B, 04D81h	;+
	MVI  A, 001h
	CALL    L_013E
	LXI  B, 071A7h	;+
	MVI  A, 002h
	CALL    L_0141
	LXI  B, 01E00h	;+
	MVI  A, 001h
	CALL    L_013E
	LXI  B, 04A81h	;+
	MVI  A, 000h
	CALL    L_0141
	LXI  B, 01EFFh	;+
	MVI  A, 001h
	CALL    L_013E
	LXI  B, 04AA7h	;+
	MVI  A, 000h
	CALL    L_0141
	LXI  B, 01F64h	;+
	LXI  D, 00404h	;+
	CALL    L_0150
	MVI  A, 00Fh
	CALL    L_0156
	MVI  A, 008h
	CALL    L_018C
	LXI  H, D_497F
	CALL    L_0138
	LXI  D, D_49E6
	CALL    L_0189
	LXI  B, 04DABh	;+
	MVI  A, 001h
	CALL    L_013E
	LXI  B, 071D1h	;+
	MVI  A, 002h
	CALL    L_0141
	LXI  B, 01E00h	;+
	MVI  A, 001h
	CALL    L_013E
	LXI  B, 04AABh	;+
	MVI  A, 000h
	CALL    L_0141
	LXI  B, 01EFFh	;+
	MVI  A, 001h
	CALL    L_013E
	LXI  B, 04AD1h	;+
	MVI  A, 000h
	CALL    L_0141
	LXI  B, 01F64h	;+
	LXI  D, 00808h	;+
	CALL    L_0150
	MVI  A, 00Fh
	CALL    L_0156
	MVI  A, 032h
L_463C:	PUSH PSW
	LXI  D, D_49B6
	CALL    L_0189
	POP  PSW
	PUSH PSW
	CALL    L_4888
	LXI  D, D_49C6
	CALL    L_0189
	POP  PSW
	PUSH PSW
	CALL    L_4888
	LXI  D, D_49D6
	CALL    L_0189
	POP  PSW
	PUSH PSW
	CALL    L_4888
	LXI  D, D_49E6
	CALL    L_0189
	POP  PSW
	PUSH PSW
	CALL    L_4888
	LXI  D, D_49D6
	CALL    L_0189
	HLT
	HLT
	HLT
	HLT
	HLT
	HLT
	LXI  D, D_49C6
	CALL    L_0189
	HLT
	HLT
	HLT
	HLT
	HLT
	HLT
	POP  PSW
	SUI     005h
	JNZ     L_463C	;==================================================
L_4687:	MVI  A, 00Fh
	CALL    L_018C
	LXI  B, 00101h	;+
	MVI  A, 000h
	CALL    L_013E
	MVI  A, 000h
	CALL    L_0156
	LXI  B, 02BFEh	;+
	MVI  A, 002h
	CALL    L_0141
	LXI  B, 07401h	;+
	MVI  A, 000h
	CALL    L_013E
	LXI  B, 0FEFEh	;+
	MVI  A, 002h
	CALL    L_0141
	LXI  B, 04B01h	;+
	MVI  A, 000h
	CALL    L_013E
	LXI  B, 0732Ah	;+
	MVI  A, 002h
	CALL    L_0141
	LXI  D, D_4792
	CALL    L_0189
	HLT
	DI
	MVI  A, 019h
	OUT     002h
	MVI  A, 069h
	CALL    L_0156
	LXI  B, 0E31Ah	;+
	MVI  A, 001h
	CALL    L_013E
	LXI  B, 07EE3h	;+
	MVI  A, 002h
	CALL    L_0141
	MVI  A, 00Fh
	CALL    L_0156
	LXI  B, 0E31Ah	;+
	MVI  A, 001h
	CALL    L_0141
	MVI  A, 069h
	CALL    L_0156
	CALL    L_47EC
	LXI  B, 03625h	;+
	CALL    L_2220
	LXI  H, D_47C9
	CALL    L_0138
	MVI  A, 019h
	OUT     002h
	XRA  A
	STA     D_47EA
	MVI  A, 003h
	STA     D_47EB
	CALL    L_47A2
	XRA  A
	STA     D_47EA
	MVI  A, 0F3h
	STA     D_47EB
	CALL    L_47A2
	MVI  A, 0E9h
	STA     D_47EB
	MVI  C, 041h
L_4726:	MVI  A, 000h
	STA     D_47EA
	CALL    L_4815
	MVI  A, 04Fh
	STA     D_47EA
	CALL    L_4815
	LDA     D_47EB
	SUI     00Ah
	STA     D_47EB
	INR  C
	MVI  A, 058h
	CMP  C
	JNZ     L_4726
	MVI  C, 000h
	MVI  A, 0D7h
	STA     D_47EB
L_474C:	MVI  A, 008h
	STA     D_47EA
	CALL    L_47B7
	LDA     D_47EB
	SUI     00Ch
	STA     D_47EB
	XRA  A
	CMP  C
	JNZ     L_474C
	LDA	D_TPPC	; Тип ПК
	ORA  A
	JZ	L_476N	; -> Вектор
	MVI  A, 002h
	CALL    L_0156
	LXI  B, 07438h	;+
	MVI  A, 001h
	CALL    L_013E
	LXI  B, 02BC8h	;+
	MVI  A, 002h
	CALL    L_0141
	LXI  B, 03820h	;+
	LXI  H, 05408h	;+
	CALL    L_226E	;L_20A9
	MVI  A, 007h
	CALL    L_0156
	LXI  B, 03F40h	;+
	LXI  D, 00201h	;+
	LXI  H, D_M44C
	CALL    L_2234	;L_206F
L_476N:	EI
;	LXI  H, 00BB8h	;+
	CALL	L_WHTM
;L_4765:	HLT
;	MVI  A, 019h
;	OUT     002h
;	CALL    L_013B
;	CPI     003h
;	JZ      L_477D
;	CPI     00Dh
;	JZ      L_477D
;	DCX  H
;	MOV  A, L
;	ORA  H
;	JNZ     L_4765
L_477D:	CALL    L_221A
	LXI  D, D_2192
	CALL    L_0189
	MVI  A, 000h
	CALL    L_0159
	MVI  A, 001h
	CALL    L_015C
	XRA  A
	RET
;
L_WHTM:	LXI  H, 00BB8h	;+
L_WH1M:	HLT
	MVI  A, 019h
	OUT     002h	; 512*256
	CALL    L_013B
	CPI     003h
	RZ
	CPI     00Dh
	RZ
	DCX  H
	MOV  A, L
	ORA  H
	JNZ     L_WH1M
	RET
;
D_4792:	.db 000h	; "_" - |        | (offset 4792h)
	.db 0C0h	; "└" - |■■      | (offset 4793h)
	.db 030h	; "0" - |  ■■    | (offset 4794h)
	.db 036h	; "6" - |  ■■ ■■ | (offset 4795h)
	.db 030h	; "0" - |  ■■    | (offset 4796h)
	.db 036h	; "6" - |  ■■ ■■ | (offset 4797h)
	.db 030h	; "0" - |  ■■    | (offset 4798h)
	.db 030h	; "0" - |  ■■    | (offset 4799h)
	.db 0C0h	; "└" - |■■      | (offset 479Ah)
	.db 0C0h	; "└" - |■■      | (offset 479Bh)
	.db 036h	; "6" - |  ■■ ■■ | (offset 479Ch)
	.db 036h	; "6" - |  ■■ ■■ | (offset 479Dh)
	.db 036h	; "6" - |  ■■ ■■ | (offset 479Eh)
	.db 036h	; "6" - |  ■■ ■■ | (offset 479Fh)
	.db 036h	; "6" - |  ■■ ■■ | (offset 47A0h)
	.db 005h	; "_" - |     ■ ■| (offset 47A1h)
;
;---------------------------------------- ПК-6128ц
L_M02:	MOV  A, M
	CMP  E		; = 037h?
	JNZ	L_M03
	MVI  M, 035h
	JMP	L_M00
L_M03:	CPI     021h
	JNZ	L_M00
	MVI  M, 028h
	JMP	L_M00
;
L_M276:	CALL    L_221A	; L_2055
	LXI  H, D_48E4
	LXI  D, 05937h	;
	MVI  C, 0C8h	; счётчик
L_M00:	MOV  A, D	; ищем 059h...
L_M01:	CMP  M
	INX  H
	JZ	L_M02	; > нашли
	DCR  C
	JNZ	L_M01
	MVI  A, 030h	; '0'
	STA     D_M5D6
	XRA  A
	STA     D_M5D5
	OUT     00Eh	; Экран 00
	STA     D_M5D8
	CALL    L_M48E
	MVI  A, 033h
	OUT     00Eh	; Экран 33
	STA     D_M5D8
	MVI  A, 010h
	STA     X_M530+1
	MVI  A, 00Fh	; RRC
	STA     X_M53B
	MVI  A, 02Fh	; CMA
	STA     X_M543
	LXI  H, 002C6h	; ADI 002h
	SHLD    X_M544
	LXI  H, D_49E6	;< D_4899
	SHLD    X_M4A0+1
	CALL    L_M48E
	MVI  A, 022h
	OUT     00Eh	; Экран 22
	STA     D_M5D8
	MVI  A, 080h
	STA     X_M530+1
	MVI  A, 007h	; RLC
	STA     X_M53B
	XRA  A		; NOP
	STA     X_M543
	STA     X_M544
	STA     X_M545
	LXI  H, D_49B6	;< D4869
	SHLD    X_M4A0+1
	CALL    L_M48E
	LXI  H, 00050h	;+
	CALL    L_WHT	;L_3642
	MVI  A, 030h	; '0'
	STA     D_M781
	MVI  A, 014h
	STA     D_M5D7
	XRA  A
	OUT     00Dh	; ОЗУ: Банк 0, Банк 1
L_M2F2:	CALL    L_M604
	MVI  A, 033h
	OUT     00Dh
	CALL    L_M634
	MVI  A, 022h
	OUT     00Dh	; ОЗУ: Банк 0, Банк 3
	CALL    L_M604
	CALL    L_M634
	MVI  A, 033h
	OUT     00Dh	; ОЗУ: Банк 0, Банк 2
	CALL    L_M604
	XRA  A
	OUT     00Dh	; ОЗУ: Банк 0, Банк 1
	CALL    L_M634
	LDA     D_M5D7
	SUI     005h
	STA     D_M5D7
	JNZ     L_M2F2
L_MDN:	MVI  A, 022h
	OUT     00Dh
	OUT     00Eh
	JMP	L_4687	;>> возврат
;
L_M48E:	XRA  A
	CALL    L_0159
	CALL    L_015C
	MVI  A, 00Fh
	CALL    L_0156
	CALL    L_018C
	CALL    L_221A	; L_2055
X_M4A0:	LXI  D, D_49B6	;< D4869
	CALL    L_0189
	LXI  B, 00000h	;+
	MVI  A, 001h
	CALL    L_013E
	LXI  B, 0FFFFh	;+
	MVI  A, 001h
	CALL    L_0141
	LXI  B, 0E812h	;+
	MVI  A, 002h
	CALL    L_013E
	LXI  B, 00201h	;+
	MVI  A, 003h
	CALL    L_0141
	LXI  H, D_M71E
	CALL    L_0138
	LXI  B, 0D810h	;+
	MVI  A, 002h
	CALL    L_013E
	LXI  B, 00101h	;+
	MVI  A, 003h
	CALL    L_0141
	LXI  H, D_48A5	;< D_4736
	CALL    L_0138
	LXI  B, 0CC10h	;+
	MVI  A, 002h
	CALL    L_013E
	LXI  B, 00101h	;+
	MVI  A, 003h
	CALL    L_0141
	LXI  H, D_48BE	;< D_474F
	CALL    L_0138
	LXI  B, 0C010h	;+
	MVI  A, 002h
	CALL    L_013E
	LXI  B, 00101h	;+
	MVI  A, 003h
	CALL    L_0141
	LXI  H, D_M768
	CALL    L_0138
	LXI  B, 00E1Dh	;+
	MVI  A, 002h
	CALL    L_013E
	LXI  B, 00101h	;+
	MVI  A, 003h
	CALL    L_0141
	LDA     D_M781
	INR  A
	LXI  H, D_M781
	MOV  M, A	;STA     D_M781
	CALL    L_0138
	LDA     D_M5D8
	OUT     00Dh
X_M530:	MVI  A, 080h
	PUSH PSW
L_M533:	LDA     D_M5D5
	INR  A
	STA     D_M5D5
	POP  PSW
X_M53B:	RLC
	PUSH PSW
	CALL    L_018C
	LDA     D_M5D5
X_M543:	NOP
X_M544:	NOP
X_M545:	NOP
	ANI     003h
	JNZ     L_M54D
	ADI     004h
L_M54D:	LXI  H, D_49B6	;< D4869
	LXI  D, 00010h	;+
L_M553:	DCR  A
	JZ      L_M55B
	DAD  D
	JMP     L_M553
;
L_M55B:	XCHG
	CALL    L_0189
	LDA     D_M5D5
	ANI     003h
	JNZ     L_M569
	ADI     004h
L_M569:	LXI  D, D_M5D9
L_M56C:	DCR  A
	JZ      L_M575
	INX  D
	INX  D
	JMP     L_M56C
;
L_M575:	LDAX D
	MOV  L, A
	INX  D
	LDAX D
	MOV  H, A
	CALL    L_0138
	LXI  H, 00080h	;+
	LXI  D, 0006Bh	;+
	LDA     D_M5D6
	ADI     002h	; 003h -- приращение радиуса
	STA     D_M5D6
	CALL    L_0144
	LXI  B, 00907h	;+
	MVI  A, 003h
	CALL    L_0141
	LDA     D_M5D5
	MOV  L, A
	MVI  H, 000h
	LXI  D, D_M5D0
	CALL    L_0183
	DCR  A
	JNZ     L_M5AF
	MVI  A, 020h	; ' '
	STAX D
	LXI  B, 0486Bh	;+
	JMP     L_M5B2
;
L_M5AF:	LXI  B, 04852h	;+
L_M5B2:	MVI  A, 002h
	CALL    L_013E
	LXI  H, D_M5D0
	CALL    L_0138
	LDA     D_M5D5
	ANI     003h
	JNZ     L_M5C7
	POP  PSW
	RET
;
L_M5C7:	LXI  H, 00050h	;+
	CALL    L_WHT	;L_3642
	DI
	JMP     L_M533
;
L_M604:	LDA     D_M5D7
	PUSH PSW
	LXI  D, D_49B6	;< D4869
	CALL    L_0189
	CALL    L_M700
	LXI  D, D_49C6	;< D4879
	CALL    L_0189
	POP  PSW
	PUSH PSW
	CALL    L_M700
	LXI  D, D_49D6	;< D4889
	CALL    L_0189
	POP  PSW
	PUSH PSW
	CALL    L_M700
	LXI  D, D_49E6	;< D4899
	CALL    L_0189
	POP  PSW
	PUSH PSW
	CALL    L_M700
	POP  PSW
	RET
;
L_M634:	LDA     D_M5D7
	PUSH PSW
	LXI  D, D_49E6	;< D4899
	CALL    L_0189
	CALL    L_M700
	LXI  D, D_49D6	;< D4889
	CALL    L_0189
	POP  PSW
	PUSH PSW
	CALL    L_M700
	LXI  D, D_49C6	;< D4879
	CALL    L_0189
	POP  PSW
	PUSH PSW
	CALL    L_M700
	LXI  D, D_49B6	;< D4869
	CALL    L_0189
	POP  PSW
	PUSH PSW
	CALL    L_M700
	POP  PSW
	RET
;
L_M700:	PUSH PSW
	CALL    L_013B
	CPI     003h
	JZ      L_M717
	CPI     00Dh
	JZ      L_M715
	POP  PSW
	HLT
	DCR  A
	JNZ     L_M700
	RET
;
L_M715:	POP  PSW
	RET
;
L_M717:	POP  PSW
	POP  PSW
	POP  PSW
	POP  PSW
	JMP     L_MDN
;
D_M5D0:	.db "1 "
	.db 00Dh, 00Ah, 000h
D_M5D5:	.db 000h	; "_" - |        | (offset 45D5h)
D_M5D6:	.db 030h	; "0" - |        | (offset 45D6h)
D_M5D7:	.db 000h	; "_" - |        | (offset 45D7h)
D_M5D8:	.db 000h	; "_" - |        | (offset 45D8h)
D_M5D9:	.dw D_48E4	;04797h
	.dw D_4915	;047C8h
	.dw D_494A	;047FDh
	.dw D_497F	;04832h
;
D_M71E:	.db "12 planow izobraveniq"
	.db 00Dh, 00Ah, 000h
D_M768:	.db "w 1 grafi~eskom |krane"
	.db 00Dh, 00Ah, 000h
D_M781:	.db "0 grafi~eskij |kran"
	.db 00Dh, 00Ah, 000h
D_M44C:	.db "konec testa"
	.db 000h
;^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ ПК-6128ц 
;
L_47A2:	MVI  C, 030h
	MVI  B, 050h
L_47A6:	CALL    L_4815
	INR  C
	MOV  A, C
	CPI     03Ah
	JNZ     L_47B2
	MVI  C, 030h
L_47B2:	DCR  B
	JNZ     L_47A6
	RET
;
L_47B7:	MVI  B, 020h
L_47B9:	CALL    L_4815
	INR  C
	LDA     D_47EA
	INR  A
	STA     D_47EA
	DCR  B
	JNZ     L_47B9
	RET
;
L_47EC:	LXI  H, M_7C00	; ?
	MVI  A, 0C0h
	LXI  B, 0A020h	;+
L_47F4:	MVI  D, 008h
L_47F6:	MOV  M, A
	INX  H
	MOV  M, B
	INX  H
	DCR  D
	JNZ     L_47F6
	INR  A
	INR  B
	DCR  C
	JNZ     L_47F4
	LXI  H, M_7E00	; ?
	MVI  A, 080h
	MVI  C, 000h
L_480B:	MOV  M, A
	INX  H
	MOV  M, A
	INX  H
	RRC
	DCR  C
	JNZ     L_480B
	RET
;
L_4815:	PUSH PSW
	PUSH H
	PUSH D
	PUSH B
	MVI  H, 000h
	MVI  A, 09Fh	; 1001 1111
	ORA  C
	INR  A
	JNZ	L_48R
	MVI  A, 080h	; 1000 0000
	XRA  C
	MOV  C, A	; символы 6х-7х <-> Ex-Fx
L_48R:	MOV  L, C
	PUSH H
	POP  D
	DAD  H
	DAD  H
	DAD  D		; HL = (код символа) * 5
	LXI  D, D_1808	;D_5F00	; >> ссылка на шрифт
	DAD  D
	PUSH H
	CALL    L_4847
	MVI  D, 006h
L_482B:	INX  B
	DCR  D
	JZ      L_483A
	POP  H
	MOV  A, M
	INX  H
	PUSH H
	CALL    L_4860
	JMP     L_482B
;
L_483A:	LDA     D_47EA
	INR  A
	STA     D_47EA
	POP  H
	POP  B
	POP  D
	POP  H
	POP  PSW
	RET
;
L_4847:	LDA     D_47EA
	MOV  L, A
	MVI  H, 000h
	DAD  H
	PUSH H
	POP  B
	DAD  H
	DAD  B
	LXI  B, M_0010	; ?
	DAD  B
	MOV  A, H
	ANI     001h
	MOV  B, A
	MOV  C, L
	LDA     D_47EB
	MOV  E, A
	RET
;
L_4860:	PUSH D
	PUSH B
	LXI  H, M_7C00	; ?
	DAD  B
	MOV  D, M
	INR  H
	INR  H
;	RLC
	MOV  C, A
	MOV  H, M
	XCHG
	MVI  B, 008h
L_486F:	MOV  A, C
L_4870:	RLC
	JC      L_487C
	INR  L
	DCR  B
	JNZ     L_4870
	POP  B
	POP  D
	RET
;
L_487C:	MOV  C, A
	MOV  A, D
	ORA  M
	MOV  M, A
	INR  L
	DCR  B
	JNZ     L_486F
	POP  B
	POP  D
	RET
;
L_4888:	PUSH PSW
	CALL    L_013B
	CPI     003h
	JZ      L_489F
	CPI     00Dh
	JZ      L_489D
	POP  PSW
	HLT
	DCR  A
	JNZ     L_4888
	RET
;
L_489D:	POP  PSW
	RET
;
L_489F:	POP  PSW
	POP  PSW
	POP  PSW
	JMP     L_4687
;
L_4A0E:	MVI  H, 000h
	MVI  A, 0FFh
L_4A12:	HLT
	OUT     003h
	PUSH PSW
	PUSH H
	LXI  H, L_01D6
L_4A1A:	DCX  H
	MOV  A, H
	ORA  L
	JNZ     L_4A1A
	MVI  L, 00Fh
L_4A22:	MVI  H, 063h
	MOV  A, L
	OUT     002h
L_4A27:	DCR  H
	JNZ     L_4A27
	DCR  L
	JNZ     L_4A22
	MVI  A, 000h
	OUT     002h
	POP  H
	POP  PSW
	ADD  L
	INR  H
	JNZ     L_4A12
	RET
;
D_47C9:	.db " 25 strok, 80 simwolow"
	.db " w stroke "
	.db 000h
D_47EA:	.db 005h	; "_" - |     ■ ■| (offset 47EAh)
D_47EB:	.db 064h	; "d" - | ■■  ■  | (offset 47EBh)
;
D_48A5:	.db "~islo adresuemyh to~ek"
	.db 00Dh, 00Ah
	.db 000h
;
D_48BE:	.db "sostawlqet:"
	.db " 1024 * 256"
	.db 00Dh, 00Ah
	.db 000h
;
D_48D7:	.db "1024"
	.db 00Dh, 00Ah
	.db 000h
;
D_48DE:	.db "256"
	.db 00Dh, 00Ah
	.db 000h
;
D_48E4:	.db 01Bh, 059h, 037h, 022h
	.db "/(0,0)"
	.db 01Bh, 059h, 021h, 022h
	.db 05Ch	; \
	.db "(0,255)"
	.db 01Bh, 059h, 021h, 03Eh
	.db "(255,255)/"
	.db 01Bh, 059h, 037h, 040h
	.db "(255,0)"
	.db 05Ch	; \
	.db 000h
;
D_4915:	.db 01Bh, 059h, 037h, 022h
	.db "/(256,0)"
	.db 01Bh, 059h, 021h, 022h
	.db 05Ch	; \
	.db "(256,255)"
	.db 01Bh, 059h, 021h, 03Eh
	.db "(511,255)/"
	.db 01Bh, 059h, 037h, 040h
	.db "(511,0)"
	.db 05Ch	; \
	.db 000h
;
D_494A:	.db 01Bh, 059h, 037h, 022h
	.db "/(512,0)"
	.db 01Bh, 059h, 021h, 022h
	.db 05Ch	; \
	.db "(512,255)"
	.db 01Bh, 059h, 021h, 03Eh
	.db "(767,255)/"
	.db 01Bh, 059h, 037h, 040h
	.db "(767,0)"
	.db 05Ch	; \
	.db 000h
;
D_497F:	.db 01Bh, 059h, 037h, 022h
	.db "/(768,0)"
	.db 01Bh, 059h, 021h, 022h
	.db 05Ch	; \
	.db "(768,255)"
	.db 01Bh, 059h, 021h, 03Dh
	.db "(1023,255)/"
	.db 01Bh, 059h, 037h, 03Fh
	.db "(1023,0)"
	.db 05Ch	; \
	.db 000h
;
D_49B6:	.db 080h	; "А" - |■       | (offset 49B6h)
	.db 03Fh	; "?" - |  ■■■■■■| (offset 49B7h)
	.db 080h	; "А" - |■       | (offset 49B8h)
	.db 03Fh	; "?" - |  ■■■■■■| (offset 49B9h)
	.db 080h	; "А" - |■       | (offset 49BAh)
	.db 03Fh	; "?" - |  ■■■■■■| (offset 49BBh)
	.db 080h	; "А" - |■       | (offset 49BCh)
	.db 03Fh	; "?" - |  ■■■■■■| (offset 49BDh)
	.db 080h	; "А" - |■       | (offset 49BEh)
	.db 03Fh	; "?" - |  ■■■■■■| (offset 49BFh)
	.db 080h	; "А" - |■       | (offset 49C0h)
	.db 03Fh	; "?" - |  ■■■■■■| (offset 49C1h)
	.db 080h	; "А" - |■       | (offset 49C2h)
	.db 03Fh	; "?" - |  ■■■■■■| (offset 49C3h)
	.db 080h	; "А" - |■       | (offset 49C4h)
	.db 03Fh	; "?" - |  ■■■■■■| (offset 49C5h)
D_49C6:	.db 080h	; "А" - |■       | (offset 49C6h)
	.db 080h	; "А" - |■       | (offset 49C7h)
	.db 03Fh	; "?" - |  ■■■■■■| (offset 49C8h)
	.db 03Fh	; "?" - |  ■■■■■■| (offset 49C9h)
	.db 080h	; "А" - |■       | (offset 49CAh)
	.db 080h	; "А" - |■       | (offset 49CBh)
	.db 03Fh	; "?" - |  ■■■■■■| (offset 49CCh)
	.db 03Fh	; "?" - |  ■■■■■■| (offset 49CDh)
	.db 080h	; "А" - |■       | (offset 49CEh)
	.db 080h	; "А" - |■       | (offset 49CFh)
	.db 03Fh	; "?" - |  ■■■■■■| (offset 49D0h)
	.db 03Fh	; "?" - |  ■■■■■■| (offset 49D1h)
	.db 080h	; "А" - |■       | (offset 49D2h)
	.db 080h	; "А" - |■       | (offset 49D3h)
	.db 03Fh	; "?" - |  ■■■■■■| (offset 49D4h)
	.db 03Fh	; "?" - |  ■■■■■■| (offset 49D5h)
D_49D6:	.db 080h	; "А" - |■       | (offset 49D6h)
	.db 080h	; "А" - |■       | (offset 49D7h)
	.db 080h	; "А" - |■       | (offset 49D8h)
	.db 080h	; "А" - |■       | (offset 49D9h)
	.db 03Fh	; "?" - |  ■■■■■■| (offset 49DAh)
	.db 03Fh	; "?" - |  ■■■■■■| (offset 49DBh)
	.db 03Fh	; "?" - |  ■■■■■■| (offset 49DCh)
	.db 03Fh	; "?" - |  ■■■■■■| (offset 49DDh)
	.db 080h	; "А" - |■       | (offset 49DEh)
	.db 080h	; "А" - |■       | (offset 49DFh)
	.db 080h	; "А" - |■       | (offset 49E0h)
	.db 080h	; "А" - |■       | (offset 49E1h)
	.db 03Fh	; "?" - |  ■■■■■■| (offset 49E2h)
	.db 03Fh	; "?" - |  ■■■■■■| (offset 49E3h)
	.db 03Fh	; "?" - |  ■■■■■■| (offset 49E4h)
	.db 03Fh	; "?" - |  ■■■■■■| (offset 49E5h)
D_49E6:	.db 080h	; "А" - |■       | (offset 49E6h)
	.db 080h	; "А" - |■       | (offset 49E7h)
	.db 080h	; "А" - |■       | (offset 49E8h)
	.db 080h	; "А" - |■       | (offset 49E9h)
	.db 080h	; "А" - |■       | (offset 49EAh)
	.db 080h	; "А" - |■       | (offset 49EBh)
	.db 080h	; "А" - |■       | (offset 49ECh)
	.db 080h	; "А" - |■       | (offset 49EDh)
	.db 03Fh	; "?" - |  ■■■■■■| (offset 49EEh)
	.db 03Fh	; "?" - |  ■■■■■■| (offset 49EFh)
	.db 03Fh	; "?" - |  ■■■■■■| (offset 49F0h)
	.db 03Fh	; "?" - |  ■■■■■■| (offset 49F1h)
	.db 03Fh	; "?" - |  ■■■■■■| (offset 49F2h)
	.db 03Fh	; "?" - |  ■■■■■■| (offset 49F3h)
	.db 03Fh	; "?" - |  ■■■■■■| (offset 49F4h)
	.db 03Fh	; "?" - |  ■■■■■■| (offset 49F5h)
;
D_4A3B:	.db 000h	; "_" - |        | (offset 4A3Bh)
;
D_4A3C:	.db "grafika 256*256 to~ek"
	.db 000h
;
D_4A52:	.db "grafika 512*256 to~ek"
	.db 000h
;
D_4A68:	.db "256"
	.db 008h, 008h, 008h, 01Ah
	.db "128"
	.db 008h, 008h, 008h, 01Ah
	.db " 64"
	.db 008h, 008h, 008h, 01Ah
	.db " 32"
	.db 008h, 008h, 008h, 01Ah
	.db " 16"
	.db 008h, 008h, 008h, 01Ah
	.db "  8"
	.db 008h, 008h, 008h, 01Ah
	.db "  4"
	.db 008h, 008h, 008h, 01Ah
	.db "  2"
	.db 000h
;
D_4A9D:	.db "512"
	.db 000h
;
D_4AA1:	.db "16 cwetow"
	.db 000h
;
D_4AAB:	.db "4 cweta"
	.db 000h
