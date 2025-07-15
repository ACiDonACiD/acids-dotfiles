; Assembly Data Type Sizes:
; 	db (define byte)     [ x1 byte/s |  x8 bit/s ]
; 	dw (define word)     [ x2 byte/s | x16 bit/s ]
; 	dd (define dword)    [ x4 byte/s | x32 bit/s ]
   
; Hexidecimal definitions
;       0xA = newline character (LF)

;  INFO: x86 Registers
;	        32 bits : EAX EBX ECX EDX
; 	        16 bits : AX BX CX DX
; 	        8 bits 	: AH AL BH BL CH CL DH DL
;     
;  General registers       | EAX EBX ECX EDX
;  Segment registers       | CS DS ES FS GS SS
;  Index and pointers      | ESI EDI EBP EIP ESP
;  Indicator | EFLAGS REGISTER
        
        ; Bit   Label    Desciption
        ; ---------------------------
        ; 0      CF      Carry flag
        ; 2      PF      Parity flag
        ; 4      AF      Auxiliary carry flag
        ; 6      ZF      Zero flag
        ; 7      SF      Sign flag
        ; 8      TF      Trap flag
        ; 9      IF      Interrupt enable flag
        ; 10     DF      Direction flag
        ; 11     OF      Overflow flag
        ; 12-13  IOPL    I/O Priviledge level
        ; 14     NT      Nested task flag
        ; 16     RF      Resume flag
        ; 17     VM      Virtual 8086 mode flag
        ; 18     AC      Alignment check flag (486+)
        ; 19     VIF     Virutal interrupt flag
        ; 20     VIP     Virtual interrupt pending flag
        ; 21     ID      ID flag
        ;
; [ EAX,AX,AH,AL ] ~ The Accumulator register. 
;   	It is used for I/O port access, arithmetic, interrupt calls,
    
; [ EBX,BX,BH,BL ] ~ The Base register
;        It is used as a base pointer for memory access
;         Gets some interrupt return values

; [ ECX,CX,CH,CL ] ~ The Counter register
;	It is used as a loop counter and for shifts
;	Gets some interrupt values

; [ EDX,DX,DH,DL ] ~ The Data register
;	It is used for I/O port access, arithmetic, 
; 	some interrupt calls.

section .text
global _start         ; Entry point for the program

_start:               ; Code begins here

section .data
; -----------------------------------------------
; INFO: STORED_DATA
; Defines a string followed by a newline character (0xA)
; Each character takes 1 byte (8 bits)
; Total memory used = length of string + 1 byte for newline
; -----------------------------------------------
msg     db "Hello World!", 0xA   ; Define string in memory (13 chars + newline)

len     equ $ - msg               ; Calculate length of the string (in bytes)
                                  ; '$' = current address, 'msg' = starting address
                                  ; result: len = number of bytes in stringf bytes in string
