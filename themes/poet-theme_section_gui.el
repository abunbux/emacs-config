;;; poet-theme_section_gui.el -*- coding: utf-8; lexical-binding: t; -*-
;;; --- insert here summary

;;; CREATED: <Thu Jul 29 21:47:37 EEST 2021>
;;; Time-stamp: <Последнее обновление -- Friday July 30 19:32:28 EEST 2021>



;;; Commentary:

;;; Code:




;;; Code:


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(button ((t (:inherit default :foreground "#616161"))))
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
 '(cursor ((t (:background "#333333"))))
 ;; '(default ((t (:background "#e1d9c2" :foreground "#444444"))))
 '(default ((t (:family "DejaVu Sans Mono" :height 110 :background "#e1d9c2" :foreground "#2b2727"))))
 '(escape-glyph ((t (:foreground "#673AB7"))))
 '(fixed-pitch ((t (:family "DejaVu Sans Mono"))))


 '(error ((t (:foreground "#df5286" :inherit fixed-pitch))))






 '(font-lock-string-face ((t (:inherit fixed-pitch :foreground "#6C3082"))))
 ;; '(font-lock-string-face ((((class color) (min-colors 88) (background dark)) (:foreground "#b58900"))))
 '(font-lock-builtin-face ((t (:foreground "#795548" :inherit fixed-pitch))))
 ;; '(font-lock-builtin-face ((((class color) (min-colors 88) (background dark)) (:foreground "#268bd2"))))


 '(font-lock-doc-string-face ((t (:bold t :foreground "#633A34"))))
 '(font-lock-function-name-face ((t (:inherit fixed-pitch :foreground "#388E3C"))))
 ;; '(font-lock-function-name-face ((((class color) (min-colors 88) (background dark)) (:foreground "#01d302"))))
 '(font-lock-keyword-face ((t (:inherit fixed-pitch :foreground "#bf360c"))))
 ;; '(font-lock-keyword-face ((((class color) (min-colors 88) (background dark)) (:foreground "#2aa198"))))

 '(font-lock-comment-delimiter-face ((t (:inherit fixed-pitch :foreground "#7a7979"))))
 '(font-lock-comment-face ((t (:foreground "#7a7979" :inherit fixed-pitch))))

 '(font-lock-constant-face ((t (:inherit fixed-pitch :foreground "#0288D1"))))
 ;; '(font-lock-constant-face ((((class color) (min-colors 88) (background dark)) (:foreground "#d33682"))))
 '(font-lock-doc-face ((t (:inherit fixed-pitch :inherit font-lock-string-face))))
 ;; '(font-lock-doc-face ((t (:foreground "#CA3A27"))))
 '(font-lock-preprocessor-face ((t (:inherit fixed-pitch :inherit font-lock-builtin-face))))
 '(font-lock-reference-face ((t (bold t :foreground "MediumPurple"))))
 '(font-lock-regexp-grouping-backslash ((t (:inherit fixed-pitch :inherit bold))))
 '(font-lock-regexp-grouping-construct ((t (:inherit fixed-pitch :inherit bold))))
 '(font-lock-type-face ((t (:foreground "#3f51b5" :inherit fixed-pitch))))
 ;; '(font-lock-type-face ((((class color) (min-colors 88) (background dark)) (:foreground "#268bd2"))))
 '(font-lock-variable-name-face ((t (:inherit fixed-pitch :foreground "#455A64"))))
 ;; '(font-lock-variable-name-face ((t (:foreground "#808000" :bold t))))
 '(font-lock-warning-face ((t (:inherit error))))
 ;; '(font-lock-warning-face ((t (:bold t :foreground "Red"))))




 ;; header-line-highlight

 '(fringe ((t (:background "#e1d9c2"))))
 '(header-line ((t (:overline nil :foreground "#878710" :background "#e0e0e0" :box (:line-width 3 :color "#e0e0e0") :underline "#eeeeee"))))
 '(highlight ((t (:background "#efefef" :overline nil))))
 '(hl-line ((t (:background "#efefef"))))


 '(isearch ((t (:foreground "#eeeeec" :background "#ce5c00"))))
 '(isearch-fail ((t (:background "#f8bbd0"))))
 ;; '(isearch ((((class color) (min-colors 89)) (:foreground "#eeeeec" :background "#ce5c00"))))

 '(italic ((t (:foreground "#222222" :slant italic))))
 '(ivy-modified-buffer ((t (:inherit default :weight bold :foreground "#FD971F"))))
 '(ivy-modified-outside-buffer ((t (:foreground "red" :weight bold))))
 '(ivy-org ((t (:inherit fixed-pitch))))
 '(ivy-virtual ((t (:inherit default :foreground "green"))))
 '(lazy-highlight ((t (:foreground "#000000" :background "#ffffff"))))
 '(line-number ((t (:inherit fixed-pitch :foreground "#aaaaaa"))))
 '(line-number-current-line ((t (:inherit fixed-pitch :foreground "#555555"))))
 '(link ((t (:underline (:color "#304ffe" :style line) :foreground "#303f9f"))))
 '(link-visited ((t (:inherit link :foreground "#303f9f" :underline (:color "#1a237e" :style line)))))
 '(minibuffer-prompt ((t (:inherit fixed-pitch :weight bold :foreground "#4e342e"))))


 ;; Mode line faces
 '(mode-line ((t (:box (:line-width 1 :color "#1A2F54") :foreground "#C2C2C2" :background "#031A42"))))
 '(mode-line-inactive ((t (:box (:line-width 1 :color "#4E4E4C") :foreground "#F0F0EF" :background "#9B9C97"))))
 '(mode-line-buffer-id ((t (:weight bold :foreground "white"))))
 '(mode-line-emphasis ((t (:weight bold :foreground "white"))))
 '(mode-line-highlight ((t (:foreground "yellow"))))




 '(next-error ((t (:inherit region))))
 '(region ((t (:bold t :background "#556832" :foreground "white"))))
 '(secondary-selection ((t (:background "#fff59d"))))
 '(shadow ((t (:foreground "#999999"))))

 '(show-paren-match ((t (:background "#ffffff" :foreground "#ff1744"))))
 '(show-paren-mismatch-face ((t (:background "navy" :foreground "white"))))

 '(tooltip ((t (:inherit default :foreground "#111111" :background "#fff176"))))
 '(trailing-whitespace ((t (:background "#ff8a65"))))
 '(variable-pitch ((t (:family "IBM Plex Serif"))))
 '(vertical-border ((t (:background "#eeeeee" :foreground "#eeeeee"))))
 '(vimish-fold-overlay ((t (:foreground "white" :background "#02404f"))))
 '(which-key-command-description-face ((t (:inherit default))))
 '(which-key-group-description-face ((t (:inherit default :foreground "brown" :weight bold))))
 '(window-divider ((t (:background "#eeeeee" :foreground "#eeeeee"))))


 '(query-replace ((t (:inherit isearch))))






 '(org-block ((t (:foreground "#000088" :background "#FFFFE0"))))
 '(org-block-background ((t (:background "#FFFFE0"))))
 '(org-block-begin-line ((t (:underline "#A7A6AA" :foreground "#555555" :background "#E2E1D5"))))
 '(org-block-end-line ((t (:overline "#A7A6AA" :foreground "#555555" :background "#E2E1D5"))))
 '(org-code ((t (:foreground "#006400" :background "#FDFFF7"))))
 '(org-default ((t (:foreground "#333333" :background "#FFFFFF"))))
 '(org-document-info ((t (:foreground "brown"))))
 '(org-document-info-keyword ((t (:inherit shadow :slant italic))))
 '(org-document-title ((t (:weight bold :height 1.1))))




 '(minibuffer-prompt ((((background dark)) (:foreground "#FFFF00"))))








 '(helm-action ((t (:foreground "black"))))
 '(helm-bookmarks-su-face ((t (:foreground "red"))))
 '(helm-buffer-directory ((t (:foreground "DarkRed"))))
 '(helm-buffer-file ((t (:foreground "White"))))
 '(helm-buffer-process ((t (:foreground "#008200"))))
 '(helm-candidate-number ((t (:foreground "black" :background "#FFFF66"))))
 '(helm-dir-heading ((t (:foreground "blue" :background "pink"))))
 '(helm-dir-priv ((t (:foreground "dark red" :background "light grey"))))
 '(helm-ff-directory ((t (:weight bold :foreground "blue" :background "#FFFFD2"))))
 ;; '(helm-ff-directory ((t (:foreground "DarkRed"  :weight bold))))
 '(helm-ff-denied ((t (:foreground "red" :background nil :weight bold))))
 '(helm-ff-dotted-directory ((t (:foreground "DarkRed"))))
 '(helm-ff-dotted-symlink-directory ((((class color) (background dark)) :foreground "#8b0000")))
 '(helm-ff-executable ((t (:foreground "green3" :background "white"))))
 '(helm-ff-file ((t (:foreground "black"))))
 ;; '(helm-ff-file ((t (:foreground "chocolate" :background nil))))
 ;; '(helm-ff-invalid-symlink ((t (:foreground "yellow" :background "red"))))
 '(helm-ff-invalid-symlink ((((class color) (background dark)) :foreground "black" :background "red")))
 '(helm-ff-prefix ((t (:foreground "red" :background nil :weight bold))))
 ;; '(helm-ff-symlink ((t (:foreground "deep sky blue"))))
 '(helm-ff-symlink ((t (:foreground "blue" :background "DarkOliveGreen"))))
 '(helm-file-name ((t (:foreground "blue"))))
 '(helm-header ((t (:foreground "black" :background "goldenrod"))))
 '(helm-helper ((t (:foreground "red" :background "green"))))
 '(helm-gentoo-match-face ((t (:foreground "red"))))
 ;; '(helm-grep-match ((t (:weight bold :background "#FBE448"))))
 '(helm-grep-match ((t (:foreground "#511a1a"))))
 '(helm-grep-running ((t (:weight bold :foreground "white"))))
 '(helm-grep-lineno ((t (:foreground "#7F7F7F"))))
 '(helm-isearch-match ((t (:background "#CCFFCC"))))
 '(helm-match ((t (:weight bold :background "#FBE448"))))
 ;; '(helm-match ((t (:foreground "#511a1a"))))
 '(helm-match-item ((t (:foreground "#511a1a" :weight bold))))
 '(helm-minibuffer-prompt ((t (:foreground "black" :background "goldenrod"))))
 '(helm-moccur-buffer ((t (:foreground "#0066CC"))))
 '(helm-non-file-buffer ((t (:foreground "red"))))
 '(helm-selection ((t (:underline nil :background "#FFF876"))))
 ;; '(helm-selection ((t (:background "#575757" :weight bold))))
 '(helm-selection-line ((t (:underline nil :background "#FFF876"))))
 ;; '(helm-selection-line ((t (:foreground "black" :background "goldenrod"))))
 ;; '(helm-source-header ((t (:family "Sans Serif" :height 1.3 :weight bold :foreground "white" :background "#2F69BF"))))
 '(helm-source-header ((t (:foreground "white" :background "#511a1a" :weight bold :height 130 :family "Sans Serif"))))
 '(helm-swoop-line-number-face ((t (:foreground "DarkRed"))))
 '(helm-swoop-target-line-face ((t (:underline nil :background "#FFF876"))))
 '(helm-swoop-target-line-block-face ((t (:background "#CCCC00" :foreground "#222222"))))
 '(helm-swoop-target-word-face ((t (:weight bold :foreground nil :background "#FDBD33"))))
 '(helm-visible-mark ((t (:weight bold :foreground "white" :background "red"))))
 ;; '(helm-visible-mark ((t (:foreground "black" :background "goldenrod"))))
 '(helm-w3m-bookmarks-face ((t (:underline t :foreground "cyan1"))))







 ;; '(help-argument-name ((t (:italic t :slant italic))))



 )





(provide 'poet-theme_section_gui)

;;; poet-theme_section_gui.el ends here
