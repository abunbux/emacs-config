;;; hydra_init.el -*- coding: utf-8; lexical-binding: t; -*-

;;; CREATED: <Fri Feb 01 16:50:27 EET 2019>
;;; Time-stamp: <Последнее обновление -- Saturday February 4 19:18:42 MSK 2023>



;;; Commentary:

;;; Code:



;; ;;; hydra.el
;; (use-package hydra
;;   :ensure t
;;   :config (message "Loading \"hydra\"")
;;   (require 'hydra-dired_config)       ; переделать под себя
;;   (require 'hydra-help_config)
;;   (require 'hydra-highlight_config)
;;   (require 'hydra-info_config)
;;   (require 'hydra-insert-unicode_config)
;;   (require 'hydra-multiple-cursors_config)
;;   (require 'hydra-vimish-fold_config)
;;   (require 'hydra-rectangle_config)
;;   )


;; ;; hydra
;; (use-package hydra
;;   ;; :pin melpa-stable
;;   :config
;;   (use-package use-package-hydra
;;     ;; :pin melpa-stable
;;     :ensure t
;;     );use-package-hydra
;;   (use-package hydra-posframe
;;     :config
;;     (require 'hydra-posframe)
;;     :custom
;;     (hydra-posframe-parameters
;;      '((left-fringe . 4) (right-fringe . 4) (top-fringe . 4) (bottom-fringe . 4) (height . 18) (width . 105) (min-height . 17) (max-height . 30) (top . 25)))
;;     :custom-face
;;     (hydra-posframe-border-face ((t (:background "#ffffff"))))
;;     (hydra-posframe-face ((t (:background-color "#6272a4"))))
;;     :hook
;;     (after-init . hydra-posframe-enable)
;;     )
;;   ;; end use-package-hydra-posframe
;;   )
;; ;; end use-package hydra

;; ;; Pretty Hydra
;; (use-package pretty-hydra
;;   :ensure t
;;   :config
;;   (require 'pretty-hydra)
;;   )
;; ;; end use package pretty hyrda
;; ;; title generator
;; (require 's)
;; (require 'all-the-icons)
;; (with-eval-after-load 'all-the-icons
;;   (declare-function all-the-icons-faicon 'all-the-icons)
;;   (declare-function all-the-icons-fileicon 'all-the-icons)
;;   (declare-function all-the-icons-material 'all-the-icons)
;;   (declare-function all-the-icons-octicon 'all-the-icons)
;;   )

;; ;; with-faicon function allows an icon in hydra title.
;; ;; Requires following requires and aliases.
;; ;; To omit don't include 'with-faicon' in appearance-title

;; ;; define an icon function with all-the-icons-faicon
;; ;; to use filecon, etc, define same function with icon set%
;; (defun with-faicon (icon str &rest height v-adjust)
;;   (s-concat (all-the-icons-faicon icon :v-adjust (or v-adjust 0) :height (or height 1)) " " str))
;; ;; filecon
;; (defun with-fileicon (icon str &rest height v-adjust)
;;   (s-concat (all-the-icons-fileicon icon :v-adjust (or v-adjust 0) :height (or height 1)) " " str))



;; (use-package major-mode-hydra
;;   :ensure t
;;   ;; :bind
;;   ;; ("M-SPC" . major-mode-hydra)
;;   )

;; (pretty-hydra-define jp-toggles
;;   (:color amaranth :quit-key "q")
;;   ("Basic"
;;    (("n" linum-mode "line number" :toggle t)
;;     ("w" whitespace-mode "whitespace" :toggle t)
;;     ("W" whitespace-cleanup-mode "whitespace cleanup" :toggle t)
;;     ("r" rainbow-mode "rainbow" :toggle t)
;;     ("L" page-break-lines-mode "page break lines" :toggle t))
;;    "Highlight"
;;    (("s" symbol-overlay-mode "symbol" :toggle t)
;;     ("l" hl-line-mode "line" :toggle t)
;;     ("x" highlight-sexp-mode "sexp" :toggle t)
;;     ("t" hl-todo-mode "todo" :toggle t))
;;    "UI"
;;    (("d" jp-themes-toggle-light-dark "dark theme" :toggle jp-current-theme-dark-p))
;;    "Coding"
;;    (("p" smartparens-mode "smartparens" :toggle t)
;;     ("P" smartparens-strict-mode "smartparens strict" :toggle t)
;;     ("S" show-smartparens-mode "show smartparens" :toggle t)
;;     ("f" flycheck-mode "flycheck" :toggle t))
;;    "Emacs"
;;    (("D" toggle-debug-on-error "debug on error" :toggle (default-value 'debug-on-error))
;;     ("X" toggle-debug-on-quit "debug on quit" :toggle (default-value 'debug-on-quit)))))


;; (pretty-hydra-define+ jp-window ()
;;   (;; these heads are added to the existing "Windows" column
;;    "Windows"
;;    (("r" transpose-frame "rotate")
;;     ("z" zone "zone out!"))
;;    ;; this is a new column, which gets added
;;    "Appearance"
;;    (("f" set-frame-font "font")
;;     ("t" load-theme "theme"))))

(provide 'hydra_init)
