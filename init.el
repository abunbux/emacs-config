;;; init.el -*- coding: utf-8; lexical-binding: t; -*-

;;; CREATED: <Fri Feb 01 16:50:27 EET 2019>
;;; Time-stamp: <Последнее обновление -- Thursday July 22 21:17:6 EEST 2021>



;;; Commentary:

;;; Code:

(setq file-name-handler-alist       nil
      message-log-max               t
      gc-cons-threshold             most-positive-fixnum
      ;; gc-cons-percentage            0.6
      auto-window-vscroll           nil)


;; System-type definition
(defun system-is-linux()
  (string-equal system-type "gnu/linux"))
(defun system-is-windows()
  (string-equal system-type "windows-nt"))




(when (system-is-linux)
  (load "~/.emacs.d/lisp/benchmark-init.el"
        'no-error nil 'no-suffix))
(when (system-is-windows)
  (load "C:/Documents and Settings/abunb/AppData/Roaming/.emacs.d/lisp/benchmark-init.el"
        'no-error nil 'no-suffix))




(defvar file-name-handler-alist-old file-name-handler-alist)


(add-hook 'after-init-hook
          `(lambda ()
             (setq file-name-handler-alist file-name-handler-alist-old
                   ;; gc-cons-threshold    (* 6 1024 1024)
                   ;; gc-cons-percentage   0.1
                   ;; garbage-collection-messages t
                   )
             (garbage-collect)) t)



(add-hook 'emacs-startup-hook
          (lambda ()
            (message "Emacs ready in %s with %d garbage collections."
                     (format "%.2f seconds"
                             (float-time
                              (time-subtract after-init-time before-init-time)))
                     gcs-done)))



;;; засекаем время начала загрузки
(setq emacs-load-start-time (current-time))


;;; выводим в буфер сообщений
(message "start .init loading")


(defconst emacs-start-time (current-time))


(eval-and-compile
  (add-to-list 'load-path (locate-user-emacs-file "lisp/"))
  (add-to-list 'load-path (locate-user-emacs-file "custom/"))
  (add-to-list 'load-path (locate-user-emacs-file "custom/hydras_file/"))
  (add-to-list 'load-path (locate-user-emacs-file "themes/"))
  (add-to-list 'custom-theme-load-path (locate-user-emacs-file "themes/")))





(setq custom-file (locate-user-emacs-file "custom.el"))
(condition-case nil
    (load custom-file)
  (error (with-temp-file custom-file)))





(eval-and-compile
  (setq load-prefer-newer t
        package--init-file-ensured t
        package-enable-at-startup nil))




(eval-when-compile
  (require 'package)
  (unless (or (version= "27" emacs-version) package--initialized)
    (package-initialize)
    ;; (package-initialize nil)
    )

  ;; for gnu repository
  (setq package-check-signature nil)


  (add-to-list 'package-archives '("melpa"          . "https://melpa.org/packages/") t)
  (add-to-list 'package-archives '("melpa-stable"   . "https://stable.melpa.org/packages/") t)
  (add-to-list 'package-archives '("org"            . "https://orgmode.org/elpa/") t)
  ;; (add-to-list 'package-archives '("ELPA"           . "https://tromey.com/elpa/") t)
  ;; (add-to-list 'package-archives '("marmalade"      . "https://marmalade-repo.org/packages/") t)
  (add-to-list 'package-archives '("gnu"            . "https://elpa.gnu.org/packages/") t)



  (setq package-archive-priorities '(("melpa"         . 150)
                                     ("melpa-stable"  . 100)
                                     ("org"           . 50)
                                     ;; ("ELPA"          . 50)
                                     ;; ("marmalade"     . 50)
                                     ("gnu"           . 10)))

  (unless (and (package-installed-p 'quelpa-use-package)
               (package-installed-p 'use-package)
               (package-installed-p 'quelpa))
    (package-refresh-contents)
    (package-install 'quelpa-use-package)
    (message "EMACS install quelpa-use-package.el")
    (message "-------------------------------------------------------------------")
    ;; `use-package' и `quelpa' ставятся как зависимости `quelpa-use-package'
    ;; (package-install 'use-package)
    ;; (message "EMACS install use-package.el")
    ;; (message "-------------------------------------------------------------------")


    ))

(use-package use-package
  :init
  ;; Предпочитаю контролировать всё наглядно
  ;; (setq use-package-always-ensure t)
  (setq use-package-verbose t)
  (if init-file-debug
      (setq use-package-verbose t
            use-package-expand-minimally nil
            use-package-compute-statistics t
            debug-on-error t)
    (setq use-package-verbose nil
          use-package-expand-minimally t))
  :config
  (message "Loading \"use-package\"")

  ;; https://github.com/ejmr/DotEmacs/blob/master/init.el
  (defun my/update-available-packages ()
    "Open the list of packages and mark all available for update."
    (interactive)
    (package-list-packages)
    (package-menu-mark-upgrades))

  ;; https://emacs.stackexchange.com/questions/31872/how-to-update-packages-installed-with-use-package
  (defun package-menu-find-marks ()
    "Find packages marked for action in *Packages*."
    (interactive)
    (occur "^[A-Z]"))

  ;; Only in Emacs 25.1+
  (defun package-menu-filter-by-status (status)
    "Filter the *Packages* buffer by status."
    (interactive
     (list (completing-read
            "Status: " '("new" "installed" "dependency" "obsolete"))))
    (package-menu-filter (concat "status:" status)))

  (bind-key "s" #'package-menu-filter-by-status   package-menu-mode-map)
  (bind-key "a" #'package-menu-find-marks         package-menu-mode-map)
  )




(use-package quelpa-use-package
  :init
  (unless (require 'quelpa nil t)
    (with-temp-buffer
      (url-insert-file-contents "https://github.com/quelpa/quelpa/raw/master/bootstrap.el")
      (eval-buffer)))
  :config
  (message "Loading \"quelpa-use-package\"")


  (use-package quelpa
    :init
    (setq     quelpa-checkout-melpa-p       t)
    (setq      quelpa-upgrade-p              nil)
    (setq      quelpa-update-melpa-p         nil)
    (setq      quelpa-self-upgrade-p         nil)
    (setq      quelpa-stable-p               t)
    :config
    (message "Loading \"quelpa\""))
  ;; (add-to-list 'quelpa-melpa-recipe-stores "/path/to/custom/recipe/dir")
  )




(use-package benchmark-init
  :ensure t
  :config
  (message "Loading \"benchmark-init\""))




(use-package diminish
  :ensure t
  :demand t
  :config
  (message "Loading \"diminish\""))



(use-package bind-key
  :ensure t
  :init
  ;;; my/describe-personal-keybindings ("<f6> b")
  (defun my/describe-personal-keybindings ()
    "Функция вызывает ~describe-personal-keybindings~
и перемещается в новое окно. Так реально удобнее!
(Мне так кажется)."
    (interactive)
    (describe-personal-keybindings)
    (other-window 1))

  (setq bind-key-describe-special-forms t)

  :bind (("<f6> b" . my/describe-personal-keybindings))
  :config
  (message "Loading \"bind-key\""))



;;; server.el
;; built-in
;; (use-package server
;;   :ensure nil
;;   :hook (after-init . server-mode))





(defun my/minibuffer-setup-hook ()
  (setq gc-cons-threshold most-positive-fixnum))

(defun my/minibuffer-exit-hook ()
  (setq gc-cons-threshold (* 6 1024 1024)))

(add-hook 'minibuffer-setup-hook #'my/minibuffer-setup-hook)
(add-hook 'minibuffer-exit-hook #'my/minibuffer-exit-hook)



;;; Unset keys
(global-unset-key (kbd "C-c"))      ; Эта комбинация изначально предназначалась для пользователя
(global-unset-key (kbd "C-d"))      ; `delete-char'
(global-unset-key (kbd "C-x C-l"))  ; `downcase-region' - у меня для этого функция есть
(global-unset-key (kbd "C-x C-u"))  ; `upcase-region' - у меня для этого функция есть
(global-unset-key (kbd "C-x n"))    ; `narrow-...'
(global-unset-key (kbd "C-z"))      ; `suspend-frame'
(global-unset-key (kbd "M-h"))      ; `mark-paragraph'
(global-unset-key (kbd "M-k"))      ; `kill-sentence' - назначил на `my/delete-line'
(global-unset-key (kbd "M-m"))      ; `back-to-indentation'
(global-unset-key (kbd "M-s h"))    ; `hi-lock-...', `highlight-...', `unhighlight-' - перебиндил
(global-unset-key (kbd "M-s o"))    ; `occur' - сделал префикс





(require 'setq_built-in_config)
(require 'history_config)
(require 'abbrev_init)              ; built-in
;; (require 'encryption_config)     ; built-in

(require 'help_config)


(require 'dired_init)




(message "-----------------------------------------------")

(let ((elapsed (float-time (time-subtract (current-time) emacs-start-time))))
  (message "Loading %s...done (%.3fs)" load-file-name elapsed))

(message ".init loaded OK.")

(message "Emacs startup time: %g seconds." (float-time (time-since emacs-load-start-time)))

(message "-----------------------------------------------")



;;; after-init



(require 'ivy_init)
(require 'helm_init)


(require 'smartparens_init)
(require 'company_init)
(require 'which-key_init)
(require 'amx_init)
(require 'yasnippet_init)

(defun my/after-init-load ()
  (require 'smart-mode-line_init)
  (require 'backup-each-save_init)
  (require 'search_replace_config)
  (require 'vimish-fold_init)

  (require 'defun_bind)

  (require 'easy-menu_init)

  ;; стартуем emacs на весь экран и устанавливаем цветовую тему в зависимости от того,
  ;; где работаем - гуй или терминал
  (if (display-graphic-p)
      (progn
        (set-scroll-bar-mode    'right)
        (tool-bar-mode -1)
        (tooltip-mode -1)
        (setq-default initial-frame-alist   (quote    ((fullscreen . maximized))))
        (require 'custom_section_gui)
        (message "Loading \"custom_section_gui\"")
        )
    (progn
      (menu-bar-mode       -1)
      (require 'custom_section_tty)
      (message "Loading \"custom_section_tty\"")))


  ;; ;; (menu-bar-mode       -1)
  ;; (when (fboundp 'set-scroll-bar-mode)
  ;;   (set-scroll-bar-mode    'right))
  ;; (when (fboundp 'tool-bar-mode)
  ;;   (tool-bar-mode -1))
  ;; (when (fboundp 'tooltip-mode)
  ;;   (tooltip-mode -1))

  )


(add-hook 'after-init-hook 'my/after-init-load)





(require 'highlight_init)




;;; duplicate-thing.el
(use-package duplicate-thing
  :ensure t
  :bind (
         :map global-map
         ("C-x <down>" . duplicate-thing)
         )
  :config
  (message "Loading \"duplicate-thing\""))



;;; elmacro.el
(use-package elmacro
  :ensure t
  :hook
  (after-init . elmacro-mode)
  :config
  (elmacro-mode)
  (message "Loading \"elmacro-mode\""))




;;; move-lines.el
;; up M-<up>" or M-<down>"
(use-package move-lines
  :quelpa (move-lines :fetcher github :repo "targzeta/move-lines")
  :hook
  (after-init . move-lines-binding)
  :config
  (message "Loading \"move-lines\"")
  ;; (move-lines-binding)
  (defun move-lines-binding ()
    "Sets the default key binding for moving lines. M-p or M-<up> for moving up
and M-n or M-<down> for moving down."
    (bind-key "M-<up>"          'move-lines-up)
    (bind-key "M-<down>"        'move-lines-down)
    ))



;;; volatile-highlights.el
;; * `vhl/...'
(use-package volatile-highlights
  :ensure t
  :diminish
  :init (volatile-highlights-mode t)
  :config
  (message "Loading \"volatile-highlights\"")
  (vhl/ext/kill/on)
  (vhl/ext/delete/on))




;;; hydra.el
(use-package hydra
  :ensure t
  :config
  (message "Loading \"hydra\"")

  (require 'hydra-dired_config)       ; переделать под себя
  (require 'hydra-help_config)
  (require 'hydra-highlight_config)
  (require 'hydra-info_config)
  (require 'hydra-insert-unicode_config)
  (require 'hydra-multiple-cursors_config)
  (require 'hydra-vimish-fold_config)
  (require 'hydra-rectangle_config)
  )




;;; defer
;;; эти моды работают по вызову


(require 'loccur_init)
(require 'hide-lines_init)
;; (require 'tramp_init)               ; built-in


(require 'web-mode_init)
(require 'emmet_init)
(require 'org-mode_config)
(require 'markdown-mode_init)
(require 'flycheck_init)
(require 'git_config)
(require 'syslog-mode_init)
(require 'multiple-cursors_init)


(require 'shell_init)



;;; iedit.el
;; Выделить текст, либо поставить точку на необходимое слово,
;; нажать "C-;" - будут выделены все вхождения.
;; Чтобы ограничить видимое только нужными вхождениями нажимаем "C-'".
(use-package iedit
  :ensure t
  ;; :defer t
  :bind (("C-c ;" . iedit-mode))
  :config
  (message "Loading \"iedit\"")
  (setq iedit-is-narrowed t)
  (setq iedit-auto-narrow t)
  (custom-set-faces
   '(iedit-occurrence ((t :foreground "red" :background "#008b8b" )))))




;;; free-keys.el находится в директории ~/.emacs.d/lisp
(use-package free-keys
  :ensure t
  :defer t
  :commands (free-keys
             free-keys-mode
             free-keys-change-buffer
             free-keys-set-prefix)
  :config
  (message "Loading \"free-keys\""))




;;; htmlize.el
(use-package htmlize
  :ensure t
  :defer t
  :config
  (message "Loading \"htmlize\""))





;;; helm-backup.el
(use-package helm-backup
  :ensure t
  ;; :defer 5
  :init
  (require 'helm-backup)
  (bind-key "C-c g h" 'helm-backup)
  (setq helm-backup-excluded-entries '("\\/cache/"))
  :config
  (message "Loading \"helm-backup\"")
  (add-hook 'after-save-hook 'helm-backup-versioning))




(use-package autoinsert
  :defer t
  :init
  ;; (setq auto-insert-query 'function)
  (setq auto-insert-directory (locate-user-emacs-file "templates-autoinsert/"))

  ;; templates: `auto-insert-alist'
  (setq auto-insert-alist nil)

  ;; Don't want to be prompted before insertion:
  ;; (setq auto-insert-query nil)

  :config
  (message "Loading \"autoinsert\"")

  ;; combining YASnippet & Auto Insert
  (defun autoinsert-yas-expand ()
    "Replace text in yasnippet template."
    (yas-expand-snippet (buffer-string) (point-min) (point-max)))

  (define-auto-insert "\\.el$" ["default-elisp.el" autoinsert-yas-expand])
  (define-auto-insert "\\.lisp$" ["default-lisp.lisp" autoinsert-yas-expand])
  (define-auto-insert "\\.clj$" ["default-clojure.clj" autoinsert-yas-expand])
  (define-auto-insert "\\.py$" ["default-python.py" autoinsert-yas-expand])
  (define-auto-insert "\\.rb$" ["default-ruby.rb" autoinsert-yas-expand])
  (define-auto-insert "\\.c$" ["default-C.c" autoinsert-yas-expand])
  (define-auto-insert "\\.cpp$" ["default-C++.cpp" autoinsert-yas-expand])
  (define-auto-insert "\\.java$" ["default-Java.java" autoinsert-yas-expand])
  (define-auto-insert "\\.org?$" ["default-org.org" autoinsert-yas-expand])

  (auto-insert-mode 1))




;;; fill-column-indicator.el
;; To toggle graphical indication of the fill column in a buffer,
;; use the command fci-mode
;; файл "fill-column-indicator.el" находится в директории "lisp"
(use-package fill-column-indicator
  :defer t
  :commands fci-mode
  :config
  (message "Loading \"fci-mode\" - fill-column-indicator"))




;; (add-hook 'compilation-mode-hook 'winnow-mode)





;;; add-to-list ****************************************************
;; http://ergoemacs.org/emacs/emacs_auto-activate_a_major-mode.html
;;
;; auto-mode-alist - встроенная переменная.
;; Её значение - список ассоциаций. Каждый ключ представляет собой строку регулярных выражений,
;; а значение - название режима.


(use-package conf-mode
  :defer t
  :mode ("/etc/.*"  .  conf-unix-mode)
  :config
  (message "Loading \"conf-mode\"")
  (bind-key "RET" 'newline global-map)
  (bind-key "C-j" 'newline-and-indent global-map)
  )


;;; Finalization

(add-hook 'after-init-hook
          `(lambda ()
             (let ((elapsed (float-time (time-subtract (current-time) emacs-start-time))))
               (message "Loading %s...done (%.3fs) [after-init]" ,load-file-name elapsed))

             (message "        INITIALIZATION COMPLETED")
             (message "-------------------------------------------------------------------")) t)
