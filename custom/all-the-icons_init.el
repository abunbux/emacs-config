;;; all-the-icons_init.el -*- coding: utf-8; lexical-binding: t; -*-
;;; --- insert here summary

;;; CREATED: <Thu Sep 02 22:45:49 EEST 2021>
;;; Time-stamp: <Последнее обновление -- Thursday September 2 22:46:29 EEST 2021>



;;; Commentary:

;;; Code:




;;; Code:




(use-package all-the-icons
  :ensure t
  ;; :defer t
  :config
  (message "Loading \"all-the-icons\"")
  ;; (unless (find-font (font-spec :name "all-the-icons"))
  ;; (all-the-icons-install-fonts t))
  )



(use-package all-the-icons-dired
  :ensure t
  :hook
  (dired-mode . all-the-icons-dired-mode)
  :config
  (message "Loading \"all-the-icons-dired\"")
  )



(use-package all-the-icons-ivy
  :defer t
  :ensure t
  :hook
  (after-init . all-the-icons-ivy-setup)
  ;; :custom
  ;; (all-the-icons-ivy-buffer-commands '() "Don't use for buffers.")
  :config
  (message "Loading \"all-the-icons-ivy\"")
  ;; (all-the-icons-ivy-setup)
  )





(provide 'all-the-icons_init)

;;; all-the-icons_init.el ends here
