L_6400:	LXI  B, 05A04h	;+
	LXI  H, 0B902h	;+
	CALL    L_226E
	MVI  A, 0C7h
	CALL    L_0156
	LXI  H, D_6403
	CALL    L_0138
	LXI  H, 00BB8h  ;+
        CALL    L_WHT
	XRA  A
	RET
;
D_6403:	.db 00Ah	; "_" - |    ■ ■ | (offset 6403h)
	.db 00Ah	; "_" - |    ■ ■ | (offset 6404h)
	.db 018h
	.db "    test dopolnitelxnyh"
	.db " ustrojstw :     "
	.db 00Ah, 00Dh
	.db 018h
	.db " processory,magnitnye"
	.db " diski, i dr. movet"
	.db 00Ah, 00Dh
	.db 018h
	.db " bytx wkl`~en w bazowyj"
	.db " nabor testow.   "
	.db 00Ah, 00Dh
	.db 018h
	.db "    dlq |togo ego"
	.db " neobhodimo dozagruzitx"
	.db 00Ah, 00Dh
	.db 018h
	.db " s adresa 0"
	.db (L_6400 / 01000h) + 30h
	.db ((L_6400 / 0100h) % 10h) + 37h	; +30h для <=9
	.db "00H "
	.db "s wne{nego zapomina`}e-"
	.db 00Ah, 00Dh
	.db 018h
	.db " go ustrojstwa, n"
	.db "aprimer s magnitofona  "
	.db 00Ah, 00Dh
	.db 018h
	.db " (sm."
	.db 022h	; "
	.db "rukowodstwo polxzowatelq"
	.db 022h	; "
	.db ")."
	.db 000h
	.db 000h
