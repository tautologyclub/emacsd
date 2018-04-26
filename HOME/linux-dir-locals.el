((c-mode . ((eval . (c-set-style "linux"))
	    (tab-width . 8)
	    (c-basic-offset 8)))
 (nil . ((indent-tabs-mode . t)
	 (irony-additional-clang-options
	  . ("-I/home/benjamin/work/hm/repos/linux-toradex/include"
	     "-I/home/benjamin/work/hm/repos/linux-toradex/include/generated"
	     "-I/home/benjamin/work/hm/repos/linux-toradex/include/uapi"
	     "-I/home/benjamin/work/hm/repos/linux-toradex/arch/arm/include"
	     "-I/home/benjamin/work/hm/repos/linux-toradex/arch/arm/include/generated"
	     "-I/home/benjamin/work/hm/repos/linux-toradex/arch/arm/include/generated/uapi"
	     "-include/home/benjamin/work/hm/repos/linux-toradex/include/linux/kconfig.h"
	     "-D__KERNEL__"
	     "-D__GNUC__"
	     "-DMODULE"
	     "-Dcpu_to_le32(x) x"
	     "-Dle32_to_cpu(x) x"
	     "-Dcpu_to_le16(x) x"
	     "-Dle16_to_cpu(x) x"
	     "-DDEBUG"
	     "-DCC_HAVE_ASM_GOTO"
	     "-DKBUILD_STR(s)=#s"
	     "-DKBUILD_BASENAME=KBUILD_STR(bounds)"
	     "-DKBUILD_MODNAME=KBUILD_STR(bounds)"
	     "-D__LINUX_ARM_ARCH__=7"
	     "-nostdinc"))
         )))
