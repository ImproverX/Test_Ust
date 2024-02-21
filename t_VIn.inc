L_4AB3:	LXI  B, 00101h	;+
	LXI  H, 0C402h	;+
	CALL    L_226E	; рисование прямоугольника
	MVI  A, 0C7h
	CALL    L_0156
	LXI  H, D_4E40	; вводный текст
	CALL    L_0138
	LXI  H, 00BB8h  ;+
	CALL    L_WHT
	CPI     003h
	JZ      L_4BAA	; прервать тест
L_4ACF:	LXI  B, 00101h	;+
	LXI  H, 0C50Ch	;+
	CALL    L_226E	; рисование прямоугольника
	MVI  A, 007h
	CALL    L_0156
	LXI  B, 0AA1Eh
	LXI  D, 00101h
	LXI  H, D_4CA8	; "200Гц"
	CALL    L_2234	; вывод крупного текста с обрамлением
	LXI  H, 01D4Ch	;+
	CALL    L_4BB8
	CALL    L_4BAC
	MVI  A, 007h
	CALL    L_0156
	LXI  B, 0961Eh
	LXI  D, 00101h
	LXI  H, D_4CBB	; "1000Гц"
	CALL    L_2234	; вывод крупного текста с обрамлением
	LXI  H, 005DCh	;+
	CALL    L_4BB8
	CALL    L_4BAC
	MVI  A, 007h
	CALL    L_0156
	LXI  B, 0821Eh
	LXI  D, 00101h
	LXI  H, D_4CCF	; "10кГц"
	CALL    L_2234	; вывод крупного текста с обрамлением
	LXI  H, 00096h	;+
	CALL    L_4BB8
	CALL    L_4BAC
	CALL    L_0168
	LXI  B, 0140Ah	;+
	LXI  H, 07805h	;+
	CALL    L_226E	; рисование прямоугольника
	MVI  A, 007h
	CALL    L_0156
	LXI  B, 06214h
	LXI  D, 00201h
	LXI  H, D_4CE4	; название музыки
	CALL    L_2234	; вывод крупного текста с обрамлением
	LXI  B, 01D0Fh	;+
	LXI  H, 05A01h	;+
	CALL    L_226E	; рисование прямоугольника
	MVI  A, 078h
	CALL    L_0156
	LXI  B, 03125h	;+
	CALL    L_2220
	LXI  H, D_4CF9	; каналы 1
	CALL    L_0138
	CALL	L_ToVI	; переключить на ВИ
	LXI  H, D_4BC3	; музыка 1
	LXI  D, D_4C13	; музыка 2
	LXI  B, D_4C63	; музыка 3
	CALL    L_0162	; PLAY
	CALL    L_229C	; (далее по кн.)
	LXI  B, 03125h	;+
	CALL    L_2220
	LXI  H, D_4D66	; каналы 2
	CALL    L_0138
	LXI  H, D_4C13	; музыка 2
	LXI  D, D_4BC3	; музыка 1
	LXI  B, D_4C63	; музыка 3
	CALL    L_0162	; PLAY
	CALL    L_229C	; (далее по кн.)
	LXI  B, 03125h	;+
	CALL    L_2220
	LXI  H, D_4DD3	; каналы 3
	CALL    L_0138
	LXI  H, D_4C63	; музыка 3
	LXI  D, D_4C13	; музыка 2
	LXI  B, D_4BC3	; музыка 1
	CALL    L_0162	; PLAY
	CALL    L_229C	; (далее по кн.)
	MVI  A, 008h	; проверка наличия AY
;	MVI  A, 009h
;	MVI  A, 00Ah
	OUT     015h
	IN      015h
	INR  A
	JZ	L_4BA2
	CALL	L_ToAY	; переключить на AY
	LXI  B, 03124h	;+
	CALL    L_2220
	LXI  H, D_TAY1	; каналы AY1
	CALL    L_0138
	LXI  H, D_4BC3	; музыка 1
	LXI  D, D_4C63	; музыка 3
	LXI  B, D_4C13	; музыка 2
	CALL    L_0162	; PLAY
	CALL    L_229C	; (далее по кн.)
	LXI  B, 03124h	;+
	CALL    L_2220
	LXI  H, D_TAY2	; каналы AY2
	CALL    L_0138
	LXI  H, D_4C13	; музыка 2
	LXI  D, D_4C63	; музыка 3
	LXI  B, D_4BC3	; музыка 1
	CALL    L_0162	; PLAY
	CALL    L_229C	; (далее по кн.)
	CALL	L_ToVI	; переключить на ВИ
L_4BA2:	CALL    L_ENTS	;
	CPI     00Dh
	JZ      L_4ACF	; повтор
L_4BAA:	XRA  A
	RET
;
L_4BAC:	LXI  H, 005DCh	;+
	JMP     L_WHT
;
L_4BB8:	MVI  A, 036h
	OUT     008h
	MOV  A, L
	OUT     00Bh
	MOV  A, H
	OUT     00Bh
	RET
;
D_4BC3:	.db "L4 O4 A.G.F.E8.D"
	.db "8.G2.G.F.D.D8.C8.F2.A8.D8."
	.db "D8.C8.C8.O3 A8.D8.O4G8.G2."
	.db "G.D.E.G.F2."
	.db 000h
;
D_4C13:	.db "L4 O4 F.E. O3 A.A+.O4D2.E."
	.db "D.O3A+.A+.O4C2.F8.P.O3A.F8."
	.db "A+.A+2.O4E.O3A+.A+.O4E.C2."
	.db 000h
;
D_4C63:	.db "L4 O4 C2.C.P.O3A+2.O4C.O3A+."
	.db "F.P.A2.O4C8.O3A.F.C8.G.G2."
	.db "O4C.P2.C.O3A2."
	.db 000h
