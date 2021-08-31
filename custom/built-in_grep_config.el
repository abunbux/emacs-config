;;; built-in_grep_config.el -*- coding: utf-8; lexical-binding: t; -*-
;;; --- insert here summary

;;; CREATED: <Mon Aug 30 11:24:49 EEST 2021>
;;; Time-stamp: <Последнее обновление -- Monday August 30 15:51:6 EEST 2021>



;;; Commentary:

;;; Code:




;;; Code:




;; grep.el
;; Не использую - есть другие альтернативы, всё использовать невозможно, да и не нужно.
(use-package grep
  :disabled
  :defer t
  :preface
  ;;; https://github.com/mpolden/emacs.d/blob/master/lisp/init-grep.el
  ;; grep-visit-buffer-other-window ("o")
  ;; grep-visit-buffer-other-window-noselect ("C-o")
  (defun grep-visit-buffer-other-window (&optional event noselect)
    "Visit grep result in another window."
    (interactive)
    (let ((current-window (selected-window)))
      (compile-goto-error event)
      (when noselect
        (select-window current-window))))

  (defun grep-visit-buffer-other-window-noselect (&optional event)
    "Visit grep result in another window, but don't select it."
    (interactive)
    (grep-visit-buffer-other-window event t))

  :bind (
         ("M-s g ." . grep-at-point)
         ("M-s g s" . grep-selected-text)

         :map grep-mode-map
         ;; make C-o and o behave as in dired
         ("o"   . grep-visit-buffer-other-window)
         ("C-o" . grep-visit-buffer-other-window-noselect)
         ;; n and p changes line as in ag-mode
         ("n"   . compilation-next-error)
         ("p"   . compilation-previous-error)
         )
  :config
  (message "Loading built-in \"grep\"")
  (setq grep-command    "ack --with-filename --nofilter --nogroup ")
  (setq-default grep-highlight-matches    t)
  (add-hook 'grep-mode-hook
            (lambda ()
              ;; wrap lines
              (setq-local truncate-lines nil)))
  (setq grep-host-defaults-alist nil)
  )




(provide 'built-in_grep_config)

;;; built-in_grep_config.el ends here
