;;; built-in_paren_config.el -*- coding: utf-8; lexical-binding: t; -*-
;;; --- insert here summary

;;; CREATED: <Mon Aug 30 17:01:43 EEST 2021>
;;; Time-stamp: <Последнее обновление -- Monday August 30 17:4:43 EEST 2021>



;;; Commentary:

;;; Code:




;;; Code:




;; paren
(use-package paren
  :ensure nil
  :hook
  (after-init . show-paren-mode)
  :config
  (message "Loading built-in \"paren\"")
  (setq show-paren-style  'expression
        ;; show-paren-style 'mixed
        show-paren-when-point-inside-paren t
        show-paren-when-point-in-periphery t
        show-paren-delay                  0)

  ;; Перемещение по парным скобкам
  ;; Emulation of the vi % command
  ;; Переход к парной скобке по "%"
  ;; my/match-paren ("%")
  (defun my/match-paren (arg)
    "Go to the matching paren if on a paren; otherwise insert %."
    (interactive "p")
    (let ((prev-char (char-to-string (preceding-char)))
          (next-char (char-to-string (following-char))))
      (cond ((string-match "[[{(<]" next-char) (forward-sexp 1))
            ((string-match "[\]})>]" prev-char) (backward-sexp 1))
            (t (self-insert-command (or arg 1))))))

  (bind-key "%" 'my/match-paren)


  )





(provide 'built-in_paren_config)

;;; built-in_paren_config.el ends here
