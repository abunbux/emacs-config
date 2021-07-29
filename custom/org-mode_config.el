;;; org-mode_config.el -*- coding: utf-8; lexical-binding: t; -*-

;;; CREATED: <Sat Feb 29 16:27:41 EET 2020>
;;; Time-stamp: <Последнее обновление -- Thursday July 29 19:43:12 EEST 2021>



;;; Commentary:

;;; Code:


(use-package org
  :ensure nil
  :defer t
  :bind (
         :map org-mode-map
         ("M-h l s" .   my/hide-headers)
         ("M-h l S" .   my/hide-headers))
  :mode (
         ("\\.org$" . org-mode))
  :init
  (add-hook 'org-mode 'org-wiki-mode)

  (setq org-log-done t)
  (setq org-startup-with-inline-images  t
        org-src-tab-acts-natively       t
        org-support-shift-select        t)

  ;; Hide formatting characters like *, /, _
  (setq org-hide-emphasis-markers t)

  (setq org-fontify-quote-and-verse-blocks t)
  (setq org-startup-folded 'content)

  ;; fontify code in code blocks
  (setq org-src-fontify-natively t)

  :config
  (message "Loading \"org-mode\"")

  (org-babel-do-load-languages
   'org-babel-load-languages
   '(
     (R . t)
     (dot . t)
     (emacs-lisp . t)
     (gnuplot . t)
     (python . t)
     ;;(sh . t)
     (shell . t)
     ))

  (setq org-emphasis-alist
        '(("*" (bold :foreground "Orange" ))
          ("/" (italic :foreground "tomato"))
          ("_" underline)
          ("=" (:foreground "dark khaki"))
          ("~" (:foreground "MidnightBlue"))
          ("+" (:strike-through t))))

  (require 'org-install)

  ;; Чтобы `org' не перезаписывал мои привычные биндинги.
  (define-key org-mode-map (kbd "M-h")      nil)
  (define-key org-mode-map (kbd "C-e")      nil)
  (define-key org-mode-map (kbd "C-a")      nil)
  (define-key org-mode-map (kbd "M-<up>")   nil)
  (define-key org-mode-map (kbd "M-<down>") nil)
  (define-key org-mode-map (kbd "RET")      nil)
  (define-key org-mode-map (kbd "C-j")      nil)


  (bind-key "M-h o t"   'org-toggle-link-display org-mode-map)

  (require 'org-bullets)
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))


  (defvar my/org-src-block-faces nil)
  ;; Для последующих действий требуется `hide-lines'
  (defun my/show-headers ()
    (interactive)
    (setq org-src-block-faces 'my/org-src-block-faces)
    (hide-lines-show-all))

  (defun my/hide-headers ()
    (interactive)
    (setq my/org-src-block-faces 'org-src-block-faces)
    (hide-lines-matching "\\#\\+BEGIN_SRC")
    (hide-lines-matching "END_SRC"))

  ;; (add-hook 'org-mode-hook 'my/hide-headers)

  ;; (defun advice/org-edit-src-code ()
  ;;   (interactive)
  ;;   (my/show-headers))
  ;; (advice-add 'org-edit-src-code :before #'advice/org-edit-src-code)

  ;; (defun advice/org-edit-src-exit ()
  ;;   (interactive)
  ;;   (my/hide-headers))
  ;; (advice-add 'org-edit-src-exit :after #'advice/org-edit-src-exit)

  (font-lock-add-keywords 'org-mode
                          '(("^ *\\([-]\\) "
                             (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))



  ;;   ;; ;; Настройка взята с https://zzamboni.org/post/beautifying-org-mode-in-emacs/
  ;;   ;; ;;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  ;;   (let* ((variable-tuple
  ;;           (cond ((x-list-fonts "ETBembo")         '(:font "ETBembo"))
  ;;                 ((x-list-fonts "Source Sans Pro") '(:font "Source Sans Pro"))
  ;;                 ((x-list-fonts "Lucida Grande")   '(:font "Lucida Grande"))
  ;;                 ((x-list-fonts "Verdana")         '(:font "Verdana"))
  ;;                 ((x-family-fonts "Sans Serif")    '(:family "Sans Serif"))
  ;;                 (nil (warn "Cannot find a Sans Serif Font.  Install Source Sans Pro."))))
  ;;          (base-font-color     (face-foreground 'default nil 'default))
  ;;          (headline           `(:inherit default :weight bold :foreground ,base-font-color)))

  ;;     (custom-theme-set-faces
  ;;      'user
  ;;      `(org-level-8 ((t (,@headline ,@variable-tuple))))
  ;;      `(org-level-7 ((t (,@headline ,@variable-tuple))))
  ;;      `(org-level-6 ((t (,@headline ,@variable-tuple))))
  ;;      `(org-level-5 ((t (,@headline ,@variable-tuple))))
  ;;      `(org-level-4 ((t (,@headline ,@variable-tuple :height 1.001))))
  ;;      `(org-level-3 ((t (,@headline ,@variable-tuple :height 1.01))))
  ;;      `(org-level-2 ((t (,@headline ,@variable-tuple :height 1.02))))
  ;;      `(org-level-1 ((t (,@headline ,@variable-tuple :height 1.03))))
  ;;      `(org-document-title ((t (,@headline ,@variable-tuple :height 2.0 :underline nil))))))

  ;;   (custom-theme-set-faces
  ;;    'user
  ;;    '(variable-pitch ((t (:family "ETBembo" :height 125 :weight thin))))
  ;;    '(fixed-pitch ((t ( :family "Fira Code Retina" :height 110)))))

  ;;   (custom-theme-set-faces
  ;;    'user
  ;;    '(org-block ((t (:inherit fixed-pitch))))
  ;;    '(org-code ((t (:inherit (shadow fixed-pitch)))))
  ;;    '(org-document-info ((t (:foreground "dark orange"))))
  ;;    '(org-document-info-keyword ((t (:inherit (shadow fixed-pitch)))))
  ;;    '(org-indent ((t (:inherit (org-hide fixed-pitch)))))
  ;;    '(org-link ((t (:foreground "royal blue" :underline t))))
  ;;    '(org-meta-line ((t (:inherit (font-lock-comment-face fixed-pitch)))))
  ;;    '(org-property-value ((t (:inherit fixed-pitch))) t)
  ;;    '(org-special-keyword ((t (:inherit (font-lock-comment-face fixed-pitch)))))
  ;;    '(org-table ((t (:inherit fixed-pitch :foreground "#83a598"))))
  ;;    '(org-tag ((t (:inherit (shadow fixed-pitch) :weight bold :height 0.8))))
  ;;    '(org-verbatim ((t (:inherit (shadow fixed-pitch))))))

  ;;   (add-hook 'org-mode-hook 'variable-pitch-mode)
  ;;   (add-hook 'org-mode-hook 'visual-line-mode)

  ;; ;; ;;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<



  ;; ;;   ;; ;; Настройка взята с https://hugocisneros.com/org-config/
  ;; ;;   ;; ;;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  ;; (defun my/buffer-face-mode-variable ()
  ;;   "Set font to a variable width (proportional) fonts in current buffer"
  ;;   (interactive)
  ;;   (setq buffer-face-mode-face '(:family "Roboto Slab"
  ;;                                         :height 150
  ;;                                         :width normal))
  ;;   (buffer-face-mode))


  ;; (defun my/style-org ()
  ;;   ;; I have removed indentation to make the file look cleaner
  ;;   (org-indent-mode -1)
  ;;   (my/buffer-face-mode-variable)
  ;;   (setq line-spacing 0.1
  ;;         org-pretty-entities t
  ;;         org-startup-indented t
  ;;         org-adapt-indentation nil)
  ;;   (variable-pitch-mode +1)
  ;;   (mapc
  ;;    (lambda (face) ;; Other fonts that require it are set to fixed-pitch.
  ;;      (set-face-attribute face nil :inherit 'fixed-pitch))
  ;;    (list 'org-block
  ;;          'org-table
  ;;          'org-verbatim
  ;;          'org-block-begin-line
  ;;          'org-block-end-line
  ;;          'org-meta-line
  ;;          'org-date
  ;;          'org-drawer
  ;;          'org-property-value
  ;;          'org-special-keyword
  ;;          'org-document-info-keyword))
  ;;   (mapc ;; This sets the fonts to a smaller size
  ;;    (lambda (face)
  ;;      (set-face-attribute face nil :height 0.8))
  ;;    (list 'org-document-info-keyword
  ;;          'org-block-begin-line
  ;;          'org-block-end-line
  ;;          'org-meta-line
  ;;          'org-drawer
  ;;          'org-property-value
  ;;          ))
  ;;   ;; (set-face-attribute 'org-indent nil
  ;;   ;; :inherit '(org-hide fixed-pitch))
  ;;   (set-face-attribute 'org-code nil
  ;;                       :inherit '(shadow fixed-pitch))
  ;;   ;; Without indentation the headlines need to be different to be visible
  ;;   (set-face-attribute 'org-level-1 nil
  ;;                       :height 1.25
  ;;                       :foreground "#BEA4DB")
  ;;   (set-face-attribute 'org-level-2 nil
  ;;                       :height 1.15
  ;;                       :foreground "#A382FF"
  ;;                       :slant 'italic)
  ;;   (set-face-attribute 'org-level-3 nil
  ;;                       :height 1.1
  ;;                       :foreground "#5E65CC"
  ;;                       :slant 'italic)
  ;;   (set-face-attribute 'org-level-4 nil
  ;;                       :height 1.05
  ;;                       :foreground "#ABABFF")
  ;;   (set-face-attribute 'org-level-5 nil
  ;;                       :foreground "#2843FB")
  ;;   (set-face-attribute 'org-date nil
  ;;                       :foreground "#ECBE7B"
  ;;                       :height 0.8)
  ;;   (set-face-attribute 'org-document-title nil
  ;;                       :foreground "DarkOrange3"
  ;;                       :height 1.3)
  ;;   (set-face-attribute 'org-ellipsis nil
  ;;                       :foreground "#4f747a" :underline nil)
  ;;   (set-face-attribute 'variable-pitch nil
  ;;                       :family "Roboto Slab" :height 1.2)
  ;;   (mapc (lambda (pair) (push pair prettify-symbols-alist))
  ;;         '(;; Syntax
  ;;           ("TODO" .     "")
  ;;           ("DONE" .     "")
  ;;           ("WAITING" .  "")
  ;;           ("HOLD" .     "")
  ;;           ("NEXT" .     "")
  ;;           ("CANCELLED" . "")
  ;;           ("#+begin_quote" . "“")
  ;;           ("#+end_quote" . "”")))
  ;;   (prettify-symbols-mode +1)
  ;;   (org-superstar-mode +1)
  ;;   )

  ;; (add-hook 'org-mode-hook 'my/style-org)

  ;; ;; ;; ;;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<


  ;; (set-face-attribute 'org-document-title nil :weight 'bold :height 1.1)
  ;; (dolist (face '((org-level-1 . 1.2)
  ;;                 (org-level-2 . 1.1)
  ;;                 (org-level-3 . 1.03)
  ;;                 (org-level-4 . 1.0)
  ;;                 (org-level-5 . 1.01)
  ;;                 (org-level-6 . 1.01)
  ;;                 (org-level-7 . 1.01)
  ;;                 (org-level-8 . 1.01)))
  ;;   ;; (set-face-attribute (car face) nil :font "Dejavu Sans Mono" :weight 'medium ))
  ;;   ;; (set-face-attribute (car face) nil :font "Comic Sans MS" :weight 'medium ))
  ;;   (set-face-attribute (car face) nil :font "Fantasque Sans Mono-14" :weight 'medium ))
  )



(provide 'org-mode_config)
