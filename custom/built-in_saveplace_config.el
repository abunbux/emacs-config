;;; built-in_saveplace_config.el -*- coding: utf-8; lexical-binding: t; -*-
;;; --- insert here summary

;;; CREATED: <Sun Aug 29 18:08:19 EEST 2021>
;;; Time-stamp: <Последнее обновление -- Sunday August 29 18:8:56 EEST 2021>



;;; Commentary:

;;; Code:




;;; Code:


;;; saveplace
(use-package saveplace
  :ensure nil
  :hook
  (after-init . save-place-mode)

  :init
  (setq save-place-file   "~/.emacs.d/cache/saved-places"
        save-place-forget-unreadable-files    t)
  ;; (setq-default save-place    t)

  :config
  (message "Loading built-in \"saveplace\"")
  ;; (save-place-mode t)
  )




(provide 'built-in_saveplace_config)

;;; built-in_saveplace_config.el ends here
