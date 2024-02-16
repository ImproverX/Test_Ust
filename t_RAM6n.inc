M_DE50:	.equ    0DE37h
L_2C10:
L_MA20:	MVI  A, 000h
	CALL    L_0156
	LXI  B, 00101h	;+
	MVI  A, 001h
	CALL    L_013E
	LXI  B, 0C4FEh	;+
	MVI  A, 002h
	CALL    L_0141
	LDA	D_TPPC	; Тип ПК
	ORA  A
	JZ	L_N000	; -> Вектор06ц
;---------------------------------------------------
	MVI  A, 007h
	CALL    L_0156
	LXI  B, 02625h	;02620h+
	CALL    L_2220
	CALL    L_MB48
	JNC     L_MA4F
	LXI  H, D_MF5A	; "неисправность диспетчера памяти"
	CALL    L_0138
	JMP     L_MF0D
;
L_MA4F:	LXI  B, 00000h	;+
	MVI  A, 001h
	CALL    L_013E
	LXI  B, 0FFFFh	;+
	CALL    L_0141
	LXI  D, D_MD68	; ссылка на палитру
	CALL    L_0189
	LXI  H, D_MCF1	; "банки памяти..."
	CALL    L_0138
	MVI  A, 006h
	CALL    L_0156
	LXI  B, 03021h	;+
	CALL    L_2220
	LXI  H, D_MD1A	; "банк 0..."
	CALL    L_0138
	LXI  B, 00404h	;+
	LXI  H, 02207h	;+
	CALL    L_226E	;L_M0A9
	HLT
	DI
	LXI  H, 00000h	;+
	SHLD    D_MED7
	SHLD    D_MED9
	LXI  H, 0B736h	; ?
	MVI  B, 008h
L_MA93:	MVI  C, 002h
L_MA95:	LXI  D, D_ME81	; картинка чипа
	CALL    L_ME79
	DCR  C
	JNZ     L_MA95
	MOV  A, H
	SUI     008h
	MOV  H, A
	MOV  A, L
	ADI     010h
	MOV  L, A
	DCR  B
	JNZ     L_MA93
	LXI  H, 0C168h	;
	CALL    L_MCB9	; отрисовка банки в координате HL
	CALL	L_MCD7
	LXI  H, 0C659h	;
	CALL    L_MCB9	; отрисовка банки в координате HL
	CALL	L_MCD7
	LXI  H, 0CB4Ah	;
	CALL    L_MCB9	; отрисовка банки в координате HL
	CALL	L_MCD7
	LXI  H, 0D03Bh	;
	CALL    L_MCB9	; отрисовка банки в координате HL
	CALL    L_MCD7	; заполнение банки
	LXI  H, M_8000	; ?
	MVI  A, 008h
	CALL    L_018C
	MVI  A, 008h
	CALL    L_0156
	MVI  A, 001h
	STA     D_MDE9	;
	MVI  A, 022h
	STA     D_MDEA
	XRA  A
	OUT     00Eh	; Банк 0, Банк 1 (RW)
	STA     D_MDEB
	CALL    L_MC0B	; тестирование Банка 1
	MVI  A, 002h
	OUT     00Eh	; Банк 0, Банк 3 (R) / Банк 1 (W)
	CALL    L_MC9C	; переброска данных
	XRA  A
	OUT     00Dh	; Экран в Банке 1
	STA     D_MDEA
;
	MVI  A, 033h
	OUT     00Eh	; Банк 0, Банк 2 (RW)
	STA     D_MDEB
	MVI  A, 002h
	STA     D_MDE9	;
	CALL    L_MC0B	; тестирование Банка 2
;
	MVI  A, 022h
	OUT     00Eh	; Банк 0, Банк 3 (RW)
	STA     D_MDEB
	MVI  A, 003h
	STA     D_MDE9	;
	CALL    L_MC0B	; тестирование Банка 3
	MVI  A, 020h
	OUT     00Eh	; Банк 0, Банк 1 (R) / Банк 3 (W)
	CALL    L_MC9C	; переброска данных
	MVI  A, 022h
	OUT     00Dh	; Экран в Банке 3
	MVI  A, 066h
	STA     D_MDEA
