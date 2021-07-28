;; -*- lexical-binding: t -*-

;;; CREATED: <Fri Feb 01 16:50:27 EET 2019>
;;; Time-stamp: <Последнее обновление -- Tuesday April 16 20:6:24 EEST 2019>



;; (global-linum-mode 1)
;; (global-linum-mode)
;; (global-nlinum-mode)

;; (when (version<= "26.0.50" emacs-version )
;;   (global-display-line-numbers-mode))


(setq linum-format " <%d>")
(setq nlinum-format " [%d]")

;; (add-hook 'prog-mode-hook 'linum-mode)

;;; Сам писал, горжусь :) *****************************************************
;; my/toogle-linum-mode ("(super t) (n) (l)")
(defvar linum-mode nil)
(defun my/toogle-linum-mode ()
  "Переключает linum-mode и выключает nlinum, если он есть, конечно"
  (interactive)
  (if (equal linum-mode nil)
      (progn
        (global-nlinum-mode -1)
        (nlinum-mode -1)
        (message "nlinum-mode disabled")
        (linum-mode t)
        (message "linum-mode enabled")
        )
    (global-linum-mode -1)
    (message "linum-mode disabled")))

;;; my/toogle-nlinum-mode ("(super t) (n) (n)")
(defvar nlinum-mode nil)
(defun my/toogle-nlinum-mode ()
  "Переключает nlinum-mode и выключает linum, если он есть, конечно"
  (interactive)
  (if (equal nlinum-mode nil)
      (progn
        (global-linum-mode -1)
        (linum-mode -1)
        (message "linum-mode disabled")
        (nlinum-mode t)
        (message "nlinum-mode enabled")
        )
    (global-nlinum-mode -1)
    (message "nlinum-mode disabled")
    ))


;; (global-set-key [(super t) (n) (L)] 'global-display-line-numbers-mode)
;; (global-set-key [(super t) (n) (l)] 'my/toogle-linum-mode)
;; (global-set-key [(super t) (n) (n)] 'my/toogle-nlinum-mode)

(bind-key "s-t n L" 'global-display-line-numbers-mode)
(bind-key "s-t n l" 'my/toogle-linum-mode)
(bind-key "s-t n n" 'my/toogle-nlinum-mode)


(provide 'line_number_config)
