;;; markdown-mode_init.el -*- lexical-binding: t -*-

;;; CREATED: <Mon Jul 01 21:16:28 EEST 2019>
;;; Time-stamp: <Последнее обновление -- Monday February 24 23:29:29 EET 2020>



;;; Commentary:


;; Code:



(use-package markdown-mode
  :ensure t
  :defer t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'"  . gfm-mode)
         ("\\.md\\'"        . markdown-mode)
         ("\\.markdown\\'"  . markdown-mode))
  :init
  (setq markdown-bold-underscore                t
        markdown-command                        "pandoc"
        ;; syntax highlighting for latex fragments
        markdown-enable-math                    t
        markdown-enable-wiki-links              t
        markdown-fontify-code-blocks-natively   t
        markdown-header-scaling                 t
        markdown-hide-markup                    nil
        ;; trigger with `markdown-toggle-url-hiding'
        markdown-hide-urls                      nil
        markdown-indent-function                t
        markdown-italic-underscore              t
        ;; for compat with org-mode
        markdown-gfm-uppercase-checkbox         t)
        ;; (setq markdown-command "multimarkdown")
        :config
        (message "Loading \"markdown-mode\"")

        ;; Don't change font in code blocks
        ;; (set-face-attribute 'markdown-code-face nil
        ;;                     :inherit nil)

        (custom-set-faces
         '(markdown-header-delimiter-face   ((t (:foreground "mediumpurple"))))
         '(markdown-header-face-1           ((t (:foreground "LimeGreen" :weight bold :height 1.0))))
         '(markdown-header-face-2           ((t (:foreground "lightslateblue" :weight bold :height 1.0))))
         '(markdown-header-face-3           ((t (:foreground "mediumpurple1" :weight bold :height 1.0))))
         '(markdown-link-face               ((t (:background "#0e1014" :foreground "#bd93f9"))))
         '(markdown-list-face               ((t (:foreground "mediumpurple"))))
         '(markdown-pre-face                ((t (:foreground "#bd98fe"))))
        ))


  (provide 'markdown-mode_init)
;;; markdown-mode_init.el ends here
