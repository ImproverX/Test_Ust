M_A810:	.equ 0A810h
M_B610:	.equ 0B610h
M_A000:	.equ 0A000h
;
L_5751:	MVI  A, 000h
	CALL    L_0156
	LXI  D, D_5AD3	;
	CALL    L_0189
	LXI  B, 00101h	;+
	MVI  A, 001h
	CALL    L_013E
	LXI  B, 0C4FEh	;+
	MVI  A, 002h
	CALL    L_0141
	MVI  A, 005h
	CALL    L_0156
	LXI  B, 02727h	;+
	CALL    L_2220	;
	LXI  H, D_5AA0	; "дж1,дж2"
	CALL    L_0138
	MVI  A, 007h
	CALL    L_0156
	LXI  H, D_59A4	;
	SHLD    D_5ACE	;
	LXI  H, 00080h	;+
	SHLD    D_5AD0	;
	MVI  A, 001h
L_5790:	PUSH PSW
	CALL    L_5883
	PUSH B
	CALL    L_58C4
	POP  B
	MOV  A, C
	ADI     070h
	MOV  C, A
	CALL    L_58C4
	LHLD    D_5ACE	;
	LXI  B, 0001Ch	;+
	DAD  B
	SHLD    D_5ACE	;
	POP  PSW
	INR  A
	CPI     009h
	JNZ     L_5790
	JMP     L_57BB
;
L_57B4:	LHLD    D_5AD0	;
	XRA  A
	CALL    L_593A
L_57BB:	LXI  H, 01000h	;+
L_57BE:	CALL    L_013B
	CPI     003h
	JZ      L_57E4
	CPI     00Dh
	JZ      L_57E3
	MVI  D, 001h	; дж.1
	IN      00Fh	;<<<<<<<<<<
	ORA  A
	JZ	L_D2	; = 0 -- джойстик ПК6128, нет нажатий или отключён
	CMA
	ORA  A
;	ANI     0CFh	; 1100 1111 (кнопки+стрелки)
	JNZ     L_57ED	; <> 0 -- джойстик С, есть нажатия
L_D2:	INR  D		; дж.2
	IN      00Eh	;<<<<<<<<<<
	ORA  A
	JZ	L_D3
	CMA
	ORA  A
;	ANI     0CFh
	JNZ     L_57ED
L_D3:	EI
	HLT
	DCX  H
	MOV  A, L
	ORA  H
	RZ
	JMP     L_57BE
;
L_57E3:	XRA  A
L_57E4:	PUSH PSW
	LXI  D, D_2192	; ссылка на палитру
	CALL    L_0189
	POP  PSW
	RET
;
L_57ED:	PUSH D
	LXI  H, L_57FF	; адрес перехода
	PUSH PSW
	PUSH H
	LXI  H, L_5890	; адрес перехода дж.1
	DCR  D
	JZ      L_57FD
	LXI  H, L_589A	; адрес перехода дж.2
L_57FD:	PUSH H
	RET
;
L_57FF:	POP  PSW
	CALL    L_5856	;>> проверка команд с джойстика
	MOV  A, C
	ORA  A
	JZ      L_5837
	PUSH B
	CALL    L_5883
	POP  H
	POP  D
	PUSH D
	PUSH H
	DCR  D
	JZ      L_5818
	MOV  A, C
	ADI     070h
	MOV  C, A
L_5818:	LXI  H, 08000h	;+
	CALL    L_58F9
	SHLD    D_5AD0	;
	MVI  A, 0FFh
	CALL    L_593A
	LHLD    D_5AD0	;
	MOV  A, H
	ADI     060h
	MOV  H, A
	SHLD    D_5AD0	;
	MVI  A, 0FFh
	CALL    L_593A
	HLT
	POP  B
L_5837:	MOV  A, B	; кнопки
	ORA  A
	POP  D
	JZ      L_57B4
	LXI  H, 0A96Fh	;+
	DCR  D
	JZ      L_5846
	MVI  H, 0B7h	; дж.2
L_5846:	CPI     002h
	JZ	L_584X	; кнопка 2
	DCR  H
	CPI     003h
	JZ	L_584X	; кнопка 1+2
	DCR  H		; кнопка 1
L_584X:	LXI  D, D_5A84	;
	PUSH H
	CALL    L_5926
	HLT
	XRA  A
	POP  H
	CALL    L_593A
	JMP     L_57B4
