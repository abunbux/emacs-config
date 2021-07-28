;;; highlight_init.el -*- coding: utf-8; lexical-binding: t; -*-

;;; CREATED: <Fri Jun 28 14:05:07 EEST 2019>
;;; Time-stamp: <Последнее обновление -- Monday March 2 17:56:29 EET 2020>



;;; Commentary:


;; Code:





;;; highlight.el
;;; * `hlt-...'
;; По-умолчанию "C-x X ...", "C-x X h ...", "C-x X u ..."
(use-package highlight
  :ensure t
  ;; :defer t
  :bind (
         ("M-h h s"     . hlt-highlight-symbol)
         ("M-h h l"     . hlt-highlight-lines)
         ("M-h h C-s"   . hlt-highlight-isearch-matches)

         ("M-h h r"     . hlt-highlight-region)
         ("M-h h d"     . hlt-highlight-line-dups-region)

         ("M-h h M-r"   . hlt-highlight-regexp-groups-region)
         ("M-h h C-r"   . hlt-highlight-regexp-region)

         ("M-h h M--"   . hlt-hide-default-face)
         ("M-h h M-+"   . hlt-show-default-face)

         ("M-h h -"     . hlt-unhighlight-symbol)
         ("M-h h _"     . hlt-unhighlight-all-prop)
         ("M-h h C--"   . hlt-unhighlight-region)

         ("C-M-}"       . hlt-next-highlight)
         ("C-M-{"       . hlt-previous-highlight)

         ;; hlt-unhighlight-isearch-matches
         ;; hlt-highlight-single-quotations
         ;; hlt-unhighlight-region
         )
  :config
  (message "Loading \"highlight\"")
  (setq hlt-auto-face-foreground t)
  )



;;; highlight-symbol.el
;;; https://www.emacswiki.org/emacs/HighlightSymbol
;; * `highlight-symbol'
;; * `highlight-symbol-...'
(use-package highlight-symbol
  :ensure t
  ;; :defer t
  :preface

  ;; ;;; https://github.com/mwfogleman/.emacs.d/blob/master/michael.org ********
  ;; ;; highlight-symbol-first ("----------")
  ;; ;; highlight-symbol-last ("---------")
  ;; ;; Не пользуюсь.
  ;; (defun my/highlight-symbol-first ()
  ;;   "Jump to the first location of symbol at point."
  ;;   (interactive)
  ;;   (push-mark)
  ;;   (eval
  ;;    `(progn
  ;;       (goto-char (point-min))
  ;;       (search-forward-regexp
  ;;        (rx symbol-start ,(thing-at-point 'symbol) symbol-end)
  ;;        nil t)
  ;;       (beginning-of-thing 'symbol))))
  ;;
  ;; (defun my/highlight-symbol-last ()
  ;;   "Jump to the last location of symbol at point."
  ;;   (interactive)
  ;;   (push-mark)
  ;;   (eval
  ;;    `(progn
  ;;       (goto-char (point-max))
  ;;       (search-backward-regexp
  ;;        (rx symbol-start ,(thing-at-point 'symbol) symbol-end)
  ;;        nil t))))

  ;; my/highlight-symbol-occur ("M-s s RET")
  (defun my/highlight-symbol-occur ()
    (interactive)
    (highlight-symbol-occur)
    (other-window 1))

  :bind (
         ("M-h h H"         . highlight-symbol-mode)
         ;; `highlight-symbol-nav-mode' to enable
         ;; key bindings (M-p and M-p) for navigation.
         ("M-h h N"         . highlight-symbol-nav-mode)
         ("M-h h ."         . highlight-symbol-at-point)
         ("M-h h M-%"       . highlight-symbol-query-replace)
         ("M-+"             . highlight-symbol-next)
         ("M--"             . highlight-symbol-prev)
         ("M-s s RET"       . my/highlight-symbol-occur)
         ;; ("------"       . highlight-symbol-query-replace)
         )

  :init
  (setq highlight-symbol-idle-delay       0.2
        highlight-symbol-on-navigation-p  t)

  :config
  (message "Loading \"highlight-symbol\"")
  )



;;; hl-sentence.el
;; находится "~/.emacs.d/lisp/hl-sentence.el"
(use-package hl-sentence
  :defer t
  :commands (hl-sentence-mode)
  :bind (("M-h h P" . hl-sentence-mode))
  :init
  :config
  (message "Loading \"hl-sentence\"")

  (set-face-attribute 'hl-sentence nil
                      :foreground "#000"
                      :background "#111"))




(provide 'highlight_init)
;;; highlight_init.el ends here
