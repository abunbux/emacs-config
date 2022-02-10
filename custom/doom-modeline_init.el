;;; doom-modeline_init.el -*- coding: utf-8; lexical-binding: t; -*-
;;; --- insert here summary

;;; CREATED: <Thu Feb 10 06:00:27 EET 2022>
;;; Time-stamp: <Последнее обновление -- Thursday February 10 6:1:16 EET 2022>



;;; Commentary:


;;; Code:



(use-package doom-modeline
  :ensure t
  ;; :after (all-the-icons)
  :hook (after-init . doom-modeline-mode)
  ;; :custom (doom-modeline-minor-modes t)
  :custom-face
  (mode-line ((t (:background "#4477aa" :box (:line-width 1 :color "black") :family "Noto Sans" :height 0.90))))
  ;; (mode-line ((t (:family "Noto Sans" :height 0.75))))
  (mode-line-inactive ((t (:family "Noto Sans" :height 0.85))))

  :config
  (message "Loading \"doom-modeline\"")
  ;; (setq doom-modeline-buffer-file-name-style 'auto)
  (setq doom-modeline-buffer-file-name-style 'buffer-name)
  ;; Отображать ли значки в строке режима.
  ;; При использовании режима сервера в графическом интерфейсе необходимо явно установить значение.
  (setq doom-modeline-icon (display-graphic-p))
  ;; (setq doom-modeline-major-mode-icon t)
  ;; (setq doom-modeline-major-mode-color-icon t)
  (setq doom-modeline-indent-info t)
  ;; (doom-modeline-set-timemachine-modeline)

  (setq doom-modeline-height 15)

  ;; Как указать специфический шрифт:
  ;; (setq doom-modeline-height 1)
  ;; (set-face-attribute 'mode-line nil :family "Noto Sans" :height 120)
  ;; (set-face-attribute 'mode-line-inactive nil :family "Noto Sans" :height 110)
  )





(provide 'doom-modeline_init)

;;; doom-modeline_init.el ends here
