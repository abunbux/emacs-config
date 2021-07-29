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
 '(blink-cursor-mode nil)
 '(calibredb-format-all-the-icons t nil nil "Customized with use-package calibredb")
 '(column-number-mode t)
 '(custom-enabled-themes '(smart-mode-line-light))
 '(custom-safe-themes
   '("28a104f642d09d3e5c62ce3464ea2c143b9130167282ea97ddcc3607b381823f" "a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" default))
 '(helm-ff-lynx-style-map t)
 '(helm-grep-use-ioccur-style-keys t)
 '(helm-imenu-lynx-style-map t)
 '(helm-occur-use-ioccur-style-keys t)
 '(helm-semantic-lynx-style-map t)
 '(package-selected-packages
   '(poet-theme bash-completion company-shell visual-regexp-steroids vimish-fold anzu phi-grep ag visual-regexp wgrep-ag wgrep-helm wgrep winnow occur-x backup-each-save smart-mode-line rich-minority helm-backup htmlize free-keys iedit multiple-cursors syslog-mode gitignore-mode gitconfig-mode gitattributes-mode magit flycheck markdown-mode emmet-mode web-mode hide-lines loccur hydra volatile-highlights move-lines elmacro duplicate-thing highlight-symbol highlight yasnippet amx which-key smartparens helm-swoop swiper-helm helm-ls-git helm-helm-commands helm-describe-modes helm-descbinds helm-company helm-ag helm flx counsel ivy peep-dired dired-subtree dired-narrow helpful help-fns+ interaction-log diminish benchmark-init quelpa-use-package))
 '(show-paren-mode t)
 '(size-indication-mode t)
 '(sml/pos-id-separator "| ")
 '(sml/pos-minor-modes-separator " /")
 '(sml/pre-id-separator "|")
 '(sml/pre-minor-modes-separator "/ ")
 '(sml/pre-modes-separator "| |")
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:default nil :inherit nil :stipple nil :background "#002b36" :foreground "#c5c9d1" :distant-foreground "orange" :inverse-vidppeo nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 143 :width normal :family "DejaVu Sans Mono for Powerline" :foundry "PfEd"))))
 '(comint-highlight-input ((t (:foreground "#2aa198"))))
 '(comint-highlight-prompt ((((min-colors 88) (background dark)) (:foreground "#268bd2"))))
 '(company-preview-common ((t (:inherit company-preview :foreground "brightcyan"))))
 '(company-preview-search ((t (:inherit company-preview :background "black"))))
 '(company-scrollbar-bg ((t (:background "dark green"))))
 '(company-scrollbar-fg ((t (:background "red"))))
 '(company-template-field ((t (:background "black" :foreground "chartreuse"))))
 '(company-tooltip ((t (:background "black" :foreground "yellow green"))))
 '(company-tooltip-search ((t (:foreground "dark khaki" :underline "blue"))))
 '(company-tooltip-selection ((t (:background "honeydew" :foreground "dark green"))))
 '(cursor ((t (:background "#7CFC00" :foreground "#CED23A"))))
 '(custom-button ((((type x w32 ns) (class color)) (:background "#073642" :foreground "#93a1a1" :box (:line-width 2 :color "#073642" :style released-button)))))
 '(custom-button-mouse ((((type x w32 ns) (class color)) (:background "#586e75" :foreground "#93a1a1" :box (:line-width 2 :style released-button)))))
 '(custom-button-pressed ((((type x w32 ns) (class color)) (:background "#586e75" :foreground "#93a1a1" :box (:line-width 2 :style pressed-button)))))
 '(custom-changed-face ((t (:background "blue" :foreground "white"))))
 '(custom-documentation-face ((t (nil))))
 '(custom-face-tag-face ((t (:underline t))))
 '(custom-group-tag-face ((t (:underline t :foreground "blue"))))
 '(custom-group-tag-face-1 ((t (:underline t :foreground "red"))))
 '(custom-invalid-face ((t (:background "red" :foreground "yellow"))))
 '(custom-modified-face ((t (:background "blue" :foreground "white"))))
 '(custom-rogue-face ((t (:background "black" :foreground "pink"))))
 '(custom-saved-face ((t (:underline t))))
 '(custom-set-face ((t (:background "white" :foreground "blue"))))
 '(custom-state ((((class color) (background dark)) (:foreground "#859900"))))
 '(custom-state-face ((t (:foreground "dark green"))))
 '(custom-variable-button-face ((t (:underline t :bold t))))
 '(custom-variable-tag-face ((t (:underline t :foreground "blue"))))
 '(custom-visibility ((t (:inherit link))))
 '(dired-directory ((t (:inherit nil :foreground "yellow"))))
 '(flycheck-error ((((class color)) (:underline "Red"))))
 '(flycheck-warning ((((class color)) (:underline "Orange"))))
 '(fringe ((t (:background "#013340"))))
 '(header-line ((default (:inherit mode-line)) (((class color grayscale) (background dark)) (:background "#073642" :foreground "#93a1a1" :box nil))))
 '(highlight ((((class color) (min-colors 88) (background dark)) (:background "#586e75" :foreground "#002b36"))))
 '(hl-line ((t (:inherit t :background "#3d4753" :foreground nil))))





 '(ivy-modified-buffer ((t (:inherit default :weight bold :foreground "#FD971F"))))
 '(ivy-modified-outside-buffer ((t (:foreground "red" :weight bold))))
 '(ivy-virtual ((t (:inherit default :foreground "green"))))



 '(link ((((class color) (min-colors 88) (background dark)) (:foreground "#aaccff" :underline t))))
 '(linkd-generic-link ((((class color) (min-colors 88) (background dark)) (:foreground "yellow" :underline t))))
 '(linkd-generic-link-name ((((class color) (min-colors 88) (background dark)) (:foreground "yellow" :underline t))))
 '(linkd-tag ((((class color) (min-colors 88) (background dark)) (:foreground "white" :underline t))))
 '(linkd-tag-name ((((class color) (min-colors 88) (background dark)) (:foreground "white" :underline t))))



 '(magit-diff-added ((t (:background "black" :foreground "green3"))))
 '(magit-diff-removed ((t (:background "black" :foreground "red3"))))




 '(secondary-selection ((((class color) (min-colors 88) (background dark)) (:background "#1f1f1f"))))





 '(sr-active-path-face ((t (:foreground "yellow" :weight bold :height 120))))
 '(sr-editing-path-face ((t (:foreground "yellow" :underline "red" :weight bold :height 120))))
 '(sr-highlight-path-face ((t (:foreground "#ace6ac" :underline "magenta" :weight bold :height 120))))
 '(sr-mirror-path-face ((t (:foreground "yellow" :underline "sienna" :weight bold :height 120))))
 '(sr-passive-path-face ((t (:foreground "lightgray" :underline "white" :weight bold :height 120))))



 '(vertical-border ((nil (:foreground "#93a1a1"))))



 '(vimish-fold-overlay ((t (:foreground "white" :background "#02404f"))))

)
