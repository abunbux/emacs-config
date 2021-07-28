;;; dired-rsync_init.el -*- coding: utf-8; lexical-binding: t; -*-

;;; CREATED: <Mon Feb 24 18:33:14 EET 2020>
;;; Time-stamp: <Последнее обновление -- Monday February 24 18:34:20 EET 2020>



;;; Commentary:

;;; Code:


;;; dired-rsync.el
;; https://github.com/stsquad/dired-rsync
;; клавиша "r" была `diredp-rename-this-file' из `dired+.el'.
;; то-же самое можно сделать "R" - `dired-do-rename' из `dired-aux.el'.
(use-package dired-rsync
  :ensure t
  :commands (dired-rsync)
  :bind (
         :map dired-mode-map
         ("r" . dired-rsync)
         )
  :init
  (setq dired-rsync-modeline-status   t)
  :config
  (message "Loading \"dired-rsync\""))



(provide 'dired-rsync_init)