;
L_5856:	MOV  B, A	; проверка команд с джойстика
	MVI  C, 000h
	ANI     01Fh	; 0000 1111, плюс 0001 0000 для определения ПК-6128
	JZ      L_587B	;-> нажаты только кнопки
	MVI  C, 008h
	LXI  H, D_CODE
	CPI     010h
	JC	L_CLP	;-> ПК6128
	LXI  H, D_6128
L_CLP:	CMP  M
	JZ	L_587B	;-> к проверке кнопок
	INX  H
	DCR  C
	JNZ	L_CLP
L_587B:	MOV  A, B
	ANI     0C0h
	MVI  B, 003h
	CPI     0C0h	; кнопки 1+2
	RZ
	DCR  B
	CPI     040h	; кнопка 2
	RZ
	DCR  B
	CPI     080h	; кнопка 1
	RZ
	DCR  B		; нет нажатых кнопок
	RET
;
;Джойстик С (02)
D_CODE:	.db 006h	;(8) -- влево-вверх
	.db 002h	;(7) -- влево
	.db 00Ah	;(6) -- влево-вниз
	.db 008h	;(5) -- вниз
	.db 009h	;(4) -- вправо-вниз
	.db 001h	;(3) -- вправо
	.db 005h	;(2) -- вправо-вверх
	.db 004h	;(1) -- вверх
;
;ПК6128 в инверсии
D_6128:	.db 01Ch	;(8) -- влево-вверх
	.db 01Eh	;(7) -- влево
	.db 016h	;(6) -- влево-вниз --
	.db 017h	;(5) -- вниз
	.db 013h	;(4) -- вправо-вниз
	.db 01Bh	;(3) -- вправо
	.db 019h	;(2) -- вправо-вверх --
	.db 01Dh	;(1) -- вверх
;
L_5883:	LXI  H, D_5ABE	;
	DCR  A
	ADD  A
	MVI  B, 000h
	MOV  C, A
	DAD  B
	MOV  C, M
	INX  H
	MOV  B, M
	RET
;
L_5890:	LXI  D, D_594C	; отрисовка джойстика
	LXI  H, M_A810	; ?
	CALL    L_58A4
	RET
;
L_589A:	LXI  D, D_594C	; отрисовка джойстика
	LXI  H, M_B610	; ?
	CALL    L_58A4
	RET
;
L_58A4:	PUSH H
L_58A5:	LDAX D
	INX  D
	CPI     055h
	JNZ     L_58B6
	LDAX D
	INX  D
	CPI     055h
	JZ      L_58C2	;->
	POP  H
	INR  H
	PUSH H
L_58B6:	MOV  C, A
	LDAX D
	INX  D
L_58B9:	MOV  M, C
	INX  H
	DCR  A
	JNZ     L_58B9
	JMP     L_58A5
;
L_58C2:	POP  H
	RET
;
L_58C4:	PUSH H
	PUSH B
	MVI  A, 002h
	CALL    L_013E
	CALL    L_5905
	MVI  A, 001h
	CALL    L_0141
	PUSH B
	POP  H
	POP  B
	PUSH B
	MVI  A, 003h
	CALL    L_0156
	CALL    L_590E
	POP  B
	LXI  H, M_A000	; ?
	CALL    L_58F9
	XCHG
	LHLD    D_5ACE	;
	XCHG
	XRA  A
	CALL    L_0156
	CALL    L_5926
	MVI  A, 007h
	CALL    L_0156
	POP  H
	RET
;
L_58F9:	MOV  A, B
	ADD  L
	INR  A
	MOV  L, A
	MOV  A, C
	CALL    L_591F
	INR  A
	ADD  H
	MOV  H, A
	RET
;
L_5905:	MOV  A, B
	ADI     011h
	MOV  B, A
	MOV  A, C
	ADI     011h
	MOV  C, A
	RET
;
L_590E:	INR  C
	INR  B
	MVI  A, 001h
	CALL    L_013E
	DCR  H
	DCR  L
	MOV  B, H
	MOV  C, L
	MVI  A, 002h
	CALL    L_0141
	RET
;
L_591F:	ORA  A
	RAR
	ORA  A
	RAR
	ORA  A
	RAR
	RET
;
L_5926:	MVI  B, 002h
L_5928:	MVI  C, 00Eh
	PUSH H
