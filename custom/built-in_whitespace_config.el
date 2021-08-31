;;; built-in_whitespace_config.el -*- coding: utf-8; lexical-binding: t; -*-
;;; --- insert here summary

;;; CREATED: <Mon Aug 30 01:58:44 EEST 2021>
;;; Time-stamp: <Последнее обновление -- Monday August 30 2:0:12 EEST 2021>



;;; Commentary:

;;; Code:




;;; Code:




;;; whitespace.el
;; built-in
;; "M-h h W"  `whitespace-mode'
(use-package whitespace
  :ensure nil
  :defer t
  :init
  :config
  (message "Loading built-in \"whitespace\"")
  (setq whitespace-style
        '(face
          empty
          lines
          newline
          newline-mark
          spaces
          space-mark
          tab-mark
          tabs
          trailing))

  (setq whitespace-display-mappings
        '((space-mark 32 [183] [46])
          (space-mark 160 [164] [95])
          (newline-mark 10 [36 10])
          (tab-mark 9 [187 9] [92 9]))))



(provide 'built-in_whitespace_config)

;;; built-in_whitespace_config.el ends here
