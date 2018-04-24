(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (url (concat (if no-ssl "http" "https") "://melpa.org/packages/")))
  (add-to-list 'package-archives (cons "melpa" url) t))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/")))
(add-to-list 'package-archives '("melpa-stable" . "https://melpa-stable.milkbox.net/packages/") t)
(add-to-list 'package-archives '("marmalade" .
                                 "https://marmalade-repo.org/packages/"))
(add-to-list 'load-path "~/.emacs.d/lisp/")
(add-to-list 'load-path "~/.emacs.d/lisp/helm/")
(add-to-list 'load-path "~/repos/counsel-term/")
(add-to-list 'load-path "/usr/share/emacs/site-lisp/mu4e")
(add-to-list 'load-path "~/repos/counsel-projectile")
(add-to-list 'load-path "~/repos/Fill-Column-Indicator")
(add-to-list 'load-path "~/repos/feebleline")
(add-to-list 'load-path "~/.emacs.d/ample-theme")
(load-file "~/.emacs.d/ample-theme/ample-light-theme.el")
(package-initialize)

(use-package ample-light-theme)
(require 'counsel-term)
(require 'feebleline)

;; <<<<<<< variant A
;; >>>>>>> variant B
(require 'fill-column-indicator)
;; (require 'counsel-projectile)
;; (require 'mu4e)
;; (setq mu4e-get-mail-command "offlineimap")
;; (setq mu4e-update-interval 120)
;; (setq mu4e-sent-folder "/SentItems"
;;       mu4e-drafts-folder "/Drafts"
;;       mu4e-trash-folder "/DeletedItems"
;;       mu4e-refile-folder "/Archive"
;;       user-email-addresss "benjamin@lindqvist.xyz"
;;       smtpmail-default-smtp-server "smtp.office365.com"
;;       smtpmail-smtp-service 587
;;       )
;; ======= end
;; ;; Encryption method: STARTTLS

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#757575" "#CD5542" "#4A8F30" "#7D7C21" "#4170B3" "#9B55C3" "#68A5E9" "gray43"])
 '(async-bytecomp-allowed-packages nil)
 '(auto-dim-other-buffers-dim-on-switch-to-minibuffer nil)
 '(avy-keys
   (quote
    (97 115 101 100 102 103 114 111 112 106 107 105 113 119)))
 '(aw-keys
   (quote
    (97 115 101 100 102 103 114 116 111 112 106 107 108 105 113 119 110 109)))
 '(browse-url-browser-function (quote browse-url-chrome))
 '(browse-url-chrome-arguments (quote ("--new-window")))
 '(column-number-mode nil)
 '(company-auto-complete-chars (quote (46 62)))
 '(company-backends
   (quote
    (company-semantic company-clang company-xcode company-cmake company-capf company-files
                      (company-dabbrev-code company-gtags company-etags company-keywords)
                      company-oddmuse company-dabbrev)))
 '(company-idle-delay 0)
 '(company-minimum-prefix-length 3)
 '(company-show-numbers t)
 '(company-tooltip-idle-delay 0.2)
 '(company-tooltip-limit 10)
 '(compilation-message-face (quote default))
 '(counsel-mode t)
 '(counsel-term-ff-initial-input "")
 '(counsel-term-history-initial-input "")
 '(custom-enabled-themes (quote (ample-light)))
 '(custom-safe-themes
   (quote
    ("c9ddf33b383e74dac7690255dd2c3dfa1961a8e8a1d20e401c6572febef61045" "5691b95e3cb9d4b7a6e8e22f3fc6a5ef2677c4a6be130c5c356955aa27ec9f97" "c445dc2c368dfe68804a1b6d5bf6e3398b050aabd69fd051669fc2a6364bdeca" "94246a88ef81fcd114da447c2396dbe4afc7e66cdc58c438a933d914463ea3b6" "13b815a01a4cc8cf411e8257a0f5e30aa7f4adccc18748cfa82909cbac4fa0c8" "7afea3a70d8faa333f339170d2d7530533e2a9f87f7d68e54cf769c44d8269d2" default)))
 '(debug-on-error nil)
 '(default ((t (:height 105 :width normal :family "Inconsolata"))))
 '(delete-by-moving-to-trash t)
 '(echo-keystrokes 0.01)
 '(eldoc-idle-delay 0.75)
 '(electric-pair-pairs (quote ((34 . 34) (123 . 125))))
 '(elfeed-feeds
   (quote
    ("http://cestlaz.github.io/rss.xml" "http://nullprogram.com/feed/" "http://planet.emacsen.org/atom.xml" "https://www.electronicsweekly.com/news/feed/" "https://www.electronicsweekly.com/rss-feeds/" "http://pragmaticemacs.com/feed/")))
 '(elpy-rpc-backend "rope" t)
 '(erc-autojoin-channels-alist (quote (("#emacs"))))
 '(erc-nick "g00iekabl00ie")
 '(erc-rename-buffers t)
 '(eshell-banner-message
   "--- eshell ---------------------------------------------------------------------
")
 '(explicit-shell-file-name "/usr/bin/xterm")
 '(fci-rule-character 124)
 '(fci-rule-color "dim gray")
 '(feebleline-mode t nil (feebleline))
 '(feebleline-show-git-branch t)
 '(feebleline-show-time nil)
 '(fill-column 80)
 '(flycheck-check-syntax-automatically (quote (save idle-change mode-enabled)))
 '(flycheck-display-errors-delay 0.2)
 '(flycheck-pos-tip-timeout 20)
 '(fringe-mode (quote (1 . 1)) nil (fringe))
 '(gdb-many-windows t)
 '(gdb-show-main t)
 '(global-fci-mode nil)
 '(global-flycheck-mode t)
 '(global-linum-mode nil)
 '(global-semantic-stickyfunc-mode t)
 '(helm-autoresize-max-height 24)
 '(helm-autoresize-min-height 24)
 '(helm-autoresize-mode t)
 '(helm-buffer-details-flag nil)
 '(helm-descbinds-mode t)
 '(helm-display-buffer-default-width 32)
 '(helm-display-header-line nil)
 '(helm-mode nil)
 '(helm-swoop-split-direction (quote split-window-vertically))
 '(highlight-changes-colors (quote ("#d33682" "#6c71c4")))
 '(highlight-indent-guides-character 58)
 '(highlight-symbol-colors
   (--map
    (solarized-color-blend it "#002b36" 0.25)
    (quote
     ("#b58900" "#2aa198" "#dc322f" "#6c71c4" "#859900" "#cb4b16" "#268bd2"))))
 '(highlight-symbol-foreground-color "#93a1a1")
 '(highlight-tail-colors
   (quote
    (("#073642" . 0)
     ("#546E00" . 20)
     ("#00736F" . 30)
     ("#00629D" . 50)
     ("#7B6000" . 60)
     ("#8B2C02" . 70)
     ("#93115C" . 85)
     ("#073642" . 100))))
 '(hl-bg-colors
   (quote
    ("#7B6000" "#8B2C02" "#990A1B" "#93115C" "#3F4D91" "#00629D" "#00736F" "#546E00")))
 '(hl-fg-colors
   (quote
    ("#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36")))
 '(hl-paren-background-colors (quote ("#2492db" "#95a5a6" nil)))
 '(hl-paren-colors (quote ("#ecf0f1" "#ecf0f1" "#c0392b")))
 '(hl-sexp-background-color "#1c1f26")
 '(hlt-max-region-no-warning 30)
 '(ivy-fixed-height-minibuffer t)
 '(ivy-height 24)
 '(ivy-ignore-buffers (quote ("\\` " "\\*Helm" "\\*Ivy" "TAGS")))
 '(ivy-mode t)
 '(jit-lock-stealth-time 1)
 '(keyboard-coding-system (quote utf-8-unix))
 '(line-number-mode nil)
 '(magit-commit-arguments nil)
 '(magit-diff-use-overlays nil)
 '(magit-display-buffer-function (quote magit-display-buffer-fullframe-status-v1))
 '(max-mini-window-height 10)
 '(mode-line-default-help-echo nil)
 '(mode-line-format nil)
 '(mode-line-in-non-selected-windows nil)
 '(mouse-avoidance-mode nil nil (avoid))
 '(mu4e-maildir "/home/benjamin/.mail")
 '(multi-term-buffer-name "TERM")
 '(multi-term-scroll-to-bottom-on-output t)
 '(multi-term-switch-after-close nil)
 '(nrepl-message-colors
   (quote
    ("#336c6c" "#205070" "#0f2050" "#806080" "#401440" "#6c1f1c" "#6b400c" "#23733c")))
 '(org-agenda-files nil)
 '(org-log-done (quote time))
 '(package-selected-packages
   (quote
    (eproject goto-last-change ace-link switch-buffer-functions company-quickhelp c-eldoc logview highlight-indent-guides dts-mode flycheck-popup-tip minibuffer-line counsel-spotify help-fns+ el-get pdf-tools org-pdfview yapfify py-autopep8 move-text epc flycheck-pos-tip git-timemachine helm-pydoc counsel-pydoc python-pylint slack vimish-fold helm-make function-args evil multiple-cursors git-gutter-fringe+ helm-google helm-flycheck framemove company-c-headers flycheck-rtags rtags ace-jump-buffer fastnav dired+ rg smex which-key lispy wgrep smart-hungry-delete counsel-projectile anaconda-mode nlinum auto-compile helm-ag ag helm-projectile avy ace-jump-mode helm-describe-modes helm-descbinds ivy-hydra helm-themes golden-ratio helm-swoop auto-dim-other-buffers popwin crux imenu-anywhere ssh irony counsel hungry-delete undo-tree expand-region volatile-highlights elfeed company-irony-c-headers flycheck-irony projectile use-package pylint magit jedi helm-gtags helm-flymake helm-etags-plus helm-company gtags google-c-style ggtags frame-cmds flycheck-pycheckers fill-column-indicator elpy drupal-mode counsel-gtags company-jedi company-irony)))
 '(pdf-view-midnight-colors (quote ("#232333" . "#c7c7c7")))
 '(pos-tip-background-color "#073642")
 '(pos-tip-border-width 0)
 '(pos-tip-foreground-color "#93a1a1")
 '(pos-tip-internal-border-width 1)
 '(powerline-display-hud nil)
 '(projectile-enable-caching nil)
 '(projectile-globally-ignored-modes
   (quote
    ("erc-mode" "help-mode" "completion-list-mode" "Buffer-menu-mode" "gnus-.*-mode" "occur-mode" "term-mode")))
 '(projectile-mode-line "PROJECTILE")
 '(python-indent-guess-indent-offset t)
 '(python-indent-guess-indent-offset-verbose nil)
 '(python-pylint-command "pylint+ 2")
 '(resize-mini-windows t)
 '(safe-local-variable-values
   (quote
    ((c-style)
     (c-basic-offset 8)
     (irony-additional-clang-options "-I/home/benjamin/work/hm/repos/linux-toradex/include" "-I/home/benjamin/work/hm/repos/linux-toradex/include/generated" "-I/home/benjamin/work/hm/repos/linux-toradex/arch/arm/include" "-I/home/benjamin/work/hm/repos/linux-toradex/arch/arm/include/generated" "-I/home/benjamin/work/hm/repos/linux-toradex/arch/arm/include/generated/uapi" "-include/home/benjamin/work/hm/repos/linux-toradex/include/linux/kconfig.h" "-include/home/benjamin/work/hm/repos/linux-toradex/arch/arm/include/asm/types.h" "-include/home/benjamin/work/hm/repos/linux-toradex/include/linux/byteorder/generic.h" "-include/home/benjamin/work/hm/repos/linux-toradex/include/linux/wait.h" "-include/home/benjamin/work/hm/repos/linux-toradex/include/linux/mutex.h" "-include/home/benjamin/work/hm/repos/linux-toradex/include/linux/timer.h" "-include/home/benjamin/work/hm/repos/linux-toradex/include/linux/mii.h" "-include/home/benjamin/work/hm/repos/linux-toradex/include/linux/usb.h" "-include/home/benjamin/work/hm/repos/linux-toradex/include/linux/netdevice.h" "-D__KERNEL__" "-D__GNUC__" "-DMODULE" "-Dcpu_to_le32(x) x" "-Dle32_to_cpu(x) x" "-Dcpu_to_le16(x) x" "-Dle16_to_cpu(x) x" "-DDEBUG" "-DCC_HAVE_ASM_GOTO" "-DKBUILD_STR(s)=#s" "-DKBUILD_BASENAME=KBUILD_STR(bounds)" "-DKBUILD_MODNAME=KBUILD_STR(bounds)" "-D__LINUX_ARM_ARCH__=7" "-nostdinc")
     (eval setenv "GTAGSLIBPATH" "~/.gtags")
     (eval setenv "GTAGSLIBPATH" "")
     (irony-additional-clang-options "-I/home/benjamin/work/hm/repos/linux-toradex/include" "-I/home/benjamin/work/hm/repos/linux-toradex/include/generated" "-I/home/benjamin/work/hm/repos/linux-toradex/arch/arm/include" "-I/home/benjamin/work/hm/repos/linux-toradex/arch/arm/include/generated" "-I/home/benjamin/work/hm/repos/linux-toradex/arch/arm/include/generated/uapi" "-include/home/benjamin/work/hm/repos/linux-toradex/include/linux/kconfig.h" "-include/home/benjamin/work/hm/repos/linux-toradex/arch/arm/include/asm/types.h" "-include/home/benjamin/work/hm/repos/linux-toradex/include/linux/byteorder/generic.h" "-include/home/benjamin/work/hm/repos/linux-toradex/include/linux/wait.h" "-include/home/benjamin/work/hm/repos/linux-toradex/include/linux/mutex.h" "-include/home/benjamin/work/hm/repos/linux-toradex/include/linux/timer.h" "-include/home/benjamin/work/hm/repos/linux-toradex/include/linux/mii.h" "-include/home/benjamin/work/hm/repos/linux-toradex/include/linux/usb.h" "-include/home/benjamin/work/hm/repos/linux-toradex/include/linux/netdevice.h" "-D__KERNEL__" "-D__GNUC__" "-Dcpu_to_le32(x) x" "-Dle32_to_cpu(x) x" "-Dcpu_to_le16(x) x" "-Dle16_to_cpu(x) x" "-DDEBUG" "-DCC_HAVE_ASM_GOTO" "-DKBUILD_STR(s)=#s" "-DKBUILD_BASENAME=KBUILD_STR(bounds)" "-DKBUILD_MODNAME=KBUILD_STR(bounds)" "-D__LINUX_ARM_ARCH__=7" "-nostdinc")
     (irony-additional-clang-options "-I/home/benjamin/work/hm/repos/linux-toradex/include" "-I/home/benjamin/work/hm/repos/linux-toradex/arch/arm/include" "-I/home/benjamin/work/hm/repos/linux-toradex/arch/arm/include/generated" "-include/home/benjamin/work/hm/repos/linux-toradex/include/linux/kconfig.h" "-include/home/benjamin/work/hm/repos/linux-toradex/arch/arm/include/asm/types.h" "-include/home/benjamin/work/hm/repos/linux-toradex/include/linux/byteorder/generic.h" "-include/home/benjamin/work/hm/repos/linux-toradex/include/linux/wait.h" "-include/home/benjamin/work/hm/repos/linux-toradex/include/linux/mutex.h" "-include/home/benjamin/work/hm/repos/linux-toradex/include/linux/timer.h" "-include/home/benjamin/work/hm/repos/linux-toradex/include/linux/mii.h" "-include/home/benjamin/work/hm/repos/linux-toradex/include/linux/usb.h" "-include/home/benjamin/work/hm/repos/linux-toradex/include/linux/netdevice.h" "-D__KERNEL__" "-D__GNUC__" "-Dcpu_to_le32(x) x" "-Dle32_to_cpu(x) x" "-Dcpu_to_le16(x) x" "-Dle16_to_cpu(x) x" "-DDEBUG" "-DCC_HAVE_ASM_GOTO" "-DKBUILD_STR(s)=#s" "-DKBUILD_BASENAME=KBUILD_STR(bounds)" "-DKBUILD_MODNAME=KBUILD_STR(bounds)" "-D__LINUX_ARM_ARCH__=7" "-nostdinc")
     (irony-additional-clang-options "-I/home/benjamin/work/hm/repos/linux-toradex/include" "-I/home/benjamin/work/hm/repos/linux-toradex/arch/arm/include" "-include/home/benjamin/work/hm/repos/linux-toradex/arch/arm/include/asm/types.h" "-include/home/benjamin/work/hm/repos/linux-toradex/include/linux/byteorder/generic.h" "-include/home/benjamin/work/hm/repos/linux-toradex/include/linux/wait.h" "-include/home/benjamin/work/hm/repos/linux-toradex/include/linux/mutex.h" "-include/home/benjamin/work/hm/repos/linux-toradex/include/linux/timer.h" "-include/home/benjamin/work/hm/repos/linux-toradex/include/linux/mii.h" "-include/home/benjamin/work/hm/repos/linux-toradex/include/linux/usb.h" "-include/home/benjamin/work/hm/repos/linux-toradex/include/linux/netdevice.h" "-D__KERNEL__" "-D__GNUC__" "-Dcpu_to_le32(x) x" "-Dle32_to_cpu(x) x" "-Dcpu_to_le16(x) x" "-Dle16_to_cpu(x) x" "-DDEBUG" "-DCC_HAVE_ASM_GOTO" "-DKBUILD_STR(s)=#s" "-DKBUILD_BASENAME=KBUILD_STR(bounds)" "-DKBUILD_MODNAME=KBUILD_STR(bounds)" "-D__LINUX_ARM_ARCH__=7" "-nostdinc")
     (irony-additional-clang-options "-I/home/benjamin/work/hm/repos/linux-toradex/include" "-I/home/benjamin/work/hm/repos/linux-toradex/arch/arm/include" "-include/home/benjamin/work/hm/repos/linux-toradex/arch/arm/include/asm/types.h" "-include/home/benjamin/work/hm/repos/linux-toradex/include/linux/byteorder/generic.h" "-include/home/benjamin/work/hm/repos/linux-toradex/include/linux/wait.h" "-D__KERNEL__" "-D__GNUC__" "-Dcpu_to_le32(x) x" "-Dle32_to_cpu(x) x" "-Dcpu_to_le16(x) x" "-Dle16_to_cpu(x) x" "-DDEBUG" "-DCC_HAVE_ASM_GOTO" "-DKBUILD_STR(s)=#s" "-DKBUILD_BASENAME=KBUILD_STR(bounds)" "-DKBUILD_MODNAME=KBUILD_STR(bounds)" "-D__LINUX_ARM_ARCH__=7" "-nostdinc")
     (irony-additional-clang-options "-I/home/benjamin/work/hm/repos/linux-toradex/include" "-I/home/benjamin/work/hm/repos/linux-toradex/arch/arm/include" "-include /home/benjamin/work/hm/repos/linux-toradex/arch/arm/include/asm/types.h" "-include /home/benjamin/work/hm/repos/linux-toradex/include/linux/byteorder/generic.h" "-D__KERNEL__" "-D__GNUC__" "-Dcpu_to_le32(x) x" "-Dle32_to_cpu(x) x" "-Dcpu_to_le16(x) x" "-Dle16_to_cpu(x) x" "-DDEBUG" "-DCC_HAVE_ASM_GOTO" "-DKBUILD_STR(s)=#s" "-DKBUILD_BASENAME=KBUILD_STR(bounds)" "-DKBUILD_MODNAME=KBUILD_STR(bounds)" "-D__LINUX_ARM_ARCH__=7" "-nostdinc")
     (irony-additional-clang-options "-I/home/benjamin/work/hm/repos/linux-toradex/include" "-I/home/benjamin/work/hm/repos/linux-toradex/arch/arm/include" "-include /home/benjamin/work/hm/repos/linux-toradex/arch/arm/include/asm/types.h" "-include /home/benjamin/work/hm/repos/linux-toradex/include/linux/byteorder/generic.h" "-D__KERNEL__" "-D__GNUC__" "-Dcpu_to_le32(x) x" "-Dle32_to_cpu(x) x" "-Dcpu_to_le16(x) x" "-Dle16_to_cpu(x) x" "-DDEBUG" "-DKBUILD_STR(s)=#s" "-nostdinc")
     (irony-additional-clang-options "-I/home/benjamin/work/hm/repos/linux-toradex/include" "-I/home/benjamin/work/hm/repos/linux-toradex/arch/arm/include" "-include /home/benjamin/work/hm/repos/linux-toradex/arch/arm/include/asm/types.h" "-include /home/benjamin/work/hm/repos/linux-toradex/include/linux/byteorder/generic.h" "-D__KERNEL__" "-D__GNUC__" "-D__cpu_to_le32(x) x" "-DDEBUG" "-DKBUILD_STR(s)=#s" "-nostdinc")
     (irony-additional-clang-options "-I/home/benjamin/work/hm/repos/linux-toradex/include" "-I/home/benjamin/work/hm/repos/linux-toradex/arch/arm/include" "-include /home/benjamin/work/hm/repos/linux-toradex/arch/arm/include/asm/types.h" "-include /home/benjamin/work/hm/repos/linux-toradex/include/linux/byteorder/generic.h" "-include /home/benjamin/work/hm/repos/linux-toradex/include/uapi/linux/byteorder/little_endian.h" "-D__KERNEL__" "-D__GNUC__" "-DDEBUG" "-DKBUILD_STR(s)=#s" "-nostdinc")
     (irony-additional-clang-options "-I/home/benjamin/work/hm/repos/linux-toradex/include" "-I/home/benjamin/work/hm/repos/linux-toradex/arch/arm/include" "-include /home/benjamin/work/hm/repos/linux-toradex/arch/arm/include/asm/types.h" "-include /home/benjamin/work/hm/repos/linux-toradex/include/linux/byteorder/generic.h" "-D__KERNEL__" "-D__GNUC__" "-DDEBUG" "-DKBUILD_STR(s)=#s" "-nostdinc")
     (irony-additional-clang-options "-I/home/benjamin/work/hm/repos/linux-toradex/include" "-I/home/benjamin/work/hm/repos/linux-toradex/arch/arm/include" "-include /home/benjamin/work/hm/repos/linux-toradex/arch/arm/include/asm/types.h" "-D__KERNEL__" "-D__GNUC__" "-DDEBUG" "-DKBUILD_STR(s)=#s" "-nostdinc")
     (irony-additional-clang-options "-I/home/benjamin/work/hm/repos/u-boot-toradex/include" "-I/home/benjamin/work/hm/repos/u-boot-toradex/arch/arm/include" "-include /home/benjamin/work/hm/repos/u-boot-toradex/arch/arc/include/asm/types.h" "-D__KERNEL__" "-D__GNUC__" "-DDEBUG" "-DKBUILD_STR(s)=#s" "-nostdinc")
     (irony-additional-clang-options "-I/home/benjamin/work/hm/repos/u-boot-toradex/include" "-I/home/benjamin/work/hm/repos/u-boot-toradex/arch/arm/include" "-include /home/benjamin/work/hm/repos/u-boot-toradex/arch/arc/include/asm/types.h" "-DDEBUG" "-DKBUILD_STR(s)=#s" "-nostdinc")
     (irony-additional-clang-options "-I/home/benjamin/work/hm/repos/u-boot-toradex/include" "-I/home/benjamin/work/hm/repos/u-boot-toradex/arch/arm/include" "-i/home/benjamin/work/hm/repos/u-boot-toradex/arch/arc/include/asm/types.h" "-DDEBUG" "-DKBUILD_STR(s)=#s" "-nostdinc")
     (irony-additional-clang-options "-I/home/benjamin/work/hm/repos/u-boot-toradex/include" "-I/home/benjamin/work/hm/repos/u-boot-toradex/arch/arm/include" "-DDEBUG" "-DKBUILD_STR(s)=#s" "-nostdinc")
     (irony-additional-clang-options quote
                                     (("-I/home/benjamin/work/hm/repos/linux-toradex/include" "-I/home/benjamin/work/hm/repos/u-boot-toradex/arch/arm/include" "-DDEBUG" "-DKBUILD_STR(s)=#s" "-nostdinc")))
     (irony-additional-clang-options quote
                                     ("-I/home/benjamin/work/hm/repos/linux-toradex/include" "-I/home/benjamin/work/hm/repos/u-boot-toradex/arch/arm/include" "-DDEBUG" "-DKBUILD_STR(s)=#s" "-nostdinc"))
     (irony-additional-clang-options quote
                                     ("-I/home/benjamin/work/hm/repos/linux-toradex/include" "-I/home/benjamin/work/hm/repos/u-boot-toradex/arch/arm/include" "-DDEBUG" "-DMODULE" "-DKBUILD_STR(s)=#s" "-nostdinc"))
     (irony-additional-clang-options "-I/home/benjamin/work/hm/repos/linux-toradex/include" "-I/home/benjamin/work/hm/repos/u-boot-toradex/arch/arm/include" "-DDEBUG" "-DMODULE" "-DKBUILD_STR(s)=#s" "-nostdinc")
     (tab-always-indent . t))))
 '(save-interprogram-paste-before-kill t)
 '(scroll-bar-mode nil)
 '(semantic-idle-scheduler-idle-time 5)
 '(semantic-mode t)
 '(shell-file-name "/bin/bash")
 '(shift-select-mode nil)
 '(sml/active-background-color "#34495e")
 '(sml/active-foreground-color "#ecf0f1")
 '(sml/inactive-background-color "#dfe4ea")
 '(sml/inactive-foreground-color "#34495e")
 '(tab-width 8)
 '(term-bind-key-alist
   (quote
    (("C-g" lambda nil
      (interactive)
      (term-send-raw-string ""))
     ("H-w" . counsel-term-ff)
     ("H-c" . counsel-term-cd)
     ("M-r" . counsel-term-history)
     ("H-f" . avy-goto-word-or-subword-1)
     ("H-k" lambda nil
      (interactive)
      (term-send-raw-string ""))
     ("C-d" . term-send-raw)
     ("C-p" . projectile-command-map)
     ("C-l" . forward-char)
     ("C-h" . backward-char)
     ("C-S-n" . term-updir)
     ("C-n" . term-downdir)
     ("C-s" . swiper)
     ("C-r" . term-send-backspace)
     ("<f9>" . term-send-backspace)
     ("C-m" . term-send-return)
     ("C-y" . term-paste)
     ("C-q" . backward-word)
     ("M-q" . term-send-backward-word)
     ("M-f" . term-send-forward-word)
     ("M-p" . term-send-up)
     ("M-n" . term-send-down)
     ("<C-backspace>" . term-send-backward-kill-word)
     ("<C-return>" . term-cd-input)
     ("M-d" . term-send-delete-word)
     ("M-," . term-send-raw)
     ("M-." . company-complete)
     ("H-M-t" . term-toggle-mode-w/warning)
     ("C-c C-c" . term-interrupt-subjob)
     ("C-c C-e" . term-send-esc)
     ("C-c C-z" lambda nil
      (interactive)
      (term-send-raw-string ""))
     ("C-c C-x" lambda nil
      (interactive)
      (term-send-raw-string ""))
     ("C-c C-u" lambda nil
      (interactive)
      (term-send-raw-string "sudo "))
     ("H-M-p" lambda nil
      (interactive)
      (term-send-raw-string "sudo "))
     ("H-M-u" lambda nil
      (interactive)
      (term-send-raw-string "sudo "))
     ("H-M-l" lambda nil
      (interactive)
      (term-send-raw-string ""))
     ("H-M-f" lambda nil
      (interactive)
      (term-send-raw-string " fuck")
      (sleep-for 0.2)
      (term-send-raw-string ""))
     ("C-x t" . jnm/term-toggle-mode))))
 '(term-buffer-maximum-size 10000)
 '(term-default-bg-color "#002b36")
 '(term-default-fg-color "#839496")
 '(term-unbind-key-list (quote ("C-x" "C-z" "C-c" "C-h" "C-y" "<ESC>" "M-o")))
 '(tool-bar-mode nil)
 '(tramp-verbose 6)
 '(transient-mark-mode t)
 '(truncate-partial-width-windows 80)
 '(vc-annotate-background "#d4d4d4")
 '(vc-annotate-background-mode nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#437c7c")
     (40 . "#336c6c")
     (60 . "#205070")
     (80 . "#2f4070")
     (100 . "#1f3060")
     (120 . "#0f2050")
     (140 . "#a080a0")
     (160 . "#806080")
     (180 . "#704d70")
     (200 . "#603a60")
     (220 . "#502750")
     (240 . "#401440")
     (260 . "#6c1f1c")
     (280 . "#935f5c")
     (300 . "#834744")
     (320 . "#732f2c")
     (340 . "#6b400c")
     (360 . "#23733c"))))
 '(vc-annotate-very-old-color "#23733c")
 '(weechat-color-list
   (quote
    (unspecified "#002b36" "#073642" "#990A1B" "#dc322f" "#546E00" "#859900" "#7B6000" "#b58900" "#00629D" "#268bd2" "#93115C" "#d33682" "#00736F" "#2aa198" "#839496" "#657b83")))
 '(wgrep-auto-save-buffer t)
 '(windmove-wrap-around nil)
 '(window-divider-default-bottom-width 1)
 '(window-divider-default-places (quote bottom-only))
 '(xterm-color-names
   ["#073642" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#eee8d5"])
 '(xterm-color-names-bright
   ["#002b36" "#cb4b16" "#586e75" "#657b83" "#839496" "#6c71c4" "#93a1a1" "#fdf6e3"]))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-dim-other-buffers-face ((t (:background "#a39d7f" :foreground "black"))))
 '(aw-leading-char-face ((t (:background "gray" :foreground "black" :height 3.0))))
 '(counsel-buffer-face-term-mode ((t :inherit (quote font-lock-function-name-face))))
 '(feebleline-bufname-face ((t (:foreground "#000000" :bold nil :medium nil))))
 '(feebleline-dir-face ((t (:inherit font-lock-variable-name-face))))
 '(feebleline-linum-face ((t (:inherit default))))
 '(feebleline-previous-buffer-face ((t (:foreground "#3e3e3e"))))
 '(git-gutter+-added ((t (:background "#d7d8da" :foreground "#00aa00"))))
 '(git-gutter+-deleted ((t (:background "#d7d8da" :foreground "#aa0000"))))
 '(git-gutter+-modified ((t (:background "#d7d8da" :foreground "#ff44ff"))))
 '(hl-line ((t (:background "#b7b29a"))))
 '(link ((t (:foreground "deep sky blue" :underline t))))
 '(linum ((t (:background nil :foreground "dark red"))))
 '(minibuffer-prompt ((t (:foreground "#9B55C3" :bold t :background nil))))
 '(mode-line ((t :height unspecified)))
 '(mode-line-inactive ((t (:inherit mode-line :background "#555753" :foreground "#eeeeec" :box (:line-width -1 :style released-button)))))
 '(popup-tip-face ((t (:foreground "yellow" :background "red" :bold nil))))
 '(semantic-highlight-func-current-tag-face ((t (:background "Gray90"))))
 '(term ((t nil)))
 '(tooltip ((t (:foreground "red" :background "#ad9dca")))))

