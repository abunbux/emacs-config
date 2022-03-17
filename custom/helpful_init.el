;;; helpful_init.el -*- coding: utf-8; lexical-binding: t; -*-
;;; --- insert here summary

;;; CREATED: <Wed Feb 16 06:42:30 EET 2022>
;;; Time-stamp: <Последнее обновление -- Wednesday February 16 6:43:23 EET 2022>



;;; Commentary:



;;; Code:


;;; helpful.el
(use-package helpful
  :ensure t
  :commands (helpful-callable
             helpful-function
             helpful-macro
             helpful-command
             helpful-key
             helpful-variable
             helpful-at-point)

  :bind (
         ("<f6> h c" . helpful-callable)
         ;; ("<f6> h v" . helpful-variable)     ; то же самое `counsel-describe-variable'
         ("<f6> h k" . helpful-key)
         ("<f6> h ." . helpful-at-point)
         ;; ("<f6> h f" . helpful-function)     ; то же самое `counsel-describe-function'
         ("<f6> h C" . helpful-command)
         )
  :init
  :config
  (message "Loading \"helpful\"")
  )





(provide 'helpful_init)

;;; helpful_init.el ends here
