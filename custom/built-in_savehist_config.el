;;; built-in_savehist_config.el -*- coding: utf-8; lexical-binding: t; -*-
;;; --- insert here summary

;;; CREATED: <Sun Aug 29 18:10:13 EEST 2021>
;;; Time-stamp: <Последнее обновление -- Saturday February 4 19:46:59 MSK 2023>



;;; Commentary:

;;; Code:




;;; Code:




;;; savehist
(use-package savehist
  :ensure nil
  :hook
  (after-init . savehist-mode)
  :config
  (message "Loading built-in \"savehist\"")
  (setq savehist-additional-variables
        '(compile-history
          command-history
          ;; extended-command-history
          file-name-history
          global-mark-ring
          ;; ido-file-history
          ;; Info-history-list
          ;; ivy-views
          ;; helm-grep-history
          helm-M-x-input-history
          kill-ring
          ;; log-edit-comment-ring
          mark-ring
          minibuffer-history
          regexp-history
          read-expression-history
          regexp-search-ring
          ring
          savehist-minibuffer-history-variables
          search
          search-ring
          set-variable-value-history
          shell-command-history)
        savehist-save-minibuffer-history  t
        savehist-autosave-interval        180)
  (setq savehist-file     "~/.emacs.d/cache/savehist")
  ;; (savehist-mode 1)
  )



(provide 'built-in_savehist_config)

;;; built-in_savehist_config.el ends here
