;;; poet-theme_section_gui.el -*- coding: utf-8; lexical-binding: t; -*-
;;; --- insert here summary

;;; CREATED: <Thu Jul 29 21:47:37 EEST 2021>
;;; Time-stamp: <Последнее обновление -- Thursday July 29 22:25:39 EEST 2021>



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






 '(fringe ((t (:background "#e1d9c2"))))
 '(header-line ((t (:overline nil :background "#e0e0e0" :box (:line-width 3 :color "#e0e0e0") :underline "#eeeeee" :inherit mode-line))))
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


 ;; '(mode-line ((t (:inherit fixed-pitch :foreground "#000000" :background "#706d64" :overline "#eeeeee" :box (:line-width 3 :color "#e1d9c2")))))
 ;; '(mode-line-buffer-id ((t (:weight bold))))
 ;; '(mode-line-emphasis ((t (:weight bold))))
 ;; '(mode-line-highlight ((t (:background "#000000"))))
 ;; '(mode-line-inactive ((t (:inherit mode-line :background "#e1d9c2" :foreground "#888888" :box (:color "#e1d9c2" :line-width 3)))))




 '(next-error ((t (:inherit region))))
 ;; '(region ((t (:background "#fff8e1"))))
 '(region ((t (:bold t :background "#556832" :foreground "white"))))
 '(secondary-selection ((t (:background "#fff59d"))))
 '(shadow ((t (:foreground "#999999"))))
 '(show-paren-match ((t (:background "#ffffff" :foreground "#ff1744"))))
 '(tooltip ((t (:inherit default :foreground "#111111" :background "#fff176"))))
 '(trailing-whitespace ((t (:background "#ff8a65"))))
 '(variable-pitch ((t (:family "IBM Plex Serif"))))
 '(vertical-border ((t (:background "#eeeeee" :foreground "#eeeeee"))))
 '(vimish-fold-overlay ((t (:foreground "white" :background "#02404f"))))
 '(which-key-command-description-face ((t (:inherit default))))
 '(which-key-group-description-face ((t (:inherit default :foreground "brown" :weight bold))))
 '(window-divider ((t (:background "#eeeeee" :foreground "#eeeeee"))))


 '(query-replace ((t (:inherit isearch))))



 ;; '(show-paren-match ((t (:background "#3e3b32" :foreground "white"))))
 ;; '(show-paren-match-expression ((t (:background "#021f26" :foreground nil))))
 '(show-paren-mismatch-face ((t (:background "navy" :foreground "white"))))



 '(org-block ((t (:foreground "#000088" :background "#FFFFE0"))))
 '(org-block-background ((t (:background "#FFFFE0"))))
 '(org-block-begin-line ((t (:underline "#A7A6AA" :foreground "#555555" :background "#E2E1D5"))))
 '(org-block-end-line ((t (:overline "#A7A6AA" :foreground "#555555" :background "#E2E1D5"))))
 '(org-code ((t (:foreground "#006400" :background "#FDFFF7"))))



 ;; '(org-block ((t (:inherit shadow :extend t))))
 ;; '(org-block-begin-line ((t (:inherit org-meta-line :extend t :distant-foreground "black" :foreground "brown" :overline "dim gray" :slant italic :height 0.9))))
 ;; '(org-block-end-line ((t (:inherit org-meta-line :extend t :foreground "brown" :underline "dim gray" :height 0.8))))
 ;; '(org-code ((t (:inherit shadow))))
 '(org-document-info ((t (:foreground "brown"))))
 '(org-document-info-keyword ((t (:inherit shadow :slant italic))))

 '(minibuffer-prompt ((((background dark)) (:foreground "#FFFF00"))))


 '(helm-buffer-directory ((t (:foreground "DarkRed"))))
 '(helm-buffer-file ((t (:foreground "White"))))
 '(helm-ff-denied ((t (:foreground "red" :background nil :weight bold))))
 '(helm-ff-directory ((t (:foreground "DarkRed"  :weight bold))))
 '(helm-ff-dotted-directory ((t (:foreground "DarkRed"))))
 '(helm-ff-dotted-symlink-directory ((((class color) (background dark)) :foreground "#8b0000")))
 ;; '(helm-ff-file ((t (:foreground "gray75" :background nil))))
 '(helm-ff-file ((t (:foreground "chocolate" :background nil))))
 '(helm-ff-invalid-symlink ((((class color) (background dark)) :foreground "black" :background "red")))
 '(helm-ff-prefix ((t (:foreground "red" :background nil :weight bold))))
 '(helm-ff-symlink ((t (:foreground "blue" :background "DarkOliveGreen"))))
 '(helm-grep-match ((t (:foreground "#511a1a"))))
 '(helm-match ((t (:foreground "#511a1a"))))
 '(helm-match-item ((t (:foreground "#511a1a" :weight bold))))
 '(helm-non-file-buffer ((t (:foreground "red"))))
 '(helm-selection ((t (:background "#575757" :weight bold))))
 ;; '(helm-source-header ((t (:foreground "white" :background "#511a1a" :weight bold :height 150))))
 '(helm-source-header ((t (:foreground "white" :background "#511a1a" :weight bold :height 130 :family "Sans Serif"))))
 '(helm-swoop-line-number-face ((t (:foreground "DarkRed"))))
 '(helm-visible-mark ((t (:foreground "black" :background "goldenrod"))))




 '(help-argument-name ((t (:italic t :slant italic))))



 )





(provide 'poet-theme_section_gui)

;;; poet-theme_section_gui.el ends here
