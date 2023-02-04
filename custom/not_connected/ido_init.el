;; -*- lexical-binding: t -*-

;;; CREATED: <Wed May 15 20:06:44 EEST 2019>
;;; Time-stamp: <Последнее обновление -- Friday August 20 6:13:24 EEST 2021>



(use-package ido
  :preface
  ;; Use Ido selection with recentf
  ;; ido-mode в паре с recentf
  ;; my/ido-choose-from-recentf ("--------")
  (defun my/ido-choose-from-recentf ()
    "Use ido to select a recently visited file from the `recentf-list'"
    (interactive)
    (find-file (ido-completing-read "Open file: " recentf-list nil t)))

  :bind* (
          ("C-x C-f"    . ido-find-file)
          ("C-x d"      . ido-dired)

          ;; :map global-map
          ;; ("C-c r i"        . my/ido-choose-from-recentf)
          ;; ("-----------"    . my/ido-choose-from-recentf)
          )
  :init
  (setq-default ido-save-directory-list-file "~/.emacs.d/cache/ido.last")
  (setq ido-all-frames              t
        ido-auto-merge-delay-time   0
        ;; Поведение Ido по умолчанию, когда в текущем каталоге отсутствует соответствующий файл,
        ;; - это посмотреть в последних рабочих каталогах.
        ;; Если вы хотите ограничить [C-x C-f] (или M-x ido-find-file) текущим каталогом,
        ;; вы можете отключить это поведение автоматического слияния:
        ido-auto-merge-work-directories-length t
        ido-case-fold               t
        ido-create-new-buffer       'always
        ido-default-item            nil                 ; ?
        ido-default-buffer-method   'selected-window
        ido-enable-flex-matching    t
        ido-enable-prefix           nil
        ido-use-faces               t
        ido-use-filename-at-point   'guess
        ido-use-url-at-point        t
        ;; If Recentf is enabled, you can use [C-x b] (or M-x ido-switch-buffer)
        ;; to visit recently closed files by enabling virtual buffers:
        ido-use-virtual-buffers     t
        ido-virtual-buffers         t)
  (require 'ido)
  (ido-mode t)

  :config
  (progn
    (message "Loading \"ido\"")
    ;; (ido-everywhere 1)       ; несовместим с helm
    (ido-mode 'both))          ; for buffers and files
  (custom-set-faces
   '(ido-subdir ((t (:bold t :foreground "#66ff00" :background "#142300"))))
   '(ido-first-match ((t (:foreground "#ccff66" :background "black"))))
   '(ido-only-match ((t (:foreground "#003366" :background "#d0d0d0"))))))


(use-package flx-ido
  :ensure t
  :after ido
  :config
  (progn
    (message "Loading \"flx-ido\"")
    (flx-ido-mode 1)))


(use-package ido-vertical-mode
  :ensure t
  :after ido
  :init
  (setq ido-vertical-define-keys 'C-n-C-p-up-down-left-right
        ido-vertical-show-count   t)
  :config
  (progn
    (message "Loading \"ido-vertical-mode\"")
    (ido-vertical-mode      1)
    )
  (custom-set-faces
   '(ido-vertical-first-match ((t (:foreground "#ccff66" :background "black" :italic t :bold))))
   '(ido-vertical-only-match ((t (:foreground "#003366" :background "#d0d0d0"))))
   '(ido-vertical-match ((t (:foreground "ForestGreen" :background "yellow" :italic t :bold))))))


(use-package ido-completing-read+
  :ensure t
  :after ido
  :init
  (setq ido-completing-read 'all
        ido-cur-item        nil
        ido-cur-list        nil)
  :config
  (progn
    (message "Loading \"ido-completing-read+\"")
    (ido-ubiquitous-mode 1)))


(provide 'ido_init)
