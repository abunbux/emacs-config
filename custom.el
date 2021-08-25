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
 '(helm-ff-lynx-style-map t)
 '(helm-grep-use-ioccur-style-keys t)
 '(helm-imenu-lynx-style-map t)
 '(helm-occur-use-ioccur-style-keys t)
 '(helm-semantic-lynx-style-map t)
 '(package-selected-packages
   '(ido-completing-read+ ido-vertical-mode flx-ido hydra-posframe use-package-hydra frame-local dash-functional major-mode-hydra highlight-parentheses dashboard all-the-icons-dired doom-modeline tree-sitter-langs tree-sitter yasnippet xterm-color winnow which-key wgrep-helm wgrep-ag web-mode volatile-highlights visual-regexp-steroids vimish-fold syslog-mode smartparens smart-mode-line quelpa-use-package poet-theme phi-grep peep-dired occur-x multiple-cursors move-lines markdown-mode magit loccur interaction-log iedit hydra htmlize highlight-symbol highlight helpful help-fns+ helm-swoop helm-ls-git helm-helm-commands helm-describe-modes helm-descbinds helm-company helm-backup helm-ag gitignore-mode gitconfig-mode gitattributes-mode free-keys flycheck flx emmet-mode elmacro duplicate-thing dired-subtree dired-narrow diminish company-shell benchmark-init bash-completion backup-each-save anzu amx ag))
 '(sml/pos-id-separator "| ")
 '(sml/pos-minor-modes-separator " /")
 '(sml/pre-id-separator "|")
 '(sml/pre-minor-modes-separator "/ ")
 '(sml/pre-modes-separator "| |"))
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
 '(dashboard-heading ((t (:inherit (font-lock-string-face bold)))))
 '(highlight-parentheses-highlight ((t (:weight bold :height 1.0 :background "#1d2014"))) t)
 '(hl-line ((((class color) (min-colors 89)) (:inherit t :background "#3d4753" :foreground nil))))
 '(hl-tags-face ((((class color) (min-colors 89)) (:background "#FEFCAE"))))
 '(ido-first-match ((t (:foreground "#ccff66" :background "black"))))
 '(ido-only-match ((t (:foreground "#003366" :background "#d0d0d0"))))
 '(ido-subdir ((t (:bold t :foreground "#66ff00" :background "#142300"))))
 '(ido-vertical-first-match ((t (:foreground "#ccff66" :background "black" :italic t :bold))))
 '(ido-vertical-match ((t (:foreground "ForestGreen" :background "yellow" :italic t :bold))))
 '(ido-vertical-only-match ((t (:foreground "#003366" :background "#d0d0d0"))))
 '(ivy-modified-buffer ((t (:inherit default :weight bold :foreground "#FD971F"))))
 '(ivy-modified-outside-buffer ((t (:foreground "red" :weight bold))))
 '(ivy-virtual ((t (:inherit default :foreground "green"))))
 '(mode-line ((t (:family "Noto Sans" :height 1.0))))
 '(mode-line-inactive ((t (:family "Noto Sans" :height 0.95))))
 '(vimish-fold-overlay ((t (:foreground "white" :background "#02404f"))))
 '(which-key-command-description-face ((t (:inherit default))))
 '(which-key-group-description-face ((t (:inherit default :foreground "yellow" :weight bold)))))