(defmacro csetq (variable value)
  "Stolen from abo-abo.  VARIABLE and VALUE blabla."
  `(funcall (or (get ',variable 'custom-set) 'set-default) ',variable ,value))

(defmacro lambi (&rest b)
  "Laziest macro in the world!  B etc."
  `(lambda () (interactive),@b))

(eval-after-load 'pdf-view '(define-key pdf-view-mode-map (kbd "C-s") 'isearch-forward)  )

(require 'cc-mode)
(require 'counsel)
(require 'helm)
(require 'auto-complete)
(require 'semantic)
(require 'semantic/bovine/gcc)
(require 'expand-region)
(require 'whitespace)

(use-package	company
  :ensure       t
  :custom       (company-auto-complete-chars '(?. ?>))    ;; ???
                (company-backends
                 '(company-semantic company-clang company-xcode company-cmake
                                    company-capf company-files
                                    (company-dabbrev-code
                                     company-gtags company-etags
                                     company-keywords)
                                    company-oddmuse company-dabbrev))
                (company-idle-delay 0)                    ;; ???
                (company-minimum-prefix-length 3)
                (company-tooltip-idle-delay 0.2)
                (company-show-numbers t)
                (company-tooltip-limit 10)
  :config       (counsel-mode 1)
                (add-hook 'after-init-hook 'global-company-mode))

(require 'volatile-highlights)
(require 'wgrep)
(require 'function-args)
(require 'yasnippet)
;; (fa-config-default) ;; stop stealing my bindings ;; todo obv


; todo tmp
(setq company-backends
      (quote
       (company-bbdb company-nxml company-css company-eclim company-semantic company-clang company-xcode company-cmake company-capf company-files
              (company-dabbrev-code company-gtags company-etags company-keywords)
              company-oddmuse company-dabbrev)
       ))

;; Random vanilla settings
(setq enable-recursive-minibuffers t)
;; (setq enable-recursive-minibuffers nil)
(setq mouse-autoselect-window t)
(setq shift-select-mode nil)
(setq scroll-margin 2)
(setq whitespace-style '(face empty tabs lines-tail trailing))
(setq tab-width 4)
(setq tab-always-indent t)
(setq scroll-error-top-bottom t)

(setq save-interprogram-paste-before-kill t)
(setq select-enable-clipboard t)
(setq x-select-enable-clipboard t)
(setq kill-buffer-query-functions (delq 'process-kill-buffer-query-function kill-buffer-query-functions))
(setq-default indent-tabs-mode nil)
(setq inhibit-splash-screen t)
(setq backup-directory-alist `(("." . "~/.saves")))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))
(setq scroll-preserve-screen-position nil)
(setq backup-by-copying t      ; don't clobber symlinks
      backup-directory-alist
      '(("." . "~/.saves"))    ; don't litter my fs tree
      delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)       ; use versioned backups
(setq delete-by-moving-to-trash t)
(setq gc-cons-threshold 20000000)
(set-default 'sentence-end-double-space nil)
(set-default 'fill-column 80)

(setq initial-major-mode 'org-mode)                             ;; for *Scratch*

(fset 'yes-or-no-p 'y-or-n-p)
(put 'scroll-left 'disabled nil)
(setenv "GTAGSLIBPATH" "~/.gtags")

(auto-compression-mode t)
(show-paren-mode -1)                            ;; really annoying, it turns out

(recentf-mode 1)
(setq recentf-max-saved-items 100)

(window-divider-mode t)
(yas-global-mode 1)
(global-undo-tree-mode 1)
(delete-selection-mode t)
(volatile-highlights-mode t)
(menu-bar-mode -1)
(toggle-scroll-bar -1)

;; Auto revert
(global-auto-revert-mode)
(setq global-auto-revert-non-file-buffers t)

(electric-pair-mode)
(projectile-mode t)
(auto-dim-other-buffers-mode 1)
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(add-hook 'org-mode-hook 'turn-on-auto-fill)
(add-hook 'after-init-hook 'global-company-mode)

(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)

;; fci-mode kind of ruins everything
;; (add-hook 'prog-mode-hook 'fci-mode)
(add-hook 'org-mode-hook 'fci-mode)
(add-hook 'prog-mode-hook 'helm-gtags-mode)
(add-hook 'prog-mode-hook #'hs-minor-mode)

;;;; --- this added to theme instead --- ;;;;
;; (add-hook 'minibuffer-setup-hook
;;           (lambda ()
;;             (make-local-variable 'face-remapping-alist)
;;             (add-to-list 'face-remapping-alist
;;                          '(default (:background "#3c4447")))))

(defun set-hook-newline-and-indent ()
  "Rebind RET."
  (local-set-key (kbd "RET") 'newline-and-indent))
(add-hook 'prog-mode-hook 'set-hook-newline-and-indent)

;; I dunno if semantic is really worth it, it's kind of shit
(add-to-list 'semantic-default-submodes
             'global-semantic-idle-local-symbol-highlight-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-idle-scheduler-mode)
(add-to-list 'semantic-default-submodes 'global-semanticdb-minor-mode)
(semantic-mode 1)
(global-semantic-idle-scheduler-mode t)

;; Open some defaults
(find-file "~/.emacs.d/bindings2.el")
(find-file "~/.emacs.d/init.el")

;; ugly load
(load "~/.emacs.d/custom-defun.el")
(load "~/.emacs.d/blq-display.el")
(load "~/.emacs.d/multiterm-custom.el")
(load "~/.emacs.d/term-addons.el")
(load "~/.emacs.d/hydras.el")
(load "~/.emacs.d/org-custom.el")
(load "~/.emacs.d/hydra-nav.el")
(load "~/.emacs.d/semicolon-modifier.el")
(load "~/.emacs.d/annotation-custom.el")
(load "~/.emacs.d/ivy-custom.el")
(load "~/.emacs.d/face-by-mode.el")
(load "~/.emacs.d/defuns.el")
(load "~/.emacs.d/defun-lexical.el")
(load "~/.emacs.d/helm-custom.el")
(load "~/.emacs.d/python-custom.el")
(load "~/.emacs.d/simple-paren.el")
(load "~/.emacs.d/projectile-custom.el")
(load "~/.emacs.d/flycheck-custom.el")
(load "~/.emacs.d/c-custom.el")
(load "~/.emacs.d/gdb-custom.el")
(load "~/.emacs.d/ora-ediff.el")
(load "~/.emacs.d/git-custom.el")
(load "~/.emacs.d/editing-defuns.el")
(load "~/.emacs.d/compile-custom.el")
(load "~/.emacs.d/mode-mappings.el")
(load "~/.emacs.d/indicate-cursor.el")

(load "~/.emacs.d/frame-fns.el")
(load "~/.emacs.d/frame-cmds.el")
(load "~/.emacs.d/zoom-frm.el")

(load "~/.emacs.d/bindings2.el")
(load "~/.emacs.d/private.el")

(feebleline-mode)
(ample-light-theme)

(condition-case nil (kill-buffer "*scratch*") (error nil))

;; eldoc as pos-tip instead of echo area
(defun my-eldoc-display-message (format-string &rest args)
  "Display eldoc message near point."
  (when format-string
    (pos-tip-show (apply 'format format-string args))))
(setq eldoc-message-function #'my-eldoc-display-message)

(provide 'init)
;;; init.el ends here
