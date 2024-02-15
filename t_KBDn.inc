L_2F83:	MVI  A, 0C7h
	CALL    L_0156
	LXI  H, D_317F	; текст
	CALL    L_0138
	LXI  B, 00F0Ah
	LXI  H, 01901h
	CALL    L_226E	; >> прямоугольник
	LXI  B, 0190Ah
	LXI  H, 0A603h
	CALL    L_226E	; >>
	LXI  B, 07319h
	LXI  H, 0A801h
	CALL    L_226E	; >>
	LXI  B, 0781Eh
	LXI  H, 08908h
	CALL    L_226E	; >>
	MVI  A, 017h
	CALL    L_0156	; >>
	LXI  B, 02C26h
	CALL    L_2220	; >>
	LXI  H, D_VECT	;
	MVI  B, 000h
	LDA  D_TPPC	; тип ПК
	MOV  C, A
	DAD  B		; "Вектор-06ц" / "ПК-6128ц++" (из заставки)
	CALL    L_0138	; >>
	MVI  A, 008h
	CALL    L_0156	; >>
	MVI  H, 063h
	LXI  B, 08D1Eh
L_2FCD:	MVI  A, 001h
	CALL    L_013E	; >>
	PUSH B
	MOV  A, B
	ADI     018h
	MOV  B, A
	MVI  A, 001h
	CALL    L_0141	; >>
	POP  B
	MOV  A, C
	ADI     002h
	MOV  C, A
	DCR  H
	JNZ     L_2FCD
	LXI  H, D_313B
L_2FE8:	MOV  A, M
	INX  H
	CPI     0FFh
	CNZ     L_305D
	JNZ     L_2FE8
	CALL    L_3016
	LXI  H, D_31CF
	MVI  C, 000h
L_2FFA:	MOV  A, M
	CPI     088h
	JZ      L_3013
	JNC     L_3007
	INX  H
	JMP     L_2FFA
;
L_3007:	MVI  M, 0FFh
	INX  H
	CPI     0FEh
	JNZ     L_2FFA
	INR  C
	JMP     L_2FFA
;
L_3013:	MOV  A, C
	ANA  A
	RET
;
L_3016:	LXI  H, 005DCh
L_3019:	EI
	HLT
	EI
	HLT
	DCX  H
	MOV  A, L
	ORA  H
	RZ
	CALL    L_013B	; >>
	CPI     003h
	MOV  C, A
	JNZ     L_302F
	IN      001h
	ANI     040h
	RZ
L_302F:	MOV  A, C
	CPI     0FFh
	JNZ     L_3057
	IN      001h
	ANI     0E0h
	CMP  D
	JZ      L_3019
	MOV  D, A
	MVI  E, 080h
	CPI     0A0h
	JZ      L_3056
	MVI  E, 081h
	CPI     0C0h
	JZ      L_3056
	MVI  E, 082h
	CPI     060h
	JZ      L_3056
	JMP     L_3019
;
L_3056:	MOV  A, E
L_3057:	CALL    L_305D
	JMP     L_3016
;
L_305D:	PUSH H
	PUSH B
	PUSH D
	PUSH PSW
	MOV  B, A
	LXI  H, D_31CF
L_3065:	MOV  A, M
	CPI     088h
	JZ      L_3136
	INX  H
	JC      L_3065
	PUSH H
	POP  D
	INX  H
	INX  H
L_3073:	INX  H
	MOV  A, M
	CMP  B
	JZ      L_3084
	CPI     088h
	JZ      L_3136
	JNC     L_3065
	JMP     L_3073
;
L_3084:	DCX  D
	LDAX D
	PUSH D
	CPI     0FEh
	JNZ     L_308F
	MVI  A, 0F0h
	STAX D
L_308F:	CPI     0FFh
	JNZ     L_30A3
	DCR  A
	STAX D
	MVI  A, 00Fh
	CALL    L_0156	; >>
	POP  D
	LDAX D
	CPI     0FEh
	JZ      L_30C2
	PUSH D
L_30A3:	CPI     0F0h
	JNZ     L_30AD
	MVI  A, 001h
	CALL    L_0156	; >>
L_30AD:	CPI     0F2h
	JNZ     L_30B7
	MVI  A, 00Ah
	CALL    L_0156	; >>
L_30B7:	POP  D
	LDAX D
	ANI     002h
	ADI     002h
	ANI     002h
	ORI     0F0h
	STAX D