;
	XRA  A		; {можно 005 -> Банк 0, Банк 0 (R) / Банк 1 (W) и L_MC9C}
	OUT     00Eh	; Банк 0, Банк 1 (RW)
	STA     D_MDE9
	CALL    L_MCA9	; переброска данных из Банка 0 в Банк 1
	MVI  A, 055h
	OUT     00Eh	; Банк 1, Банк 0 (RW)
	STA     D_MDEB
	CALL    L_MC0B	; тестирование Банка 0
	CALL    L_MCA9	; переброска данных из Банка 1 в Банк 0
	MVI  A, 022h
	OUT     00Eh	; Банк 0, Банк 3 (RW)
	MVI  A, 00Fh
	CALL    L_018C
;	JMP     L_MEDD
;L_MEDD:
	LHLD    D_MED9	; << завершение теста ================================================================
	LXI  D, 00002h	;/2
	CALL    L_017A
	LXI  D, D_MF50	;
	LXI  B, 03620h	;+
L_MEDD:	CALL    L_2220
	CALL    L_0183
	LXI  H, 02020h	; "  "
	SHLD    D_MF37
	SHLD    D_MF39
	SHLD    D_MF3B
	LHLD    D_MED7
	LXI  D, D_MF37
	CALL    L_0183
	MVI  A, 070h
	CALL    L_0156
	LXI  H, D_MF21
	CALL    L_0138
L_MF0D:	CALL    L_ENTS	;L_362D
	CPI     00Dh
	JZ      L_MA20
	LXI  D, D_2192	;D_2015
	CALL    L_0189
	LHLD    D_MED7
	MOV  A, L
	ORA  H
	RET
;
L_MB48:	LXI  H, 08010h	; ?
	LXI  D, L_MBBB	; адрес возврата
	PUSH D
	LXI  D, 00404h	;+
	MVI  A, 022h	; Банк 0, Банк 3 (RW)
	OUT     00Eh
	CALL    L_MBC2
	RC
	LXI  D, 00202h	;+
	MVI  A, 033h	; Банк 0, Банк 2 (RW)
	OUT     00Eh
	CALL    L_MBC2
	RC
	LXI  D, 00101h	;+
	MVI  A, 000h	; Банк 0, Банк 1 (RW)
	OUT     00Eh
	CALL    L_MBC2
	RC
	PUSH H		; очищаем облать в нижней памяти (Банк 0)
	MVI  H, 000h
	MVI  C, 00Ah
L_MBXX:	MOV  M, H
	INX  H
	DCR  C
	JNZ     L_MBXX
	POP  H	
	LXI  D, 00104h	;+
	MVI  A, 020h	; Банк 0, Банк 1 (R) / Банк 3 (W)
	OUT     00Eh
	CALL    L_MBC2
	RC
	LXI  D, 00102h	;+
	MVI  A, 030h	; Банк 0, Банк 1 (R) / Банк 2 (W)
	OUT     00Eh
	CALL    L_MBC2
	RC
	LXI  D, 00204h	;+
	MVI  A, 023h	; Банк 0, Банк 2 (R) / Банк 3 (W)
	OUT     00Eh
	CALL    L_MBC2
	RC
	LXI  D, 00201h	;+
	MVI  A, 003h	; Банк 0, Банк 2 (R) / Банк 1 (W)
	OUT     00Eh
	CALL    L_MBC2
	RC
	LXI  D, 00401h	;+
	MVI  A, 002h	; Банк 0, Банк 3 (R) / Банк 1 (W)
	OUT     00Eh
	CALL    L_MBC2
	RC
	LXI  D, 00402h	;+
	MVI  A, 032h	; Банк 0, Банк 3 (R) / Банк 2 (W)
	OUT     00Eh
	CALL    L_MBC2
	RC
	LXI  H, 00010h	;+
	MVI  D, 000h
	CALL    L_MBE3	; проверка -- не задета ли нижняя память в Банке 0?
	RET
