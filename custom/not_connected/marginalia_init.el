;;; marginalia_init.el -*- coding: utf-8; lexical-binding: t; -*-
;;; --- insert here summary

;;; CREATED: <Thu Sep 02 22:47:53 EEST 2021>
;;; Time-stamp: <Последнее обновление -- Thursday September 2 22:48:13 EEST 2021>



;;; Commentary:

;;; Code:




;;; Code:




;; Enable richer annotations using the Marginalia package
(use-package marginalia
  :ensure t
  ;; Either bind `marginalia-cycle` globally or only in the minibuffer
  :bind (("M-A" . marginalia-cycle)
         :map minibuffer-local-map
         ("M-A" . marginalia-cycle))

  :init
  (marginalia-mode)
  :config
  (message "Loading \"marginalia\"")
  ;; (add-to-list 'marginalia-prompt-categories '("sketch" . sketch))
  (setq marginalia-align-offset 10)
  )





(provide 'marginalia_init)

;;; marginalia_init.el ends here
