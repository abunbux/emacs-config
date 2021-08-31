;;; custom_section_gui.el.el -*- coding: utf-8; lexical-binding: t; -*-

;;; CREATED: <Fri Feb 01 16:50:27 EET 2019>
;;; Time-stamp: <Последнее обновление -- Monday August 2 22:1:38 EEST 2021>



;;; Commentary:

;;; Code:




;; (set-face-attribute 'default nil
;;                     :family "Comic Sans MS" )
;; (set-face-attribute 'variable-pitch nil
;;                     :family "Fira Sans" :height 120 :weight 'regular)


(custom-set-faces
 ;; ----------------------------------------------------------------

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


 ;; ----------------------------------------------------------------

 '(flycheck-error ((((class color)) (:underline "Red"))))
 '(flycheck-warning ((((class color)) (:underline "Orange"))))
 '(fringe ((t (:background "#013340"))))
 ;; ----------------------------------------------------------------


 '(help-argument-name ((t (:italic t :slant italic))))
 ;; ----------------------------------------------------------------



 ;; ----------------------------------------------------------------

 ;; ----------------------------------------------------------------


 ;; ----------------------------------------------------------------


 ;; ----------------------------------------------------------------



 '(sr-active-path-face ((t (:foreground "yellow" :weight bold :height 120))))
 '(sr-editing-path-face ((t (:foreground "yellow" :underline "red" :weight bold :height 120))))
 '(sr-highlight-path-face ((t (:foreground "#ace6ac" :underline "magenta" :weight bold :height 120))))
 '(sr-mirror-path-face ((t (:foreground "yellow" :underline "sienna" :weight bold :height 120))))
 '(sr-passive-path-face ((t (:foreground "lightgray" :underline "white" :weight bold :height 120))))
 ;; ----------------------------------------------------------------

 '(vertical-border ((nil (:foreground "#93a1a1"))))



 ;; '(org-level-1 ((t (:foreground "#446350"))))
 ;; '(org-level-2 ((t (:foreground "#446350"))))
 ;; '(org-level-3 ((t (:foreground "#446350"))))
 ;; '(org-level-4 ((t (:foreground "#446350"))))
 ;; '(org-level-5 ((t (:foreground "#446350"))))
 ;; '(org-level-6 ((t (:foreground "#446350"))))
 ;; '(org-level-7 ((t (:foreground "#446350"))))
 ;; '(org-level-8 ((t (:foreground "#446350"))))

 )


(provide 'custom_section_gui)