;
L_MBBB:	PUSH PSW
	MVI  A, 022h
	OUT     00Eh
	POP  PSW
	RET
;
L_MBC2:	STA     D_MDE9
	CALL    L_MBD9
	RC
	LDA     D_MDE9
	RLC
	RLC
	RLC
	RLC
	OUT     00Eh
	MOV  A, D
	MOV  D, E
	MOV  E, A
	CALL    L_MBD9
	RET
;
L_MBD9:	PUSH H
	MVI  C, 00Ah
L_MBDC:	MOV  M, E
	INX  H
	DCR  C
	JNZ     L_MBDC
	POP  H
L_MBE3:	PUSH H
	LXI  B, 0000Ah
;	MVI  B, 000h
L_MBE8:	MOV  A, M
	CMP  D
	JZ      L_MBEE
	INR  B
L_MBEE:	INX  H
	DCR  C
	JNZ     L_MBE8
	POP  H
	MOV  A, B
	CPI     005h
	CMC
	RET
;
L_MBF9:	MOV  B, M
	CMP  B
	CNZ     L_ME2D	;>> брак
	MOV  M, C
	INR  L
	JNZ     L_MBF9
	INR  H
	RZ		;>>
	CPE     L_MC3D
	JMP     L_MBF9
;
L_MC0B:	PUSH H		; тестирование памяти
	MVI  B, 040h
;	STA     D_MDED
	LXI  D, D_MDED
	XRA  A
L_MC15:	STAX D
	INX  D
	DCR  B
	JNZ     L_MC15	; очистка буфера ?
	LXI  D, D_MDE5
;	XRA  A
L_MC1F:	MOV  M, A
	INR  L
	JNZ     L_MC1F
	INR  H
	JNZ     L_MC1F	; очистка памяти
	MOV  C, A
L_MC29:	POP  H
	LDAX D
	STA     D_MDEC	; тестирующий байт ?
	PUSH H
	MOV  B, C
	MOV  C, A
	MOV  A, B
	CALL    L_MBF9	;>>
	MOV  A, C
	INX  D
	ORA  A
	JNZ     L_MC29	; цикл
	POP  H
	RET
;
L_MC3D:	PUSH PSW
	PUSH B
	PUSH D
	PUSH H
	LDA     D_MDEC
	ORA  A
	JNZ     L_MC7D
	MOV  B, A	; закраска банки
	MOV  A, H
	ANI     07Fh
	RAR
	MOV  C, A
	LXI  H, D_MDED
	DAD  B
	MOV  A, M
	ORA  A
	JNZ     L_MC7D
	LDA     D_MDEA
	OUT     00Eh
	CALL    L_MC82
	MOV  B, C
	MOV  C, E
	MOV  A, D
	ADD  B
	MOV  B, A
	MVI  A, 001h
	CALL    L_013E
	MOV  A, E
	ADI     028h
	MOV  C, A
	XRA  A
	CALL    L_0141
	LDA     D_MDEB
	OUT     00Eh
	LHLD    D_MED9
	INX  H
	SHLD    D_MED9
L_MC7D:	POP  H
	POP  D
	POP  B
	POP  PSW
	RET
;
L_MC82:	LDA     D_MDE9
	INR  A
	MOV  E, A
	MVI  A, 008h
	MVI  D, 069h
L_MC8B:	DCR  E
	JZ      L_MC9A
	ADI     028h
	PUSH PSW
	MOV  A, D
	SUI     00Fh
	MOV  D, A
	POP  PSW
	JMP     L_MC8B
;
L_MC9A:	MOV  E, A
	RET
;
L_MC9C:	PUSH H		; переброска данных
L_MC9D:	MOV  A, M
	MOV  M, A
	INR  L
	JNZ     L_MC9D
	INR  H
	JNZ     L_MC9D
	POP  H
	RET
;
L_MCA9:	PUSH H		; переброска данных
	LXI  D, M_0000	; ?
L_MCAD:	LDAX D
	MOV  M, A
;	INX  H
	INX  D
