M_8535:	.equ    08535h
M_C0FF:	.equ    0C0FFh
;
L_596A:	LXI  B, 00101h	;+
	MVI  A, 000h
	CALL    L_013E
	MVI  A, 000h
	CALL    L_0156
	LXI  B, 0C4FEh	;+
	MVI  A, 002h
	CALL    L_0141	; стирание области экрана
	MVI  A, 070h
	CALL    L_0156
	LXI  B, 01405h	;+
	LXI  H, 03006h	;+
	CALL    L_226E	; нижний прямоугольник
	MVI  A, 078h
	CALL    L_0156
	DI		;----------
	MVI  A, 001h
	STA     D_5E05
	LXI  H, D_5E00
	MVI  C, 004h
L_599D:	MVI  M, 000h
	INX  H
	DCR  C
	JNZ     L_599D
	LXI  B, 03522h	;+
	CALL    L_2220
	LXI  H, M_C0FF	; ?
	CALL    L_5B92	; Тест 1 ???
	CPI     001h
	JNZ     L_59BE
	LXI  H, D_5A81	; "ЭД не подключён"
	CALL    L_0138
	JMP     L_5A68	;>>>
;
L_59BE:	CPI     002h
	JNZ     L_59CC
	LXI  H, D_5AA8	; "Не работает переключение ОЗУ диска"
	CALL    L_0138
	JMP     L_5A68	;>>>
;
L_59CC:	LXI  H, M_C0FF	; ?
	CALL    L_5BC9	; Тест 2 ???
	CPI     001h
	JNZ     L_59E0
	LXI  H, D_5ACF	; "Нет подключения стека диска"
	CALL    L_0138
	JMP     L_5A68	;>>>
;
L_59E0:	CPI     002h
	JNZ     L_59EE
	LXI  H, D_5AF6	; "Не работает переключение стека диска"
	CALL    L_0138
	JMP     L_5A68	;>>>
;
L_59EE:	CALL    L_5D3C	; рисовать чипы
	LXI  B, 02620h	;+
	CALL    L_2220
	LXI  H, D_5943	; текст шапки 1
	CALL    L_0138
	LDA     D_PORT
	CALL	L_0135
	LXI  H, D_5944	; текст шапки 2
	CALL    L_0138
	LXI  B, 03522h	;+
	CALL    L_2220
	MVI  A, 005h
	STA     D_5A61
	MVI  A, 003h
	STA     D_5E04
L_5A0D:	CALL    L_5C32
	CALL    L_5D88	; чип >>
	PUSH PSW
	PUSH B
	PUSH D
	MVI  A, 001h
	CALL    L_0156	; цвет
	LDA     D_5A61
	MOV  C, A
	INR  C
	ADI     03Dh
	STA     D_5A61
	MVI  B, 015h
	MVI  A, 001h
	CALL    L_013E	; plot
	LDA     D_5A61
	MOV  C, A
	MVI  B, 02Fh
	MVI  A, 002h
	CALL    L_0141	; line <- закраска шкалы
	MVI  A, 078h
	CALL    L_0156	; цвет
	POP  D
	POP  B
	POP  PSW
	LXI  H, D_5E04
	DCR  M
	MOV  A, M
	JP      L_5A0D	; цикл >>>
	LXI  H, D_5E00
	MOV  A, M
	INX  H
	ORA  M
	INX  H
	ORA  M
	INX  H
	ORA  M
	JNZ     L_5A62
	LXI  H, D_5B44	; "Ёмкость диска..."
	CALL    L_0138
	XRA  A
	STA     D_5E05
	JMP     L_5A68
;
D_5A61:	.db 005h	; "_" - |     ■ ■| (offset 5A61h)
;
L_5A62:	LXI  H, D_5B1D	; "Неисправна память..."
	CALL    L_0138
L_5A68:	LXI  B, 03622h	;+
	CALL    L_2220
	LXI  H, D_5B6B	; "тест ..."
	CALL    L_0138
	LDA     D_PORT
	CALL	L_0135
	LXI  H, D_5B6C	; "... завершен"
	CALL    L_0138
	LXI  H, D_FINS	; текст
	CALL    L_0138	; >>
	LXI  H, 03A98h
	SHLD    D_25FE	; счётчик ожидания
