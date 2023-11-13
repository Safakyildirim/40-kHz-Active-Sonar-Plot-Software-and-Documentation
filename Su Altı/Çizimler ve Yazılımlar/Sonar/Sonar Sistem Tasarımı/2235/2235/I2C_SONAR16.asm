;  Sonar range finder program w/ I2C interface
;  Processor will send 16 pulses @ 40KHz to transducer when I2C '\r' byte is received

;  Joe Bradshaw		11-18-02
;			03-01-04 - Started I2C version for final SMD board
;			03-03-04 - Added AN1 input from LM34 for temperature/sound speed comp.
;			03-05-04 - Developed TMR0 temperature compensation lookup table
;			05-07-04 - Finished writing SSP Handler and Calibrated delay
;
;Timer Delay routine X = -((T) / (1/(20000000/4) * Prescaler)) + 65556
;X = 16bit hexadecimal value to load into TH_COUNT and TL_COUNT
;T = Time in seconds to delay (eg. 20us = .00002)
; desired time is divided by the reciprical of the oscillator frequency
; divided by clocks per inst. cycle, multiplied by the prescaler. Then add 
; 65556 (16bits max plus subroutine # of instructions.
	__config _CP_OFF & _LVP_OFF & _BODEN_OFF & _WDT_OFF & _HS_OSC & _PWRTE_OFF & _DEBUG_OFF;

	list	p=16f876A, r=dec
	#include	p16f876A.inc

samples			equ	0x20	;Counts the samples
new_pulse		equ	0x21	;Stores width of current sonar pulse
old_pulse		equ	0x22	;Stores width of last significant sonar pulse
last_str		equ	0x23	;The last signal strength sampled
temperature		equ	0x24	;stores output from LM34 (F temp sensor) 
Temp			equ	0x25	;Temporary storage register
i2c_rec_buf		equ	0x26	;Temporary I2C PIC read result from I2C Master
i2c_txm_buf		equ	0x27	;Temporary I2C PIC write result from I2C Master
son_flag		equ	0x28	;Flag to indicate sonar go
cnt				equ	0x29	;General Counter register
NumH			equ	0x2a	;A3*16+A2
NumL			equ	0x2b	;A1*16+A0
inch_l			equ	0x2c	;Low byte of total inches accumulated
inch_h			equ	0x2d	;High byte of total inches accumulated
max_str			equ	0x2e	;Largest signals position during receive time
new_str			equ	0x2f	;Last a2d sample's signal strength
targ_dist_l		equ	0x30	;Low byte of targets distance in inches
targ_dist_h		equ	0x31	;High byte of targets distance in inches
temp			equ	0x32	;Temporary storage register

acq_temp		equ	0x71	;Temporary Storage register
timeVL			equ	0x72	;Low value register used for time delay
TenK			equ	0x73	;B4
Thou			equ	0x74	;B3
Hund			equ	0x75	;B2
Tens			equ	0x76	;B1
Ones			equ	0x77	;B0
NULL			equ	0x78	;NULL = '\0';
timeVH			equ	0x79	;High value register used for time delay
W_TEMP			equ	0x7a	;Temporary W register
STATUS_TEMP		equ	0x7b	;Temporary STATUS register
flags			equ	0x7c	;Flag register

	org	0
	nop
	goto	start
;--------------------------------------------------------------------
	org	4
	goto	isr
start
	banksel	ADCON1
	movlw	0x0e		;Left justified, AN0 is analog,8bit conversion
	movwf	ADCON1		;Remaining port A pins are digital I/O
	
	banksel	ADCON0
	bsf	ADCON0, ADON	;turn AD module ON	

	banksel	T2CON
	movlw	0x78		;Postscalar=1:16, TMR2=OFF, Prescaler=1:1
	movwf	T2CON

	banksel	PR2
	movlw	124		;Sets period, 124 @20Mhz = 40Khz 
	movwf	PR2		;[(124 + 1) * 4 * (1/20MHz) * 1] = 40KHz
				; or 25us period.
	
	banksel	TRISA
	movlw	0xff		;Port A bit 0 is AD605 input, bit 1 = LM34 input
	movwf	TRISA		;

	banksel	TRISB		
	clrf	TRISB		;All Port B pins are outputs (to alphanumeric
				; display)

	banksel	TRISC
	movlw	b'10111000'	;PORTC inputs are bit 7 RX, and bit 5 (trigger pushbutton),
	movwf	TRISC		; bit3 SCL(I2C), bit4 SDA(I2C),bit2 PWM(40KHz)

	banksel	CCPR1L
	movlw	0		;Set initial PWM duty cycle at 0%
	movwf	CCPR1L

	banksel	SSPCON
	movlw	0x36		;setup SSP module for 7-bit address
	movwf	SSPCON

	banksel	SSPADD
	movlw	0xa2		;PIC's I2C address is 0xa2
	movwf	SSPADD

	banksel	SSPSTAT		
	clrf	SSPSTAT

	banksel	PIR1
	bcf	PIR1, TMR2IF	;Clear TMR2 and PR2 match flag. This will
				; become set when TMR2 to PR2 match occurs
				; (15 pulses have completed)

	banksel	CCP1CON
	movlw	0x0f		;Set for PWM mode
	movwf	CCP1CON

	banksel	T2CON		;Turn off timer 2
	bcf	T2CON, TMR2ON

	banksel	STATUS
	bcf		son_flag, 0	;

	banksel	NULL
	movlw	'\0';
	movwf	NULL
	
	banksel	PORTB
	bsf		PORTB, 0	;Turn ON LED

	movlw	40
	movwf	cnt

LED_Time
	movlw	0x0B		;Delay 25ms
	movwf	timeVH
	movlw	0xF0
	movwf	timeVL
	call	time_delay
	
	decfsz	cnt
	goto	LED_Time

	banksel	cnt
	clrf	cnt			;Clear General Counter
main
	banksel	PORTB
	clrf	PORTB

	banksel	PIE1
	bsf	PIE1, SSPIE

	banksel	INTCON
	bcf	INTCON, T0IE	
	bcf	INTCON, T0IF
	bsf	INTCON, PEIE	;enable all peripheral interrupts
	bsf	INTCON, GIE		;enable global interrupts

	banksel	PIR1
	bcf	PIR1, SSPIF

wait_go
;	banksel	PORTC
;	btfsc	PORTC, 5	;If pushbutton is active, start sonar
;	goto	check_son_flag
;sample_now
;	call	sample_sonar
;	goto	main

check_son_flag
	banksel	son_flag
	btfss	son_flag, 0	;If flag was set, start sonar
	goto	chk_nxt_flg
	call	sample_sonar
	banksel	son_flag
	bcf		son_flag, 0
	goto	main
chk_nxt_flg
	btfss	son_flag, 1	;Not Implemented in current version
	goto	wait_go
	;Start from main
	bcf		son_flag, 1
	goto	main

sample_sonar
	banksel	PORTB
	bsf		PORTB, 0	;Set PORTB bit 0 LED
	banksel	INTCON
	bcf	INTCON, T0IE	
	bcf	INTCON, T0IF
	bcf	INTCON, PEIE	;disable all peripheral interrupts

	banksel	ADCON1
	bcf	ADCON1, ADFM	;Left Justified
	banksel	ADCON0
	bcf	ADCON0, CHS2			
	bcf	ADCON0, CHS1
	bcf	ADCON0, CHS0		;ch0
	bsf	ADCON0, ADON	;turn AD module ON	
;-------------------------------------------------------------------
	banksel	targ_dist_l
	clrf	targ_dist_l	;Clear all variables
	clrf	targ_dist_h
	clrf	max_str
	clrf	new_str
	clrf	last_str
	clrf	inch_h

	banksel	inch_l
	movlw	1		;start inches with 1
	movwf	inch_l

	banksel	CCPR1L
	movlw	50		;63 = ~50%dc
	movwf	CCPR1L		;Sets duty cycle

	banksel	T2CON
	bsf	T2CON, TMR2ON	;Start PWM
	bcf	PIR1, 1		;Clear TMR2 and PR2 match flag

; This process of transmitting the 16 pulses takes approximatly .5ms
pulses_done
	btfss	PIR1, TMR2IF	;Skip next instruction when match occurs
	goto	pulses_done	;Remain in loop until match (16 pulses) occurs

	movlw	0		;0%dc
	movwf	CCPR1L		;Sets duty cycle

; Use time delay to settle receive line after sonar burst. Total of
; .5ms to transmit 16 40KHz pulses and 1ms to debounce.
 
	movlw	0xEC		;Set up time_delay for 1ms delay (see comment)
	movwf	timeVH
	movlw	0x95
	movwf	timeVL
	call	time_delay	;Yeild 1ms pulse @ 20MHz clock

;At this point in the start sonar loop approximatly 1.38ms should have passed.
; or 6886 cycles.
;	banksel	TMR0
;	movf	TMR0_val, W	;Start TMR0 with initial delay time value
	movlw	76
	movwf	TMR0		;adjust to allow code and sonar 2 in time

	banksel	OPTION_REG	
	movlw	b'10000001'	;Setup Timer 0 1:4prescaler
	movwf	OPTION_REG

	banksel	INTCON		
	bsf	INTCON, T0IE	;Enable Timer 0 interrupt
	bsf	INTCON, GIE	;Enable Global interrupts
	bcf	INTCON, T0IF	;Clear the Timer 0 interrupt flag
	call	adconvert	;Do an analog to digital conversion
	movwf	last_str	;Move initial value to last_str register
record_samples
	call	adconvert	;Do an analog to digital conversion
	movwf	new_str		;Move analog result to new_str register
	movlw	0x02		;Load 0x02 in W
	subwf	inch_h, w	;Subtract 0x02 from inches high byte (inch_h)
	btfss	STATUS, Z	;Skip next instruction if ZERO flag is set
	goto	record_samples	;Continue to find max dist. of largest object 
	movlw	0x58		;Load 0x58 in W
	subwf	inch_l, w	;Subtract 0x58 from inches low byte (inch_l)
	btfss	STATUS, Z	;Skip next instruction if ZERO flag is set
	goto	record_samples	;Continue to find max dist. of largest object

	banksel	INTCON		;Disable all interrupts
	bcf	INTCON, T0IE
	bcf	INTCON, GIE
	bcf	INTCON, T0IF

	banksel	STATUS		;Point to bank 0
	movf	targ_dist_l, W	;Move target distance (inches that had the
				; maximum analog return value) to W
	addlw	3		;Offset, distance sound travels during pulses
				; and 1ms damping 387.6us
				; 1387.6us/74.07us = 18.7in
				; 18.7/2 = 9in to target
	btfss	STATUS, C	;Skip next instruction if CARRY flag is set
	goto	finish_main_loop


	incf	targ_dist_h
	movlw	0x02
	subwf	targ_dist_h, W
	btfss	STATUS, Z
	goto	finish_main_loop

	movf	targ_dist_l, W		;Load 
	sublw	0x58
	
	btfsc	STATUS, Z
	goto	max_dist
	
	movf	targ_dist_l, W
	movwf	NumL		;Move W into NumL register

finish_main_loop
;				;********* Will need to add routine to determine that 
;				; another 3 added to targ_dist_l will not exeed max value
;				; (decimal 9999 or 0x270f) so maximum range can
;				; be acheived.
;
	banksel	NumH
	movf	targ_dist_l, W	;Load target distance low byte (targ_dist_l) in W
	movwf	NumL		;Store targ_dist_l value with added 3 offset to NumL register

	movf	targ_dist_h, W	;Load target distance high byte (targ_dist_h) in W
	movwf	NumH

	goto	exit_main
max_dist
	movlw	0x02
	movwf	NumL
	movlw	0x58
	movwf	NumH
exit_main

	bcf	flags, 0
	
	call	bin_to_bcd	;Converts 16-bit targ_dist to bcd for transmission
;	movf	max_str, W	;load max strength in W
;	call	dec_to_bcd	;Converts 8-bit max_str to bcd for transmission
	call	bcd_to_ASCII;Convert the BCD result to ASCII characters

	banksel	PORTB
	bcf		PORTB, 0	;Clear LED

	return
;-----------------------------------------------------------------------
;===================================================================
bin_to_bcd
	banksel	TenK
;Takes hex number in NumH:NumL  Returns decimal in ;TenK:Thou:Hund:Tens:Ones
;written by John Payson

;input
;=A3*163 + A2*162 + A1*161 + A0*160
;=A3*4096 + A2*256 + A1*16 + A0
;NumH            EQU AD3M        ;A3*16+A2
;NumL            EQU AD3L	;A1*16+A0
;share variables
;=B4*104 + B3*103 + B2*102 + B1*101 + B0*100
;=B4*10000 + B3*1000 + B2*100 + B1*10 + B0
;TenK            EQU LOOPER      ;B4
;Thou            EQU D2		;B3
;Hund            EQU D1		;B2
;Tens            EQU R2		;B1
;Ones            EQU R1		;B0
	clrf	TenK
	clrf	Thou
	clrf	Hund
	clrf	Tens
	clrf	Ones

	swapf	NumH,w	;w  = A2*16+A3
        andlw   0x0F     ;w  = A3		*** PERSONALLY, I'D REPLACE THESE 2
        addlw   0xF0	;w  = A3-16	*** LINES WITH "IORLW b'11110000B' " -AW
        movwf   Thou	;B3 = A3-16
        addwf   Thou,f	;B3 = 2*(A3-16) = 2A3 - 32
        addlw   .226	;w  = A3-16 - 30 = A3-46
        movwf   Hund	;B2 = A3-46
        addlw   .50	;w  = A3-46 + 50 = A3+4
        movwf   Ones	;B0 = A3+4

        movf    NumH,w	;w  = A3*16+A2
        andlw   0x0F	;w  = A2
        addwf   Hund,f	;B2 = A3-46 + A2 = A3+A2-46
        addwf   Hund,f	;B2 = A3+A2-46  + A2 = A3+2A2-46
        addwf   Ones,f	;B0 = A3+4 + A2 = A3+A2+4
        addlw   .233	;w  = A2 - 23
        movwf   Tens	;B1 = A2-23
        addwf   Tens,f	;B1 = 2*(A2-23)
        addwf   Tens,f	;B1 = 3*(A2-23) = 3A2-69 (Doh! thanks NG)

        swapf   NumL,w	;w  = A0*16+A1
        andlw   0x0F	;w  = A1
        addwf   Tens,f	;B1 = 3A2-69 + A1 = 3A2+A1-69 range -69...-9
        addwf   Ones,f	;B0 = A3+A2+4 + A1 = A3+A2+A1+4 and Carry = 0 (thanks NG)

        rlf     Tens,f	;B1 = 2*(3A2+A1-69) + C = 6A2+2A1-138 and Carry is now 1 as tens register had to be negitive
        rlf     Ones,f	;B0 = 2*(A3+A2+A1+4) + C = 2A3+2A2+2A1+9 (+9 not +8 due to the carry from prev line, Thanks NG)
        comf    Ones,f	;B0 = ~(2A3+2A2+2A1+9) = -2A3-2A2-2A1-10 (ones complement plus 1 is twos complement. Thanks SD)
;;Nikolai Golovchenko [golovchenko at MAIL.RU] says: comf can be regarded like:
;;      comf Ones, f
;;      incf Ones, f
;;      decf Ones, f
;;First two instructions make up negation. So,
;;Ones  = -1 * Ones - 1 
;;      = - 2 * (A3 + A2 + A1) - 9 - 1 
;;      = - 2 * (A3 + A2 + A1) - 10
        rlf     Ones,f	;B0 = 2*(-2A3-2A2-2A1-10) = -4A3-4A2-4A1-20

        movf    NumL,w	;w  = A1*16+A0
        andlw   0x0F	;w  = A0
        addwf   Ones,f	;B0 = -4A3-4A2-4A1-20 + A0 = A0-4(A3+A2+A1)-20 range -215...-5 Carry=0
        rlf     Thou,f	;B3 = 2*(2A3 - 32) = 4A3 - 64

        movlw   0x07	;w  = 7
        movwf   TenK	;B4 = 7

;B0 = A0-4(A3+A2+A1)-20	;-5...-200
;B1 = 6A2+2A1-138	;-18...-138
;B2 = A3+2A2-46		;-1...-46
;B3 = 4A3-64		;-4...-64
;B4 = 7			;7
; At this point, the original number is
; equal to TenK*10000+Thou*1000+Hund*100+Tens*10+Ones 
; if those entities are regarded as two's compliment 
; binary.  To be precise, all of them are negative 
; except TenK.  Now the number needs to be normal- 
; ized, but this can all be done with simple byte 
; arithmetic.

        movlw   .10	;w  = 10
Lb1:			;do
        addwf   Ones,f	; B0 += 10
        decf    Tens,f	; B1 -= 1
        btfss   3,0
	;skip no carry
         goto   Lb1	; while B0 < 0
	;jmp carry
Lb2:			;do
        addwf   Tens,f	; B1 += 10
        decf    Hund,f	; B2 -= 1
        btfss   3,0
         goto   Lb2	; while B1 < 0
Lb3:			;do
        addwf   Hund,f	; B2 += 10
        decf    Thou,f	; B3 -= 1
        btfss   3,0
         goto   Lb3	; while B2 < 0
Lb4:			;do
        addwf   Thou,f	; B3 += 10
        decf    TenK,f	; B4 -= 1
        btfss   3,0
        goto   Lb4	; while B3 < 0

        retlw   0
;-------------------------------------------------------------------
bcd_to_ASCII
	banksel	TenK
	movlw	0x30
	addwf	TenK, F
	addwf	Thou, F
	addwf	Hund, F
	addwf	Tens, F
	addwf	Ones, F
	return
;---------28.4us total routine time --------------------------
adconvert
	banksel	ADCON0

;	bsf	ADCON0, ADON		;turn AD module ON	
	bsf	ADCON0, ADCS1	
	bsf	ADCON0, ADCS0		;clock select - RC

	banksel	STATUS
	movlw	33		;yeilds a 20us acquisition time at 20MHz
	movwf	acq_temp
doneacq
	decfsz	acq_temp, F
	goto	doneacq
	
	banksel	ADCON0
	bsf	ADCON0, GO_DONE
wt_adc
	btfsc	ADCON0, GO_DONE
	goto	wt_adc
;	banksel	ADCON0
;	bcf	ADCON0, ADON		;Turn A/D module off

	banksel	ADRESH
	movf	ADRESH, W		;store A/D result in W

	return
;---- 20cycles -----------------------------------------------------
time_delay
	banksel	T1CON		;(2cy)
	clrf	T1CON		;(1cy)
	
	banksel	T1CON		;(1cy)

	movf	timeVH, W	;(1cy)
	movwf	TMR1H		;(1cy)
	movf	timeVL, W	;(1cy)
	movwf	TMR1L		;(1cy)
	bsf		T1CON, TMR1ON	;(1cy)start counting

	banksel	PIE1		;(2cy)
	bcf		PIE1, TMR1IE	;(1cy)disable Timer1 interrupt
	banksel	PIR1		;(2cy)
overflow_done
 	btfss	PIR1, TMR1IF	;???
 	goto	overflow_done	;???
	banksel	T1CON		;(2cy)
	bcf		T1CON, TMR1ON	;(1cy)
	bcf		PIR1, TMR1IF	;(1cy)
	return			;(2cy)
;-------------------------------------------------------------------
isr
	movwf	W_TEMP		;Save current W and Status register contents
	swapf	STATUS, W
	bcf		STATUS, RP0
	movwf	STATUS_TEMP

	banksel	PIR1
	btfss	PIR1, SSPIF	;Did I2C Byte cause In
	goto	TMR0_int
	call	SSP_Handler
	banksel	PIR1
	bcf		PIR1, SSPIF
	goto	exit_isr
TMR0_int
;	banksel	TMR0		;Yeilds an interrupt time of ...
;	movf	TMR0_val, W
	movlw	76
	movwf	TMR0

	banksel	INTCON
	bcf		INTCON, T0IF	;Clear the Timer 0 interrupt flag
	banksel	STATUS		
	movf	last_str, W	;Move last_str register value to W
	addwf	new_str, F	;Add last sample and new sample, then divide
	rrf		new_str, F	; by two to attain the average

	movf	max_str, W	;Load max_str into W
	subwf	new_str, W	;Subtract avg_str from max_str, carry will be
				; set if new averaged value is greater
				; then previous largest signals value.
	btfss	STATUS, C	;If subtractions result resulted in a negative
				; number, the new value is greater
	goto	no_new_value	;In result is not negative, the new value is
				; not greater
record_new_value
	movf	inch_l, W	;Move current inch_l value into W
	movwf	targ_dist_l	;Record current inch_l to targ_distance_l

	movf	inch_h, W	;Move current inch_h value into W
	movwf	targ_dist_h	;Record current inch_h to targ_distance_h

	movf	new_str, W	;Move new_str register value to W
	movwf	max_str		;Record the new_str register value as the 
				; maximum strength signal received

no_new_value			;This is done regardless if new sample was
				; greater or not
	movf	new_str, W	;Move new_str into W
	movwf	last_str	;Move W into the last_str register

	incfsz	inch_l, F	;Increment the inch_l register
	goto	exit_isr
	incfsz	inch_h, F	;Increment the inch_h register
	goto	exit_isr
	
	;If the High byte of Inches carrys over when it is incremented, then an error
	; has occured because it should immediatly exit the record_samples loop under main 
	;when a decimal value of 9999 (0x270f) has been obtained or exceeded.
	;  Write an error routine here which displays Err on the display and clears the stack
	; before restarting the program from statr or main.
exit_isr
	banksel	STATUS		;Restore Status and W register contents
	swapf	STATUS_TEMP, W	; to how they were before interrupt
	movwf	STATUS
	swapf	W_TEMP, F
	swapf	W_TEMP, W

	retfie			;Return from the interrupt
;===================================================================
;-----------------------------------------------------------------------
SSP_Handler
	banksel	PIR1
	bcf		PIR1, SSPIF
	banksel	SSPSTAT
	btfss	SSPSTAT, 2	;R_W, skip next if read command was received
	goto	slave_reception
slave_transmission
	banksel	FSR
	movlw	0x73			;Have FSR point to the hund register
	movwf	FSR

	movf	cnt, W			;Move current count to W
	addwf	FSR, F			;Add cnt offset to FSR
	
	movf	INDF, W			;Read contents of current FSR
	call	WriteI2C		;Write to SSPBUF
	banksel	cnt
	incf	cnt, F			;Increment counter

	movlw	6
	subwf	cnt, W			;Subtract 4 from cnt

	banksel	STATUS
	btfsc	STATUS, Z		;If zero register is set then cnt is 4
	clrf	cnt				;clear cnt register
	goto	end_ssp
		
slave_reception
	banksel	SSPBUF
	call	ReadI2C			;Get I2C Data
	movwf	i2c_rec_buf		;Move I2C byte to incoming buffer
	
	movlw	'\r';			;If '\r' (CR) was byte received by PIC, set the Start Sonar Flag
	subwf	i2c_rec_buf, W
	
	banksel	STATUS
	btfss	STATUS, Z
	goto	end_ssp
	banksel	son_flag
	bsf		son_flag, 0		;If received byte was a CR '\r', set flag 0		
	banksel	PIE1
	bsf		PIE1, 3		;Re-Enable SSP Interrupt
end_ssp
	banksel	SSPCON
	bcf		SSPCON, SSPOV	;Clear Overflow bit

	return	
;----------------------------------------------------------------------
WriteI2C
	banksel	SSPSTAT
	btfsc	SSPSTAT, BF	; Is the buffer full?
	goto	WriteI2C	; Yes, keep waiting
	banksel	SSPCON		; No, continue
DoI2CWrite
	bcf		SSPCON, WCOL	; Clear the WCOL flag
	movwf	SSPBUF		; Write the byte in WREG
	btfsc	SSPCON, WCOL	; Was there a write collision?
	goto	DoI2CWrite
	bsf		SSPCON, CKP	; Release the clock
	return
;-----------------------------------------------------------------------
ReadI2C
	banksel	SSPBUF
	movf	SSPBUF, W	; Get the byte and put it in WREG
	return
;-----------------------------------------------------------------------
	end

