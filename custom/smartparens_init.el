;;; smartparens_init.el -*- coding: utf-8; lexical-binding: t -*-

;;; CREATED: <Fri May 17 08:59:06 EEST 2019>
;;; Time-stamp: <Последнее обновление -- Friday November 27 23:3:42 EET 2020>



;;; Commentary:


;;; Code:




(use-package smartparens
  :ensure t
  :diminish smartparens-mode
  :init
  (bind-key "C-M-f" 'sp-forward-sexp  smartparens-mode-map)
  (bind-key "C-M-b" 'sp-backward-sexp smartparens-mode-map)

  (bind-key "M-<delete>" 'sp-unwrap-sexp smartparens-mode-map)
  (bind-key "C-M-<delete>" 'sp-rewrap-sexp smartparens-mode-map)

  (bind-key "C-x M-\(" 'sp-wrap-round)

  (setq sp-highlight-pair-overlay nil
        smartparens-strict-mode   nil)

  :hook
  (after-init . smartparens-global-mode)

  :config
  (message "Loading \"smartparens\"")
  (require 'smartparens-config)
  (require 'smartparens-html)
  ;; (add-hook 'after-init-hook '(lambda () (show-smartparens-global-mode t)))
  ;; (add-hook 'after-init-hook 'smartparens-global-mode)
  (sp-with-modes '(org-mode)
    (sp-local-pair "=" "=")
    (sp-local-pair "*" "*")
    (sp-local-pair "/" "/")
    (sp-local-pair "_" "_")
    (sp-local-pair "+" "+")
    (sp-local-pair "<" ">")
    (sp-local-pair "[" "]")
    (sp-local-pair "~" "~"))
  (sp-with-modes '(prog-mode)
    (sp-local-pair "<" ">"))

  )


(provide 'smartparens_init)


;;;;;;;;;;;;;;;;;;;;;;;;
;; https://github.com/Fuco1/.emacs.d/blob/master/files/smartparens.el
;; keybinding management

;; (define-key smartparens-mode-map (kbd "C-]") 'sp-select-next-thing-exchange)
;; (define-key smartparens-mode-map (kbd "C-[") 'sp-select-previous-thing)
;; (define-key smartparens-mode-map (kbd "C-M-}") 'sp-select-next-thing)

;; (define-key smartparens-mode-map (kbd "C-M-d") 'sp-down-sexp)
;; (define-key smartparens-mode-map (kbd "C-M-a") 'sp-backward-down-sexp)
;; (define-key smartparens-mode-map (kbd "C-S-d") 'sp-beginning-of-sexp)
;; (define-key smartparens-mode-map (kbd "C-S-a") 'sp-end-of-sexp)

;; (define-key smartparens-mode-map (kbd "C-M-e") 'sp-up-sexp)
;; (define-key smartparens-mode-map (kbd "C-M-u") 'sp-backward-up-sexp)
;; (define-key smartparens-mode-map (kbd "C-M-t") 'sp-transpose-sexp)

;; (define-key smartparens-mode-map (kbd "C-M-n") 'sp-next-sexp)
;; (define-key smartparens-mode-map (kbd "C-M-p") 'sp-previous-sexp)

;; (define-key smartparens-mode-map (kbd "C-M-k") 'sp-kill-sexp)
;; (define-key smartparens-mode-map (kbd "C-M-w") 'sp-copy-sexp)

;; (define-key smartparens-mode-map (kbd "M-<backspace>") 'sp-backward-unwrap-sexp)

;; (define-key smartparens-mode-map (kbd "C-<right>") 'sp-forward-slurp-sexp)
;; (define-key smartparens-mode-map (kbd "C-<left>") 'sp-forward-barf-sexp)
;; (define-key smartparens-mode-map (kbd "C-M-<left>") 'sp-backward-slurp-sexp)
;; (define-key smartparens-mode-map (kbd "C-M-<right>") 'sp-backward-barf-sexp)

;; (define-key smartparens-mode-map (kbd "M-D") 'sp-splice-sexp)
;; (define-key smartparens-mode-map (kbd "C-M-<delete>") 'sp-splice-sexp-killing-forward)
;; (define-key smartparens-mode-map (kbd "C-M-<backspace>") 'sp-splice-sexp-killing-backward)
;; (define-key smartparens-mode-map (kbd "C-S-<backspace>") 'sp-splice-sexp-killing-around)

;; (define-key smartparens-mode-map (kbd "C-M-n") 'sp-forward-hybrid-sexp)
;; (define-key smartparens-mode-map (kbd "C-M-p") 'sp-backward-hybrid-sexp)

;; (define-key smartparens-mode-map (kbd "M-F") 'sp-forward-symbol)
;; (define-key smartparens-mode-map (kbd "M-B") 'sp-backward-symbol)

;; (define-key smartparens-mode-map (kbd "C-\"") 'sp-change-inner)
;; (define-key smartparens-mode-map (kbd "M-i") 'sp-change-enclosing)

;; (bind-key "C-c f" (lambda () (interactive) (sp-beginning-of-sexp 2)) smartparens-mode-map)
;; (bind-key "C-c b" (lambda () (interactive) (sp-beginning-of-sexp -2)) smartparens-mode-map)


;; (bind-key "H-t" 'sp-prefix-tag-object smartparens-mode-map)
;; (bind-key "H-p" 'sp-prefix-pair-object smartparens-mode-map)
;; (bind-key "H-y" 'sp-prefix-symbol-object smartparens-mode-map)
;; (bind-key "H-h" 'sp-highlight-current-sexp smartparens-mode-map)
;; (bind-key "H-e" 'sp-prefix-save-excursion smartparens-mode-map)
;; (bind-key "H-s c" 'sp-convolute-sexp smartparens-mode-map)
;; (bind-key "H-s a" 'sp-absorb-sexp smartparens-mode-map)
;; (bind-key "H-s e" 'sp-emit-sexp smartparens-mode-map)
;; (bind-key "H-s p" 'sp-add-to-previous-sexp smartparens-mode-map)
;; (bind-key "H-s n" 'sp-add-to-next-sexp smartparens-mode-map)
;; (bind-key "H-s j" 'sp-join-sexp smartparens-mode-map)
;; (bind-key "H-s s" 'sp-split-sexp smartparens-mode-map)

;; заменить скобки на другие
;; (bind-key "H-s r"                'sp-rewrap-sexp smartparens-mode-map)
;; (global-set-key (kbd "C-z c")    'sp-rewrap-sexp)

;; (defvar hyp-s-x-map)
;; (define-prefix-command 'hyp-s-x-map)
;; (bind-key "H-s x" hyp-s-x-map smartparens-mode-map)
;; (bind-key "H-s x x" 'sp-extract-before-sexp smartparens-mode-map)
;; (bind-key "H-s x a" 'sp-extract-after-sexp smartparens-mode-map)
;; (bind-key "H-s x s" 'sp-swap-enclosing-sexp smartparens-mode-map)

;; (bind-key "C-x C-t" 'sp-transpose-hybrid-sexp smartparens-mode-map)

;; (bind-key ";" 'sp-comment emacs-lisp-mode-map)


;; (bind-key [remap c-electric-backspace] 'sp-backward-delete-char smartparens-strict-mode-map)
;; ;; let C-S-d bound to 'delete-region
;; (define-key smartparens-strict-mode-map [remap delete-region] [nil])

;; Keys for smartparens ends
;;;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
