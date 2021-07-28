;; -*- lexical-binding: t -*-

;;; CREATED: <Mon Mar 18 23:50:41 EET 2019>
;;; Time-stamp: <Последнее обновление -- Tuesday April 16 20:5:16 EEST 2019>



;;; linkd
(require 'linkd)

;; (dolist
;;     (hook
;;      (list
;;       'lisp-mode-hook
;;       'emacs-lisp-mode-hook
;;       'lisp-interaction-mode-hook))
;;   (add-hook hook
;;             '(lambda ()
;;                (linkd-mode 1)
;;                (linkd-enable))))


(bind-key "s-t L" 'linkd-mode)


(provide 'linkd_init)
