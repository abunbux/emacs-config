;;; built-in_abbrev_config.el -*- coding: utf-8; lexical-binding: t; -*-
;;; --- insert here summary

;;; CREATED: <Fri Jan 24 13:51:40 EET 2020>
;;; Time-stamp: <Последнее обновление -- Sunday August 29 20:2:26 EEST 2021>



;;; Commentary:

;;; Code:




;;; abbrev.el
;; По-умолчанию команды "abbrev" начинаются с "C-x a"
(use-package abbrev
  :diminish
  :init
  (setq-default abbrev-file-name "~/.emacs.d/cache/abbrev")
  (setq-default abbrev-mode 'silently)
  ;; (abbrev-mode t)
  :config
  (message "Loading built-in \"abbrev\"")
  (setq save-abbrevs    'silently)


  )


(provide 'built-in_abbrev_config)
;;; built-in_abbrev_config.el ends here
