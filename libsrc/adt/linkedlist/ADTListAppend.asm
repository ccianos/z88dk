; int adt_ListAppend(struct adt_List *list, void *item)
; 02.2003, 06.2005 aralbrec

XLIB ADTListAppend
LIB ADTemptylistadd
XDEF ADTListAppend2
XREF _u_malloc

; enter: DE = struct adt_List *
;        BC = item *
; exit : carry reset if fail (no memory)
;        new item appended to end of list, current points at new item
; uses : AF,BC,DE,HL

.ADTListAppend
   push bc
   push de
   ld hl,6                ; sizeof(struct adt_ListNode)
   call _u_malloc
   pop de
   pop bc
   ret nc                 ; alloc memory failed

   ld (hl),c
   inc hl
   ld (hl),b              ; store user item into new NODE
   inc hl                 ; hl = new NODE.next
   ex de,hl               ; hl = LIST*, de = new NODE.next

   ld a,(hl)
   inc (hl)               ; increase item count
   inc hl
   jp nz, noinchi
   inc (hl)
   jp cont
.noinchi
   or (hl)                ; hl = LIST.count+1, de = new NODE.next, list count & item done
   jp z, ADTemptylistadd   ; if there are no items in list jump to emptylistadd helper
.cont
   inc hl                 ; hl = LIST.state, de = new NODE.next, list count & item done

.ADTListAppend2
   ld (hl),1              ; current INLIST
   inc hl
   dec de
   dec de                 ; de = new NODE
   push de                ; stack = new NODE
   ld (hl),d
   inc hl
   ld (hl),e              ; current = new NODE
   inc hl
   inc hl
   inc hl                 ; hl = tail
   inc de
   inc de                 ; de = new NODE.next
   xor a
   ld (de),a
   inc de
   ld (de),a              ; new NODE.next = NULL
   inc de                 ; de = new NODE.prev
   ldi
   ldi                    ; new NODE.prev = tail
   dec hl
   ld e,(hl)
   dec hl                 ; hl = tail
   ld d,(hl)              ; de = old tail NODE
   pop bc                 ; bc = new NODE
   ld (hl),b
   inc hl
   ld (hl),c              ; tail = new NODE
   ex de,hl               ; hl = old tail NODE
   inc hl
   inc hl                 ; hl = old tail NODE.next
   ld (hl),b
   inc hl
   ld (hl),c              ; old tail NODE.next = new NODE
   scf
   ret
