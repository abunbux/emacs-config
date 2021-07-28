;; -*- lexical-binding: t -*-

;;; CREATED: <Fri Feb 01 16:50:27 EET 2019>
;;; Time-stamp: <Последнее обновление -- Tuesday June 4 16:5:50 EEST 2019>



;;; Buffer-menu-mode-hook ***********************************************
(add-hook 'buffer-menu-mode-hook
          '(lambda()
             (let ((font-lock-unfontify-region-function
                    (lambda (start end)
                      (remove-text-properties start end '(font-lock-face nil)))))
               (font-lock-unfontify-buffer)
               (set (make-local-variable 'font-lock-defaults)
                    '(buffer-menu-buffer-font-lock-keywords t))
               (font-lock-fontify-buffer))))
;;;**********************************************************************


;;(require 'ibuffer)
(require 'bs)

;; https://github.com/snosov1/dot-emacs#default-uniquification
(require 'uniquify)

(setq-default uniquify-buffer-name-style 'forward)
(setq-default ibuffer-show-empty-filter-groups nil)

(setq bs-configurations '(("files"
                           "^\\*scratch\\*"
                           nil nil
                           bs-visits-non-file
                           bs-sort-buffer-interns-are-last))
      bs-default-configuration  "files-and-scratch"
      bs-max-window-height      120
      buffer-menu-buffer-font-lock-keywords
      '(("^....[*]Man .*Man.*"    . font-lock-variable-name-face)   ; Man page
        (".*.py"                  . font-lock-comment-face)         ; Python
        (".*.el"                  . font-lock-doc-face)             ; Emacs Lisp
        (".*Dired.*"              . font-lock-comment-face)         ; Dired
        ("^....[*]shell.*"        . font-lock-preprocessor-face)    ; shell buff
        (".*[*]scratch[*].*"      . font-lock-function-name-face)   ; scratch buffer
        ("^....[*].*"             . font-lock-string-face)          ; "*" named buffers
        ("^..[*].*"               . font-lock-constant-face)        ; Modified
        ("^.[%].*"                . font-lock-keyword-face)         ; Read only
        ))

;; Следующие две переменные закомментированы потому, что при их включении
;; не работает "electric-buffer-list"
;; (setq ibuffer-show-empty-filter-groups    nil
;;       ibuffer-use-other-window            t   ;; always display ibuffer in another window
;;       )

(autoload 'ibuffer "ibuffer" "List buffers." t)

(defalias 'list-buffers 'ibuffer)


;; Switching to ibuffer puts the cursor on the most recent buffer
;; При вызове ibuffer курсор помещается на строку
;; с последним посещённым буфером
(defadvice ibuffer (around ibuffer-point-to-most-recent) ()
           "Open ibuffer with cursor pointed to most recent (non-minibuffer) buffer name"
           (let ((recent-buffer-name
                  (if (minibufferp (buffer-name))
                      (buffer-name
                       (window-buffer (minibuffer-selected-window)))
                    (buffer-name (other-buffer)))))
             ad-do-it
             (ibuffer-jump-to-buffer recent-buffer-name)))
(ad-activate 'ibuffer)


(bind-key "C-x C-b" 'ibuffer)
(bind-key "C-z C-b" 'bs-show)
(bind-key "C-z b"   'electric-buffer-list)
(bind-key "s-d m"   'kill-matching-buffers)


(provide 'buffers_config)
