;
;       SAM Coupe C Library
;
;	getkey() Wait for keypress
;
;       We will corrupt any register
;
;       Stefano Bodrato - Mar.2001



		XLIB	fgetc_cons

.fgetc_cons
		call	$016C

		ld	h,0
		ld	l,a

		ret
