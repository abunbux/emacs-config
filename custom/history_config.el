;;; history_config.el -*- coding: utf-8; lexical-binding: t; -*-

;;;
;;; Time-stamp: <Последнее обновление -- Sunday August 1 20:45:56 EEST 2021>



;;; Commentary:

;;; Code:




(when (not (file-directory-p "~/.emacs.d/cache"))
  (make-directory "~/.emacs.d/cache"))

(when (not (file-directory-p "~/.emacs.d/cache/backup"))
  (make-directory "~/.emacs.d/cache/backup"))
(if (file-directory-p "~/.emacs.d/cache/backup")
    (setq backup-directory-alist '(("" . "~/.emacs.d/cache/backup"))))


(when (not (file-directory-p "~/.emacs.d/cache/auto-save-list/"))
  (make-directory "~/.emacs.d/cache/auto-save-list/"))
(if (file-directory-p "~/.emacs.d/cache/auto-save-list/")
    (setq auto-save-file-name-transforms '((".*" "~/.emacs.d/cache/auto-save-list/\\1" "#"  t))))


;;; force-backup-of-buffer ()
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

(add-hook 'before-save-hook  'force-backup-of-buffer)


(setq-default eww-bookmarks-directory           "~/.emacs.d/cache/"
              projectile-cache-file             "~/.emacs.d/cache/projectile/projectile.cache"
              projectile-known-projects-file    "~/.emacs.d/cache/projectile/known-projects.eld"
              url-configuration-directory       "~/.emacs.d/cache/url/")







(setq backup-by-copying             t
      backup-by-copying-when-linked t
      delete-auto-save-files        nil
      delete-old-versions           t
      kept-new-versions             40
      kept-old-versions             10
      history-delete-duplicates     t
      history-length                250
      version-control               t
      vc-make-backup-files          t)


;; (setq auto-save-interval            500
;;       auto-save-timeout             120)

(setq create-lockfiles              nil)
(setq make-backup-files             nil)
(setq auto-save-default             nil)
(setq auto-save-list-file-name      nil)
(setq auto-save-visited-file-name   nil)
(setq auto-save-list-file-prefix    nil)





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
  (message "Loading \"saveplace\"")
  ;; (save-place-mode t)
  )





;;; savehist
(use-package savehist
  :ensure nil
  :hook
  (after-init . savehist-mode)
  :init
  (setq savehist-additional-variables
        '(compile-history
          command-history
          extended-command-history
          file-name-history
          global-mark-ring
          ido-file-history
          helm-grep-history
          helm-M-x-input-history
          kill-ring
          log-edit-comment-ring
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
        savehist-autosave-interval        60)
  (setq savehist-file     "~/.emacs.d/cache/savehist")
  :config
  (message "Loading \"savehist\"")
  ;; (savehist-mode 1)
  )




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
   recentf-exclude         '("^/var/folders\\.*"
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
  (message "Loading \"recentf\""))



(provide 'history_config)
