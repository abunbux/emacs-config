;;; built-in_delsel_config.el -*- coding: utf-8; lexical-binding: t; -*-
;;; --- insert here summary

;;; CREATED: <Sun Aug 29 19:41:20 EEST 2021>
;;; Time-stamp: <Последнее обновление -- Sunday August 29 19:42:50 EEST 2021>



;;; Commentary:

;;; Code:




;;; Code:





;;; delsel.el
(use-package delsel
  :bind
  (:map mode-specific-map
        ("C-g" . minibuffer-keyboard-quit)) ; C-c C-g always quits minubuffer

  :init
  (delete-selection-mode      -1)

  :config
  (message "Loading built-in \"delsel\"")

  (bind-key
   (kbd "d")
   (lambda (arg)
     (interactive "p")
     (if (region-active-p)
         (delete-active-region)
       (self-insert-command arg))))

  (bind-key
   (kbd "w")
   (lambda (arg)
     (interactive "p")
     (if (region-active-p)
         (call-interactively 'kill-ring-save)
       (self-insert-command arg))))

  (bind-key
   (kbd "c")
   (lambda (arg)
     (interactive "p")
     (if (region-active-p)
         (let ((str (buffer-substring-no-properties
                     (region-beginning)
                     (region-end))))
           (goto-char (region-end))
           (insert "\n" str))
       (self-insert-command arg))))
  )





(provide 'built-in_delsel_config)

;;; built-in_delsel_config.el ends here