L_592B:	LDAX D
	MOV  M, A
	INX  H
	INX  D
	DCR  C
	JNZ     L_592B
	POP  H
	INR  H
	DCR  B
	JNZ     L_5928
	RET
;
L_593A:	MVI  B, 002h
L_593C:	MVI  C, 010h
	PUSH H
L_593F:	MOV  M, A
	INX  H
	DCR  C
	JNZ     L_593F
	POP  H
	INR  H
	DCR  B
	JNZ     L_593C
	RET
;
D_594C:	.db 07Eh	; "~" - | ■■■■■■ | (offset 594Ch)
	.db 001h	; "_" - |       ■| (offset 594Dh)
	.db 018h	; "_" - |   ■■   | (offset 594Eh)
	.db 001h	; "_" - |       ■| (offset 594Fh)
	.db 03Fh	; "?" - |  ■■■■■■| (offset 5950h)
	.db 001h	; "_" - |       ■| (offset 5951h)
	.db 0FFh	; " " - |■■■■■■■■| (offset 5952h)
	.db 007h	; "_" - |     ■■■| (offset 5953h)
	.db 03Fh	; "?" - |  ■■■■■■| (offset 5954h)
	.db 001h	; "_" - |       ■| (offset 5955h)
	.db 001h	; "_" - |       ■| (offset 5956h)
	.db 002h	; "_" - |      ■ | (offset 5957h)
	.db 000h	; "_" - |        | (offset 5958h)
	.db 003h	; "_" - |      ■■| (offset 5959h)
	.db 001h	; "_" - |       ■| (offset 595Ah)
	.db 004h	; "_" - |     ■  | (offset 595Bh)
	.db 003h	; "_" - |      ■■| (offset 595Ch)
	.db 00Ah	; "_" - |    ■ ■ | (offset 595Dh)
	.db 001h	; "_" - |       ■| (offset 595Eh)
	.db 005h	; "_" - |     ■ ■| (offset 595Fh)
	.dw 00200h
	.db 001h	; "_" - |       ■| (offset 5962h)
	.db 001h	; "_" - |       ■| (offset 5963h)
	.db 003h	; "_" - |      ■■| (offset 5964h)
	.db 002h	; "_" - |      ■ | (offset 5965h)
	.db 001h	; "_" - |       ■| (offset 5966h)
	.db 003h	; "_" - |      ■■| (offset 5967h)
	.db 055h	; "U" - | ■ ■ ■ ■| (offset 5968h)
;
	.dw 00200h
	.db 0FFh	; " " - |■■■■■■■■| (offset 596Bh)
	.db 009h	; "_" - |    ■  ■| (offset 596Ch)
	.db 0FEh	; "■" - |■■■■■■■ | (offset 596Dh)
	.db 002h	; "_" - |      ■ | (offset 596Eh)
	.db 078h	; "x" - | ■■■■   | (offset 596Fh)
	.db 001h	; "_" - |       ■| (offset 5970h)
	.db 0FCh	; "№" - |■■■■■■  | (offset 5971h)
	.db 001h	; "_" - |       ■| (offset 5972h)
	.db 0FEh	; "■" - |■■■■■■■ | (offset 5973h)
	.db 001h	; "_" - |       ■| (offset 5974h)
	.db 0FFh	; " " - |■■■■■■■■| (offset 5975h)
	.db 003h	; "_" - |      ■■| (offset 5976h)
	.dw 003FEh
	.db 0FFh	; " " - |■■■■■■■■| (offset 5979h)
	.db 003h	; "_" - |      ■■| (offset 597Ah)
	.dw 003FEh
	.db 0FFh	; " " - |■■■■■■■■| (offset 597Dh)
	.db 003h	; "_" - |      ■■| (offset 597Eh)
	.dw 003FEh
	.db 0FFh	; " " - |■■■■■■■■| (offset 5981h)
	.db 00Ah	; "_" - |    ■ ■ | (offset 5982h)
	.db 07Fh	; "" - | ■■■■■■■| (offset 5983h)
	.db 001h	; "_" - |       ■| (offset 5984h)
	.db 03Fh	; "?" - |  ■■■■■■| (offset 5985h)
	.db 001h	; "_" - |       ■| (offset 5986h)
	.db 00Fh	; "_" - |    ■■■■| (offset 5987h)
	.db 001h	; "_" - |       ■| (offset 5988h)
	.db 055h	; "U" - | ■ ■ ■ ■| (offset 5989h)