L_WHT2:	EI
	HLT
	CALL    L_013B	; >>
	CPI     00Dh	; <ВК>
	JZ      L_596A	; повтор
	CPI     020h	; " "
	JZ      L_CKD	; др.порт
	CPI     003h
	JZ	L_KDN	; далее
	LHLD    D_25FE	;
	DCX  H
	MOV  A, H
	ORA  L
	RZ
	SHLD    D_25FE	;
	JMP     L_WHT2
;
L_KDN:	LDA     D_5E05
	RET
;
L_CKD:	LXI  B, 03821h	;+
	CALL    L_2220
	LXI  H, D_ADRP
	CALL    L_0138
	CALL    L_RHEX
	CPI     010h
	JC	L_CKD	; порт <10h
	LXI  B, D_PORT
	LXI  H, D_XP
L_CPRT:	STAX B
	MOV  C, M
	INX  H
	MOV  B, M
	INX  H
	DCR  B
	INR  B
	JNZ	L_CPRT
	JMP	L_596A
;
D_ADRP:	.db " {estnadcateri~nyj"
	.db " nomer porta -        "
	.db 008h, 008h, 008h, 008h, 008h
	.db 008h, 008h
	.db 000h
;
D_5943:	.db 018h
	.db " port "
	.db 000h
D_5944:	.db ": raspolovenie bis"
	.db " ozu kr565ru5 "
	.db 000h
;
D_5A81:	.db " "
	.db 022h	; "
	.db "|lektronnyj disk"
	.db 022h	; "
	.db " ne podkl`~en  !!! "
	.db 000h
;
D_5AA8:	.db " ne rabotaet perekl`~enie "
	.db 022h	; "
	.db "ozu"
	.db 022h	; "
	.db " diska "
	.db 000h
;
D_5ACF:	.db "  net podkl`~eniq  "
	.db 022h	; "
	.db "steka"
	.db 022h	; "
	.db " |l. diska  "
	.db 000h
;
D_5AF6:	.db "ne rabotaet perekl`~enie "
	.db 022h	; "
	.db "steka"
	.db 022h	; "
	.db " diska"
	.db 000h
;
D_5B1D:	.db " neisprawna pamqtx"
	.db " |lektronnogo diska "
	.db 000h
;
D_5B44:	.db " emkostx |l.diska"
	.db " sostawlqet-256kbajt "
	.db 000h
;
D_5B6B:	.db " test "
	.db 022h	; "
	.db "|l.diska"
	.db 022h	; "
	.db " (port "
	.db 000h
D_5B6C:	.db ")  zawer{en. "
	.db 000h
;
D_FINS:	.db 01Bh, 059h, 038h, 021h
	.db "<probel>-dr.port,"
	.db "<wk>-powt.,"
	.db "<us+C>-dalee"
	.db 000h
;
L_5B92:	MVI  B, 003h
	MOV  C, M
	PUSH B
L_5B96:	MVI  A, 020h
	ORA  B
X_O1:	OUT     010h
	INR  C
	MOV  M, C
	DCR  B
	JP      L_5B96
	POP  B
	XRA  A
X_O2:	OUT     010h
	MOV  A, M
	CMP  C
	JZ      L_5BAE
	MOV  M, C
	MVI  A, 001h
	RET
;
L_5BAE:	MVI  B, 003h
L_5BB0:	MVI  A, 020h
	ORA  B
X_O3:	OUT     010h
	INR  C
	MOV  A, C
	CMP  M
	JZ      L_5BC1
	XRA  A
X_O4:	OUT     010h
	MVI  A, 002h
	RET
;
L_5BC1:	DCR  B
	JP      L_5BB0
	XRA  A
X_O5:	OUT     010h
	RET
;
L_5BC9:	MVI  B, 00Ch
	MOV  C, M
	CALL    L_5D2E	; сохранение указателя стека
	SPHL
L_5BD0:	MVI  A, 010h
	ORA  B
X_O6:	OUT     010h
	INR  C
	POP  D
	PUSH B
	MOV  A, B
	SUI     004h
	MOV  B, A
	JP      L_5BD0
	MOV  A, C
	SUI     004h
	MOV  C, A
	XRA  A