;
D_4CA8:	.db "kanal [0] - 200 gc"
	.db 000h
;
D_4CBB:	.db "kanal [0] - 1000 gc"
	.db 000h
;
D_4CCF:	.db "kanal [0] - 10000 gc"
	.db 000h
;
D_4CE4:	.db "neapolitanskaq pesnq"
	.db 000h
;
D_4CF9:	.db " kanal [0] - soliru`}ij"
	.db " golos "
	.db 00Ah, 00Dh
	.db 00Ah, 00Dh
	.db 018h
	.db 018h
	.db 018h
	.db 018h
	.db 018h
	.db " kanal [1] - wtoroj"
	.db " golos     "
	.db 00Ah, 00Dh
	.db 00Ah, 00Dh
	.db 018h
	.db 018h
	.db 018h
	.db 018h
	.db 018h
	.db " kanal [2] - tretij"
	.db " golos     "
	.db 000h
;
D_4D66:	.db " kanal [0] - wtoroj"
	.db " golos  "
	.db "   "
	.db 00Ah, 00Dh
	.db 00Ah, 00Dh
	.db 018h
	.db 018h
	.db 018h
	.db 018h
	.db 018h
	.db " kanal [1] - soliru`}ij"
	.db " golos "
	.db 00Ah, 00Dh
	.db 00Ah, 00Dh
	.db 018h
	.db 018h
	.db 018h
	.db 018h
	.db 018h
	.db " kanal [2] - tretij"
	.db " golos     "
	.db 000h
;
D_4DD3:	.db " kanal [0] - tretij"
	.db " golos     "
	.db 00Ah, 00Dh
	.db 00Ah, 00Dh
	.db 018h
	.db 018h
	.db 018h
	.db 018h
	.db 018h
	.db " kanal [1] - wtoroj"
	.db " golos     "
	.db 00Ah, 00Dh
	.db 00Ah, 00Dh
	.db 018h
	.db 018h
	.db 018h
	.db 018h
	.db 018h
	.db " kanal [2] - soliru`}ij"
	.db " golos "
	.db 000h
;
D_TAY1:	.db " AY kanal [A] - soliru`}ij"
	.db " golos "
	.db 00Ah, 00Dh
	.db 00Ah, 00Dh
	.db 018h
	.db 018h
	.db 018h
	.db 018h
;	.db 018h
	.db " AY kanal [B] - tretij"
	.db " golos     "
	.db 00Ah, 00Dh
	.db 00Ah, 00Dh
	.db 018h
	.db 018h
	.db 018h
	.db 018h
;	.db 018h
	.db " AY kanal [C] - wtoroj"
	.db " golos     "
	.db 000h
;
D_TAY2:	.db " AY kanal [A] - wtoroj"
	.db " golos     "
	.db 00Ah, 00Dh
	.db 00Ah, 00Dh
	.db 018h
	.db 018h
	.db 018h
	.db 018h
;	.db 018h
	.db " AY kanal [B] - tretij"
	.db " golos     "
	.db 00Ah, 00Dh
	.db 00Ah, 00Dh
	.db 018h
	.db 018h
	.db 018h
	.db 018h
;	.db 018h
	.db " AY kanal [C] - soliru`}ij"
	.db " golos "
	.db 000h
;
D_4E40:	.db 00Ah, 00Dh
	.db 018h
	.db "    prowerka tajmera"
	.db " sostoit w program- "
	.db 00Ah, 00Dh
	.db 018h
	.db " mirowanii  kanala [0]"
	.db " tajmera na wywod "
	.db 00Ah, 00Dh
	.db 018h
	.db " odnoj iz zadannyh ~astot"
	.db ": 200gc,1000gc "
	.db 00Ah, 00Dh
	.db 018h
	.db " i 10000 gc.  kontrolx"
	.db " wypolneniq testa "
	.db 00Ah, 00Dh
	.db 018h
	.db " proizwoditsq oscillografom"
	.db " na kontakte "
	.db 00Ah, 00Dh
	.db 018h
	.db " razxema XS5/B01 i po"
	.db " nali~i` zwukowogo "
	.db 00Ah, 00Dh
	.db 018h
	.db " signala wstroennogo"
	.db " izlu~atelq zwuka.  "
	.db 00Ah, 00Dh
	.db 018h
	.db "    prowerka  wstroennogo"
	.db "  trehgolosogo "
	.db 00Ah, 00Dh
	.db 018h
	.db " muzykalxnogo   sintezatora"
	.db "  sostoit  w "
	.db 00Ah, 00Dh
	.db 018h
	.db " ispolnenii otrywka"
	.db " izwestnogo muzykalx-"
	.db 00Ah, 00Dh
	.db 018h
	.db " nogo proizwedeniq. muzyka"
	.db "  zwu~it  tri "
	.db 00Ah, 00Dh
	.db 018h
	.db " raza  ( izmenqetsq  nomer"
	.db "  soliru`}ego "
	.db 00Ah, 00Dh
	.db 018h
	.db " kanala ) pri |tom ne dolvn"
	.db "o bytx zamet-"
	.db 00Ah, 00Dh
	.db 018h
	.db " no na sluh otli~ij  w kavdom"
	.db "  iz  treh "
	.db 00Ah, 00Dh
	.db 018h
	.db " ispolnenij.               "
	.db "             "
	.db 00Ah, 00Dh
	.db 018h
	.db "    w  slu~ae  obnaruveniq "
	.db " sintezatora "
	.db 00Ah, 00Dh
	.db 018h
	.db " AY8910 na nem budet "
	.db "proigran tot ve ot-"
	.db 00Ah, 00Dh
	.db 018h
	.db " rywok muzykalxnogo "
	.db "proizwedeniq.       "
	.db 000h
