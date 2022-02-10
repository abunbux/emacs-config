(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(anzu-deactivate-region t)
 '(anzu-mode-lighter " Az ")
 '(anzu-mode-line-update-function #'my/anzu-update-func)
 '(anzu-replace-threshold 50)
 '(anzu-replace-to-string-separator " => ")
 '(anzu-search-threshold 1000)
 '(package-selected-packages
   '(yasnippet xterm-color winnow which-key wgrep-helm wgrep-ag web-mode volatile-highlights visual-regexp-steroids vimish-fold use-package-hydra tree-sitter-langs syslog-mode swiper-helm smartparens smart-mode-line quelpa-use-package powerline poet-theme phi-grep peep-dired page-break-lines occur-x multiple-cursors move-lines markdown-mode marginalia major-mode-hydra magit loccur ivy-prescient interaction-log iedit ido-vertical-mode ido-completing-read+ htmlize highlight-symbol highlight-parentheses highlight helpful help-fns+ helm-swoop helm-ls-git helm-helm-commands helm-describe-modes helm-descbinds helm-company helm-backup helm-ag gitignore-mode gitconfig-mode gitattributes-mode gcmh free-keys frame-local fnhh flycheck flx-ido emmet-mode elmacro duplicate-thing doom-modeline dired-subtree dired-narrow diminish dash-functional counsel company-shell company-flx benchmark-init bash-completion backup-each-save anzu amx all-the-icons-ivy all-the-icons-dired ag)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-preview-common ((t (:inherit company-preview :foreground "brightcyan"))))
 '(company-preview-search ((t (:inherit company-preview :background "black"))))
 '(company-scrollbar-bg ((t (:background "dark green"))))
 '(company-scrollbar-fg ((t (:background "red"))))
 '(company-template-field ((t (:background "black" :foreground "chartreuse"))))
 '(company-tooltip ((t (:background "black" :foreground "yellow green"))))
 '(company-tooltip-search ((t (:foreground "dark khaki" :underline "blue"))))
 '(company-tooltip-selection ((t (:background "honeydew" :foreground "dark green"))))
 '(highlight-parentheses-highlight ((t (:weight bold :height 1.0 :background "#1d2014"))) t)
 '(hl-line ((((class color) (min-colors 89)) (:inherit t :background "#3d4753" :foreground nil))))
 '(hl-tags-face ((((class color) (min-colors 89)) (:background "#FEFCAE"))))
 '(ivy-modified-buffer ((t (:inherit default :weight bold :foreground "#FD971F"))))
 '(ivy-modified-outside-buffer ((t (:foreground "red" :weight bold))))
 '(ivy-virtual ((t (:inherit default :foreground "green"))))
 '(mode-line ((t (:family "Noto Sans" :height 0.95))))
 '(mode-line-inactive ((t (:family "Noto Sans" :height 0.95))))
 '(vimish-fold-overlay ((t (:foreground "white" :background "#02404f"))))
 '(which-key-command-description-face ((t (:inherit default))))
 '(which-key-group-description-face ((t (:inherit default :foreground "yellow" :weight bold)))))
