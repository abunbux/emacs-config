;;; built-in_frame_config.el -*- coding: utf-8; lexical-binding: t; -*-
;;; --- insert here summary

;;; CREATED: <Sun Aug 29 15:16:21 EEST 2021>
;;; Time-stamp: <Последнее обновление -- Sunday August 29 15:21:46 EEST 2021>



;;; Commentary:

;;; Code:




;;; Code:



(use-package frame
  :bind
  (
   ("C-x |"  .   my/toggle-window-split)
   )
  :config
  (message "Loading built-in \"frame\"")
  ;; Display the name of the current buffer in the title bar
  (setq frame-title-format                                              ; C-code (emacs)
        '("emacs - %@"
          (:eval (system-name)) ": " (:eval
                                      (if (buffer-file-name)
                                          (abbreviate-file-name (buffer-file-name))
                                        "%b")) " [%*]"))
  (blink-cursor-mode          -1)                                       ; frame.el



  ;; Переключает отображение фреймов (двух) - с вертикального на горизонтальный и наоборот
  ;; my/toggle-window-split ("C-x |")
  (defun my/toggle-window-split ()
    (interactive)
    (if (= (count-windows) 2)
        (let* ((this-win-buffer (window-buffer))
               (next-win-buffer (window-buffer (next-window)))
               (this-win-edges (window-edges (selected-window)))
               (next-win-edges (window-edges (next-window)))
               (this-win-2nd (not (and (<= (car this-win-edges)
                                           (car next-win-edges))
                                       (<= (cadr this-win-edges)
                                           (cadr next-win-edges)))))
               (splitter
                (if (= (car this-win-edges)
                       (car (window-edges (next-window))))
                    'split-window-horizontally
                  'split-window-vertically)))
          (delete-other-windows)
          (let ((first-win (selected-window)))
            (funcall splitter)
            (if this-win-2nd (other-window 1))
            (set-window-buffer (selected-window) this-win-buffer)
            (set-window-buffer (next-window) next-win-buffer)
            (select-window first-win)
            (if this-win-2nd (other-window 1))))))
  ;; (bind-key "C-x |" 'my/toggle-window-split)


  )




(provide 'built-in_frame_config)

;;; built-in_frame_config.el ends here
