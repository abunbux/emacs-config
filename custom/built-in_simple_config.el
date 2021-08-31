;;; built-in_simple_config.el -*- coding: utf-8; lexical-binding: t; -*-
;;; --- insert here summary

;;; CREATED: <Sun Aug 29 18:05:48 EEST 2021>
;;; Time-stamp: <Последнее обновление -- Sunday August 29 18:6:7 EEST 2021>



;;; Commentary:

;;; Code:




;;; Code:



(use-package simple
  :defer t
  :custom
  (column-number-mode                   t)                                      ; simple.el
  (global-visual-line-mode              t)                                      ; simple.el
  (kill-whole-line                      t)                                      ; simple.el
  (kill-ring-max                        1000)                                   ; simple.el
  (next-line-add-newlines               nil)                                    ; simple.el
  ;; Allows navigation through the mark ring by doing C-u C-SPC once, then C-SPC
  ;; C-SPC.  instead of C-u C-SPC C-u C-SPC C-u C-SPC ...
  (set-mark-command-repeat-pop          t)                                      ; simple.el
  (save-interprogram-paste-before-kill  t)                                      ; simple.el
  (blink-matching-paren-distance        nil)                                    ; simple.el
  (interprogram-cut-function            (and (fboundp #'x-select-text)          ; simple.el
                                             #'x-select-text))
  (interprogram-paste-function          (and (fboundp #'x-selection-value)      ; simple.el
                                             #'x-selection-value))
  (line-number-mode                     t)                                      ; simple.el

  (size-indication-mode                 t)                                      ; simple.el
  ;; (mark-ring-max                        16) ; 16 по умолчанию                ; simple.el
  :config
  (message "Loading built-in \"simple\"")
  (toggle-truncate-lines 1)
  )





(provide 'built-in_simple_config)

;;; built-in_simple_config.el ends here
