;;; built-in_recentf_config.el -*- coding: utf-8; lexical-binding: t; -*-
;;; --- insert here summary

;;; CREATED: <Sun Aug 29 19:44:33 EEST 2021>
;;; Time-stamp: <Последнее обновление -- Tuesday October 5 20:7:58 EEST 2021>



;;; Commentary:

;;; Code:




;;; Code:




;;; recentf
(use-package recentf
  :ensure nil
  :bind (
         :map global-map
         ("C-c r r" . recentf-open-files)
         )
  :hook
  (after-init . recentf-mode)
  :init
  (setq-default recentf-save-file "~/.emacs.d/cache/recentf")
  (setq
   recentf-auto-cleanup    "11:00pm"
   recentf-exclude         '("/\\.git/.*\\'"            ; Git contents
                             "^/var/folders\\.*"
                             "COMMIT_EDITMSG\\'"
                             ".*-autoloads\\.el\\'"
                             "\\.loaddefs\\.el"
                             "[/\\]\\.elpa/"
                             "ido.last"
                             "\\/cache/")
   recentf-keep            '(file-remote-p file-readable-p)
   recentf-max-menu-items  100
   recentf-max-saved-items 200)

  :config
  (message "Loading built-in \"recentf\"")
  )




(provide 'built-in_recentf_config)

;;; built-in_recentf_config.el ends here
