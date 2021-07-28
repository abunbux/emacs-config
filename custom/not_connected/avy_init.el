;;; avy_init.el -*- coding: utf-8; lexical-binding: t; -*-

;;; CREATED: <Mon Feb 03 15:23:52 EET 2020>
;;; Time-stamp: <Последнее обновление -- Saturday February 22 21:5:13 EET 2020>



;;; Commentary:

;;; Code:



;; avy-goto-char
;; avy-goto-word-0
;; avy-org-goto-heading-timer
;; avy-org-refile-as-child

;; avy-resume
;; avy-isearch in isearch-mode-map

;; avy-copy-line
;; avy-copy-region
;; avy-kill-ring-save-whole-line
;; avy-kill-whole-line
;; avy-move-line
;; avy-kill-ring-save-region
;; avy-move-region
;; avy-kill-region

;; Jump to characters in buffers
(use-package avy
  :ensure t
  :bind (("C-c j w" . avy-goto-word-1)
         ("C-c j l" . avy-goto-line)
         ("C-c j b" . avy-pop-mark)
         ("C-c j j" . avy-goto-char-2)
         ("C-c j k" . avy-goto-char-in-line)
         ("C-c j t" . avy-goto-char-timer)
         ("C-c j p" . my/avy-goto-paren)
         ("C-c C-j" . avy-resume))
  :config
  (message "Loading \"avy-jump\"")
  )




(provide 'avy_init)
