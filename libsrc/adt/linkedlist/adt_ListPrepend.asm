; int adt_ListPrepend(struct adt_List *list, void *item)
; 02.2003, 06.2005 aralbrec

XLIB adt_ListPrepend
LIB ADTListPrepend

.adt_ListPrepend
   ld hl,2
   add hl,sp
   ld c,(hl)
   inc hl
   ld b,(hl)
   inc hl
   ld e,(hl)
   inc hl
   ld d,(hl)
   call ADTListPrepend
   ld hl,1
   ret c
   dec l
   ret

; enter: DE = struct adt_List *
;        BC = item *
; exit : carry reset if fail (no memory) else:
;        new item prepended to start of list, current points at new item
; uses : AF,BC,DE,HL
