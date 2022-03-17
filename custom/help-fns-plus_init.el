;;; help-fns-plus_init.el -*- coding: utf-8; lexical-binding: t; -*-
;;; --- insert here summary

;;; CREATED: <Wed Feb 16 06:41:01 EET 2022>
;;; Time-stamp: <Последнее обновление -- Wednesday February 16 6:41:56 EET 2022>



;;; Commentary:



;;; Code:


;; help-fns+.el
(use-package help-fns+
  :quelpa (help-fns+ :fetcher github :repo "emacsmirror/help-fns-plus")
  ;;  Commands defined here:
  ;;
  ;;    `describe-buffer', `describe-command', `describe-file',
  ;;    `describe-face',
  ;;    `describe-keymap', `describe-option', `describe-option-of-type'.

  :bind
  ;;  Keys bound here:
  ;;
  ;;    `C-h B'      `describe-buffer'
  ;;    `C-h c'      `describe-command'     (replaces `describe-key-briefly')
  ;;    `C-h o'      `describe-option'
  ;;    `C-h C-c'    `describe-key-briefly' (replaces `C-h c')
  ;;    `C-h C-o'    `describe-option-of-type'
  ;;    `C-h M-c'    `describe-copying'     (replaces `C-h C-c')
  ;;    `C-h M-f'    `describe-file'
  ;;    `C-h M-k'    `describe-keymap'
  ;;    `C-h M-l'    `find-function-on-key'
  :init
  (require 'help-fns+)
  :config
  (message "Loading \"help-fns+\"")
  )





(provide 'help-fns-plus_init)

;;; help-fns-plus_init.el ends here
