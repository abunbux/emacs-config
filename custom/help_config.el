;;; help_config.el -*- coding: utf-8; lexical-binding: t -*-

;;; CREATED: <Sun Jul 14 12:50:34 EEST 2019>
;;; Time-stamp: <Последнее обновление -- Friday September 3 15:2:37 EEST 2021>



;;; Commentary:


;; Code:



;; help-fns+.el
(use-package help-fns+
  :quelpa (help-fns+ :fetcher github :repo "emacsmirror/help-fns-plus")
  ;;  Commands defined here:
  ;;
  ;;    `describe-buffer', `describe-command', `describe-file',
  ;;    `describe-face',
  ;;    `describe-keymap', `describe-option', `describe-option-of-type'.

  :bind
  ;;  Keys bound here:
  ;;
  ;;    `C-h B'      `describe-buffer'
  ;;    `C-h c'      `describe-command'     (replaces `describe-key-briefly')
  ;;    `C-h o'      `describe-option'
  ;;    `C-h C-c'    `describe-key-briefly' (replaces `C-h c')
  ;;    `C-h C-o'    `describe-option-of-type'
  ;;    `C-h M-c'    `describe-copying'     (replaces `C-h C-c')
  ;;    `C-h M-f'    `describe-file'
  ;;    `C-h M-k'    `describe-keymap'
  ;;    `C-h M-l'    `find-function-on-key'
  :init
  (require 'help-fns+)
  :config
  (message "Loading \"help-fns+\"")
  )


;;; helpful.el
(use-package helpful
  :ensure t
  :commands (helpful-callable
             helpful-function
             helpful-macro
             helpful-command
             helpful-key
             helpful-variable
             helpful-at-point)

  :bind (
         ("<f6> h c" . helpful-callable)
         ;; ("<f6> h v" . helpful-variable)     ; то же самое `counsel-describe-variable'
         ("<f6> h k" . helpful-key)
         ("<f6> h ." . helpful-at-point)
         ;; ("<f6> h f" . helpful-function)     ; то же самое `counsel-describe-function'
         ("<f6> h C" . helpful-command)
         )
  :init
  :config
  (message "Loading \"helpful\""))




(provide 'help_config)
;;; help_config.el ends here


;; ;; help+.el
;; (use-package help+
;;   :bind (
;;          ;; The following bindings are made here:
;;          ;; Биндинги назначены самим модом (автором мода)
;;          ("C-h k"       . describe-key)
;;          ("C-h ?"       . help-for-help)
;;          ("C-h u"       . manual-entry)
;;          ("C-h C-a"     . apropos)
;;          ("C-h M-a"     . apropos-documentation)
;;          ("C-h C-l"     . locate-library)
;;          ("C-h RET"     . help-on-click/key)
;;          ("C-h M-o"     . pop-to-help-toggle)
;;          ("C-h C-M-a"   . tags-apropos)
;;          )
;;   ;;    `C-h u'      `manual-entry'
;;   ;;    `C-h C-a'    `apropos'
;;   ;;    `C-h C-l'    `locate-library'
;;   ;;    `C-h RET'    `help-on-click/key'
;;   ;;    `C-h M-a'    `apropos-documentation'
;;   ;;    `C-h M-o'    `pop-to-help-toggle'
;;   ;;    `C-h C-M-a'  `tags-apropos'
;;   ;;    [mouse-1]    `mouse-help-on-click' (non-mode-line)
;;   ;;    [mouse-1]    `mouse-help-on-mode-line-click' (mode-line)

;;   :init
;;   (require 'help+)

;;   :config
;;   (message "Loading \"help+\""))