;	MOV  A, D
;	CPI     070h
;	JNZ     L_MCAD
	INR  L
	JNZ     L_MCAD
	INR  H
	JNZ     L_MCAD
	POP  H
	RET
;
L_MCB9:	LXI  D, D_MD78	; отрисовка банки в координате HL
	MVI  B, 005h
L_MCBE:	PUSH H		; отрисовка картинки
L_MCBF:	LDAX D
	CPI     055h
	JZ      L_MCCF
	MOV  C, A
	INX  D
	LDAX D
	INX  D
;	CALL    L_MCEA
L_MCEA:	MOV  M, C
	INX  H
	DCR  A
	JNZ     L_MCEA
;	RET
	JMP     L_MCBF
;
L_MCCF:	POP  H
	INR  H
	INX  D
	DCR  B
	JNZ     L_MCBE
	RET
;
L_MCD7:	MVI  A, 01Ch
	ADD  H
	MOV  H, A
	INR  L
	INR  L		;LXI  H, 0E16A
	LXI  D, D_FB
	MVI  B, 003h
	CALL	L_MCBE	; прямоугольник, для ускорения заливки
	MOV  B, L	; заливка цветом банки
	DCR  B
	MOV  A, H
	SUI  0E0h
	RLC
	RLC
	RLC
	MOV  C, A	; BC = коодината точки заливки
	LXI  D, 00102h	;+
	JMP	L_0150	
;
L_ME2D:	PUSH PSW
	PUSH H
	PUSH D
	PUSH B
	PUSH H
	MOV  C, A
	MOV  A, H
	ANI     040h
	MVI  H, 097h
	JZ      L_ME3D
	MVI  H, 09Bh
L_ME3D:	MOV  A, C
	XRA  B
	MVI  L, 0B6h
	MOV  C, A
	LDA     D_MDEA
	OUT     00Eh
	MVI  B, 008h
L_ME49:	MOV  A, L
	SUI     010h
	MOV  L, A
	MOV  A, C
	RAR
	MOV  C, A
	LXI  D, D_ME9F	; чип "брак"
	PUSH H
	CC      L_ME78	;>>
	LHLD    D_MED7
	INX  H
	SHLD    D_MED7
	POP  H
	DCR  B
	JNZ     L_ME49
	LDA     D_MDEB
	OUT     00Eh
	POP  H
	MOV  A, H
	ANI     07Fh
	RAR
	MOV  C, A
	LXI  H, D_MDED
	DAD  B
	MVI  M, 001h
	POP  B
	POP  D
	POP  H
	POP  PSW
	RET
;
L_ME78:	INX  H
	INX  H
	INX  H
L_ME79:	PUSH B
	MVI  B, 004h
	CALL    L_MCBE
	POP  B
	RET
;
;-----------------------------------------------------------------
L_N000:	MVI  A, 070h	; << Вектор06ц
	CALL    L_0156	; >>
	LXI  B, 02620h
	CALL    L_2220	; >>
	LXI  H, D_NC47	; текст
	CALL    L_0138	; >>
	LXI  B, 01404h
	LXI  H, 03006h
	CALL    L_226E	; >> закрашенный прямоугольник
	MVI  A, 001h
	CALL    L_0156	; >>
	LXI  H, 00000h
	SHLD    D_MED7
	SHLD    D_MED9
	DI
	DAD  SP
	SHLD    D_NE5E
	LXI  SP,L_NSTK	;L_ND00	;
	LXI  H, M_DE50	; координата
	MVI  B, 004h	; счётчик рядов
L_ND16:	MVI  C, 008h	; чипов в ряду
L_ND18:	MVI  A, 0FFh
	CALL    L_NDE5
	MOV  A, H
	SUI     004h
	MOV  H, A
	DCR  C
	JNZ     L_ND18
	MOV  A, H
	ADI     020h
	MOV  H, A
	MOV  A, L
	ADI     020h
	MOV  L, A
	DCR  B
	JNZ     L_ND16
