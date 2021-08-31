;;; encryption_config.el -*- coding: utf-8; lexical-binding: t -*-

;;; CREATED: <Wed Apr 03 16:33:51 EEST 2019>
;;; Time-stamp: <Последнее обновление -- Monday August 30 17:6:58 EEST 2021>




;;; epg.el
(use-package epg
  :defer t
  :config
  (message "Loading \"epg\"")

  (use-package epg-config
    :after epg
    :init
    :config
    (message "Loading built-in \"epg-config\"")
    (setq epg-gpg-program "gpg2")
    (setq epg-gpg-home-directory "~/.gnupg")
    (setq epg-debug t)
    ))

;;     ;; (setq epg-gpg-program "/usr/local/bin/gpg")


;;; epa.el
(use-package epa
  :defer t
  ;; :after epg
  :config
  (message "Loading built-in \"epa\"")
  (setq epa-armor t)
  (setq epa-pinentry-mode 'loopback)


  ;;; epa-file.el
  (use-package epa-file
    :after epa
    :init
    :config
    (message "Loading built-in \"epa-file\"")
    (require 'epa-file)
    (epa-file-enable)
    ;; (setq epa-file-name-regexp (rx (or ".gpg" ".asc") line-end))
    (setq epa-file-name-regexp "\\.gpg\\(~\\|\\.~[0-9]+~\\)?\\'\\|\\.asc")
    (epa-file-name-regexp-update)
    (setenv "GPG_AGENT_INFO" nil)
    ))



(provide 'encryption_config)
