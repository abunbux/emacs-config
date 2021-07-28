;; -*- lexical-binding: t -*-

;;; CREATED: <Fri Feb 01 16:50:27 EET 2019>
;;; Time-stamp: <Последнее обновление -- Tuesday June 4 20:16:46 EEST 2019>



;;; По-умолчанию команды "narrow" начинаются с "C-x n"


(put 'narrow-to-defun  'disabled nil)
;; Разрешить ограничение редактирования только в выделенном участке
(put 'narrow-to-region  'disabled nil)
;; Разрешить ограничение редактирования только на текущей странице
(put 'narrow-to-page    'disabled nil)


;;; my/narrow-next-line ("C-x n i")
(defun my/narrow-next-line ()
  (interactive)
  (widen)
  (call-interactively 'move-end-of-line)
  (forward-char)
  (call-interactively 'move-end-of-line)
  (narrow-to-region 1 (point)))

(bind-key "C-x n i" 'my/narrow-next-line)


;;; my/narrow-or-widen-dwim ("C-x n -")
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

(bind-key "C-x n -" 'my/narrow-or-widen-dwim)


(provide 'narrow_config)
