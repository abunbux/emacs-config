;;; custom_section_gui.el.el -*- coding: utf-8; lexical-binding: t; -*-

;;; CREATED: <Fri Feb 01 16:50:27 EET 2019>
;;; Time-stamp: <Последнее обновление -- Friday March 6 15:45:14 EET 2020>



;;; Commentary:

;;; Code:




;; (set-face-attribute 'default nil
;;                     :family "Comic Sans MS" )
;; (set-face-attribute 'variable-pitch nil
;;                     :family "Fira Sans" :height 120 :weight 'regular)


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:default    nil
                            :inherit       nil
                            :stipple       nil
                            :background    "#002b36"
                            :foreground    "#c5c9d1"
                            :distant-foreground "orange"
                            :inverse-vidppeo nil
                            :box nil
                            :strike-through nil
                            :overline  nil
                            :underline nil
                            :slant     normal
                            :weight    normal
                            :height    135
                            :width     normal
                            ))))
 ;; ----------------------------------------------------------------

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
 ;; ----------------------------------------------------------------

 '(dired-directory ((t (:inherit nil :foreground "yellow"))))
 ;; ----------------------------------------------------------------

 '(flycheck-error ((((class color)) (:underline "Red"))))
 '(flycheck-warning ((((class color)) (:underline "Orange"))))
 '(font-lock-builtin-face ((((class color) (min-colors 88) (background dark)) (:foreground "#268bd2"))))
 '(font-lock-comment-face ((((class color) (min-colors 88) (background dark)) (:foreground "#5e5c5c"))))
 '(font-lock-comment-delimiter-face ((t (:foreground "#5e5c5c"))))
 '(font-lock-constant-face ((((class color) (min-colors 88) (background dark)) (:foreground "#d33682"))))
 '(font-lock-doc-face ((t (:foreground "#CA3A27"))))
 '(font-lock-doc-string-face ((t (:bold t :foreground "#633A34"))))
 '(font-lock-function-name-face ((((class color) (min-colors 88) (background dark)) (:foreground "#01d302"))))
 '(font-lock-keyword-face ((((class color) (min-colors 88) (background dark)) (:foreground "#2aa198"))))
 '(font-lock-preprocessor-face ((t (:inherit font-lock-builtin-face))))
 '(font-lock-reference-face ((t (bold t :foreground "MediumPurple"))))
 '(font-lock-string-face ((((class color) (min-colors 88) (background dark)) (:foreground "#b58900"))))
 '(font-lock-type-face ((((class color) (min-colors 88) (background dark)) (:foreground "#268bd2"))))
 '(font-lock-variable-name-face ((t (:foreground "#808000" :bold t))))
 '(font-lock-warning-face ((t (:bold t :foreground "Red"))))
 '(fringe ((t (:background "#013340"))))
 ;; ----------------------------------------------------------------

 '(header-line ((default (:inherit mode-line)) (((class color grayscale) (background dark)) (:background "#073642" :foreground "#93a1a1" :box nil))))
 '(help-argument-name ((t (:italic t :slant italic))))
 '(highlight ((((class color) (min-colors 88) (background dark)) (:background "#586e75" :foreground "#002b36"))))
 '(hl-line ((t (:inherit t :background "#3d4753" :foreground nil))))
 ;; ----------------------------------------------------------------

 '(isearch ((((class color) (min-colors 89)) (:foreground "#eeeeec" :background "#ce5c00"))))

 ;; ----------------------------------------------------------------

 '(link ((((class color) (min-colors 88) (background dark)) (:foreground "#aaccff" :underline t))))
 '(linkd-tag ((((class color) (min-colors 88) (background dark)) (:foreground "white" :underline t))))
 '(linkd-tag-name ((((class color) (min-colors 88) (background dark)) (:foreground "white" :underline t))))
 '(linkd-generic-link ((((class color) (min-colors 88) (background dark)) (:foreground "yellow" :underline t))))
 '(linkd-generic-link-name ((((class color) (min-colors 88) (background dark)) (:foreground "yellow" :underline t))))
 ;; ----------------------------------------------------------------

 '(minibuffer-prompt ((((background dark)) (:foreground "#FFFF00"))))
 ;; ----------------------------------------------------------------

 '(region ((t (:bold t :background "#556832" :foreground "white"))))
 ;; ----------------------------------------------------------------

 '(secondary-selection ((((class color) (min-colors 88) (background dark)) (:background "#1f1f1f"))))
 '(show-paren-match ((t ( :background "#3e3b32" :foreground "white"))))
 '(show-paren-mismatch-face ((t (:background "navy" :foreground "white"))))
 '(show-paren-match-expression ((t (:background "#021f26" :foreground nil))))
 '(sr-active-path-face ((t (:foreground "yellow" :weight bold :height 120))))
 '(sr-editing-path-face ((t (:foreground "yellow" :underline "red" :weight bold :height 120))))
 '(sr-highlight-path-face ((t (:foreground "#ace6ac" :underline "magenta" :weight bold :height 120))))
 '(sr-mirror-path-face ((t (:foreground "yellow" :underline "sienna" :weight bold :height 120))))
 '(sr-passive-path-face ((t (:foreground "lightgray" :underline "white" :weight bold :height 120))))
 ;; ----------------------------------------------------------------

 '(vertical-border ((nil (:foreground "#93a1a1"))))
 )


(provide 'custom_section_gui)
