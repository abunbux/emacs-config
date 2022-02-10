;;; built-in_semantic_config.el -*- coding: utf-8; lexical-binding: t; -*-
;;; --- insert here summary

;;; CREATED: <Thu Sep 02 21:18:54 EEST 2021>
;;; Time-stamp: <Последнее обновление -- Thursday September 2 21:19:43 EEST 2021>



;;; Commentary:

;;; Code:




;;; Code:




;;; semantic.el
(use-package semantic
  :ensure nil
  ;; :disabled
  :commands (semantic-mode)
  :init
  :config
  (message "Loading \"semantic\"")
  (with-eval-after-load 'semantic-mode
    (progn
      (message "semantic-mode loaded")
      (setq semantic-idle-summary-function (quote semantic-format-tag-summarize))
      (setq semantic-imenu-bucketize-file t)
      (setq semantic-imenu-bucketize-type-members nil)
      (setq semantic-imenu-buckets-to-submenu nil)
      (setq semantic-imenu-expand-type-members nil)
      (setq semantic-imenu-sort-bucket-function (quote semantic-sort-tags-by-type-increasing-ci))
      (setq semantic-which-function-use-color t)
      ))

  (add-hook 'semantic-mode-hook 'global-semantic-highlight-func-mode)
  (add-hook 'semantic-mode-hook 'global-semantic-idle-completions-mode)
  (add-hook 'semantic-mode-hook 'global-semanticdb-minor-mode)
  (add-hook 'semantic-mode-hook 'global-semantic-highlight-edits-mode)
  (add-hook 'semantic-mode-hook 'global-semantic-idle-summary-mode)
  )




(provide 'built-in_semantic_config)

;;; built-in_semantic_config.el ends here
