;; -*- lexical-binding: t -*-

;;; CREATED: <Fri May 31 05:37:42 EEST 2019>
;;; Time-stamp: <Последнее обновление -- Thursday December 3 10:50:42 EET 2020>



;;; Commentary:

;; When point is inside of a fold you can toggle it with "C-`",
;; so usually you don't need to bind toggling functions.

;;; Code:


;; vimish-fold.el
(use-package vimish-fold
  :ensure t
  :preface

  (defmacro deffold (func-name params let*-list start-cond while-cond &optional backward-cond last-cond)
    (cond
     ((and backward-cond last-cond)
      `(defun ,func-name ,params
         (interactive "p")
         (let* (,@let*-list)
           (save-excursion
             (goto-char (point-min))
             ;; Fisrt iteration
             ;; Looking at begin
             (while (and (not ,start-cond)
                         (= 0 (forward-line))))
             (unless (= (point) (point-max))
               (let ((beg (point)))
                 ;; Looking at end
                 (while (and ,while-cond
                             (= 0 (forward-line))))
                 (unless ,last-cond
                   (forward-line -1)
                   (while (and ,backward-cond
                               (= 0 (forward-line -1))))
                   (forward-line))
                 (let ((end (point)))
                   (when (< threshold (count-lines beg end))
                     (save-excursion
                       (ignore-errors
                         (vimish-fold beg end)))))))
             ;; Rest iterations
             (while (= 0 (forward-line))
               ;; Looking at begin
               (while (and (not ,start-cond)
                           (= 0 (forward-line))))
               (unless (= (point) (point-max))
                 (let ((beg (point)))
                   ;; Looking at end
                   (while (and ,while-cond
                               (= 0 (forward-line))))
                   (unless ,last-cond
                     (forward-line -1)
                     (while (and ,backward-cond
                                 (= 0 (forward-line -1))))
                     (forward-line))
                   (let ((end (point)))
                     (when (< threshold (count-lines beg end))
                       (save-excursion
                         (ignore-errors
                           (vimish-fold beg end))))))))))))
     (backward-cond
      `(defun ,func-name ,params
         (interactive "p")
         (let* (,@let*-list)
           (save-excursion
             (goto-char (point-min))
             ;; First iteration
             ;; Looking at begin
             (while (and (not ,start-cond)
                         (= 0 (forward-line))))
             (unless (= (point) (point-max))
               (let ((beg (point)))
                 ;; Looking at end
                 (while (and ,while-cond
                             (= 0 (forward-line))))
                 (forward-line -1)
                 (while (and ,backward-cond
                             (= 0 (forward-line -1))))
                 (forward-line)
                 (let ((end (point)))
                   (when (< threshold (count-lines beg end))
                     (save-excursion
                       (ignore-errors
                         (vimish-fold beg end)))))))
             ;; Rest iterations
             (while (= 0 (forward-line))
               ;; Looking at begin
               (while (and (not ,start-cond)
                           (= 0 (forward-line))))
               (unless (= (point) (point-max))
                 (let ((beg (point)))
                   ;; Looking at end
                   (while (and ,while-cond
                               (= 0 (forward-line))))
                   (forward-line -1)
                   (while (and ,backward-cond
                               (= 0 (forward-line -1))))
                   (forward-line)
                   (let ((end (point)))
                     (when (< threshold (count-lines beg end))
                       (save-excursion
                         (ignore-errors
                           (vimish-fold beg end))))))))))))
     (t
      `(defun ,func-name ,params
         (interactive "p")
         (let* (,@let*-list)
           (save-excursion
             (goto-char (point-min))
             ;; First iteration
             (while (and (not ,start-cond)
                         (= 0 (forward-line))))
             (unless (= (point) (point-max))
               (let ((beg (point)))
                 ;; Looking at end
                 (while (and ,while-cond
                             (= 0 (forward-line))))
                 (let ((end (point)))
                   (when (< threshold (count-lines beg end))
                     (save-excursion
                       (ignore-errors
                         (vimish-fold beg end)))))))
             ;; Rest iterations
             (while (= 0 (forward-line))
               ;; Looking at begin
               (while (and (not ,start-cond)
                           (= 0 (forward-line))))
               (unless (= (point) (point-max))
                 (let ((beg (point)))
                   ;; Looking at end
                   (while (and ,while-cond
                               (= 0 (forward-line))))
                   (let ((end (point)))
                     (when (< threshold (count-lines beg end))
                       (save-excursion
                         (ignore-errors
                           (vimish-fold beg end))))))))))))))

  (deffold fold-indent (level &optional threshold)
    ((indentation (* level tab-width))
     (threshold (or 5 threshold)))
    (and (= indentation (current-indentation))
         (not (looking-at "[[:space:]]*$")))
    (or (<= indentation (current-indentation))
        (looking-at "[[:space:]]*$")
        (char-equal ?\\ (char-before (1- (point)))))
    (looking-at "[[:space:]]*$")
    (looking-at "[[:space:]]*[}\\])]"))

  (deffold fold-precomp (&optional threshold)
    ((threshold 1))
    (cond
     ((derived-mode-p 'c-mode 'c++-mode)
      (looking-at "[[:space:]]*#"))
     ((derived-mode-p 'python-mode 'elpy-mode)
      (looking-at "[[:space:]]*\\(from\\|import\\)")))
    (or (looking-at "[[:space:]]*$")
        (char-equal ?\\ (char-before (1- (point))))
        (cond
         ((derived-mode-p 'c-mode 'c++-mode)
          (looking-at "[[:space:]]*#"))
         ((derived-mode-p 'python-mode 'elpy-mode)
          (looking-at "[[:space:]]*\\(from\\|import\\)"))))
    (looking-at "[[:space:]]*$"))

  (deffold fold-comment (&optional threshold)
    ((threshold 1))
    (cond
     ((derived-mode-p 'lisp-interaction-mode 'emacs-lisp)
      (looking-at "[[:space:]]*;"))
     ((derived-mode-p 'c-mode 'c++-mode)
      (looking-at "[[:space:]]*/[/*]"))
     ((derived-mode-p 'python-mode 'elpy-mode)
      (looking-at "[[:space:]]*#")))
    (or (sp-point-in-comment)
        (cond
         ((derived-mode-p 'lisp-interaction-mode 'emacs-lisp)
          (looking-at "[[:space:]]*;"))
         ((derived-mode-p 'c-mode 'c++-mode)
          (looking-at "[[:space:]]*/[/*]"))
         ((derived-mode-p 'python-mode 'elpy-mode)
          (looking-at "[[:space:]]*#")))))


  ;;; my/fold-dwim ("C-z v w")
  (defun my/fold-dwim (level)
    (interactive "p")
    (cond
     (mark-active
      (call-interactively #'vimish-fold))
     ((cl-block nested-dolist ;; exist vimish overlay at point?
        (dolist (overlay (overlays-at (point)))
          (when (vimish-fold--vimish-overlay-p overlay)
            (cl-return-from nested-dolist t)))
        nil)
      (vimish-fold-toggle))
     ((cl-block nested-dolist ;; exist vimish overlays in buffer?
        (dolist (overlay (overlays-in (point-min) (point-max)))
          (when (vimish-fold--vimish-overlay-p overlay)
            (cl-return-from nested-dolist t)))
        nil)
      (vimish-fold-toggle-all))
     (t
      (if current-prefix-arg
          (fold-indent level (read-number "Threshold: " 1))
        (fold-indent level))
      (fold-precomp)
      (fold-comment))))

  :bind (
         ;; В документации определено "C-`"  vimish-fold-unfold,
         ;; из-за моей старенькой клавиатуры не работает, клавиши залипают.
         ("<kp-enter>"  . my/fold-dwim)
         ("C-z v w"     . my/fold-dwim)
         ("C-z v f"     . vimish-fold)
         ("C-z v r"     . vimish-fold-refold)
         ("C-z v d"     . vimish-fold-delete)
         ("C-<kp-enter>" . vimish-fold-delete)

         ("C-z v p" . vimish-fold-previous-fold)
         ("C-z v n" . vimish-fold-next-fold)

         ("C-z v a d" . vimish-fold-delete-all)
         ("C-z v a t" . vimish-fold-toggle-all)
         ("C-z v a r" . vimish-fold-refold-all)
         ("C-z v a u" . vimish-fold-unfold-all)
         )

  :init
  (setq vimish-fold-dir "~/.emacs.d/cache/vimish-fold/")
  (vimish-fold-global-mode 1)

  :config
  (message "Loading \"vimish-fold\"")
  (custom-set-faces
   '(vimish-fold-overlay ((t (:foreground "white" :background "#02404f"))))
   ))



(provide 'vimish-fold_init)
