;;; flycheck_init.el -*- lexical-binding: t -*-

;;; CREATED: <Fri Mar 15 19:01:29 EET 2019>
;;; Time-stamp: <Последнее обновление -- Wednesday February 12 23:14:22 EET 2020>



;;; Code:


(use-package flycheck
  :ensure t
  :defer t
  :commands (flycheck-mode)

  :init
  :config
  (message "Loading \"flycheck\"")
  (with-eval-after-load 'flycheck
    (progn
      (setq flycheck-check-syntax-automatically '(mode-enabled save idle-change)
            flycheck-highlighting-mode          'lines
            flycheck-indication-mode            'left-fringe
            flycheck-checker-error-threshold    2000)

      (bind-key "C-c C-n" 'flycheck-next-error        flycheck-mode-map)
      (bind-key "C-c C-p" 'flycheck-previous-error    flycheck-mode-map)
      (bind-key "C-c f"   'flycheck-list-errors       flycheck-mode-map))))


(provide 'flycheck_init)
;;; flycheck_init.el ends here
