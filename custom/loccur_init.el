;;; loccur_init.el -*- coding: utf-8; lexical-binding: t -*-

;;; CREATED: <Wed Apr 03 19:19:36 EEST 2019>
;;; Time-stamp: <Последнее обновление -- Friday February 14 20:12:15 EET 2020>



;;; Commentary:

;;; Code:




(use-package loccur
  :ensure t
  :defer t
  :commands (loccur loccur-no-highlight)
  :bind (
         :map global-map
         ("M-h l c" . loccur-current)
         ("M-h l o" . loccur)
         ("M-h l p" . loccur-previous-match)
         ("M-h l h" . loccur-no-highlight)
         ("M-h l t" . loccur-toggle-highlight)
         )
  :init
  ;; (setq loccur-jump-beginning-of-line t)

  ;; :hook
  ;; (after-init . loccur-mode)

  :config
  (message "Loading \"loccur\"")

  ;;   ;;; isearch
  ;; (add-hook 'isearch-update-post-hook
  ;;           (lambda ()
  ;;             (let ((loccur-mode nil))
  ;;               (loccur (regexp-quote isearch-string)))))
  ;; (add-hook 'isearch-mode-end-hook
  ;;           (lambda ()
  ;;             (loccur nil)))

  ;;   ;;; vr/isearch
  ;; (add-hook 'vr/isearch-update-post-hook
  ;;           (lambda ()
  ;;             (let ((loccur-mode nil))
  ;;               (loccur (regexp-quote vr/isearch-string)))))

  ;; (add-hook 'vr/isearch-mode-end-hook
  ;;           (lambda ()
  ;;             (loccur nil)))
  )


(provide 'loccur_init)
