;;; built-in_files_config.el -*- coding: utf-8; lexical-binding: t; -*-
;;; --- insert here summary

;;; CREATED: <Sun Aug 29 17:59:02 EEST 2021>
;;; Time-stamp: <Последнее обновление -- Sunday August 29 18:0:4 EEST 2021>



;;; Commentary:

;;; Code:




;;; Code:



;;; files
(use-package files
  :hook
  (before-save . delete-trailing-whitespace)
  (before-save . force-backup-of-buffer)
  :bind
  (
   ("C-c I" .   my/find-user-init-file)
   )

  :custom
  (auto-save-default                nil)
  (auto-save-list-file-prefix       nil)
  (backup-by-copying                t)
  (backup-by-copying-when-linked    t)
  ;; (confirm-kill-emacs               #'yes-or-no-p)
  ;; (confirm-nonexistent-file-or-buffer nil)
  (delete-old-versions              t)
  (delete-auto-save-files           nil)
  (kept-new-versions                40)
  (kept-old-versions                10)
  (require-final-newline            t)
  (version-control                  t)

  :config
  (message "Loading buit-in \"files\"")
  (setq-default find-file-visit-truename t)

  (when (not (file-directory-p "~/.emacs.d/cache/backup"))
    (make-directory "~/.emacs.d/cache/backup")
    (message "make directory \"~/.emacs.d/cache/backup\""))
  (if (file-directory-p "~/.emacs.d/cache/backup")
      (setq backup-directory-alist '(("" . "~/.emacs.d/cache/backup"))))


  ;; (when (not (file-directory-p "~/.emacs.d/cache/auto-save-list/"))
  ;;   (make-directory "~/.emacs.d/cache/auto-save-list/")
  ;;   (message "make directory \"~/.emacs.d/cache/auto-save-list/\""))
  ;; (if (file-directory-p "~/.emacs.d/cache/auto-save-list/")
  ;;     (setq auto-save-list-file-prefix "~/.emacs.d/cache/auto-save-list/"))


  ;; force-backup-of-buffer ()
  (defun force-backup-of-buffer ()
    ;; Make a special "per session" backup at the first save of each
    ;; emacs session.
    (when (not buffer-backed-up)
      ;; Override the default parameters for per-session backups.
      (let ((backup-directory-alist '(("" . "~/.emacs.d/cache/backup/per-session")))
            (kept-new-versions 10))
        (backup-buffer)))
    ;; Make a "per save" backup on each save.  The first save results in
    ;; both a per-session and a per-save backup, to keep the numbering
    ;; of per-save backups consistent.
    (let ((buffer-backed-up nil))
      (backup-buffer)))


  ;;; Быстрое открытие init.el
  ;; my/find-user-init-file ("C-c I")
  (defun my/find-user-init-file ()
    "Edit the `user-init-file'"
    (interactive)
    ;; (find-file-other-window user-init-file) ;; in another window.
    (find-file user-init-file))
  ;; (bind-key "C-c I" 'my/find-user-init-file)


  ;;; my/byte-recompile-config ()
  (defun my/byte-recompile-config (&optional arg)
    (interactive "p")
    "Recompile this Emacs configuration.
If passed a non-nil or called interactively with a C-u, also recompile
files with (apparently) up to date bytecodes."
    (let* ((force (if (called-interactively-p 'any)
                      (and (integerp arg) (= arg 4))
                    arg))
           (init-el-error
            (progn
              (when force
                (delete-file (locate-user-emacs-file "init.elc")))
              (not (byte-compile-file (locate-user-emacs-file "init.el")))))
           (modules-error (string-match-p
                           (rx "failed")
                           (byte-recompile-directory
                            (locate-user-emacs-file "custom/")
                            0
                            force))))
      (or init-el-error modules-error)))



;;; Перезагружает файл инициализации emacs
  ;; Reload current emacs lisp file
  ;; my/reload-current-init-file ()
  (defun my/reload-current-init-file ()
    "Reloads the current initialization file into emacs."
    (interactive)
    (load-file buffer-file-name))



;;; Переименовывает текущий буфер
  ;; my/rename-current-buffer-file ()
  (defun my/rename-current-buffer-file ()
    "Renames current buffer and file it is visiting."
    (interactive)
    (let ((name (buffer-name))
          (filename (buffer-file-name)))
      (if (not (and filename (file-exists-p filename)))
          (error "Buffer '%s' is not visiting a file!" name)
        (let ((new-name (read-file-name "New name: " filename)))
          (if (get-buffer new-name)
              (error "A buffer named '%s' already exists!" new-name)
            (rename-file filename new-name 1)
            (rename-buffer new-name)
            (set-visited-file-name new-name)
            (set-buffer-modified-p nil)
            (message "File '%s' successfully renamed to '%s'"
                     name (file-name-nondirectory new-name)))))))


  ;; Копирует абсолютный путь к файлу и имя файла.
  ;; my/copy-full-file-name-to-clipboard ()
  (defun my/copy-full-file-name-to-clipboard ()
    "Copy the current buffer file name to the clipboard."
    (interactive)
    (let ((filename (if (equal major-mode 'dired-mode)
                        default-directory
                      (buffer-file-name))))
      (when filename
        (kill-new filename)
        (message "Copied buffer file name '%s' to the clipboard." filename))))


  ;; Копирует имя файла без директории.
  ;; my/copy-buffer-file-name-nondirectory ()
  (defun my/copy-buffer-file-name-nondirectory ()
    (interactive)
    (kill-new (file-name-nondirectory buffer-file-name)))


  ;; Копирует имя директории.
  ;; my/copy-buffer-file-name-directory ()
  (defun my/copy-buffer-file-name-directory ()
    (interactive)
    (kill-new (file-name-directory buffer-file-name)))
  )





(provide 'built-in_files_config)

;;; built-in_files_config.el ends here
