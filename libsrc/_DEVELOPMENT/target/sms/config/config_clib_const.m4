define(`__count__', 0)
define(`__ECOUNT__', `__count__`'define(`__count__', eval(__count__+1))')

dnl############################################################
dnl# C LIBRARY CONSTANTS - MESSAGES AND IOCTL

include(`target/clib_const.m4')

dnl# NO USER CONFIGURATION, MUST APPEAR FIRST
dnl############################################################

divert(-1)

###############################################################
# TARGET CONSTANTS - MESSAGES AND IOCTL
# rebuild the library if changes are made
#

# IOCTL

# sms_01_output_terminal

define(`IOCTL_OTERM_CHARACTER_PATTERN_OFFSET', 0x0802)
define(`IOCTL_OTERM_SCREEN_MAP_ADDRESS', 0x1002)
define(`IOCTL_OTERM_PRINT_FLAGS', 0x1102)
define(`IOCTL_OTERM_BACKGROUND_CHARACTER', 0x1202)

#
# END OF USER CONFIGURATION
###############################################################

divert(0)

dnl#
dnl# COMPILE TIME CONFIG EXPORT FOR ASSEMBLY LANGUAGE
dnl#

ifdef(`CFG_ASM_PUB',
`
PUBLIC `IOCTL_OTERM_CHARACTER_PATTERN_OFFSET'
PUBLIC `IOCTL_OTERM_SCREEN_MAP_ADDRESS'
PUBLIC `IOCTL_OTERM_PRINT_FLAGS'
PUBLIC `IOCTL_OTERM_BACKGROUND_CHARACTER'
')

dnl#
dnl# LIBRARY BUILD TIME CONFIG FOR ASSEMBLY LANGUAGE
dnl#

ifdef(`CFG_ASM_DEF',
`
defc `IOCTL_OTERM_CHARACTER_PATTERN_OFFSET' = IOCTL_OTERM_CHARACTER_PATTERN_OFFSET
defc `IOCTL_OTERM_SCREEN_MAP_ADDRESS' = IOCTL_OTERM_SCREEN_MAP_ADDRESS
defc `IOCTL_OTERM_PRINT_FLAGS' = IOCTL_OTERM_PRINT_FLAGS
defc `IOCTL_OTERM_BACKGROUND_CHARACTER' = IOCTL_OTERM_BACKGROUND_CHARACTER
')

dnl#
dnl# COMPILE TIME CONFIG EXPORT FOR C
dnl#

ifdef(`CFG_C_DEF',
`
`#define' `IOCTL_OTERM_CHARACTER_PATTERN_OFFSET'  IOCTL_OTERM_CHARACTER_PATTERN_OFFSET
`#define' `IOCTL_OTERM_SCREEN_MAP_ADDRESS'  IOCTL_OTERM_SCREEN_MAP_ADDRESS
`#define' `IOCTL_OTERM_PRINT_FLAGS'  IOCTL_OTERM_PRINT_FLAGS
`#define' `IOCTL_OTERM_BACKGROUND_CHARACTER'  IOCTL_OTERM_BACKGROUND_CHARACTER
')

undefine(`__count__')
undefine(`__ECOUNT__')