;;; point-history_init.el -*- lexical-binding: t -*-

;;; CREATED: <Thu Jun 27 11:48:53 EEST 2019>
;;; Time-stamp: <Последнее обновление -- Sunday February 2 19:8:36 EET 2020>



;;; Commentary:


;; Code:


(use-package point-history
  :diminish
  :init
  ;; (setq point-history-show-buffer-height 30)
  (setq point-history-ignore-buffer
        "^ \\*Minibuf\\|^ \\*point-history-show*\\|^ \\*Messages*|^ \\*ag search*")
  (setq point-history-save-timer 5)
  ;; (setq point-history-ignore-major-mode '(emacs-lisp-mode ruby-mode))
  :hook
  (after-init . point-history-mode)
  :config
  (message "Loading \"point-history\"")
  ;; (point-history-mode t)
  )



(provide 'point-history_init)
;;; point-history_init.el ends here