L_30C2:	INX  D
	LDAX D
	DCR  A
	MOV  B, A
	ADD  A
	ADD  B
	ADD  A
	ADD  B
	ADD  A
	ADI     020h
	MOV  B, A
	INX  D
	LDAX D
	DCR  A
	ADD  A
	MOV  C, A
	ADD  A
	ADD  C
	ADI     01Ah
	MOV  C, A
	PUSH B
	MVI  A, 001h
	PUSH D
	CALL    L_013E	; >>
	POP  D
	INX  D
	LDAX D
	DCR  A
	ADD  A
	MOV  C, A
	ADD  A
	ADD  C
	SUI     002h
	ADI     01Ah
	MOV  C, A
	MOV  A, B
	ADI     00Ch
	MOV  B, A
	MVI  A, 002h
	CALL    L_0141	; >>
	POP  H
	PUSH B
	PUSH H
	POP  B
	MVI  A, 00Eh
	CALL    L_0156	; >>
	MVI  A, 001h
	CALL    L_0141	; >>
	INR  B
	INR  C
	MVI  A, 001h
	CALL    L_013E	; >>
	PUSH B
	MOV  A, B
	ADI     00Ah
	MOV  B, A
	MVI  A, 001h
	CALL    L_013E	; >>
	POP  B
	INR  B
	INR  C
	MVI  A, 001h
	CALL    L_013E	; >>
	POP  B
	DCR  B
	DCR  B
	DCR  C
	DCR  C
	MVI  A, 001h
	CALL    L_0141	; >>
	INR  B
	INR  C
	MVI  A, 001h
	CALL    L_013E	; >>
	MOV  A, B
	SUI     00Ah
	MOV  B, A
	MVI  A, 001h
	CALL    L_013E	; >>
L_3136:	POP  PSW
	POP  D
	POP  B
	POP  H
	RET
;
D_313B:	.db 02Bh	; "+" - |  ■ ■ ■■| (offset 313Bh)
	.db 07Fh	; "" - | ■■■■■■■| (offset 313Ch)
	.db 02Fh	; "/" - |  ■ ■■■■| (offset 313Dh)
	.db 082h	; "В" - |■     ■ | (offset 313Eh)
	.db 000h	; " " - |        | (offset 313Fh)
	.db 002h	; " " - |      ■ | (offset 3140h)
	.db 008h	; "_" - |    ■   | (offset 3141h)
	.db 018h	; "_" - |   ■■   | (offset 3142h)
	.db 020h	; " " - |  ■     | (offset 3143h)
	.db 080h	; "А" - |■       | (offset 3144h)
	.db 04Ah	; "J" - | ■  ■ ■ | (offset 3145h)
	.db 031h	; "1" - |  ■■   ■| (offset 3146h)
	.db 043h	; "C" - | ■    ■■| (offset 3147h)
	.db 059h	; "Y" - | ■ ■■  ■| (offset 3148h)
	.db 05Eh	; "^" - | ■ ■■■■ | (offset 3149h)
	.db 057h	; "W" - | ■ ■ ■■■| (offset 314Ah)
	.db 04Bh	; "K" - | ■  ■ ■■| (offset 314Bh)
	.db 034h	; "4" - |  ■■ ■  | (offset 314Ch)
	.db 045h	; "E" - | ■   ■ ■| (offset 314Dh)
	.db 050h	; "P" - | ■ ■    | (offset 314Eh)
	.db 049h	; "I" - | ■  ■  ■| (offset 314Fh)
	.db 052h	; "R" - | ■ ■  ■ | (offset 3150h)
	.db 047h	; "G" - | ■   ■■■| (offset 3151h)
	.db 037h	; "7" - |  ■■ ■■■| (offset 3152h)
	.db 05Bh	; "[" - | ■ ■■ ■■| (offset 3153h)
	.db 04Ch	; "L" - | ■  ■■  | (offset 3154h)
	.db 042h	; "B" - | ■    ■ | (offset 3155h)
	.db 044h	; "D" - | ■   ■  | (offset 3156h)
	.db 05Ah	; "Z" - | ■ ■■ ■ | (offset 3157h)
	.db 030h	; "0" - |  ■■    | (offset 3158h)
	.db 048h	; "H" - | ■  ■   | (offset 3159h)
	.db 05Ch	; "\" - | ■ ■■■  | (offset 315Ah)
	.db 00Dh	; "_" - |    ■■ ■| (offset 315Bh)
	.db 00Ah	; "_" - |    ■ ■ | (offset 315Ch)
	.db 081h	; "Б" - |■      ■| (offset 315Dh)
	.db 009h	; "_" - |    ■  ■| (offset 315Eh)
	.db 051h	; "Q" - | ■ ■   ■| (offset 315Fh)
	.db 046h	; "F" - | ■   ■■ | (offset 3160h)
	.db 053h	; "S" - | ■ ■  ■■| (offset 3161h)
	.db 041h	; "A" - | ■     ■| (offset 3162h)
	.db 04Dh	; "M" - | ■  ■■ ■| (offset 3163h)
	.db 054h	; "T" - | ■ ■ ■  | (offset 3164h)
	.db 04Fh	; "O" - | ■  ■■■■| (offset 3165h)
	.db 058h	; "X" - | ■ ■■   | (offset 3166h)
	.db 040h	; "@" - | ■      | (offset 3167h)
	.db 056h	; "V" - | ■ ■ ■■ | (offset 3168h)
	.db 02Ch	; "," - |  ■ ■■  | (offset 3169h)
	.db 03Ah
	.db 02Dh
	.db 02Eh	; "." - |  ■ ■■■ | (offset 316Ch)
	.db 032h	; "2" - |  ■■  ■ | (offset 316Dh)
	.db 033h	; "3" - |  ■■  ■■| (offset 316Eh)
	.db 055h	; "U" - | ■ ■ ■ ■| (offset 316Fh)
	.db 04Eh	; "N" - | ■  ■■■ | (offset 3170h)
	.db 036h	; "6" - |  ■■ ■■ | (offset 3171h)
	.db 035h	; "5" - |  ■■ ■ ■| (offset 3172h)
	.db 05Dh	; "]" - | ■ ■■■ ■| (offset 3173h)
	.db 038h	; "8" - |  ■■■   | (offset 3174h)
	.db 039h	; "9" - |  ■■■  ■| (offset 3175h)
	.db 001h	; "_" - |       ■| (offset 3176h)
	.db 004h	; "_" - |     ■  | (offset 3177h)
	.db 019h	; "_" - |   ■■  ■| (offset 3178h)
	.db 01Ah	; "_" - |   ■■ ■ | (offset 3179h)
	.db 01Bh	; "_" - |   ■■ ■■| (offset 317Ah)
	.db 00Ch
	.db 003h
	.db 01Fh	; "_" - |   ■■■■■| (offset 317Dh)
	.db 0FFh	; " " - |■■■■■■■■| (offset 317Eh)
