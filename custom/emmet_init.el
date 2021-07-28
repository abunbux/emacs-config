;; -*- lexical-binding: t -*-

;;; CREATED: <Fri Mar 15 19:08:43 EET 2019>
;;; Time-stamp: <Последнее обновление -- Wednesday February 12 23:12:48 EET 2020>



(use-package emmet-mode
  :ensure t
  :defer t
  :init
  (add-hook 'css-mode-hook    'emmet-mode)
  (add-hook 'html-mode-hook   'emmet-mode)
  (add-hook 'nxml-mode-hook   'emmet-mode)
  (add-hook 'sgml-mode-hook   'emmet-mode)
  (add-hook 'web-mode-hook    'emmet-mode)

  :config
  (message "Loading \"emmet-mode\"")

  ;; If you want to customize Self-closing tags style:
  (setq emmet-self-closing-tag-style " /")
  ;; default "/"
  ;; only " /", "/" and "" are valid.
  ;; eg. <meta />, <meta/>, <meta>

  ;; If you want the cursor to be positioned
  ;; between first empty quotes after expanding:
  (setq emmet-move-cursor-between-quotes t) ;; default nil
  ;;Or if you don't want to move cursor after expanding:
  ;;(setq emmet-move-cursor-after-expanding nil) ;; default
  )


(provide 'emmet_init)