X_O7:	OUT     010h
	SHLD    D_5DFC
	LHLD    D_5DFE
	SPHL
	LHLD    D_5DFC
	MOV  A, M
	CMP  C
	JZ      L_5BF9
	MOV  M, C
	MVI  A, 001h
	RET
;
L_5BF9:	MVI  B, 00Ch
	CALL    L_5D2E	; сохранение указателя стека
	SPHL
L_5BFF:	MVI  A, 010h
	ORA  B
X_O8:	OUT     010h
	POP  D
	DCX  SP
	DCX  SP
	INR  C
	MOV  A, C
	CMP  E
	JZ      L_5C1D
	XRA  A
X_O9:	OUT     010h
	SHLD    D_5DFC
	LHLD    D_5DFE
	SPHL
	LHLD    D_5DFC
	MVI  A, 002h
	RET
;
L_5C1D:	MOV  A, B
	SUI     004h
	MOV  B, A
	JP      L_5BFF
	XRA  A
X_OA:	OUT     010h
	SHLD    D_5DFC
	LHLD    D_5DFE
	SPHL
	LHLD    D_5DFC
	RET
;
L_5C32:	RAL
	RAL
	ANI     00Ch
	MOV  B, A
	CALL    L_5D2E	; сохранение указателя стека
	MVI  A, 010h
	ORA  B
X_OB:	OUT     010h
	LXI  B, 00201h	;+
	LXI  SP,M_0000	; ?
L_5C45:	DCR  B
	DCR  C
	MVI  H, 040h
L_5C49:	DCR  B
	DCR  C
	DCR  B
	DCR  C
	PUSH B
	DCR  B
	DCR  C
	DCR  B
	DCR  C
	PUSH B
	DCR  H
	JNZ     L_5C49
	MOV  A, C
	CPI     001h
	JNZ     L_5C45
L_5C5D:	MVI  H, 040h
L_5C5F:	POP  D
	MOV  A, D
	XRA  B
	MOV  D, A
	MOV  A, E
	XRA  C
	ORA  D
	JZ      L_5C7E
	MOV  D, A
	SHLD    D_5DFC
	LXI  H, D_5E00-1
	LDA     D_5E04
L_5C73:	INX  H
	DCR  A
	JP      L_5C73
	MOV  A, M
	ORA  D
	MOV  M, A
	LHLD    D_5DFC
L_5C7E:	INR  B
	INR  C
	INR  B
	INR  C
	POP  D
	MOV  A, D
	XRA  B
	MOV  D, A
	MOV  A, E
	XRA  C
	ORA  D
	JZ      L_5CA1
	MOV  D, A
	SHLD    D_5DFC
	LXI  H, D_5E00-1
	LDA     D_5E04
L_5C96:	INX  H
	DCR  A
	JP      L_5C96
	MOV  A, M
	ORA  D
	MOV  M, A
	LHLD    D_5DFC
L_5CA1:	INR  B
	INR  C
	INR  B
	INR  C
	DCR  H
	JNZ     L_5C5F
	MOV  A, B
	INR  B
	INR  C
	CPI     001h
	JNZ     L_5C5D
	LXI  B, 0FDFEh	;+
L_5CB4:	INR  B
	INR  C
	MVI  H, 040h
L_5CB8:	INR  B
	INR  C
	INR  B
	INR  C
	PUSH B
	INR  B
	INR  C
	INR  B
	INR  C
	PUSH B
	DCR  H
	JNZ     L_5CB8
	MOV  A, C
	CPI     0FEh
	JNZ     L_5CB4
L_5CCC:	MVI  H, 040h
L_5CCE:	POP  D
	MOV  A, D
	XRA  B
	MOV  D, A
	MOV  A, E
	XRA  C
	ORA  D
	JZ      L_5CED
	MOV  D, A
	SHLD    D_5DFC
	LXI  H, D_5E00-1
	LDA     D_5E04
L_5CE2:	INX  H
	DCR  A
	JP      L_5CE2
	MOV  A, M
	ORA  D
	MOV  M, A
	LHLD    D_5DFC
