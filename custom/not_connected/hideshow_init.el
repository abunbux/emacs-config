;; -*- lexical-binding: t -*-

;;; CREATED: <Fri Feb 01 16:50:27 EET 2019>
;;; Time-stamp: <Последнее обновление -- Tuesday April 16 16:2:18 EEST 2019>



(defun my/toggle-selective-display (column)
  (interactive "P")
  (set-selective-display
   (or column
       (unless selective-display
         (1+ (current-column))))))
;; (global-set-key [(super f) (t) (d)] 'my/toggle-selective-display)

(bind-key "s-f t d" 'my/toggle-selective-display)


(defun my/toggle-hiding (column)
  (interactive "P")
  (if hs-minor-mode
      (if (condition-case nil
              (hs-my/toggle-hiding)
            (error t))
          (hs-show-all))
    (my/toggle-selective-display column)))
;; (global-set-key [(super f) (t) (h)] 'my/toggle-hiding)

(bind-key "s-f t h" 'my/toggle-hiding)


(defun my/display-code-line-counts (ov)
  (when (eq 'code (overlay-get ov 'hs))
    (overlay-put ov 'help-echo
                 (buffer-substring (overlay-start ov)
                                   (overlay-end ov)))))


(setq hs-minor-mode-map
      (let ((map (make-sparse-keymap)))
        (define-key map [(super f) (a) (h)] 'hs-hide-all)
        (define-key map [(super f) (a) (s)] 'hs-show-all)
        (define-key map [(super f) (b) (h)] 'hs-hide-block)
        (define-key map [(super f) (b) (s)] 'hs-show-block)
        (define-key map [(super f) (t) (t)] 'hs-my/toggle-hiding)
        (define-key map [(super f) (l)]     'hs-hide-level)
        map))

(load-library "hideshow")



(defvar hs-special-modes-alist
  (mapcar 'purecopy
          '((c-mode "{" "}" "/[*/]" nil nil)
            (c++-mode "{" "}" "/[*/]" nil nil)
            (bibtex-mode ("@\\S(*\\(\\s(\\)" 1))
            (java-mode "{" "}" "/[*/]" nil nil)
            (js-mode "{" "}" "/[*/]" nil)
            (lisp-mode ";" ";;;" "*\\(\\s\\)" "^\\([a-zA-Z- ']*)" nil))))

;; (add-hook 'c-mode-common-hook   'hs-minor-mode)
;; (add-hook 'emacs-lisp-mode-hook 'hs-minor-mode)
;; (add-hook 'java-mode-hook       'hs-minor-mode)
;; (add-hook 'lisp-mode-hook       'hs-minor-mode)
;; (add-hook 'lisp-mode-hook       'hs-minor-mode)
;; (add-hook 'emacs-lisp-mode-hook 'hs-minor-mode)
;; (add-hook 'perl-mode-hook       'hs-minor-mode)
;; (add-hook 'sh-mode-hook         'hs-minor-mode)

;;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>


(setq hs-set-up-overlay 'my/display-code-line-counts)
(setq hs-hide-comments  nil)
(setq hs-isearch-open   't)


;; (global-set-key [(super t) (H)] 'hs-minor-mode)
(bind-key "s-t H" 'hs-minor-mode)



(provide 'hideshow_init)


;;   hs-hide-block                      C-c @ C-h
;;   hs-show-block                      C-c @ C-s
;;   hs-hide-all                        C-c @ C-M-h
;;   hs-show-all                        C-c @ C-M-s
;;   hs-hide-level                      C-c @ C-l
;;   hs-toggle-hiding                   C-c @ C-c
;;   hs-mouse-toggle-hiding             [(shift mouse-2)]
;;   hs-hide-initial-comment-block
