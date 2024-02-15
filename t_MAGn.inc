M_7800:	.equ    07800h
M_7801:	.equ    07801h
;
L_334D:	LXI  H, D_365B	; текст 1
	CALL    L_0138	; >>
	CALL    L_3637
	CPI     00Dh
	JNZ     L_335E
	CALL    L_33A9
L_335E:	LXI  H, D_37F0	; текст 2
	CALL    L_0138	; >>
	CALL    L_3637
	CPI     00Dh
	JNZ     L_3383
	LXI  H, D_3864	; текст 3
	CALL    L_0138	; >>
	CALL    L_3403
	PUSH PSW
	CALL    L_34E0
	CALL    L_ENTS	;L_362B
	CPI     00Dh
	JZ      L_3385
	POP  PSW
	RET
;
L_3383:	XRA  A
	RET
;
L_3385:	POP  PSW
	LXI  B, 00101h
	MVI  A, 000h
	CALL    L_013E	; >>
	MVI  A, 000h
	CALL    L_0156	; >>
	LXI  B, 0C4FEh
	MVI  A, 002h
	CALL    L_0141	; >>
	MVI  A, 017h
	CALL    L_0156	; >>
	LXI  B, 02620h
	CALL    L_2220	; >>
	JMP     L_334D
;
L_33A9:	DI
	MVI  B, 05Ah
	MVI  L, 000h
L_33AE:	MVI  A, 078h
	CALL    L_018F	; >>
	LXI  D, 00050h	; счётчик
L_33B6:	XRA  A
	CALL    L_012C	; >>
	DCR  E
	JNZ     L_33B6
	MVI  A, 0E6h
	CALL    L_012C	; >>
	MOV  A, L
	CALL    L_012C	; >>
	MOV  A, B
	CALL    L_012C	; >>
	MOV  A, B
	CALL    L_018F	; >>
	MVI  E, 00Ah
L_33D1:	XRA  A
	CALL    L_012C	; >>
	DCR  E
	JNZ     L_33D1
	MVI  A, 0E6h
	CALL    L_012C	; >>
	MOV  A, B
	CALL    L_012C	; >>
L_33E2:	MOV  A, D
	CALL    L_012C	; >>
	INR  D
	JNZ     L_33E2
	MOV  A, B
	ADI     00Fh
	MOV  B, A
	INR  L
	JNC     L_33AE
	EI
	RET
;
L_33F4:	PUSH PSW
	IN      001h
	ANI     040h
	JZ      L_3400
	POP  PSW
	JMP     L_0126	; >>
;
L_3400:	POP  PSW
	XRA  A
	RET
;
L_3403:	XRA  A
	STA     D_391B
	MVI  B, 05Ah
	CALL    L_012C	; >>
	EI
	HLT
L_340E:	MVI  A, 078h
	CALL    L_018F	; >>
L_3413:	DI
	CALL    L_346C
	CPI     000h
	JZ      L_341F
	JMP     L_3413
;
L_341F:	IN      001h
	ANI     040h
	JZ      L_3429
	CALL    L_35EF
L_3429:	MVI  A, 0FFh
	CALL    L_33F4
	MOV  L, A
	MVI  A, 008h
	CALL    L_33F4
	CALL    L_018F	; >>
	MVI  A, 0FFh
	CALL    L_33F4
	MVI  C, 000h
L_343E:	MVI  A, 008h
	CALL    L_33F4
	CMP  C
	JNZ     L_3464
	INR  C
	JNZ     L_343E
	PUSH H
	MVI  H, 000h
	DAD  H
	DAD  H
	DAD  H
	LXI  D, D_3893	; строки
	DAD  D
	CALL    L_0138	; >>
	POP  H
L_3459:	MOV  A, B
	ADI     00Fh
	MOV  B, A
	JNC     L_340E
	LDA     D_391B
	RET
;
L_3464:	MVI  A, 001h
	STA     D_391B
	JMP     L_3459
;
L_346C:	MVI  D, 096h
L_346E:	MVI  E, 028h
L_3470:	MVI  A, 008h
	CALL    L_33F4
	DCR  D
	JZ      L_348C
	DCR  E
	JZ      L_348A
	CPI     000h
	JZ      L_3470
	CPI     0FFh
	JZ      L_3470
	JMP     L_346E
