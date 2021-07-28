;; -*- lexical-binding: t -*-

;;; CREATED: <Fri Mar 15 18:59:47 EET 2019>
;;; Time-stamp: <Последнее обновление -- Tuesday April 16 22:0:51 EEST 2019>



;;; nxml-mode
(with-eval-after-load 'nxml-mode
  (progn
    (message "nxml-mode loaded")

    ;; my/xml-format ("C-c x f")
    (defun my/xml-format (start end)
      "Format xml START END region or entire buffer."
      (interactive
       (if (use-region-p)
           (list (region-beginning) (region-end))
         (list (point-min) (point-max))))
      (if (executable-find "xmllint")
          (progn
          (shell-command-on-region start end
                                   "xmllint --format -" t t)
          (message "xmllint --format -"))
        (error "Cannot find xmllint command")))

    ;; (define-key nxml-mode-map (kbd "C-c x f") 'my/xml-format)
    (bind-key "C-c x f" 'my/xml-format nxml-mode-map)
    ))


;;;********************************************************************


;;; sqml-mode
(with-eval-after-load 'sqml-mode
  (progn
    (message "sqml-mode loaded")))

;;;********************************************************************


(provide 'nxml_sqml_config)
