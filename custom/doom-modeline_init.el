;;; doom-modeline_init.el -*- coding: utf-8; lexical-binding: t; -*-
;;; --- insert here summary

;;; CREATED: <Thu Feb 10 06:00:27 EET 2022>
;;; Time-stamp: <Последнее обновление -- Tuesday February 10 15:7:35 MSK 2026>



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
  ;; (setq doom-modeline-icon (display-graphic-p))
  ;; (setq doom-modeline-major-mode-icon t)
  ;; (setq doom-modeline-major-mode-color-icon t)
  (setq doom-modeline-indent-info t)
  ;; (doom-modeline-set-timemachine-modeline)

  ;; How tall the mode-line should be. It's only respected in GUI.
  ;; If the actual char height is larger, it respects the actual height.
  (setq doom-modeline-height 20)

  ;; How wide the mode-line bar should be. It's only respected in GUI.
  (setq doom-modeline-bar-width 7)

  ;; Override attributes of the face used for padding.
  ;; If the space character is very thin in the modeline, for example if a
  ;; variable pitch font is used there, then segments may appear unusually close.
  ;; To use the space character from the `fixed-pitch' font family instead, set
  ;; this variable to `(list :family (face-attribute 'fixed-pitch :family))'.
  (setq doom-modeline-spc-face-overrides nil)
  )





(provide 'doom-modeline_init)

;;; doom-modeline_init.el ends here