;
L_348A:	XRA  A
	RET
;
L_348C:	MVI  A, 0FFh
	RET
;
D_348F:	.db "  ~astota   powtoreniq "
	.db " dlitelxnosti  "
	.db 00Ah, 00Dh, 018h, 018h
	.db " polovit.impulxsa "
	.db 018h, 018h
	.db " otricat.impulxsa "
	.db 000h
;
L_34E0:	LXI  B, 03205h
	LXI  H, 0C201h
	CALL    L_226E	; >>
	MVI  A, 068h
	CALL    L_0156	; >>
	LXI  H, D_348F	; текст
	LXI  B, 02622h
	CALL    L_2220	; >>
	CALL    L_0138	; >>
	XRA  A
	MOV  H, A
	MOV  L, A
	MOV  B, A
	LXI  D, M_7800	; ?
L_3501:	XCHG
	MOV  C, M
	XCHG
	DAD  B
	INX  D
	DCR  A
	JNZ     L_3501
	MOV  A, H
	ADD  A
	STA     D_25FE	; >>
	LXI  H, M_7800	; ?
	LXI  D, 03C12h
	CALL    L_3527
	LXI  H, M_7801	; ?
	LXI  D, 03C8Ah
	CALL    L_3527
	MVI  A, 017h
	CALL    L_0156	; >>
	RET
;
L_3527:	PUSH D
	PUSH D
	POP  B
	MOV  A, C
	ADI     02Dh
	MOV  C, A
	DCR  B
	DCR  B
	DCR  B
	DCR  B
	DCR  B
	MVI  A, 006h
	CALL    L_0156	; >>
	MVI  A, 001h
	CALL    L_013E	; >>
	MOV  A, B
	ADI     073h
	MOV  B, A
	MVI  A, 000h
	CALL    L_0141	; >>
	POP  B
	PUSH B
	DCR  B
	DCR  C
	PUSH B
	MVI  A, 00Fh
	CALL    L_0156	; >>
	MOV  A, B
	ADI     069h
	MOV  B, A
	MVI  A, 001h
	CALL    L_013E	; >>
	POP  B
	MVI  A, 001h
	CALL    L_0141	; >>
	MOV  A, C
	ADI     064h
	MOV  C, A
	MVI  A, 001h
	CALL    L_0141	; >>
	MVI  A, 00Bh
	CALL    L_0156	; >>
	POP  D
	PUSH D
	MOV  B, D
	INR  B
	LDA     D_25FE	; >>
	SUI     020h
	ADD  E
	MOV  C, A
	MVI  A, 001h
	CALL    L_013E	; >>
	MOV  A, B
	ADI     062h
	MOV  B, A
	MOV  A, C
	ADI     00Fh
	MOV  C, A
	MVI  A, 002h
	CALL    L_0141	; >>
	MOV  A, C
	SUI     008h
	MOV  C, A
	INR  B
	INR  B
	MVI  A, 000h
	CALL    L_0156	; >>
	MVI  A, 001h
	CALL    L_013E	; >>
	MOV  B, D
	DCR  B
	DCR  B
	MVI  A, 000h
	CALL    L_0141	; >>
	MVI  A, 007h
	CALL    L_0156	; >>
	PUSH H
	MVI  B, 080h
L_35AA:	MOV  D, B
	POP  H
	PUSH H
	MVI  C, 000h
	MOV  A, M
L_35B0:	CMP  M
	JNZ     L_35B5
	INR  C
L_35B5:	INX  H
	INX  H
	DCR  D
	JNZ     L_35B0
	POP  H
	INX  H
	INX  H
	POP  D
	PUSH D
	PUSH H
	PUSH B
	PUSH D
	ADD  A
	CPI     07Dh
	JC      L_35CB
	MVI  A, 07Ch
L_35CB:	CPI     019h
	JNC     L_35D2
	MVI  A, 01Ah
L_35D2:	ADD  E
	PUSH PSW
	MOV  A, D
	ADD  C
	MOV  B, A
	POP  PSW
	SUI     019h
	MOV  C, A
	MVI  A, 001h
	CALL    L_013E	; >>
	MOV  B, D
	MVI  A, 001h
	CALL    L_0141	; >>
	POP  D
	POP  B
	DCR  B
	JNZ     L_35AA
	POP  H
	POP  D
	RET