;
	.db 0FCh	; "№" - |■■■■■■  | (offset 598Ah)
	.db 001h	; "_" - |       ■| (offset 598Bh)
	.db 030h	; "0" - |  ■■    | (offset 598Ch)
	.db 001h	; "_" - |       ■| (offset 598Dh)
	.db 0F8h	; "°" - |■■■■■   | (offset 598Eh)
	.db 001h	; "_" - |       ■| (offset 598Fh)
	.db 0FEh	; "■" - |■■■■■■■ | (offset 5990h)
	.db 007h	; "_" - |     ■■■| (offset 5991h)
	.db 0F8h	; "°" - |■■■■■   | (offset 5992h)
	.db 001h	; "_" - |       ■| (offset 5993h)
	.db 000h	; "_" - |        | (offset 5994h)
	.db 018h	; "_" - |   ■■   | (offset 5995h)
	.db 080h	; "А" - |■       | (offset 5996h)
	.db 003h	; "_" - |      ■■| (offset 5997h)
	.dw 00100h
	.db 080h	; "А" - |■       | (offset 599Ah)
	.db 004h	; "_" - |     ■  | (offset 599Bh)
	.dw 00100h
	.dw 00180h
	.db 0C0h	; "└" - |■■      | (offset 59A0h)
	.db 002h	; "_" - |      ■ | (offset 59A1h)
	.db 055h	; "U" - | ■ ■ ■ ■| (offset 59A2h)
	.db 055h	; "U" - | ■ ■ ■ ■| (offset 59A3h)
;
D_59A4:	.db 000h	; "_" - |        | (offset 59A4h)
	.db 000h	; "_" - |        | (offset 59A5h)
	.db 003h	; "_" - |      ■■| (offset 59A6h)
	.db 002h	; "_" - |      ■ | (offset 59A7h)
	.db 002h	; "_" - |      ■ | (offset 59A8h)
	.db 002h	; "_" - |      ■ | (offset 59A9h)
	.db 002h	; "_" - |      ■ | (offset 59AAh)
	.db 002h	; "_" - |      ■ | (offset 59ABh)
	.db 002h	; "_" - |      ■ | (offset 59ACh)
	.db 00Eh	; "_" - |    ■■■ | (offset 59ADh)
	.db 004h	; "_" - |     ■  | (offset 59AEh)
	.db 002h	; "_" - |      ■ | (offset 59AFh)
	.db 001h	; "_" - |       ■| (offset 59B0h)
	.db 000h	; "_" - |        | (offset 59B1h)
	.db 000h	; "_" - |        | (offset 59B2h)
	.db 000h	; "_" - |        | (offset 59B3h)
	.db 0E0h	; "р" - |■■■     | (offset 59B4h)
	.db 020h	; " " - |  ■     | (offset 59B5h)
	.db 020h	; " " - |  ■     | (offset 59B6h)
	.db 020h	; " " - |  ■     | (offset 59B7h)
	.db 020h	; " " - |  ■     | (offset 59B8h)
	.db 020h	; " " - |  ■     | (offset 59B9h)
	.db 020h	; " " - |  ■     | (offset 59BAh)
	.db 038h	; "8" - |  ■■■   | (offset 59BBh)
	.db 010h	; "_" - |   ■    | (offset 59BCh)
	.db 020h	; " " - |  ■     | (offset 59BDh)
	.db 040h	; "@" - | ■      | (offset 59BEh)
	.db 080h	; "А" - |■       | (offset 59BFh)
