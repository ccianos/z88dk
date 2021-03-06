;
;  Copyright (c) 2020 Phillip Stevens
;
;  This Source Code Form is subject to the terms of the Mozilla Public
;  License, v. 2.0. If a copy of the MPL was not distributed with this
;  file, You can obtain one at http://mozilla.org/MPL/2.0/.
;
;  feilipu, August 2020
;
;-------------------------------------------------------------------------
; asm_am9511_log - am9511 floating point natural log
;-------------------------------------------------------------------------

SECTION code_clib
SECTION code_fp_am9511

EXTERN __IO_APU_CONTROL
EXTERN __IO_APU_OP_LN

EXTERN asm_am9511_pushf_hl
EXTERN asm_am9511_pushf_fastcall
EXTERN asm_am9511_popf

PUBLIC asm_am9511_log, asm_am9511_log_fastcall


.asm_am9511_log
    ld hl,2
    add hl,sp
    call asm_am9511_pushf_hl        ; x

    ld a,__IO_APU_OP_LN
    out (__IO_APU_CONTROL),a        ; log(x)

    jp asm_am9511_popf


.asm_am9511_log_fastcall
    call asm_am9511_pushf_fastcall  ; x

    ld a,__IO_APU_OP_LN
    out (__IO_APU_CONTROL),a        ; log(x)

    jp asm_am9511_popf

