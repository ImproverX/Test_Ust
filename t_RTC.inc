L_R000:	LXI  B, 00101h	;+
	LXI  H, 0C402h	;+
	CALL    L_226E	; рисование прямоугольника
	XRA  A
	STA	D_RTCE	; запись "нет ошибки" (для повтора)
	OUT     020h	; читаем регистр 0 -- секунды
	IN      021h
	INR  A
	JNZ	L_RTME	; >>> из порта часов прочитано не FF
	MVI  A, 0C7h
	CALL    L_0156
;	LXI  B, 02923h	;+
;	CALL    L_2220	; установка курсора
	MVI  A, 001h
	STA	D_RTCE	; запись "ошибка"
	LXI  H, D_RTCN	; "часы не подключены"
L_RBA3:	CALL    L_0138	; вывод текста
	MVI  A, 078h
	CALL    L_0156
	CALL    L_ENTS	;
	CPI     00Dh
	JZ      L_R000	; повтор теста
L_RBAA:	LDA	D_RTCE
	RET
;
L_RTME:	LXI  H, 03A98h
	SHLD    D_25FE	; счётчик ожидания
	CALL	L_RDTE	; проверка значений с занесением
;	JNZ	L_TNAS	; >>
	MVI  A, 0C7h
	STA	D_DCHG	; для принудительного вывода даты
	CALL    L_0156
	LXI  H, D_RE40	; текст
	CALL    L_0138
	MVI  A, 078h
	CALL    L_0156
	LXI  H, D_ENTT	; текст нижней строки
	CALL    L_0138
;	LXI  B, 02923h	;+
;	CALL    L_2220	; установка курсора
	LXI  B, 04332h
	LXI  H, 09A0Dh
	CALL	L_226E	; прямоугольник под часами
	LDA	D_RTCE
	ORA  A		; код ошибки
	JZ	L_RTM
	MVI  A, 0C7h	; неправильные значения
	CALL    L_0156
	LXI  H, D_RTCS	; "часы не настроены"
	CALL    L_0138	; вывод текста
L_RTM:	MVI  A, 00Dh	;00Eh
	CALL    L_0156
	LXI  B, 096C4h	;+
	MVI  A, 001h
	CALL    L_013E
	LXI  B, 07D97h	;+
	LDA	D_DCHG
	ORA  A
	JZ	L_RT0
	MVI  B, 047h	;05Fh	; увеличиваем закраску, если дата изменилась
L_RT0:	LDA	D_MCHG
	ORA  A
	JZ	L_RT1
	MVI  C, 03Dh	; увеличиваем закраску, если минуты изменились
L_RT1:	MVI  A, 002h
	CALL    L_0141
	XRA  A		;MVI  A, 000h
	CALL    L_0156	; цвет
	LXI  B, 0803Eh	;+
	MVI  A, 002h
	CALL    L_013E	; установить граф.курсор
	LXI  B, 00302h	;+
	MVI  A, 003h
	CALL    L_0141	; увеличенный текст
	LXI  H, D_RHH
	CALL    L_0138	; вывод времени
;	LXI  H, D_ESTR	; конец текста
	LDA	D_DCHG
	ORA  A
	JZ	L_RT3	; пропускаем вывод даты
	LXI  B, 0603Eh	;+
	MVI  A, 002h
	CALL    L_013E	; установить граф.курсор
	LXI  H, D_RDD
	CALL    L_0138	; вывод даты
	LXI  B, 04846h	;+
	MVI  A, 002h
	CALL    L_013E	; установить граф.курсор
	LXI  B, 00201h	;+
	MVI  A, 003h
	CALL    L_0141	; увеличенный текст
	LHLD	D_DND
	CALL    L_0138	; вывод дня недели
L_RT3:	LXI  H, D_ESTR	; конец текста
	CALL    L_0138	;
L_RWHT:	HLT
	EI
	CALL    L_013B
	CPI     003h	; "F4" / "УС"+"С"
	JZ      L_RBAA	; >>>
	CPI     00Dh	; "ВК"
	JZ      L_R000	; повтор	>>
	CPI     020h	; " "
	JZ	L_RSET	; смена даты/времени >>
	CALL	L_RDTE	; читаем время из часов
	LHLD    D_25FE	;
	DCX  H
	MOV  A, H
	ORA  L
	JZ	L_RBAA	; >> выход по таймеру
	SHLD    D_25FE	;	
L_RT4:	LDA	D_TCHG
	ORA  A
	JZ	L_RWHT	; цикл ожидания
	JMP	L_RTM	;