;	
	.db 000h	; "_" - |        | (offset 59C0h)
	.db 004h	; "_" - |     ■  | (offset 59C1h)
	.db 00Ah	; "_" - |    ■ ■ | (offset 59C2h)
	.db 011h	; "_" - |   ■   ■| (offset 59C3h)
	.db 020h	; " " - |  ■     | (offset 59C4h)
	.db 040h	; "@" - | ■      | (offset 59C5h)
	.db 020h	; " " - |  ■     | (offset 59C6h)
	.db 010h	; "_" - |   ■    | (offset 59C7h)
	.db 008h	; "_" - |    ■   | (offset 59C8h)
	.db 004h	; "_" - |     ■  | (offset 59C9h)
	.db 002h	; "_" - |      ■ | (offset 59CAh)
	.db 001h	; "_" - |       ■| (offset 59CBh)
	.db 002h	; "_" - |      ■ | (offset 59CCh)
	.db 007h	; "_" - |     ■■■| (offset 59CDh)
	.db 000h	; "_" - |        | (offset 59CEh)
	.db 000h	; "_" - |        | (offset 59CFh)
	.db 000h	; "_" - |        | (offset 59D0h)
	.db 000h	; "_" - |        | (offset 59D1h)
	.db 080h	; "А" - |■       | (offset 59D2h)
	.db 044h	; "D" - | ■   ■  | (offset 59D3h)
	.db 02Ch	; "," - |  ■ ■■  | (offset 59D4h)
	.db 014h	; "_" - |   ■ ■  | (offset 59D5h)
	.db 004h	; "_" - |     ■  | (offset 59D6h)
	.db 004h	; "_" - |     ■  | (offset 59D7h)
	.db 004h	; "_" - |     ■  | (offset 59D8h)
	.db 004h	; "_" - |     ■  | (offset 59D9h)
	.db 004h	; "_" - |     ■  | (offset 59DAh)
	.db 0FCh	; "№" - |■■■■■■  | (offset 59DBh)
;
	.db 000h	; "_" - |        | (offset 59DCh)
	.db 000h	; "_" - |        | (offset 59DDh)
	.db 000h	; "_" - |        | (offset 59DEh)
	.db 000h	; "_" - |        | (offset 59DFh)
	.db 000h	; "_" - |        | (offset 59E0h)
	.db 03Fh	; "?" - |  ■■■■■■| (offset 59E1h)
	.db 020h	; " " - |  ■     | (offset 59E2h)
	.db 020h	; " " - |  ■     | (offset 59E3h)
	.db 020h	; " " - |  ■     | (offset 59E4h)
	.db 03Fh	; "?" - |  ■■■■■■| (offset 59E5h)
	.db 000h	; "_" - |        | (offset 59E6h)
	.db 000h	; "_" - |        | (offset 59E7h)
	.db 000h	; "_" - |        | (offset 59E8h)
	.db 000h	; "_" - |        | (offset 59E9h)
	.db 000h	; "_" - |        | (offset 59EAh)
	.db 000h	; "_" - |        | (offset 59EBh)
	.db 000h	; "_" - |        | (offset 59ECh)
	.db 020h	; " " - |  ■     | (offset 59EDh)
	.db 030h	; "0" - |  ■■    | (offset 59EEh)
	.db 0E8h	; "ш" - |■■■ ■   | (offset 59EFh)
	.db 004h	; "_" - |     ■  | (offset 59F0h)
	.db 002h	; "_" - |      ■ | (offset 59F1h)
	.db 004h	; "_" - |     ■  | (offset 59F2h)
	.db 0E8h	; "ш" - |■■■ ■   | (offset 59F3h)
	.db 030h	; "0" - |  ■■    | (offset 59F4h)
	.db 020h	; " " - |  ■     | (offset 59F5h)
	.db 000h	; "_" - |        | (offset 59F6h)
	.db 000h	; "_" - |        | (offset 59F7h)
;
	.db 000h	; "_" - |        | (offset 59F8h)
	.db 007h	; "_" - |     ■■■| (offset 59F9h)
	.db 002h	; "_" - |      ■ | (offset 59FAh)
	.db 001h	; "_" - |       ■| (offset 59FBh)
	.db 002h	; "_" - |      ■ | (offset 59FCh)
	.db 004h	; "_" - |     ■  | (offset 59FDh)
	.db 008h	; "_" - |    ■   | (offset 59FEh)
	.db 010h	; "_" - |   ■    | (offset 59FFh)
	.db 020h	; " " - |  ■     | (offset 5A00h)
	.db 040h	; "@" - | ■      | (offset 5A01h)
	.db 020h	; " " - |  ■     | (offset 5A02h)
	.db 011h	; "_" - |   ■   ■| (offset 5A03h)
	.db 00Ah	; "_" - |    ■ ■ | (offset 5A04h)
	.db 004h	; "_" - |     ■  | (offset 5A05h)
	.db 000h	; "_" - |        | (offset 5A06h)
	.db 0FCh	; "№" - |■■■■■■  | (offset 5A07h)
	.db 004h	; "_" - |     ■  | (offset 5A08h)
	.db 004h	; "_" - |     ■  | (offset 5A09h)
	.db 004h	; "_" - |     ■  | (offset 5A0Ah)
	.db 004h	; "_" - |     ■  | (offset 5A0Bh)
	.db 004h	; "_" - |     ■  | (offset 5A0Ch)
	.db 014h	; "_" - |   ■ ■  | (offset 5A0Dh)
	.db 02Ch	; "," - |  ■ ■■  | (offset 5A0Eh)
	.db 044h	; "D" - | ■   ■  | (offset 5A0Fh)
	.db 080h	; "А" - |■       | (offset 5A10h)
	.db 000h	; "_" - |        | (offset 5A11h)
	.db 000h	; "_" - |        | (offset 5A12h)
	.db 000h	; "_" - |        | (offset 5A13h)
