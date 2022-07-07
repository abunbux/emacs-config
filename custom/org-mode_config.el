;;; org-mode_config.el -*- coding: utf-8; lexical-binding: t; -*-

;;; CREATED: <Sat Feb 29 16:27:41 EET 2020>
;;; Time-stamp: <Последнее обновление -- Tuesday July 5 22:52:50 EEST 2022>



;;; Commentary:

;;; Code:


(use-package org
  :ensure nil
  :defer t
  :bind (
         :map org-mode-map
         ("M-h o t" .   org-toggle-link-display)
         ("M-h l s" .   my/hide-headers)
         ("M-h l S" .   my/show-headers))
  :mode (
         ("\\.org$" . org-mode))
  :init
  ;; Хочу видеть дату+время, когда пункт был закрыт (CLOSED):
  (setq org-log-done t)

  ;; Спрятать лог изменения статусов в LOGGER:
  (setq org-log-into-drawer t)                  ;; ? при непонятном поведении убрать

  (setq org-startup-with-inline-images  t
        org-support-shift-select        t)

  ;; Выделять по shift-стрелочки даже в org-mode:
  (setq org-support-shift-select t)

  ;; Hide formatting characters like *, /, _
  (setq org-hide-emphasis-markers t)

  (setq org-fontify-quote-and-verse-blocks t)
  (setq org-startup-folded 'content)

  ;; SRC-блоки должны выглядеть максимально похоже на
  ;; исходные режимы редактирования для этих языков:
  (setq org-src-fontify-natively t)

  ;; Кнопка tab в SRC-блоках имеет то же поведение,
  ;; что и в исходных режимах языков:
  (setq org-src-tab-acts-natively t)

  ;; Не надо никуда смещать SRC-блоки:
  (setq org-edit-src-content-indentation 0)

  ;; Ругаться, если пытаемся редактировать невидимый (напр., схлопнутый) текст:
  (setq org-catch-invisible-edits 'error)

  ;; Задаем виды статусов для задач
  (setq org-todo-keywords
        '((sequence "TODO(t)" "WAIT(w)" "|" "DONE(d)" "CANCELED(c@)")))

  (setq org-agenda-files (directory-files-recursively "~/opt/python/" "\\.org$"))

  ;; Не показывать DONE в агенде:
  (setq org-agenda-skip-scheduled-if-done 't)

  :config
  (message "Loading \"org-mode\"")

  ;; с версии 9.5 `org-adapt-indentation' теперь по умолчанию равен `nil'.
  ;; Очень удивился, когда emacs перестал в org-файлах делать отступы:
  (setq org-adapt-indentation t)

  (org-babel-do-load-languages
   'org-babel-load-languages
   '(
     (R . t)
     (dot . t)
     (emacs-lisp . t)
     (gnuplot . t)
     (python . t)
     ;;(sh . t)
     (shell . t)
     ))

  (setq org-emphasis-alist
        '(("*" (bold :foreground "Orange" ))
          ("/" (italic :foreground "tomato"))
          ("_" underline)
          ("=" (:foreground "dark khaki"))
          ("~" (:foreground "MidnightBlue"))
          ("+" (:strike-through t))))

  (require 'org-install)

  ;; Чтобы `org' не перезаписывал мои привычные биндинги.
  (define-key org-mode-map (kbd "M-h")      nil)
  (define-key org-mode-map (kbd "C-e")      nil)
  (define-key org-mode-map (kbd "C-a")      nil)
  (define-key org-mode-map (kbd "M-<up>")   nil)
  (define-key org-mode-map (kbd "M-<down>") nil)
  (define-key org-mode-map (kbd "RET")      nil)
  (define-key org-mode-map (kbd "C-j")      nil)


  ;; (bind-key "M-h o t"   'org-toggle-link-display org-mode-map)

  ;; (require 'org-bullets)

  (use-package org-bullets
    :ensure nil
    :init
    (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
    :config
    (message "Loading \"org-bullets\"")
    )



  (defvar my/org-src-block-faces nil)
  ;; Для последующих действий требуется `hide-lines'
  (defun my/show-headers ()
    (interactive)
    (setq org-src-block-faces 'my/org-src-block-faces)
    (hide-lines-show-all))

  (defun my/hide-headers ()
    (interactive)
    (setq my/org-src-block-faces 'org-src-block-faces)
    (hide-lines-matching "\\#\\+BEGIN_SRC")
    (hide-lines-matching "END_SRC"))

  ;; (add-hook 'org-mode-hook 'my/hide-headers)

  ;; (defun advice/org-edit-src-code ()
  ;;   (interactive)
  ;;   (my/show-headers))
  ;; (advice-add 'org-edit-src-code :before #'advice/org-edit-src-code)

  ;; (defun advice/org-edit-src-exit ()
  ;;   (interactive)
  ;;   (my/hide-headers))
  ;; (advice-add 'org-edit-src-exit :after #'advice/org-edit-src-exit)

  (font-lock-add-keywords 'org-mode
                          '(("^ *\\([-]\\) "
                             (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))

  )



(provide 'org-mode_config)