;
L_RDTE:	LXI  H, D_RHH	; <<< проверка значений часов с занесением
	MVI  C, 004h	; часы
	CALL	L_RDTM
	MOV  A, B
	CPI	024h
	CNC	L_TERR	; >> неверная настройка часов
	INX  H		; D_RMM
	MVI  C, 002h	; минуты
	CALL	L_RDTM
	LDA	D_MOLD	; старые минуты
	SUB  B
	STA	D_MCHG	; метка изменения минут
	MOV  A, B
	STA	D_MOLD	; сохраняем минуты
	CPI	060h
	CNC	L_TERR	; >> неверная настройка часов
	INX  H		; D_RSS
	MVI  C, 000h	; секунды
	CALL	L_RDTM
	LDA	D_SOLD	; старые секунды
	SUB  B
	STA	D_TCHG	; метка изменения секунд
	MOV  A, B
	STA	D_SOLD	; сохраняем секунды
	CPI	060h
	CNC	L_TERR	; >> неверная настройка часов
	INX  H		; D_RDD
	MVI  C, 007h	; день
	CALL	L_RDTM
	LDA	D_DOLD	; старый день
	SUB  B
	STA	D_DCHG	; метка изменения дня
	MOV  A, B
	STA	D_DOLD	; сохраняем день
	DCR  A
	CPI	031h
	CNC	L_TERR	; >> неверная настройка часов
;	ORA  A
;	CZ	L_TERR	; >> неверная настройка часов
	INX  H		; D_RMD
	MVI  C, 008h	; месяц
	CALL	L_RDTM
	MOV  A, B
	DCR  A
	CPI	012h
	CNC	L_TERR	; >> неверная настройка часов
;	ORA  A
;	CZ	L_TERR	; >> неверная настройка часов
	INX  H		; D_RYY
	MVI  C, 009h	; год
	CALL	L_RDTM
	MOV  A, B
	CPI	09Ah
	CNC	L_TERR	; >> неверная настройка часов
	INX  H		; D_DND
	MVI  C, 006h	; день недели
	CALL	L_RDTM
	MOV  A, B
	DCR  A
	CPI	007h
	CNC	L_TERR	; >> неверная настройка часов
;	ORA  A
;	CZ	L_TERR	; >> неверная настройка часов
	LXI  D, 0000Ch
	LXI  H, D_DND1-0000Ch
L_RDN:	DAD  D
	DCR  B
	JNZ	L_RDN
	SHLD 	D_DND	; сохраняем день недели
	RET
;	
L_TERR:	MVI  A, 001h
	STA	D_RTCE	; запись "ошибка"
	RET
;
L_RDTM:	MVI  B, 050h	; чтение даты/времени
L_E07E:	DCR  B
	RM		; >> S=1 (знак)
	MVI  A, 00Ah
	OUT     020h
	IN      021h
	RAL
	JC      L_E07E	;>
	MOV  A, C
	OUT     020h
	IN      021h
	MOV  B, A	; запись числа
	RRC
	RRC
	RRC
	RRC
	CALL	M_HCHR
	MOV  A, B
M_HCHR:	ANI     00Fh
	ADI     030h
	MOV  M, A
	INX  H
	RET
;
; ======================= установка часов
L_RSET:	LXI  B, 00503h	;+
	LXI  H, 04206h	;+
	CALL    L_226E	; рисование прямоугольника
	MVI  A, 0C7h
	CALL    L_0156
	LXI  H, D_RSET
	CALL    L_0138
	LXI  B, 03431h	;+
L_RDT:	CALL	L_GDEC	; день (1-31)
	STA	D_NDT
	JZ	L_RDT0	; не меняется
	DCR  A
	CPI	031h
	JNC	L_RDT
;	LXI  B, 03531h	;+
L_RDT0:	INR  B
L_RMM:	CALL	L_GDEC	; месяц (1-12)
	STA	D_NMM
	JZ	L_RMM0	; не меняется
	DCR  A
	CPI	012h
	JNC	L_RMM
;	LXI  B, 03631h	;+
L_RMM0:	INR  B
	CALL	L_GDEC	; год (0-99)
	STA	D_NYY
	LXI  B, 03736h	;+
L_RDW:	CALL	L_GDEC	; день недели (1-7)
	STA	D_NDW
	JZ	L_RDW0	; не меняется
	DCR  A
	CPI	007h
	JNC	L_RDW
L_RDW0:	LXI  B, 03445h	;+
L_RHR:	CALL	L_GDEC	; час (0-23)
	STA	D_NHR
	JZ	L_RHR0	; не меняется
	CPI	024h
	JNC	L_RHR
;	LXI  B, 03545h	;+
L_RHR0:	INR  B
L_RMN:	CALL	L_GDEC	; минуты (0-59)
	STA	D_NMN
	JZ	L_RMN0	; не меняется
	CPI	060h
	JNC	L_RMN
;	LXI  B, 03645h	;+
L_RMN0:	INR  B
L_RSC:	CALL	L_GDEC	; секунды (0-59)
	STA	D_NSC
	JZ	L_RSC0	; не меняется
	CPI	060h
	JNC	L_RSC
L_RSC0:	LXI  H, 0260Ah	; начало установки часов
	CALL    L_E0C0
	LXI  H, 0820Bh	;
	CALL    L_E0C0
	LXI  D, D_SSSS	; таблица с кодами для установки
	LXI  B, D_NDT	; таблица с новыми значениями
