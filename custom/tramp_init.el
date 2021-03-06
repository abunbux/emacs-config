;;;tramp_init.el -*- coding: utf-8; lexical-binding: t -*-

;;; CREATED: <Thu May 16 09:53:18 EEST 2019>
;;; Time-stamp: <Последнее обновление -- Thursday September 2 23:39:56 EEST 2021>



;;; Commentary:

;;; Code:




(use-package tramp
  :defer t
  :preface

  ;;; my/sudired
  (defun my/sudired ()
    (interactive)
    (dired "/su::/"))

  ;; my/su-find-file
  (defun my/su-find-file (file-name)
    "Like find file, but opens the file as root."
    (interactive "FSu Find File: ")
    (let ((tramp-file-name (concat "/su::" (expand-file-name file-name))))
      (find-file tramp-file-name)))

  ;; my/su-find-alternative-file
  ;; Открывает уже открытый файл с правами root (su)
  (defun my/su-find-alternative-file ()
    (interactive)
    (let ((bname (expand-file-name (or buffer-file-name
                                       default-directory)))
          (pt (point)))
      (setq bname (or (file-remote-p bname 'localname)
                      (concat "/su::" bname)))
      (cl-flet ((server-buffer-done
                 (buffer &optional for-killing)
                 nil))
        (find-alternate-file bname))
      (goto-char pt)))

  (defface find-file-root-header-face
    '((t (:foreground "white" :background "red3")))
    "*Face use to display header-lines for files opened as root.")

  ;; Если буфер открыт от root - будет светиться вверху большой баннер с предупреждением.
  (defun find-file-root-header-warning ()
    "*Display a warning in header line of the current buffer.
This function is suitable to add to `find-file-hook'."
    (when (string-equal
           (file-remote-p (or buffer-file-name default-directory) 'user)
           "root")
      (let* ((warning "WARNING: EDITING FILE AS ROOT!")
             (space (+ 6 (- (window-width) (length warning))))
             (bracket (make-string (/ space 2) ?-))
             (warning (concat bracket warning bracket)))
        (setq header-line-format
              (propertize  warning 'face 'find-file-root-header-face)))))

  (add-hook 'find-file-hook 'find-file-root-header-warning)
  (add-hook 'dired-mode-hook 'find-file-root-header-warning)


  :defer t
  :init

  (defvar tramp-backup-directory "~/.emacs.d/cache/tramp-backups/")
  (setq tramp-backup-directory-alist `((".*" . ,tramp-backup-directory)))
  (when (not (file-exists-p tramp-backup-directory))
    (make-directory tramp-backup-directory t))

  (setq tramp-persistency-file-name "~/.emacs.d/cache/tramp")

  :config
  (message "Loading built-in \"tramp\"")

  ;; (require 'tramp)

  (setq tramp-default-method        "ssh"
        ;; password-cache-expiry       nil

        ;; с этой переменной возникает ошибка "tramp-file-name-handler: Wrong type argument: stringp, t"
        ;; tramp-auto-save-directory   t

        tramp-verbose               6)

  (add-to-list 'tramp-default-method-alist
               '("\\`localhost\\'"
                 "\\`root\\'"
                 "su"
                 "sudo"
                 ""
                 "abunbux"
                 "ssh"))

  (use-package tramp-sh
    :defer t
    :config
    (message "Loading built-in \"tramp-sh\"")
    (require 'tramp-sh nil t)
    (setf tramp-ssh-controlmaster-options (concat "-o SendEnv TRAMP=yes " tramp-ssh-controlmaster-options))
    )

  )




(provide 'tramp_init)