;
	.db 000h	; "_" - |        | (offset 5A14h)
	.db 000h	; "_" - |        | (offset 5A15h)
	.db 001h	; "_" - |       ■| (offset 5A16h)
	.db 002h	; "_" - |      ■ | (offset 5A17h)
	.db 004h	; "_" - |     ■  | (offset 5A18h)
	.db 00Eh	; "_" - |    ■■■ | (offset 5A19h)
	.db 002h	; "_" - |      ■ | (offset 5A1Ah)
	.db 002h	; "_" - |      ■ | (offset 5A1Bh)
	.db 002h	; "_" - |      ■ | (offset 5A1Ch)
	.db 002h	; "_" - |      ■ | (offset 5A1Dh)
	.db 002h	; "_" - |      ■ | (offset 5A1Eh)
	.db 002h	; "_" - |      ■ | (offset 5A1Fh)
	.db 003h	; "_" - |      ■■| (offset 5A20h)
	.db 000h	; "_" - |        | (offset 5A21h)
	.db 000h	; "_" - |        | (offset 5A22h)
	.db 080h	; "А" - |■       | (offset 5A23h)
	.db 040h	; "@" - | ■      | (offset 5A24h)
	.db 020h	; " " - |  ■     | (offset 5A25h)
	.db 010h	; "_" - |   ■    | (offset 5A26h)
	.db 038h	; "8" - |  ■■■   | (offset 5A27h)
	.db 020h	; " " - |  ■     | (offset 5A28h)
	.db 020h	; " " - |  ■     | (offset 5A29h)
	.db 020h	; " " - |  ■     | (offset 5A2Ah)
	.db 020h	; " " - |  ■     | (offset 5A2Bh)
	.db 020h	; " " - |  ■     | (offset 5A2Ch)
	.db 020h	; " " - |  ■     | (offset 5A2Dh)
	.db 0E0h	; "р" - |■■■     | (offset 5A2Eh)
	.db 000h	; "_" - |        | (offset 5A2Fh)