;	JMP     L_ND00
;
;	.ds 040h	; стек
L_ND00:	LXI  H, L_NSTK	;((((L_NSTK - 1) / 0100h) + 1) * 0100h) ; 02F00h -- начальный адрес тестирования
L_TMEM:	LXI  D, D_PAT	; список шаблонов
	XRA  A
	MOV  C, M
L_TM0:	MOV  M, A
	MVI  B, 008h
L_TM1:	DCR  B
	JNZ     L_TM1	; задержка
	MOV  B, M
	MOV  M, C
	CMP  B
	CNZ     L_NDA8	; ошибка
	LDAX D
	INX  D
	ORA  A
	JNZ	L_TM0	; следующий шаблон
	ORA  L		; L = 0?
	JNZ     L_ND95
	PUSH H
	LHLD    D_MED9
	INX  H
	SHLD    D_MED9	; инкремент счётчика памяти
	PUSH B		; закрашивание полоски
	PUSH D
	PUSH PSW
	MOV  A, L
	CPI     004h
	JC      L_NC8A
	CPI     0FAh
	JNC     L_NC8A
	MOV  C, L
	INR  C
	MVI  B, 015h
	MVI  A, 001h
	CALL    L_013E	; !>>
	MVI  B, 02Fh
	CALL    L_0141	; !>>
L_NC8A:	POP  PSW
	POP  B
	POP  D		; конец ПП закрашивания
	POP  H
L_ND95:	INX  H
	MOV  A, H
	CPI     (L_ND00 / 0100h)	; 02Dh -- конечный адрес тестирования
	JNZ     L_TMEM	;L_2D34	; цикл тестирования
	LHLD    D_NE5E
	SPHL
;	JMP	L_NSTK
;L_NSTK:
	LHLD    D_MED9	; окончание блока тестирования
	INX  H
	INX  H		; +2 на память под тестом
	LXI  D, 00004h	; HL / 4
	CALL    L_017A
	LXI  D, D_MF50+1
	LXI  B, 03520h	;+
	JMP	L_MEDD	; >> тест закончен
;
L_NDA8:	PUSH H
	PUSH B
	PUSH H
	LHLD    D_MED7
	INX  H
	SHLD    D_MED7	; инкремент счётчика ошибок
	POP  H
	MOV  C, A
	MVI  L, 017h	;30h
	MOV  A, H
	ANI     060h
	MOV  H, A
L_NDBA:	MOV  A, L
	ADI     020h
	MOV  L, A
	MOV  A, H
	SUI     020h
	MOV  H, A
	JP      L_NDBA
	MOV  A, C
	XRA  B
	MVI  H, 0BEh
	MOV  B, A
L_NDCA:	MOV  A, H
	ADI     004h
	MOV  H, A
	CPI     0E2h
	JZ      L_NDE1
	MOV  A, B
	RAR
	MOV  B, A
	JNC     L_NDCA
	MVI  A, 055h
	CALL    L_NDE5
	JMP     L_NDCA
;
L_NDE1:	MOV  A, C
	POP  B
	POP  H
	RET
;
L_NDE5:	PUSH B
	PUSH D
	PUSH H
	CPI     0FFh
	JZ      L_NE07
	MVI  A, 004h	;
	XRA  H		;
	MOV  H, A	;
	LXI  D, D_BRAK	; чип с браком
	JMP     L_NE0A
;
L_NE07:	LXI  D, D_CHIP	; чип нормальный
L_NE0A:	MVI  B, 019h	; высота чипа
L_NE0C:	LDAX D
	MOV  M, A
	INX  D
	INR  L		;DCR  L
	DCR  B
	JNZ     L_NE0C
	POP  H
	POP  D
	POP  B
	RET
;	
D_PAT:	.db 001h
	.db 0FFh
	.db 055h
	.db 0AAh
	.db 000h
;
D_NE5E:	.dw 00000h	; указатель стека
D_MED7:	.dw 00000h	; счётчик ошибок
D_MED9:	.dw 00000h	; счётчик протестированной памяти (адресов)
;
	.ds 040h	; стек на время теста
L_NSTK:
;----------------------------------------------------------
;
D_MCF1:	.db "    banki pamqti"
	.db "          kr565ru5g"
	.db 000h
