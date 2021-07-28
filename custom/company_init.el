;; -*- lexical-binding: t -*-

;;; CREATED: <Wed May 15 20:00:16 EEST 2019>
;;; Time-stamp: <Последнее обновление -- Thursday March 4 22:40:19 EET 2021>



(use-package company
  :ensure t
  :diminish
  :hook
  (after-init . company-mode)
  :config
  (setq company-auto-complete-chars       '(32 40 41 119 46 34 36 47 124 33)
                company-backends                  '((company-yasnippet
                                                     company-semantic
                                                     company-capf
                                                     company-etags
                                                     company-files
                                                     company-keywords
                                                     company-dabbrev-code
                                                     company-dabbrev
                                                     company-shell
                                                     company-shell-env
                                                     company-fish-shell
                                                     ))
                ;; company-begin-commands            '(self-insert-command)
                company-dabbrev-code-everywhere   t
                company-dabbrev-code-ignore-case  t
                company-dabbrev-downcase          nil
                company-dabbrev-other-buffers     t
                company-echo-delay                0
                company-idle-delay                1
                company-minimum-prefix-length     2
                company-selection-wrap-around     t
                company-show-numbers              nil
                company-tooltip-limit             20
                company-tooltip-align-annotations t)

  (global-company-mode 1)
  (eval-after-load 'company
    '(progn
       (bind-key "TAB" 'company-complete-common-or-cycle company-active-map)
       (bind-key "<tab>" 'company-complete-common-or-cycle company-active-map)
       (message "Loading \"company\"")))
  (bind-key "M-s" 'company-search-candidates  company-active-map)
  (bind-key "M-f" 'company-filter-candidates  company-active-map)
  (bind-key "M-l" 'company-show-location      company-active-map)
  (bind-key "M-n" 'company-select-next        company-active-map)
  (bind-key "M-p" 'company-select-previous    company-active-map)
  (bind-key "C-d" 'company-show-doc-buffer    company-active-map)

  (bind-key "C-c & c" 'company-yasnippet)


  (use-package company-shell
    :defer t
    :ensure t
    :after company
    :config
    (message "Loading \"company-shell\"")
    )


  (custom-set-faces
   '(company-preview-common     ((t (:inherit company-preview :foreground "brightcyan"))))
   '(company-preview-search     ((t (:inherit company-preview :background "black"))))
   '(company-scrollbar-bg       ((t (:background "dark green"))))
   '(company-scrollbar-fg       ((t (:background "red"))))
   '(company-template-field     ((t (:background "black" :foreground "chartreuse"))))
   '(company-tooltip            ((t (:background "black" :foreground "yellow green"))))
   '(company-tooltip-search     ((t (:foreground "dark khaki" :underline "blue"))))
   '(company-tooltip-selection  ((t (:background "honeydew" :foreground "dark green"))))
   )
  )



(provide 'company_init)
