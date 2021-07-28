;;; amx_init.el -*- coding: utf-8; lexical-binding: t -*-

;;; CREATED: <Fri May 17 13:51:20 EEST 2019>
;;; Time-stamp: <Последнее обновление -- Tuesday February 11 20:1:22 EET 2020>



;;; Commentary:

;;; Code:



(use-package amx
  :ensure t
  :hook
  (after-init . amx-mode)

  :config
  (message "Loading \"amx\"")
  (setq amx-save-file "~/.emacs.d/cache/amx-items"
        amx-ignored-command-matchers nil
        amx-history-length 50)
  (setq amx-prompt-string "(amx M-X )")
  ;; (amx-mode 1)
  )

;; amx-major-mode-commands
;; amx-show-unbound-commands


(provide 'amx_init)


;;; GETTING HELP FOR COMMANDS
;; C-h f    while Amx is active, runs describe-function on the currently selected command.
;; M-.      jumps to the definition of the selected command.
;; C-h w    shows the key bindings for the selected command. (Via where-is.)


;;; SHOW ONLY MAJOR MODE COMMANDS
;; amx-major-mode-commands runs Amx, limited to commands that are relevant to the active major mode.
;; Note that this command is not bound to any key by default, so if you use it a lot,
;; you should add your own key binding for it.


;;; Show unbound commands
;; amx-show-unbound-commands shows frequently used commands that have no key bindings.
