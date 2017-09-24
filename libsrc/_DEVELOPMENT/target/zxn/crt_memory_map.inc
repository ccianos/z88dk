
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; memory map ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

IF __MMAP = -1

   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   ;; user supplied memory map ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   
   INCLUDE "mmap.inc"

ENDIF

IF __MMAP = 0

   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   ;; standard CODE/DATA/BSS memory map ;;;;;;;;;;;;;;;;;;;;;;;
   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

   INCLUDE "../crt_memory_model_z80.inc"

Z88DK_FOR(`LOOP', `0', `139',
`
   SECTION BANK_`'LOOP
	org CRT_ORG_BANK_`'LOOP
	
	SECTION BANK_`'LOOP`'_L
	org CRT_ORG_BANK_`'LOOP`'_L
	
	SECTION BANK_`'LOOP`'_H
	org CRT_ORG_BANK_`'LOOP`'_H
')

Z88DK_FOR(`LOOP', `0', `31',
`
   SECTION DIV_`'LOOP
	org CRT_ORG_DIV_`'LOOP
')

   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   
ENDIF

IF __MMAP = 1

   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   ;; esxdos extended dot command ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

   INCLUDE "crt_memory_model_dotx.inc"

Z88DK_FOR(`LOOP', `0', `139',
`
   SECTION BANK_`'LOOP
	org CRT_ORG_BANK_`'LOOP
	
	SECTION BANK_`'LOOP`'_L
	org CRT_ORG_BANK_`'LOOP`'_L
	
	SECTION BANK_`'LOOP`'_H
	org CRT_ORG_BANK_`'LOOP`'_H
')

Z88DK_FOR(`LOOP', `0', `31',
`
   SECTION DIV_`'LOOP
	org CRT_ORG_DIV_`'LOOP
')

   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   
ENDIF

;; end memory model ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;