;
	.db 000h	; "_" - |        | (offset 5A30h)
	.db 03Fh	; "?" - |  ■■■■■■| (offset 5A31h)
	.db 020h	; " " - |  ■     | (offset 5A32h)
	.db 020h	; " " - |  ■     | (offset 5A33h)
	.db 020h	; " " - |  ■     | (offset 5A34h)
	.db 020h	; " " - |  ■     | (offset 5A35h)
	.db 020h	; " " - |  ■     | (offset 5A36h)
	.db 028h	; "(" - |  ■ ■   | (offset 5A37h)
	.db 034h	; "4" - |  ■■ ■  | (offset 5A38h)
	.db 022h	; """ - |  ■   ■ | (offset 5A39h)
	.db 001h	; "_" - |       ■| (offset 5A3Ah)
	.db 000h	; "_" - |        | (offset 5A3Bh)
	.db 000h	; "_" - |        | (offset 5A3Ch)
	.db 000h	; "_" - |        | (offset 5A3Dh)
	.db 000h	; "_" - |        | (offset 5A3Eh)
	.db 0E0h	; "р" - |■■■     | (offset 5A3Fh)
	.db 040h	; "@" - | ■      | (offset 5A40h)
	.db 080h	; "А" - |■       | (offset 5A41h)
	.db 040h	; "@" - | ■      | (offset 5A42h)
	.db 020h	; " " - |  ■     | (offset 5A43h)
	.db 010h	; "_" - |   ■    | (offset 5A44h)
	.db 008h	; "_" - |    ■   | (offset 5A45h)
	.db 004h	; "_" - |     ■  | (offset 5A46h)
	.db 002h	; "_" - |      ■ | (offset 5A47h)
	.db 004h	; "_" - |     ■  | (offset 5A48h)
	.db 088h	; "И" - |■   ■   | (offset 5A49h)
	.db 050h	; "P" - | ■ ■    | (offset 5A4Ah)
	.db 020h	; " " - |  ■     | (offset 5A4Bh)
;
	.db 000h	; "_" - |        | (offset 5A4Ch)
	.db 000h	; "_" - |        | (offset 5A4Dh)
	.db 000h	; "_" - |        | (offset 5A4Eh)
	.db 002h	; "_" - |      ■ | (offset 5A4Fh)
	.db 006h	; "_" - |     ■■ | (offset 5A50h)
	.db 00Bh	; "_" - |    ■ ■■| (offset 5A51h)
	.db 010h	; "_" - |   ■    | (offset 5A52h)
	.db 020h	; " " - |  ■     | (offset 5A53h)
	.db 010h	; "_" - |   ■    | (offset 5A54h)
	.db 00Bh	; "_" - |    ■ ■■| (offset 5A55h)
	.db 006h	; "_" - |     ■■ | (offset 5A56h)
	.db 002h	; "_" - |      ■ | (offset 5A57h)
	.db 000h	; "_" - |        | (offset 5A58h)
	.db 000h	; "_" - |        | (offset 5A59h)
	.db 000h	; "_" - |        | (offset 5A5Ah)
	.db 000h	; "_" - |        | (offset 5A5Bh)
	.db 000h	; "_" - |        | (offset 5A5Ch)
	.db 000h	; "_" - |        | (offset 5A5Dh)
	.db 000h	; "_" - |        | (offset 5A5Eh)
	.db 0FEh	; "■" - |■■■■■■■ | (offset 5A5Fh)
	.db 002h	; "_" - |      ■ | (offset 5A60h)
	.db 002h	; "_" - |      ■ | (offset 5A61h)
	.db 002h	; "_" - |      ■ | (offset 5A62h)
	.db 0FEh	; "■" - |■■■■■■■ | (offset 5A63h)
	.db 000h	; "_" - |        | (offset 5A64h)
	.db 000h	; "_" - |        | (offset 5A65h)
	.db 000h	; "_" - |        | (offset 5A66h)
	.db 000h	; "_" - |        | (offset 5A67h)
;
	.db 000h	; "_" - |        | (offset 5A68h)
	.db 000h	; "_" - |        | (offset 5A69h)
	.db 000h	; "_" - |        | (offset 5A6Ah)
	.db 000h	; "_" - |        | (offset 5A6Bh)
	.db 001h	; "_" - |       ■| (offset 5A6Ch)
	.db 022h	; """ - |  ■   ■ | (offset 5A6Dh)
	.db 034h	; "4" - |  ■■ ■  | (offset 5A6Eh)
	.db 028h	; "(" - |  ■ ■   | (offset 5A6Fh)
	.db 020h	; " " - |  ■     | (offset 5A70h)
	.db 020h	; " " - |  ■     | (offset 5A71h)
	.db 020h	; " " - |  ■     | (offset 5A72h)
	.db 020h	; " " - |  ■     | (offset 5A73h)
	.db 020h	; " " - |  ■     | (offset 5A74h)
	.db 03Fh	; "?" - |  ■■■■■■| (offset 5A75h)
	.db 000h	; "_" - |        | (offset 5A76h)
	.db 020h	; " " - |  ■     | (offset 5A77h)
	.db 050h	; "P" - | ■ ■    | (offset 5A78h)
	.db 088h	; "И" - |■   ■   | (offset 5A79h)
	.db 004h	; "_" - |     ■  | (offset 5A7Ah)
	.db 002h	; "_" - |      ■ | (offset 5A7Bh)
	.db 004h	; "_" - |     ■  | (offset 5A7Ch)
	.db 008h	; "_" - |    ■   | (offset 5A7Dh)
	.db 010h	; "_" - |   ■    | (offset 5A7Eh)
	.db 020h	; " " - |  ■     | (offset 5A7Fh)
	.db 040h	; "@" - | ■      | (offset 5A80h)
	.db 080h	; "А" - |■       | (offset 5A81h)
	.db 040h	; "@" - | ■      | (offset 5A82h)
	.db 0E0h	; "р" - |■■■     | (offset 5A83h)