D_MD1A:	.db "bank 0"
	.db 00Ah	;, 00Dh
	.db " bank 1"
	.db 00Ah, 00Ah	;, 00Ah, 00Dh
	.db "bank 2"
	.db 00Ah	;, 00Dh
	.db " bank 3"
	.db 000h
;
D_MD68:	.db 000h	; "_" - |        | (offset 2D68h)
	.db 000h	; "_" - |        | (offset 2D69h)
	.db 022h	; """ - |  ■   ■ | (offset 2D6Ah)
	.db 0D0h	; "╨" - |■■ ■    | (offset 2D6Bh)
	.db 086h	; "Ж" - |■    ■■ | (offset 2D6Ch)
	.db 006h	; "_" - |     ■■ | (offset 2D6Dh)
	.db 016h	; "_" - |   ■ ■■ | (offset 2D6Eh)
	.db 034h	; "4" - |  ■■ ■  | (offset 2D6Fh)
	.db 000h	; "_" - |        | (offset 2D70h)
	.db 080h	; "А" - |■       | (offset 2D71h)
	.db 022h	; """ - |  ■   ■ | (offset 2D72h)
	.db 0C0h	; "└" - |■■      | (offset 2D73h)
	.db 002h	; "_" - |      ■ | (offset 2D74h)
	.db 098h	; "Ш" - |■  ■■   | (offset 2D75h)
	.db 052h	; "R" - | ■ ■  ■ | (offset 2D76h)
	.db 0ADh	; "н" - |■ ■ ■■ ■| (offset 2D77h)
;
D_MD78:	.db 007h	; "_" - |     ■■■| (offset 2D78h)
	.db 001h	;
	.db 018h	; "_" - |   ■■   | (offset 2D7Ah)
	.db 001h	;
	.db 020h	; " " - |  ■     | (offset 2D7Ch)
	.db 002h	;
	.db 040h	; "@" - | ■      | (offset 2D7Eh)
	.db 036h	;
	.db 020h	; " " - |  ■     | (offset 2D84h)
	.db 002h	;
	.db 010h	; "_" - |   ■    | (offset 2D86h)
	.db 001h	;
	.db 008h	; "_" - |    ■   | (offset 2D88h)
	.db 001h	;
	.db 006h	; "_" - |     ■■ |
	.db 001h	;
	.db 001h	; "_" - |       ■| (offset 2D8Ch)
	.db 001h	;
	.db 055h	;--
;
	.db 0F8h	; "°" - |■■■■■   | (offset 2D8Fh)
	.db 001h	;
	.db 007h	; "_" - |     ■■■|
	.db 001h	;
	.db 000h	; "_" - |        | (offset 2D93h)
	.db 03Dh	;
	.db 080h	; "_" - |■       |
	.db 001h	;
	.db 0E8h	; "ш" - |■■■ ■   | (offset 2D97h)
	.db 001h	;
	.db 040h	; "@" - | ■      | (offset 2D99h)
	.db 004h	;
	.db 07Fh	; "" - | ■■■■■■■| (offset 2D9Bh)
	.db 001h	;
	.db 080h	; "_" - |■       |
	.db 001h	;
	.db 07Fh	; "" - | ■■■■■■■| (offset 2D9Fh)
	.db 001h	
	.db 080h	; "_" - |■       |
	.db 001h	;
	.db 07Fh	; "" - | ■■■■■■■| (offset 2DA3h)
	.db 001h	;
	.db 055h	;--
;
	.db 000h	; "_" - |        |
	.db 001h	;
	.db 0FFh	; " " - |■■■■■■■■|
	.db 001h	;
	.db 000h	; "_" - |        | (offset 2DAAh)
	.db 043h	;
	.db 0FFh	; " " - |■■■■■■■■|
	.db 001h	
	.db 000h	; "_" - |        |
	.db 001h	;
	.db 0FFh	; " " - |■■■■■■■■|
	.db 001h	;
	.db 000h	; "_" - |        |
	.db 001h	;
	.db 0FFh	; " " - |■■■■■■■■|
	.db 001h	;
	.db 055h	;--
