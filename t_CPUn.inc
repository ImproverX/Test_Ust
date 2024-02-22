L_29A5: CALL	L_CPUD
	LXI  H, D_CPU
	MVI  C, 00Bh	; счётчик
L_TCPU:	LDAX D
	MOV  M, A
	INX  D
	INX  H
	DCR  C
	JNZ	L_TCPU	; заносим тип процессора в строку
	LXI  D, D_2A6A
	CALL    L_0189	; >> копируем палитру
	LXI  B, 02620h
	CALL    L_2220	; >>
	LXI  B, 01403h	; 1903
	LXI  H, 0BE02h	;
	CALL    L_226E	; >> закрашенный прямоугольник
	MVI  A, 030h
	CALL    L_0156	; >>
	LXI  H, 005DCh
	CALL    L_4BB8	; >> вывод 1000Гц
	HLT
	LHLD    M_0039	;
	SHLD    D_2C0E
	DI
	LXI  H, L_29FF
	SHLD    M_0039	;
	LXI  H, M_8000	;
	LXI  D, 00CCBh	; счётчик
L_29D9:	MVI  M, 04Fh	; MOV C,A
	INX  H
	MVI  M, 007h	; RLC
	INX  H
	MVI  M, 081h	; ADD C
	INX  H
	MVI  M, 02Fh	; CMA
	INX  H
	MVI  M, 0EBh	; XCHG
	INX  H
	DCX  D
	MOV  A, D
	ORA  E
	JNZ     L_29D9
	MVI  A, 0C9h	; RET
	STA     M_0038	;
	MVI  A, 0C3h	; JMP
	LXI  H, M_0038	;
	EI
	HLT
	MOV  M, A
	EI
	JMP     M_8000	; тест 1
;
L_29FF:	POP  H
	MOV  A, H
	SUI     080h
	MOV  H, A
	LXI  D, 00014h	; делитель
	CALL    L_017A	; >> HL / DE
	LXI  D, D_2B3B	; результат 1
	CALL    L_0183	; >>
	LXI  H, L_2A36
	SHLD    M_0039	;
	LXI  H, M_8000	;
	LXI  D, 03FFFh	;+
L_2A1C:	MVI  M, 081h	; ADD C
	INX  H
	DCX  D
	MOV  A, D
	ORA  E
	JNZ     L_2A1C
	MVI  A, 0C9h	; RET
	STA     M_0038	;
	MVI  A, 0C3h	; JMP
	LXI  H, M_0038	;
	EI
	HLT
	MOV  M, A
	EI
	JMP     M_8000	; тест 2
;
L_2A36:	POP  H
	MOV  A, H
	SUI     080h
;	RAR
	MOV  H, A
;	MOV  A, L
;	RAR
;	MOV  L, A
	LXI  D, 00014h	; делитель
	CALL    L_017A	; >> HL / DE
	LXI  D, D_2B7B	; результат 2
	CALL    L_0183	; >>
	LHLD    D_2C0E
	SHLD    M_0039	;
	EI
	LXI  H, D_2A7A	; вывод текста
	CALL    L_0138	; >>
	CALL    L_ENTS	; >>
	CPI     00Dh
	JZ      L_29A5
	LXI  D, D_2192	; норм.палитра
	CALL    L_0189	; >> копируем
	CALL    L_0168	; >>
	CALL    L_221A	; >> очистка экрана
	XRA  A
	RET
;
L_CPUD:	sub	a
	lxi	d,T_Z80
	rpo
	inr	a
	lxi	d,T_8080
	.db 0D9h	;shlx
	push	psw
	pop	d
	ora	e
	ani	00000011b ;чтобы не зависеть от банка памяти ВМ1
	lxi	d,T_VM1
	rpe
	ral
	lxi	d,T_8085
	ret
;
D_2A6A:	.db 000h	; Палитра для теста ЦПУ
	.db 080h	;
	.db 010h	;
	.db 0D0h	;
	.db 000h	;
	.db 080h	;
	.db 010h	;
	.db 0D0h	;
	.db 000h	;
	.db 080h	;
	.db 010h	;
	.db 0D0h	;
	.db 000h	;
	.db 080h	;
	.db 010h	;
	.db 0D0h	;
;
T_Z80:	.db "ZILOG Z80  "
T_8080:	.db "kr580wm80a "
T_VM1:	.db "kr580wm1   "
T_8085:	.db "kr1821wm85a"
;
D_2A7A:	.db 00Ah, 00Dh, 018h
	.db " opredelen tip processo"
	.db "ra: "
D_CPU:	.db "-----------  "
	.db 00Ah, 00Dh, 018h
	.db " pri wypolnenii posledo"
	.db "watelxnosti "
	.db 00Ah, 00Dh, 018h
	.db " komand: MOV  C,A "
	.db 00Ah, 00Dh, 018h, 018h, 018h
	.db 018h, 018h, 018h, 018h, 018h
	.db 018h
	.db " RLC      "
	.db 00Ah, 00Dh, 018h, 018h, 018h
	.db 018h, 018h, 018h, 018h, 018h
	.db 018h
	.db " ADD  C   "
	.db 00Ah, 00Dh, 018h, 018h, 018h
	.db 018h, 018h, 018h, 018h, 018h
	.db 018h
	.db " CMA      "
	.db 00Ah, 00Dh, 018h, 018h, 018h
	.db 018h, 018h, 018h, 018h, 018h
	.db 018h
	.db " XCHG     "
	.db 00Ah, 00Dh, 018h
	.db " realxnoe bystrodejstwie"
	.db " sostawilo:"
	.db 00Ah, 00Dh, 018h
	.db " bolee - "
D_2B3B:	.db "    tys.op/sek."
	.db 00Ah, 00Dh, 00Ah, 00Dh, 018h
	.db " pri wypolnenii komandy:"
	.db " ADD  C "
	.db 00Ah, 00Dh, 018h
	.db " bolee - "
D_2B7B:	.db "    tys.op/sek."
	.db 00Ah, 00Dh, 00Ah, 00Dh, 018h
	.db "  na wyhode tajmera [0] "
	.db "- XS5/B01 signal"
	.db 00Ah, 00Dh, 018h
	.db " ~astotoj 1000 gc (dlq"
	.db " kontrolq taktowoj"
	.db 00Ah, 00Dh, 018h
	.db " ~astoty mikroprocessora"
	.db " - 3 mgc).      "
	.db 000h
D_2C0E:	.dw 00000h
