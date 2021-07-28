;;; backup-each-save_init.el -*- coding: utf-8; lexical-binding: t -*-

;;; CREATED: <Thu Apr 04 09:48:33 EEST 2019>
;;; Time-stamp: <Последнее обновление -- Sunday February 23 20:48:23 EET 2020>



;;; Commentary:

;;; Code:


(use-package backup-each-save
  :ensure t
  :init
  (defun backup-each-save-filter (filename)
    (let ((ignored-filenames
    	   '("\\/cache/auto-save-list"
             "\\/cache/cache/backup"
             "\\/cache/undo-tree-history"
             "^/tmp"
             "semantic.cache$"
             "\\.emacs-places$"
    	     "\\.recentf$"
             ".newsrc\\(\\.eld\\)?"))
    	  (matched-ignored-filename nil))
      (mapc
       (lambda (x)
         (when (string-match x filename)
    	   (setq matched-ignored-filename t)))
       ignored-filenames)
      (not matched-ignored-filename)))

  (setq backup-each-save-filter-function 'backup-each-save-filter)
  (setq backup-each-save-mirror-location "~/.backup-each-save")
  :config
  (message "Loading \"backup-each-save\"")
  (add-hook 'after-save-hook 'backup-each-save)
  )


(provide 'backup-each-save_init)
