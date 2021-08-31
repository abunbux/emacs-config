;;; built-in_diff_config.el -*- coding: utf-8; lexical-binding: t; -*-
;;; --- insert here summary

;;; CREATED: <Mon Aug 30 11:18:56 EEST 2021>
;;; Time-stamp: <Последнее обновление -- Monday August 30 16:39:31 EEST 2021>



;;; Commentary:

;;; Code:




;;; Code:




;; diff-mode.el
(use-package diff-mode
  :ensure nil
  :disabled
  :defer t
  :preface
  ;; my/diff-region ()
  (defun my/diff-region ()
    "Select a region to compare"
    (interactive)
    (when (use-region-p) ; there is a region
      (let (buf)
        (setq buf (get-buffer-create "*Diff-regionA*"))
        (save-current-buffer
          (set-buffer buf)
          (erase-buffer))
        (append-to-buffer buf (region-beginning) (region-end)))
      )
    (message "Now select other region to compare and run `my/diff-region-now`"))

  ;; my/diff-region-now ()
  (defun my/diff-region-now ()
    "Compare current region with region already selected by `diff-region`"
    (interactive)
    (when (use-region-p)
      (let (bufa bufb)
        (setq bufa (get-buffer-create "*Diff-regionA*"))
        (setq bufb (get-buffer-create "*Diff-regionB*"))
        (save-current-buffer
          (set-buffer bufb)
          (erase-buffer))
        (append-to-buffer bufb (region-beginning) (region-end))
        (ediff-buffers bufa bufb))))

  ;; :bind (("---------" . diff-buffer-with-file))
  :init
  (autoload 'diff-mode "diff-mode" "Diff major mode" t)
  :config
  (message "Loading built-in \"diff-mode\"")
  (setq diff-switches "-u")
  ;; show important whitespace in diff-mode
  (add-hook 'diff-mode-hook
            (lambda ()
              (setq-local whitespace-style
                          '(face
                            tabs
                            tab-mark
                            spaces
                            space-mark
                            trailing
                            indentation::space
                            indentation::tab
                            newline
                            newline-mark))
              (whitespace-mode 1)))

  )




(provide 'built-in_diff_config)

;;; built-in_diff_config.el ends here
