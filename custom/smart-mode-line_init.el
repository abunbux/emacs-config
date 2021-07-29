;;; smart-mode-line_init.el -*- coding: utf-8; lexical-binding: t -*-

;;; CREATED: <Fri Feb 01 16:50:27 EET 2019>
;;; Time-stamp: <Последнее обновление -- Thursday July 29 19:13:47 EEST 2021>




;;; Commentary:

;;; Code:




(use-package smart-mode-line
  :quelpa (smart-mode-line :fetcher github :repo "Bruce-Connor/smart-mode-line")
  :init
  (setq sml/name-width        40
        sml/mode-width        'full
        sml/shorten-directory t
        sml/shorten-modes     t
        sml/no-confirm-load-theme t)
  :config
  (message "Loading \"smart-mode-line\"")
  (setq sml/theme 'dark)
  ;; (setq sml/theme 'light)
  ;; (setq sml/theme 'respectful)
  (require 'smart-mode-line)
  (smart-mode-line-enable)
  (sml/setup)


  (custom-set-variables
   '(sml/pre-id-separator "|")
   '(sml/pos-id-separator "| ")
   '(sml/pos-minor-modes-separator " /")
   '(sml/pre-minor-modes-separator "/ ")
   '(sml/pre-modes-separator "| |")
   )

  )



(provide 'smart-mode-line_init)
