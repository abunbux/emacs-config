;;; built-in_bookmark_config.el -*- coding: utf-8; lexical-binding: t; -*-
;;; --- insert here summary

;;; CREATED: <Sun Aug 29 19:46:29 EEST 2021>
;;; Time-stamp: <Последнее обновление -- Tuesday October 5 20:10:32 EEST 2021>



;;; Commentary:

;;; Code:




;;; bookmark.el
;; По-умолчанию команды "bookmark" работают с клавишами ("C-x r {M, b, l, m}")
(use-package bookmark
  :ensure nil
  ;; :hook
  ;; (after-init   .   bookmark-mode)
  :preface
  ;; Put Last-Selected Bookmark on Top
  ;; Using this method you’ll find frequently used bookmarks easily
  (defadvice bookmark-jump (after bookmark-jump activate)
    (let ((latest (bookmark-get-bookmark bookmark)))
      (setq bookmark-alist (delq latest bookmark-alist))
      (add-to-list 'bookmark-alist latest)))

  :config
  (message "Loading built-in \"bookmark\"")
  (setq-default bookmark-default-file "~/.emacs.d/cache/bookmarks")
  ;; автоматически сохранять закладки в файл
  (setq bookmark-save-flag t)
  )



(provide 'built-in_bookmark_config)

;;; built-in_bookmark_config.el ends here
