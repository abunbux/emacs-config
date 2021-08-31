;;; built-in_ediff_config.el -*- coding: utf-8; lexical-binding: t; -*-
;;; --- insert here summary

;;; CREATED: <Mon Aug 30 11:21:15 EEST 2021>
;;; Time-stamp: <Последнее обновление -- Monday August 30 16:59:44 EEST 2021>



;;; Commentary:

;;; Code:




;;; Code:




;; ediff.el
(use-package ediff
  :ensure nil
  :defer t
  ;; :bind (("----------" . ediff-current-file))
  :config
  (message "Loading built-in \"ediff\"")
  (setq-default ediff-highlight-all-diffs t)
  (setq-default ediff-forward-word-function 'forward-char)
  (setq ediff-diff-options "-w")
  (setq ediff-window-setup-function 'ediff-setup-windows-plain)
  (setq ediff-split-window-function 'split-window-horizontally)
  (setq ediff-auto-refine-limit (* 2 14000))

  (add-hook 'ediff-startup-hook
            (lambda ()
              (progn
                (set-frame-size(selected-frame) 40 10))))

  )




(provide 'built-in_ediff_config)

;;; built-in_ediff_config.el ends here



;;; Настройки вида (`faces') перенесены в `abunbux-theme', а это оставлено на всякий случай.
;; (custom-set-faces
;;  '(ediff-current-diff-A   ((t (:background "orange"       :foreground "brown"))))
;;  '(ediff-current-diff-B   ((t (:background "red"          :foreground "blue"))))
;;  '(ediff-current-diff-C   ((t (:background "Pink"         :foreground "Navy"))))
;;  '(ediff-even-diff-A      ((t (:background "light grey"   :foreground "Black"))))
;;  '(ediff-even-diff-B      ((t (:background "Grey"         :foreground "White"))))
;;  '(ediff-even-diff-C      ((t (:background "light grey"   :foreground "Black"))))
;;  '(ediff-fine-diff-A      ((t (:background "sky blue"     :foreground "Navy"  :weight bold))))
;;  '(ediff-fine-diff-B      ((t (:background "cyan"         :foreground "Black" :weight bold))))
;;  '(ediff-fine-diff-C      ((t (:background "Turquoise"    :foreground "Black" :weight bold))))
;;  '(ediff-odd-diff-A       ((t (:background "Grey"         :foreground "White"))))
;;  '(ediff-odd-diff-B       ((t (:background "light grey"   :foreground "Black"))))
;;  '(ediff-odd-diff-C       ((t (:background "Grey"         :foreground "White"))))
;;  )
