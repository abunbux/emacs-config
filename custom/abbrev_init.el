;;; abbrev_init.el -*- coding: utf-8; lexical-binding: t; -*-

;;; CREATED: <Fri Jan 24 13:51:40 EET 2020>
;;; Time-stamp: <Последнее обновление -- Monday July 26 16:45:2 EEST 2021>



;;; Commentary:

;;; Code:



;;; По-умолчанию команды "abbrev" начинаются с "C-x a"
(use-package abbrev
  :ensure nil
  :defer 5
  :diminish
  :init
  (setq-default abbrev-file-name "~/.emacs.d/cache/abbrev")
  (setq-default abbrev-mode 'silently)
  ;; (abbrev-mode t)
  :config
  (message "Loading \"abbrev\"")
  (setq save-abbrevs    'silently)



  (clear-abbrev-table global-abbrev-table)

  (define-abbrev-table 'global-abbrev-table
    '(
      ("nameserver" "# Generated by net-scripts for interface enp3s0
domain ix
search ix
nameserver 8.8.8.8
nameserver 8.8.4.4" nil 0)
      ))

  (define-abbrev-table 'text-mode-abbrev-table
    '(
      ("ни" "Незначительные изменения." nil 0))
    )
  )


(provide 'abbrev_init)