;
	.db 01Fh	; "_" - |   ■■■■■| (offset 2DB7h)
	.db 001h	;
	.db 0E0h	; "р" - |■■■     | (offset 2DB9h)
	.db 001h	;
	.db 000h	; "_" - |        | (offset 2DBBh)
	.db 03Dh	;
	.db 001h	; "_" - |       ■| (offset 2DBDh)
	.db 001h	;
	.db 017h	; "_" - |   ■ ■■■| (offset 2DBFh)
	.db 001h	;
	.db 002h	; "_" - |      ■ | (offset 2DC1h)
	.db 004h	;
	.db 0FEh	; "■" - |■■■■■■■ | (offset 2DC3h)
	.db 001h	;
	.db 001h	; "_" - |       ■| (offset 2DC5h)
	.db 001h	;
	.db 0FEh	; "■" - |■■■■■■■ | (offset 2DC7h)
	.db 001h	;
	.db 001h	; "_" - |       ■| (offset 2DC9h)
	.db 001h	;
	.db 0FEh	; "■" - |■■■■■■■ | (offset 2DCBh)
	.db 001h	;
	.db 055h	;--
;
	.db 0E0h	; "р" - |■■■     | (offset 2DCEh)
	.db 001h	;
	.db 018h	; "_" - |   ■■   | (offset 2DD0h)
	.db 001h	;
	.db 004h	; "_" - |     ■  | (offset 2DD2h)
	.db 002h	;
	.db 002h	; "_" - |      ■ | (offset 2DD4h)
	.db 036h	;
	.db 004h	; "_" - |     ■  | (offset 2DDAh)
	.db 002h	;
	.db 008h	; "_" - |    ■   | (offset 2DDCh)
	.db 001h	;
	.db 010h	; "_" - |   ■    | (offset 2DDEh)
	.db 001h	;
	.db 060h	; "`" - | ■■     | (offset 2DE0h)
	.db 001h	;
	.db 080h	; "_" - |■       |
	.db 001h	;
	.db 055h	;--
;
D_FB:	.db 0FFh
	.db 03Ch
	.db 055h
;
	.db 0FFh
	.db 03Ch
	.db 055h
;
	.db 0FFh
	.db 03Ch
	.db 055h		
;
D_MDE5:	.db 0FFh	; " " - |■■■■■■■■| (offset 2DE5h)
	.db 055h	; "U" - | ■ ■ ■ ■| (offset 2DE6h)
	.db 0AAh	; "к" - |■ ■ ■ ■ | (offset 2DE7h)
	.db 000h	; "_" - |        | (offset 2DE8h)
D_MDE9:	.db 000h	; "_" - |        | (offset 2DE9h)
D_MDEA:	.db 000h	; "_" - |        | (offset 2DEAh)
D_MDEB:	.db 000h	; "_" - |        | (offset 2DEBh)
D_MDEC:	.db 000h	; "_" - |        | (offset 2DECh)
;
D_MDED:	.ds 40h
;
D_ME81:	.db 06Dh	; "m" - | ■■ ■■ ■| (offset 2E81h)
	.db 002h	;
	.db 0FFh	; " " - |■■■■■■■■|
	.db 001h	;
	.db 0CFh	; "╧" - |■■  ■■■■| (offset 2E85h)
	.db 002h	;
	.db 0FFh	; " " - |■■■■■■■■| (offset 2E87h)
	.db 004h	;
	.db 06Dh	; "m" - | ■■ ■■ ■| (offset 2E89h)
	.db 002h	;
	.db 055h	;--
;
	.db 0B6h	; "╢" - |■ ■■ ■■ | (offset 2E8Ch)
	.db 002h	;
	.db 0FFh	; " " - |■■■■■■■■| (offset 2E8Eh)
	.db 007h	;
	.db 0B6h	; "╢" - |■ ■■ ■■ | (offset 2E90h)
	.db 002h	;
	.db 055h	;--