L_E340:	LDAX B
	INX  B
	MOV  H, A
	CPI     0F0h
	LDAX D
	INX  D
	MOV  L, A
	JZ	L_E340	; >> значение не меняется
	ORA  A
	CP      L_E0C0	; 
	JP      L_E340	; >> далее...
	LXI  H, 0020Bh	;
	CALL	L_E0C0	; завершение записи значений
	JMP	L_R000
;	
L_E0C0:	MOV  A, L
	OUT     020h
	MOV  A, H
	OUT     021h
	RET
;
L_GDE0:	POP  B
L_GDEC:	PUSH B
	CALL    L_2220
	LXI  H, D_RSE0	; пробелы для затирки
	CALL    L_0138	; вывод текста
;	POP  B
;	PUSH B
;	CALL    L_2220	; установка курсора
;	MVI  B, 000h
	LXI  H, 000F0h
L_GDE2:	CALL    L_0132	; чтение кода клавиатуры
	CPI     00Dh	; <ВК>?
	JNZ	L_GDE1
	POP  B
	MOV  A, L
	CPI	0F0h
	RET	
;	
L_GDE1:	MOV  C, A
	SUI	030h
	JM	L_GDE0	; >> код < 2Fh и > B0h
	CPI	00Ah
	JNC	L_GDE0	; >> код >= 3Ah
	PUSH PSW
	CALL    L_0129	; вывод символа
	POP  PSW
	DAD  H
	DAD  H
	DAD  H
	DAD  H		; x16
	JC      L_GDE0
	ADD  L
	MOV  L, A
	JMP     L_GDE2	
;
D_RHH:	.db "88"
	.db ":"
D_RMM:	.db "88"	
	.db ":"
D_RSS:	.db "88"
	.db 000h
D_RDD:	.db "88"	
	.db "/"
D_RMD:	.db "88"	
	.db "/"
D_RYY:	.db "88"	
	.db 000h
D_DND:	.dw D_DND1	;"-----------"
D_ESTR:	.db 00Dh, 00Ah	; (дальше норм.текст)
	.db 01Bh, 059h, 029h, 023h
	.db 000h
;
D_TCHG:	.db 0FFh	; метки "время изменилось"
D_SOLD:	.db 0FFh
D_MCHG:	.db 0FFh
D_MOLD:	.db 0FFh
D_DCHG:	.db 0FFh
D_DOLD:	.db 0FFh
D_RTCE:	.db 000h	; код возврата
;
D_NDT:	.db 0F0h
D_NMM:	.db 0F0h
D_NYY:	.db 0F0h
D_NDW:	.db 0F0h
D_NHR:	.db 0F0h
D_NMN:	.db 0F0h
D_NSC:	.db 0F0h
;
D_SSSS:	.db 007h	; день
	.db 008h	; месяц
	.db 009h	; год
	.db 006h	; день недели
	.db 004h	; часы
	.db 002h	; минуты
	.db 000h	; секунды
	.db 0FFh	;
;
D_DND1:	.db "ponedelxnik", 000h
D_DND2:	.db "  wtornik  ", 000h
D_DND3:	.db "   sreda   ", 000h
D_DND4:	.db "  ~etwerg  ", 000h
D_DND5:	.db "  pqtnica  ", 000h
D_DND6:	.db "  subbota  ", 000h
D_DND7:	.db "woskresenxe", 000h
;
D_RTCN:	.db 01Bh, 059h, 029h, 023h
	.db "  podkl`~enie ~asow ne"
	.db " obnaruveno!  "
	.db 000h
;
D_RTCS:	.db 01Bh, 059h, 034h, 023h
	.db "   nekorrektnoe zna~enie"
	.db " wremeni!   "
	.db 000h
;
D_RE40:	.db 01Bh, 059h, 027h, 021h	;020h, 018h
	.db "        teku}ie pokazaniq"
	.db " ~asow         "
	.db 000h
;
D_ENTT:	.db 01Bh, 059h, 038h, 021h
	.db "<probel>-ust.wr.,"
	.db "<wk>-powt.,"
	.db "<us+C>-dalee"
	.db 01Bh, 059h, 027h, 021h, 000h
;
D_RSET:	.db 01Bh, 059h, 033h, 021h
	.db " wwedite nowoe zna~enie"
	.db " (<wk>-ne izm.): "
	.db 00Ah, 00Dh
	.db 018h, " denx  (1..31):     "
	.db 018h, " ~as  (0..23):     "
	.db 00Ah, 00Dh
	.db 018h, " mesqc (1..12):     "
	.db 018h, " min. (0..59):     "
	.db 00Ah, 00Dh			
	.db 018h, " god  (00..99):     "
	.db 018h, " sek. (0..59):     "
	.db 00Ah, 00Dh			
	.db 018h, " denx nedeli (1..7): "
D_RSE0:	.db "    ", 008h, 008h, 008h, 008h
	.db 000h
;