L_5CED:	DCR  B
	DCR  C
	DCR  B
	DCR  C
	POP  D
	MOV  A, D
	XRA  B
	MOV  D, A
	MOV  A, E
	XRA  C
	ORA  D
	JZ      L_5D10
	MOV  D, A
	SHLD    D_5DFC
	LXI  H, D_5E00-1
	LDA     D_5E04
L_5D05:	INX  H
	DCR  A
	JP      L_5D05
	MOV  A, M
	ORA  D
	MOV  M, A
	LHLD    D_5DFC
L_5D10:	DCR  B
	DCR  C
	DCR  B
	DCR  C
	DCR  H
	JNZ     L_5CCE
	MOV  A, B
	DCR  B
	DCR  C
	CPI     0FEh
	JNZ     L_5CCC
	XRA  A
X_OC:	OUT     010h
	SHLD    D_5DFC
	LHLD    D_5DFE
	SPHL
	LHLD    D_5DFC
	RET
;
L_5D2E:	SHLD    D_5DFC	; сохранение указателя стека
	LXI  H, M_0002	; ?
	DAD  SP
	SHLD    D_5DFE
	LHLD    D_5DFC
	RET
;
L_5D3C:	MVI  C, 004h
	MVI  B, 020h
	LXI  D, D_CHIP
	LXI  H, M_8535	; ?
L_5D46:	CALL    L_5D5E
	DCR  B
	RZ
	MOV  A, B
	ANI     003h
	JNZ     L_5D57
	MVI  L, 013h
	MOV  A, H
	ADI     003h
	MOV  H, A
L_5D57:	MOV  A, L
	ADI     022h
	MOV  L, A
	JMP     L_5D46
;
L_5D5E:	PUSH B
	PUSH H
	MVI  B, 004h
L_5D62:	MOV  A, C
	RRC
	MOV  C, A
	CC      L_5D73
	MOV  A, H
	ADI     020h
	MOV  H, A
	DCR  B
	JNZ     L_5D62
	POP  H
	POP  B
	RET
;
L_5D73:	PUSH H
	PUSH D
	PUSH B
	MVI  C, 019h
L_5D78:	LDAX D
	MOV  M, A
	INX  H
	INX  D
	DCR  C
	JNZ     L_5D78
	POP  B
	POP  D
	POP  H
	RET
;
D_5D84:	.db 003h
	.db 001h
	.db 002h
	.db 000h
;
L_5D88:	PUSH B
	PUSH H
	LDA     D_5E04
	MOV  C, A
	MVI  B, 000h
	LXI  H, D_5E00
	DAD  B
	SHLD    X_5DAF+1
	LXI  H, D_5D84
	DAD  B
	MOV  C, M
	LXI  H, M_8535	; ?
L_5D9F:	DCR  C
	JM      L_5DAA	; >>
	MOV  A, L
	ADI     022h
	MOV  L, A
	JMP     L_5D9F
;
L_5DAA:	LXI  D, D_BRAK
	MVI  B, 008h
X_5DAF:	LDA     M_0000	; ?
L_5DB2:	RRC
	MOV  C, A
	PUSH B
	MVI  C, 00Fh
	CC      L_5D5E
	POP  B
	MOV  A, H
	ADI     003h
	MOV  H, A
	DCR  B
	JZ      L_5DC7
	MOV  A, C
	JMP     L_5DB2
;
L_5DC7:	POP  H
	POP  B
	RET
;
D_5DFC:	.dw 00000h	; место для временного сохранения HL
D_5DFE:	.dw 00000h	; указатель стека+2
D_5E00:	.db 000h	; ошибки КД, стока чипов №1
	.db 000h	; ошибки КД, стока чипов №3
	.db 000h	; ошибки КД, стока чипов №2
	.db 000h	; ошибки КД, стока чипов №4
D_5E04:	.db 000h	; "_" - |        | (offset 5E04h)
D_5E05:	.db 000h
D_PORT:	.db 010h	; порт КД
D_XP:	.dw X_O1+1	; список адресов команд OUT для КД
	.dw X_O2+1
	.dw X_O3+1
	.dw X_O4+1
	.dw X_O5+1
	.dw X_O6+1
	.dw X_O7+1
	.dw X_O8+1
	.dw X_O9+1
	.dw X_OA+1
	.dw X_OB+1
	.dw X_OC+1
	.dw 00000h
;