;
D_5A84:	.db 001h	; "_" - |       ■| (offset 5A84h)
	.db 003h	; "_" - |      ■■| (offset 5A85h)
	.db 007h	; "_" - |     ■■■| (offset 5A86h)
	.db 00Fh	; "_" - |    ■■■■| (offset 5A87h)
	.db 01Fh	; "_" - |   ■■■■■| (offset 5A88h)
	.db 03Fh	; "?" - |  ■■■■■■| (offset 5A89h)
	.db 07Fh	; "" - | ■■■■■■■| (offset 5A8Ah)
	.db 07Fh	; "" - | ■■■■■■■| (offset 5A8Bh)
	.db 03Fh	; "?" - |  ■■■■■■| (offset 5A8Ch)
	.db 01Fh	; "_" - |   ■■■■■| (offset 5A8Dh)
	.db 00Fh	; "_" - |    ■■■■| (offset 5A8Eh)
	.db 007h	; "_" - |     ■■■| (offset 5A8Fh)
	.db 003h	; "_" - |      ■■| (offset 5A90h)
	.db 001h	; "_" - |       ■| (offset 5A91h)
	.db 080h	; "А" - |■       | (offset 5A92h)
	.db 0C0h	; "└" - |■■      | (offset 5A93h)
	.db 0E0h	; "р" - |■■■     | (offset 5A94h)
	.db 0F0h	; "Ё" - |■■■■    | (offset 5A95h)
	.db 0F8h	; "°" - |■■■■■   | (offset 5A96h)
	.db 0FCh	; "№" - |■■■■■■  | (offset 5A97h)
	.db 0FEh	; "■" - |■■■■■■■ | (offset 5A98h)
	.db 0FEh	; "■" - |■■■■■■■ | (offset 5A99h)
	.db 0FCh	; "№" - |■■■■■■  | (offset 5A9Ah)
	.db 0F8h	; "°" - |■■■■■   | (offset 5A9Bh)
	.db 0F0h	; "Ё" - |■■■■    | (offset 5A9Ch)
	.db 0E0h	; "р" - |■■■     | (offset 5A9Dh)
	.db 0C0h	; "└" - |■■      | (offset 5A9Eh)
	.db 080h	; "А" - |■       | (offset 5A9Fh)
;
D_5AA0:	.db "dvojstik 1"
  	.db "         "
	.db "dvojstik 2"
	.db 000h	; "_" - |        | (offset 5ABDh)
;
D_5ABE:	.db 03Fh	; "?" - |  ■■■■■■| (offset 5ABEh)
	.db 08Dh	; "Н" - |■   ■■ ■| (offset 5ABFh)
	.db 05Fh	; "_" - | ■ ■■■■■| (offset 5AC0h)
	.db 08Dh	; "Н" - |■   ■■ ■| (offset 5AC1h)
	.db 05Fh	; "_" - | ■ ■■■■■| (offset 5AC2h)
	.db 06Dh	; "m" - | ■■ ■■ ■| (offset 5AC3h)
	.db 05Fh	; "_" - | ■ ■■■■■| (offset 5AC4h)
	.db 04Dh	; "M" - | ■  ■■ ■| (offset 5AC5h)
	.db 03Fh	; "?" - |  ■■■■■■| (offset 5AC6h)
	.db 04Dh	; "M" - | ■  ■■ ■| (offset 5AC7h)
	.db 01Fh	; "_" - |   ■■■■■| (offset 5AC8h)
	.db 04Dh	; "M" - | ■  ■■ ■| (offset 5AC9h)
	.db 01Fh	; "_" - |   ■■■■■| (offset 5ACAh)
	.db 06Dh	; "m" - | ■■ ■■ ■| (offset 5ACBh)
	.db 01Fh	; "_" - |   ■■■■■| (offset 5ACCh)
	.db 08Dh	; "Н" - |■   ■■ ■| (offset 5ACDh)
;
D_5ACE:	.dw 00000h
D_5AD0:	.dw 00000h
;
	.db 000h	; "_" - |        | (offset 5AD2h)
;
D_5AD3:	.db 040h	; Палитра
	.db 080h	;
	.db 010h	;
	.db 0D0h	;
	.db 006h	;
	.db 086h	;
	.db 016h	;
	.db 036h	;
	.db 000h	;
	.db 0C5h	;
	.db 022h	;
	.db 006h	;
	.db 002h	;
	.db 098h	;
	.db 036h	;
	.db 036h	;