;
D_317F:	.db 018h, 018h
	.db " wnimanie!  klawi{i "
	.db 022h	; "
	.db "wwod"
	.db 022h	; "
	.db ","
	.db 022h	; "
	.db "bl"
	.db 022h	; "
	.db ","
	.db 022h	; "
	.db "sbr"
	.db 022h	; "
	.db " "
	.db 00Ah, 00Dh, 018h, 018h, 018h
	.db 018h, 018h, 018h
	.db "  n e   n a v i m a t x  !!!  "
	.db 007h, 000h
;
D_31CF:	.db 0FFh	; " " - |■■■■■■■■| (offset 31CFh)
	.db 005h	; "_" - |     ■ ■| (offset 31D0h)
	.db 001h	; "_" - |       ■| (offset 31D1h)
	.db 003h	; "_" - |      ■■| (offset 31D2h)
	.db 03Bh	; ";" - |  ■■■ ■■| (offset 31D3h)
	.db 02Bh	; "+" - |  ■ ■ ■■| (offset 31D4h)
	.db 0FFh	; " " - |■■■■■■■■| (offset 31D5h)
	.db 005h	; "_" - |     ■ ■| (offset 31D6h)
	.db 003h	; "_" - |      ■■| (offset 31D7h)
	.db 005h	; "_" - |     ■ ■| (offset 31D8h)
	.db 031h	; "1" - |  ■■   ■| (offset 31D9h)
	.db 021h	; "!" - |  ■    ■| (offset 31DAh)
	.db 0FFh	; " " - |■■■■■■■■| (offset 31DBh)
	.db 005h	; "_" - |     ■ ■| (offset 31DCh)
	.db 005h	; "_" - |     ■ ■| (offset 31DDh)
	.db 007h	; "_" - |     ■■■| (offset 31DEh)
	.db 032h	; "2" - |  ■■  ■ | (offset 31DFh)
	.db 022h	; """ - |  ■   ■ | (offset 31E0h)
	.db 0FFh	; " " - |■■■■■■■■| (offset 31E1h)
	.db 005h	; "_" - |     ■ ■| (offset 31E2h)
	.db 007h	; "_" - |     ■■■| (offset 31E3h)
	.db 009h	; "_" - |    ■  ■| (offset 31E4h)
	.db 033h	; "3" - |  ■■  ■■| (offset 31E5h)
	.db 023h	; "#" - |  ■   ■■| (offset 31E6h)
	.db 0FFh	; " " - |■■■■■■■■| (offset 31E7h)
	.db 005h	; "_" - |     ■ ■| (offset 31E8h)
	.db 009h	; "_" - |    ■  ■| (offset 31E9h)
	.db 00Bh	; "_" - |    ■ ■■| (offset 31EAh)
	.db 034h	; "4" - |  ■■ ■  | (offset 31EBh)
	.db 024h	; "$" - |  ■  ■  | (offset 31ECh)
	.db 0FFh	; " " - |■■■■■■■■| (offset 31EDh)
	.db 005h	; "_" - |     ■ ■| (offset 31EEh)
	.db 00Bh	; "_" - |    ■ ■■| (offset 31EFh)
	.db 00Dh	; "_" - |    ■■ ■| (offset 31F0h)
	.db 035h	; "5" - |  ■■ ■ ■| (offset 31F1h)
	.db 025h	; "%" - |  ■  ■ ■| (offset 31F2h)
	.db 0FFh	; " " - |■■■■■■■■| (offset 31F3h)
	.db 005h	; "_" - |     ■ ■| (offset 31F4h)
	.db 00Dh	; "_" - |    ■■ ■| (offset 31F5h)
	.db 00Fh	; "_" - |    ■■■■| (offset 31F6h)
	.db 036h	; "6" - |  ■■ ■■ | (offset 31F7h)
	.db 026h	; "&" - |  ■  ■■ | (offset 31F8h)
	.db 0FFh	; " " - |■■■■■■■■| (offset 31F9h)
	.db 005h	; "_" - |     ■ ■| (offset 31FAh)
	.db 00Fh	; "_" - |    ■■■■| (offset 31FBh)
	.db 011h	; "_" - |   ■   ■| (offset 31FCh)
	.db 037h	; "7" - |  ■■ ■■■| (offset 31FDh)
	.db 027h	; "'" - |  ■  ■■■| (offset 31FEh)
	.db 0FFh	; " " - |■■■■■■■■| (offset 31FFh)
	.db 005h
	.db 011h
	.db 013h	; "_" - |   ■  ■■| (offset 3202h)
	.db 038h	; "8" - |  ■■■   | (offset 3203h)
	.db 028h	; "(" - |  ■ ■   | (offset 3204h)
	.db 0FFh	; " " - |■■■■■■■■| (offset 3205h)
	.db 005h
	.db 013h
	.db 015h	; "_" - |   ■ ■ ■| (offset 3208h)
	.db 039h	; "9" - |  ■■■  ■| (offset 3209h)
	.db 029h	; ")" - |  ■ ■  ■| (offset 320Ah)
	.db 0FFh	; " " - |■■■■■■■■| (offset 320Bh)
	.db 005h	; "_" - |     ■ ■| (offset 320Ch)
	.db 015h	; "_" - |   ■ ■ ■| (offset 320Dh)
	.db 017h	; "_" - |   ■ ■■■| (offset 320Eh)
	.db 030h	; "0" - |  ■■    | (offset 320Fh)
	.db 0FFh	; " " - |■■■■■■■■| (offset 3210h)
	.db 005h	; "_" - |     ■ ■| (offset 3211h)
	.db 017h	; "_" - |   ■ ■■■| (offset 3212h)
	.db 019h	; "_" - |   ■■  ■| (offset 3213h)
	.db 02Dh	; "-" - |  ■ ■■ ■| (offset 3214h)
	.db 03Dh	; "=" - |  ■■■■ ■| (offset 3215h)
	.db 0FFh	; " " - |■■■■■■■■| (offset 3216h)
	.db 005h	; "_" - |     ■ ■| (offset 3217h)
	.db 019h	; "_" - |   ■■  ■| (offset 3218h)
	.db 01Bh	; "_" - |   ■■ ■■| (offset 3219h)
	.db 02Fh	; "/" - |  ■ ■■■■| (offset 321Ah)
	.db 03Fh	; "?" - |  ■■■■■■| (offset 321Bh)
	.db 0FFh	; " " - |■■■■■■■■| (offset 321Ch)
	.db 004h	; "_" - |     ■  | (offset 321Dh)
	.db 002h
	.db 004h
	.db 04Ah	; "J" - | ■  ■ ■ | (offset 3220h)
	.db 06Ah	; "j" - | ■■ ■ ■ | (offset 3221h)
	.db 0FFh	; " " - |■■■■■■■■| (offset 3222h)
	.db 004h	; "_" - |     ■  | (offset 3223h)
	.db 004h
	.db 006h
	.db 043h	; "C" - | ■    ■■| (offset 3226h)
	.db 063h	; "c" - | ■■   ■■| (offset 3227h)
	.db 0FFh	; " " - |■■■■■■■■| (offset 3228h)
	.db 004h
	.db 006h
	.db 008h	; "_" - |    ■   | (offset 322Bh)
	.db 055h	; "U" - | ■ ■ ■ ■| (offset 322Ch)
	.db 075h	; "u" - | ■■■ ■ ■| (offset 322Dh)
	.db 0FFh	; " " - |■■■■■■■■| (offset 322Eh)
	.db 004h	; "_" - |     ■  | (offset 322Fh)
	.db 008h	; "_" - |    ■   | (offset 3230h)
	.db 00Ah	; "_" - |    ■ ■ | (offset 3231h)
	.db 04Bh	; "K" - | ■  ■ ■■| (offset 3232h)
	.db 06Bh	; "k" - | ■■ ■ ■■| (offset 3233h)
	.db 0FFh	; " " - |■■■■■■■■| (offset 3234h)
	.db 004h	; "_" - |     ■  | (offset 3235h)
	.db 00Ah	; "_" - |    ■ ■ | (offset 3236h)
	.db 00Ch	; "_" - |    ■■  | (offset 3237h)
	.db 045h	; "E" - | ■   ■ ■| (offset 3238h)
	.db 065h	; "e" - | ■■  ■ ■| (offset 3239h)
	.db 0FFh	; " " - |■■■■■■■■| (offset 323Ah)
	.db 004h	; "_" - |     ■  | (offset 323Bh)
	.db 00Ch	; "_" - |    ■■  | (offset 323Ch)
	.db 00Eh	; "_" - |    ■■■ | (offset 323Dh)
	.db 04Eh	; "N" - | ■  ■■■ | (offset 323Eh)
	.db 06Eh	; "n" - | ■■ ■■■ | (offset 323Fh)
	.db 0FFh	; " " - |■■■■■■■■| (offset 3240h)
	.db 004h	; "_" - |     ■  | (offset 3241h)
	.db 00Eh	; "_" - |    ■■■ | (offset 3242h)
	.db 010h	; "_" - |   ■    | (offset 3243h)
	.db 047h	; "G" - | ■   ■■■| (offset 3244h)
	.db 067h	; "g" - | ■■  ■■■| (offset 3245h)
	.db 0FFh	; " " - |■■■■■■■■| (offset 3246h)
	.db 004h	; "_" - |     ■  | (offset 3247h)
	.db 010h	; "_" - |   ■    | (offset 3248h)
	.db 012h	; "_" - |   ■  ■ | (offset 3249h)
	.db 05Bh	; "[" - | ■ ■■ ■■| (offset 324Ah)
	.db 07Bh	; "{" - | ■■■■ ■■| (offset 324Bh)
	.db 0FFh	; " " - |■■■■■■■■| (offset 324Ch)
	.db 004h	; "_" - |     ■  | (offset 324Dh)
	.db 012h	; "_" - |   ■  ■ | (offset 324Eh)
	.db 014h	; "_" - |   ■ ■  | (offset 324Fh)
	.db 05Dh	; "]" - | ■ ■■■ ■| (offset 3250h)
	.db 07Dh	; "}" - | ■■■■■ ■| (offset 3251h)
	.db 0FFh	; " " - |■■■■■■■■| (offset 3252h)
	.db 004h	; "_" - |     ■  | (offset 3253h)
	.db 014h	; "_" - |   ■ ■  | (offset 3254h)
	.db 016h	; "_" - |   ■ ■■ | (offset 3255h)
	.db 05Ah	; "Z" - | ■ ■■ ■ | (offset 3256h)
	.db 07Ah	; "z" - | ■■■■ ■ | (offset 3257h)
	.db 0FFh	; " " - |■■■■■■■■| (offset 3258h)
	.db 004h	; "_" - |     ■  | (offset 3259h)
	.db 016h	; "_" - |   ■ ■■ | (offset 325Ah)
	.db 018h	; "_" - |   ■■   | (offset 325Bh)
	.db 048h	; "H" - | ■  ■   | (offset 325Ch)
	.db 068h	; "h" - | ■■ ■   | (offset 325Dh)
	.db 0FFh	; " " - |■■■■■■■■| (offset 325Eh)
	.db 004h	; "_" - |     ■  | (offset 325Fh)
	.db 018h	; "_" - |   ■■   | (offset 3260h)
	.db 01Ah	; "_" - |   ■■ ■ | (offset 3261h)
	.db 03Ah	; ":" - |  ■■■ ■ | (offset 3262h)
	.db 02Ah	; "*" - |  ■ ■ ■ | (offset 3263h)
	.db 0FFh	; " " - |■■■■■■■■| (offset 3264h)
	.db 004h	; "_" - |     ■  | (offset 3265h)
	.db 01Dh	; "_" - |   ■■■ ■| (offset 3266h)
	.db 01Fh	; "_" - |   ■■■■■| (offset 3267h)
	.db 000h	; "_" - |        | (offset 3268h)
	.db 0FFh	; " " - |■■■■■■■■| (offset 3269h)
	.db 004h	; "_" - |     ■  | (offset 326Ah)
	.db 01Fh	; "_" - |   ■■■■■| (offset 326Bh)
	.db 021h	; "!" - |  ■    ■| (offset 326Ch)
	.db 001h	; "_" - |       ■| (offset 326Dh)
	.db 0FFh	; " " - |■■■■■■■■| (offset 326Eh)
	.db 004h	; "_" - |     ■  | (offset 326Fh)
	.db 021h	; "!" - |  ■    ■| (offset 3270h)
	.db 023h	; "#" - |  ■   ■■| (offset 3271h)
	.db 002h	; "_" - |      ■ | (offset 3272h)
	.db 0FFh	; " " - |■■■■■■■■| (offset 3273h)
	.db 003h
	.db 001h
	.db 003h	; "_" - |      ■■| (offset 3276h)
	.db 080h	; "А" - |■       | (offset 3277h)
	.db 0FFh	; " " - |■■■■■■■■| (offset 3278h)
	.db 003h
	.db 003h
	.db 005h	; "_" - |     ■ ■| (offset 327Bh)
	.db 046h	; "F" - | ■   ■■ | (offset 327Ch)
	.db 066h	; "f" - | ■■  ■■ | (offset 327Dh)
	.db 0FFh	; " " - |■■■■■■■■| (offset 327Eh)
	.db 003h	; "_" - |      ■■| (offset 327Fh)
	.db 005h	; "_" - |     ■ ■| (offset 3280h)
	.db 007h	; "_" - |     ■■■| (offset 3281h)
	.db 059h	; "Y" - | ■ ■■  ■| (offset 3282h)
	.db 079h	; "y" - | ■■■■  ■| (offset 3283h)
	.db 0FFh	; " " - |■■■■■■■■| (offset 3284h)
	.db 003h	; "_" - |      ■■| (offset 3285h)
	.db 007h	; "_" - |     ■■■| (offset 3286h)
	.db 009h	; "_" - |    ■  ■| (offset 3287h)
	.db 057h	; "W" - | ■ ■ ■■■| (offset 3288h)
	.db 077h	; "w" - | ■■■ ■■■| (offset 3289h)
	.db 0FFh	; " " - |■■■■■■■■| (offset 328Ah)
	.db 003h	; "_" - |      ■■| (offset 328Bh)
	.db 009h	; "_" - |    ■  ■| (offset 328Ch)
	.db 00Bh	; "_" - |    ■ ■■| (offset 328Dh)
	.db 041h	; "A" - | ■     ■| (offset 328Eh)
	.db 061h	; "a" - | ■■    ■| (offset 328Fh)
	.db 0FFh	; " " - |■■■■■■■■| (offset 3290h)
	.db 003h	; "_" - |      ■■| (offset 3291h)
	.db 00Bh	; "_" - |    ■ ■■| (offset 3292h)
	.db 00Dh	; "_" - |    ■■ ■| (offset 3293h)
	.db 050h	; "P" - | ■ ■    | (offset 3294h)
	.db 070h	; "p" - | ■■■    | (offset 3295h)
	.db 0FFh	; " " - |■■■■■■■■| (offset 3296h)
	.db 003h	; "_" - |      ■■| (offset 3297h)
	.db 00Dh	; "_" - |    ■■ ■| (offset 3298h)
	.db 00Fh	; "_" - |    ■■■■| (offset 3299h)
	.db 052h	; "R" - | ■ ■  ■ | (offset 329Ah)
	.db 072h	; "r" - | ■■■  ■ | (offset 329Bh)
	.db 0FFh	; " " - |■■■■■■■■| (offset 329Ch)
	.db 003h	; "_" - |      ■■| (offset 329Dh)
	.db 00Fh	; "_" - |    ■■■■| (offset 329Eh)
	.db 011h	; "_" - |   ■   ■| (offset 329Fh)
	.db 04Fh	; "O" - | ■  ■■■■| (offset 32A0h)
	.db 06Fh	; "o" - | ■■ ■■■■| (offset 32A1h)
	.db 0FFh	; " " - |■■■■■■■■| (offset 32A2h)
	.db 003h	; "_" - |      ■■| (offset 32A3h)
	.db 011h	; "_" - |   ■   ■| (offset 32A4h)
	.db 013h	; "_" - |   ■  ■■| (offset 32A5h)
	.db 04Ch	; "L" - | ■  ■■  | (offset 32A6h)
	.db 06Ch	; "l" - | ■■ ■■  | (offset 32A7h)
	.db 0FFh	; " " - |■■■■■■■■| (offset 32A8h)
	.db 003h	; "_" - |      ■■| (offset 32A9h)
	.db 013h	; "_" - |   ■  ■■| (offset 32AAh)
	.db 015h	; "_" - |   ■ ■ ■| (offset 32ABh)
	.db 044h	; "D" - | ■   ■  | (offset 32ACh)
	.db 064h	; "d" - | ■■  ■  | (offset 32ADh)
	.db 0FFh	; " " - |■■■■■■■■| (offset 32AEh)
	.db 003h	; "_" - |      ■■| (offset 32AFh)
	.db 015h	; "_" - |   ■ ■ ■| (offset 32B0h)
	.db 017h	; "_" - |   ■ ■■■| (offset 32B1h)
	.db 056h	; "V" - | ■ ■ ■■ | (offset 32B2h)
	.db 076h	; "v" - | ■■■ ■■ | (offset 32B3h)
	.db 0FFh	; " " - |■■■■■■■■| (offset 32B4h)
	.db 003h	; "_" - |      ■■| (offset 32B5h)
	.db 017h	; "_" - |   ■ ■■■| (offset 32B6h)
	.db 019h	; "_" - |   ■■  ■| (offset 32B7h)
	.db 05Ch	; "\" - | ■ ■■■  | (offset 32B8h)
	.db 07Ch	; "|" - | ■■■■■  | (offset 32B9h)
	.db 0FFh	; " " - |■■■■■■■■| (offset 32BAh)
	.db 003h	; "_" - |      ■■| (offset 32BBh)
	.db 019h	; "_" - |   ■■  ■| (offset 32BCh)
	.db 01Bh	; "_" - |   ■■ ■■| (offset 32BDh)
	.db 02Eh	; "." - |  ■ ■■■ | (offset 32BEh)
	.db 03Eh	; ">" - |  ■■■■■ | (offset 32BFh)
	.db 0FFh	; " " - |■■■■■■■■| (offset 32C0h)
	.db 003h	; "_" - |      ■■| (offset 32C1h)
	.db 01Dh	; "_" - |   ■■■ ■| (offset 32C2h)
	.db 01Fh	; "_" - |   ■■■■■| (offset 32C3h)
	.db 003h	; "_" - |      ■■| (offset 32C4h)
	.db 0FFh	; " " - |■■■■■■■■| (offset 32C5h)
	.db 003h	; "_" - |      ■■| (offset 32C6h)
	.db 01Fh	; "_" - |   ■■■■■| (offset 32C7h)
	.db 021h	; "!" - |  ■    ■| (offset 32C8h)
	.db 004h	; "_" - |     ■  | (offset 32C9h)
	.db 0FFh	; " " - |■■■■■■■■| (offset 32CAh)
	.db 003h	; "_" - |      ■■| (offset 32CBh)
	.db 021h	; "!" - |  ■    ■| (offset 32CCh)
	.db 023h	; "#" - |  ■   ■■| (offset 32CDh)
	.db 01Bh	; "_" - |   ■■ ■■| (offset 32CEh)
	.db 0FFh	; " " - |■■■■■■■■| (offset 32CFh)
	.db 002h	; "_" - |      ■ | (offset 32D0h)
	.db 001h	; "_" - |       ■| (offset 32D1h)
	.db 004h	; "_" - |     ■  | (offset 32D2h)
	.db 081h	; "Б" - |■      ■| (offset 32D3h)
	.db 0FFh	; " " - |■■■■■■■■| (offset 32D4h)
	.db 002h
	.db 004h
	.db 006h	; "_" - |     ■■ | (offset 32D7h)
	.db 051h	; "Q" - | ■ ■   ■| (offset 32D8h)
	.db 071h	; "q" - | ■■■   ■| (offset 32D9h)
	.db 0FFh	; " " - |■■■■■■■■| (offset 32DAh)
	.db 002h	; "_" - |      ■ | (offset 32DBh)
	.db 006h	; "_" - |     ■■ | (offset 32DCh)
	.db 008h	; "_" - |    ■   | (offset 32DDh)
	.db 05Eh	; "^" - | ■ ■■■■ | (offset 32DEh)
	.db 07Eh	; "~" - | ■■■■■■ | (offset 32DFh)
	.db 0FFh	; " " - |■■■■■■■■| (offset 32E0h)
	.db 002h	; "_" - |      ■ | (offset 32E1h)
	.db 008h	; "_" - |    ■   | (offset 32E2h)
	.db 00Ah	; "_" - |    ■ ■ | (offset 32E3h)
	.db 053h	; "S" - | ■ ■  ■■| (offset 32E4h)
	.db 073h	; "s" - | ■■■  ■■| (offset 32E5h)
	.db 0FFh	; " " - |■■■■■■■■| (offset 32E6h)
	.db 002h	; "_" - |      ■ | (offset 32E7h)
	.db 00Ah	; "_" - |    ■ ■ | (offset 32E8h)
	.db 00Ch	; "_" - |    ■■  | (offset 32E9h)
	.db 04Dh	; "M" - | ■  ■■ ■| (offset 32EAh)
	.db 06Dh	; "m" - | ■■ ■■ ■| (offset 32EBh)
	.db 0FFh	; " " - |■■■■■■■■| (offset 32ECh)
	.db 002h	; "_" - |      ■ | (offset 32EDh)
	.db 00Ch	; "_" - |    ■■  | (offset 32EEh)
	.db 00Eh	; "_" - |    ■■■ | (offset 32EFh)
	.db 049h	; "I" - | ■  ■  ■| (offset 32F0h)
	.db 069h	; "i" - | ■■ ■  ■| (offset 32F1h)
	.db 0FFh	; " " - |■■■■■■■■| (offset 32F2h)
	.db 002h	; "_" - |      ■ | (offset 32F3h)
	.db 00Eh	; "_" - |    ■■■ | (offset 32F4h)
	.db 010h	; "_" - |   ■    | (offset 32F5h)
	.db 054h	; "T" - | ■ ■ ■  | (offset 32F6h)
	.db 074h	; "t" - | ■■■ ■  | (offset 32F7h)
	.db 0FFh	; " " - |■■■■■■■■| (offset 32F8h)
	.db 002h	; "_" - |      ■ | (offset 32F9h)
	.db 010h	; "_" - |   ■    | (offset 32FAh)
	.db 012h	; "_" - |   ■  ■ | (offset 32FBh)
	.db 058h	; "X" - | ■ ■■   | (offset 32FCh)
	.db 078h	; "x" - | ■■■■   | (offset 32FDh)
	.db 0FFh	; " " - |■■■■■■■■| (offset 32FEh)
	.db 002h
	.db 012h
	.db 014h	; "_" - |   ■ ■  | (offset 3301h)
	.db 042h	; "B" - | ■    ■ | (offset 3302h)
	.db 062h	; "b" - | ■■   ■ | (offset 3303h)
	.db 0FFh	; " " - |■■■■■■■■| (offset 3304h)
	.db 002h	; "_" - |      ■ | (offset 3305h)
	.db 014h	; "_" - |   ■ ■  | (offset 3306h)
	.db 016h	; "_" - |   ■ ■■ | (offset 3307h)
	.db 040h	; "@" - | ■      | (offset 3308h)
	.db 060h	; "`" - | ■■     | (offset 3309h)
	.db 0FFh	; " " - |■■■■■■■■| (offset 330Ah)
	.db 002h	; "_" - |      ■ | (offset 330Bh)
	.db 016h	; "_" - |   ■ ■■ | (offset 330Ch)
	.db 018h	; "_" - |   ■■   | (offset 330Dh)
	.db 02Ch	; "," - |  ■ ■■  | (offset 330Eh)
	.db 03Ch	; "<" - |  ■■■■  | (offset 330Fh)
	.db 0FFh	; " " - |■■■■■■■■| (offset 3310h)
	.db 002h	; "_" - |      ■ | (offset 3311h)
	.db 018h	; "_" - |   ■■   | (offset 3312h)
	.db 01Bh	; "_" - |   ■■ ■■| (offset 3313h)
	.db 00Dh	; "_" - |    ■■ ■| (offset 3314h)
	.db 0FFh	; " " - |■■■■■■■■| (offset 3315h)
	.db 002h	; "_" - |      ■ | (offset 3316h)
	.db 01Dh	; "_" - |   ■■■ ■| (offset 3317h)
	.db 01Fh	; "_" - |   ■■■■■| (offset 3318h)
	.db 00Ch	; "_" - |    ■■  | (offset 3319h)
	.db 0FFh	; " " - |■■■■■■■■| (offset 331Ah)
	.db 002h	; "_" - |      ■ | (offset 331Bh)
	.db 01Fh	; "_" - |   ■■■■■| (offset 331Ch)
	.db 021h	; "!" - |  ■    ■| (offset 331Dh)
	.db 019h	; "_" - |   ■■  ■| (offset 331Eh)
	.db 0FFh	; " " - |■■■■■■■■| (offset 331Fh)
	.db 002h	; "_" - |      ■ | (offset 3320h)
	.db 021h	; "!" - |  ■    ■| (offset 3321h)
	.db 023h	; "#" - |  ■   ■■| (offset 3322h)
	.db 01Fh	; "_" - |   ■■■■■| (offset 3323h)
	.db 0FFh
	.db 001h
	.db 001h	; "_" - |       ■| (offset 3326h)
	.db 004h	; "_" - |     ■  | (offset 3327h)
	.db 082h	; "В" - |■     ■ | (offset 3328h)
	.db 0FFh
	.db 001h
	.db 004h
	.db 006h
	.db 009h	; "_" - |    ■  ■| (offset 332Dh)
	.db 0FFh
	.db 001h
	.db 006h	; "_" - |     ■■ | (offset 3330h)
	.db 016h	; "_" - |   ■ ■■ | (offset 3331h)
	.db 020h	; " " - |  ■     | (offset 3332h)
	.db 0FFh
	.db 001h
	.db 016h	; "_" - |   ■ ■■ | (offset 3335h)
	.db 018h	; "_" - |   ■■   | (offset 3336h)
	.db 00Ah	; "_" - |    ■ ■ | (offset 3337h)
	.db 0FFh
	.db 001h
	.db 018h	; "_" - |   ■■   | (offset 333Ah)
	.db 01Bh	; "_" - |   ■■ ■■| (offset 333Bh)
	.db 07Fh	; "" - | ■■■■■■■| (offset 333Ch)
	.db 0FFh
	.db 001h
	.db 01Dh	; "_" - |   ■■■ ■| (offset 333Fh)
	.db 01Fh	; "_" - |   ■■■■■| (offset 3340h)
	.db 008h	; "_" - |    ■   | (offset 3341h)
	.db 0FFh
	.db 001h
	.db 01Fh	; "_" - |   ■■■■■| (offset 3344h)
	.db 021h	; "!" - |  ■    ■| (offset 3345h)
	.db 01Ah	; "_" - |   ■■ ■ | (offset 3346h)
	.db 0FFh
	.db 001h
	.db 021h	; "!" - |  ■    ■| (offset 3349h)
	.db 023h	; "#" - |  ■   ■■| (offset 334Ah)
	.db 018h	; "_" - |   ■■   | (offset 334Bh)
	.db 088h	; "И" - |■   ■   | (offset 334Ch)
