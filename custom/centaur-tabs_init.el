;;; centaur-tabs_init.el -*- coding: utf-8; lexical-binding: t; -*-
;;; --- insert here summary

;;; CREATED: <Thu Feb 10 07:19:58 EET 2022>
;;; Time-stamp: <Последнее обновление -- Thursday February 10 7:20:52 EET 2022>



;;; Commentary:




;;; Code:



(use-package centaur-tabs
  :ensure t
  :demand
  :hook
  (dired-mode . centaur-tabs-local-mode)
  :config
  (message "Loading \"centaur-tabs\"")
  (centaur-tabs-mode t)
  (centaur-tabs-headline-match)
  (setq centaur-tabs-style "bar")
  (setq centaur-tabs-set-icons t)
  (setq centaur-tabs-plain-icons t)
  (setq centaur-tabs-gray-out-icons 'buffer)
  (setq centaur-tabs-set-bar 'left)
  (setq centaur-tabs-set-close-button nil)
  (centaur-tabs-change-fonts "arial" 1.0)

)





(provide 'centaur-tabs_init)

;;; centaur-tabs_init.el ends here