;
L_35EF:	PUSH PSW
	PUSH H
	PUSH D
	PUSH B
	LXI  H, M_7800	; ?
	MVI  E, 080h
L_35F8:	CALL    L_3608
	MOV  M, B
	INX  H
	MOV  M, C
	INX  H
	DCR  E
	JNZ     L_35F8
	POP  B
	POP  D
	POP  H
	POP  PSW
	RET
;
L_3608:	PUSH D
	MVI  D, 010h
L_360B:	IN      001h
	ANA  D
	JNZ     L_360B
L_3611:	IN      001h
	ANA  D
	JZ      L_3611
	MVI  B, 000h
L_3619:	INR  B
	IN      001h
	ANA  D
	JNZ     L_3619
	MVI  C, 000h
L_3622:	INR  C
	IN      001h
	ANA  D
	JZ      L_3622
	POP  D
	RET
;
L_3637:	LXI  H, D_37E1	; текст
	CALL    L_0138	; >>
	LXI  H, 01770h
	JMP	L_WHT
;L_3640:	SHLD    D_25FE	; >>
;L_3643:	EI
;	HLT
;	CALL    L_013B	; >>
;	CPI     00Dh
;	RZ
;	CPI     003h
;	RZ
;	LHLD    D_25FE	; >>
;	DCX  H
;	MOV  A, H
;	ORA  L
;	RZ
;	SHLD    D_25FE	; >>
;	JMP     L_3643
;
D_365B:	.db "    posredstwom   zapisi"
	.db "   informacii  s "
	.db 00Ah, 00Dh
	.db " razli~noj skorostx` zapisi"
	.db " (bit/sek.) : "
	.db 00Ah, 00Dh
	.db "   900, 1050, 1200, 1350,  "
	.db "1500,  1650,  "
	.db 00Ah, 00Dh
	.db "  1800, 1950, 2100, 2250,  "
	.db "2400,  2550   "
	.db 00Ah, 00Dh
	.db " i posledu`}ego kontrolxnogo"
	.db "  s~itywaniq "
	.db 00Ah, 00Dh
	.db " opredelqetsq  wozmovnostx"
	.db " ispolxzowaniq "
	.db 00Ah, 00Dh
	.db " magnitnoj lenty i magnitofona"
	.db " dlq nadev-"
	.db 00Ah, 00Dh
	.db " nogo hraneniq zapisannoj"
	.db " informacii.    "
	.db 00Ah, 00Dh, 00Ah, 00Dh
	.db " perewedite magnitofon w" - | ■■■ ■■■| (offset 37CCh)
	.db " revim -"
	.db 022h	; "
	.db "zapisx"
	.db 022h	; "
	.db "."
	.db 00Ah, 00Dh
	.db 000h
;
D_37E1:	.db 018h
	.db " gotowo? <wk>"
	.db 000h
;
D_37F0:	.db 00Ah, 00Dh
	.db "  ustanowite lentu na na~alo"
	.db " zapisannoj  "
	.db 00Ah, 00Dh
	.db "  informacii i perewedite "
	.db " magnitofon w  "
	.db 00Ah, 00Dh
	.db "  revim -"
	.db 022h	; "
	.db "wosproizwedenie"
	.db 022h	; "
	.db "."
	.db 000h
;
D_3864:	.db 00Ah, 00Dh, 00Ah, 00Dh
	.db " pro~itano bez o{ibok pri"
	.db " skorosti obmena:"
	.db 000h
;
D_3893:	.db "  900  "
	.db 000h
	.db " 1050  "
	.db 000h
	.db " 1200  "
	.db 000h
	.db " 1350  "
	.db 000h
	.db " 1500  "
	.db 000h
	.db " 1650  "
	.db 000h
	.db " 1800  "
	.db 000h
	.db " 1950  "
	.db 000h
	.db " 2100  "
	.db 000h
	.db " 2250  "
	.db 000h
	.db " 2400  "
	.db 000h
	.db " 2550  "
	.db 000h
;
D_391B:	.db 000h
