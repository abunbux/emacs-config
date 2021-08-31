;;; built-in_narrow_config.el -*- coding: utf-8; lexical-binding: t; -*-
;;; --- insert here summary

;;; CREATED: <Sun Aug 29 22:44:40 EEST 2021>
;;; Time-stamp: <Последнее обновление -- Sunday August 29 23:13:43 EEST 2021>



;;; Commentary:

;;; Code:




;;; Code:



;;; По-умолчанию команды "narrow" начинаются с "C-x n"

(use-package emacs
  :bind (
         ("C-x n i" .   my/narrow-next-line)
         ("C-x n -" .   my/narrow-or-widen-dwim)
         )
  :config
  (message "Loading built-in \"narrow\" - \"pseudo-emacs\"")


  (put 'narrow-to-defun  'disabled nil)
  ;; Разрешить ограничение редактирования только в выделенном участке
  (put 'narrow-to-region  'disabled nil)
  ;; Разрешить ограничение редактирования только на текущей странице
  (put 'narrow-to-page    'disabled nil)


  ;; my/narrow-next-line ("C-x n i")
  (defun my/narrow-next-line ()
    (interactive)
    (widen)
    (call-interactively 'move-end-of-line)
    (forward-char)
    (call-interactively 'move-end-of-line)
    (narrow-to-region 1 (point)))
  ;; (bind-key "C-x n i" 'my/narrow-next-line)

  ;; my/narrow-or-widen-dwim ("C-x n -")
  (defun my/narrow-or-widen-dwim (p)
    "Widen if buffer is narrowed, narrow-dwim otherwise.
Dwim means: region, org-src-block, org-subtree, or
defun, whichever applies first. Narrowing to
org-src-block actually calls `org-edit-src-code'.

With prefix P, don't widen, just narrow even if buffer
is already narrowed."
    (interactive "P")
    (declare (interactive-only))
    (cond ((and (buffer-narrowed-p) (not p)) (widen))
          ((region-active-p)
           (narrow-to-region (region-beginning)
                             (region-end)))
          ((derived-mode-p 'org-mode)
           ;; `org-edit-src-code' is not a real narrowing
           ;; command. Remove this first conditional if
           ;; you don't want it.
           (cond ((ignore-errors (org-edit-src-code) t)
                  (delete-other-windows))
                 ((ignore-errors (org-narrow-to-block) t))
                 (t (org-narrow-to-subtree))))
          ((derived-mode-p 'latex-mode)
           (LaTeX-narrow-to-environment))
          (t (narrow-to-defun))))
  ;; (bind-key "C-x n -" 'my/narrow-or-widen-dwim)


  )







(provide 'built-in_narrow_config)

;;; built-in_narrow_config.el ends here