;
	.db 0DBh	; "█" - |■■ ■■ ■■| (offset 2E93h)
	.db 002h	;
	.db 0FFh	; " " - |■■■■■■■■| (offset 2E95h)
	.db 007h	;
	.db 0DBh	; "█" - |■■ ■■ ■■| (offset 2E97h)
	.db 002h	;
	.db 055h	;--
;
	.db 000h	; "_" - |        |
	.db 002h	;
	.db 080h	; "А" - |■       | (offset 2E9Ch)
	.db 007h	;
	.db 055h	;--
;
D_ME9F:
;	.db 06Dh	; "m" - | ■■ ■■ ■| (offset 2E9Fh)
;	.db 002h	;
;	.db 0FFh	; " " - |■■■■■■■■|
;	.db 001h	;
	.db 006h
;	.db 0CEh	; "╬" - |■■  ■■■ | (offset 2EA3h)
	.db 005h
;	.db 002h	;
;	.db 0FEh	; " " - |■■■■■■■ |
;	.db 003h	;
;	.db 0FFh	; " " - |■■■■■■■■|
;	.db 001h	;
;	.db 06Dh	; "m" - | ■■ ■■ ■| (offset 2EA9h)
;	.db 002h	;
	.db 055h	;--
;
;	.db 0B6h	; "╢" - |■ ■■ ■■ | (offset 2EACh)
;	.db 002h	;
;	.db 0FFh	; " " - |■■■■■■■■|
;	.db 001h	;
	.db 02Eh	; "." - |  ■ ■■■ | (offset 2EB0h)
	.db 001h	;
	.db 0AEh	; "о" - |■ ■ ■■■ | (offset 2EB2h)
	.db 001h	;
	.db 022h	; """ - |  ■   ■ | (offset 2EB4h)
	.db 001h	;
	.db 0EAh	; "ъ" - |■■■ ■ ■ | (offset 2EB6h)
	.db 001h	;
	.db 023h	; """ - |  ■   ■■|
	.db 001h	;
;	.db 0FFh	; " " - |■■■■■■■■|
;	.db 001h	;
;	.db 0B6h	; "╢" - |■ ■■ ■■ | (offset 2EBCh)
;	.db 002h	;
	.db 055h	;--
;
;	.db 0DBh	; "█" - |■■ ■■ ■■| (offset 2EBFh)
;	.db 002h	;
;	.db 0FFh	; " " - |■■■■■■■■|
;	.db 001h	;
	.db 0ABh	; "л" - |■ ■ ■ ■■| (offset 2EC3h)
	.db 001h	;
	.db 027h	; "'" - |  ■  ■■■| (offset 2EC5h)
	.db 001h	;
	.db 0AFh	; "п" - |■ ■ ■■■■| (offset 2EC7h)
	.db 001h	;
	.db 027h	; "'" - |  ■  ■■■| (offset 2EC9h)
	.db 001h	;
	.db 06Bh	;	| ■■ ■ ■■|
	.db 001h	;
;	.db 0FFh	; " " - |■■■■■■■■|
;	.db 001h	;
;	.db 0DBh	; "█" - |■■ ■■ ■■| (offset 2ECFh)
;	.db 002h	;
	.db 055h	;--
;
	.db 000h	; "_" - |        |
	.db 001h	;
;	.db 080h	; "А" - |■       | (offset 2ED4h)
;	.db 007h	;
	.db 055h	;--
;
D_NC47:	.db 018h, 018h, 018h, 018h
	.db " raspolovenie  bis ozu -"
	.db " kr565ru6 "
	.db 000h
;
D_MF21:	.db 018h
	.db " obnaruveno o{ibok - "
D_MF37:	.db "  "
D_MF39:	.db "  "
D_MF3B:	.db "  "
	.db 00Ah, 00Dh, 018h
	.db " emkostx ozu sostawlqet - "
D_MF50:	.db "    kbajt"
	.db 000h
;
D_MF5A:	.db 00Ah, 00Ah, 00Ah	;, 00Dh
	.db "neisprawnostx dispet~era"
	.db " pamqti"
	.db 000h
