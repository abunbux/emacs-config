;;; init.el -*- coding: utf-8; lexical-binding: t; -*-

;;; CREATED: <Fri Feb 01 16:50:27 EET 2019>
;;; Time-stamp: <Последнее обновление -- Friday March 25 16:31:30 EET 2022>



;;; Commentary:

;;; Code:



;; (debug-on-entry 'package-initialize)

(add-hook 'emacs-startup-hook
          (lambda ()
            (message "-----------------------------------------------")
            (message "Emacs ready in %s with %d garbage collections."
                     (format "%.2f seconds"
                             (float-time
                              (time-subtract after-init-time before-init-time)))
                     gcs-done)
            (message "-----------------------------------------------")
            ))



;;; засекаем время начала загрузки
(setq emacs-load-start-time (current-time))


;;; выводим в буфер сообщений
(message "start .init loading")
(message "---------------------------------------------------------")


(defconst emacs-start-time (current-time))


(defvar file-name-handler-alist-old file-name-handler-alist)
(message "file-name-handler-alist-old == file-name-handler-alist")


;; (load "~/.emacs.d/lisp/benchmark-init.el")



(setq package-enable-at-startup     nil
      file-name-handler-alist       nil
      message-log-max               16384
      ;; gc-cons-threshold             most-positive-fixnum
      gc-cons-threshold             64000000
      gc-cons-percentage            0.6
      auto-window-vscroll           nil                                 ; C-code (emacs)
      )




(add-hook 'after-init-hook
          `(lambda ()
             (setq file-name-handler-alist file-name-handler-alist-old
                   ;; gc-cons-threshold    (* 6 1024 1024)
                   gc-cons-threshold 800000
                   gc-cons-percentage   0.1
                   garbage-collection-messages t
                   )
             (message "file-name-handler-alist == file-name-handler-alist-old")
             (garbage-collect))
          t)



(eval-and-compile
  (add-to-list 'load-path (locate-user-emacs-file "lisp/"))
  (add-to-list 'load-path (locate-user-emacs-file "custom/"))
  (add-to-list 'load-path (locate-user-emacs-file "custom/hydras_file/"))
  (add-to-list 'load-path (locate-user-emacs-file "themes/"))
  (add-to-list 'custom-theme-load-path (locate-user-emacs-file "themes/"))
  )

(setq custom-file (locate-user-emacs-file "custom.el"))
(condition-case nil
    (load custom-file)
  (error (with-temp-file custom-file)))




(when (not (file-directory-p "~/.emacs.d/cache"))
  (make-directory "~/.emacs.d/cache")
  (message "make directory \"~/.emacs.d/cache\"" ))






;;;; ????????????????????? - может убрать?
(eval-and-compile
  (setq load-prefer-newer t
        package--init-file-ensured t)
  )



;;; PACKAGE MANAGER.
(eval-when-compile
  (require 'package)

  ;; for gnu repository
  (setq package-check-signature nil)


  (add-to-list 'package-archives '("melpa"          . "https://melpa.org/packages/")        t)
  (add-to-list 'package-archives '("melpa-stable"   . "https://stable.melpa.org/packages/") t)
  (add-to-list 'package-archives '("org"            . "https://orgmode.org/elpa/")          t)
  (add-to-list 'package-archives '("gnu"            . "https://elpa.gnu.org/packages/")     t)



  (setq package-archive-priorities '(("melpa"         . 150)
                                     ("melpa-stable"  . 100)
                                     ("org"           . 50)
                                     ("gnu"           . 10)))

  (package-initialize)

  
  ;;; INSATALL QUELPA, QUELPA-USE-PACKAGE, USE-PACAKGE.
  (unless (and (package-installed-p 'quelpa-use-package)
               (package-installed-p 'use-package)
               (package-installed-p 'quelpa))
    (package-refresh-contents)
    (package-install 'quelpa-use-package)
    (message "EMACS install quelpa-use-package.el")
    (message "-------------------------------------------------------------------"))
  )





;;; USE-PACKAGE
(use-package use-package
  :init
  ;; Предпочитаю контролировать всё наглядно
  ;; (setq use-package-always-ensure t)
  (setq use-package-verbose t)
  (if init-file-debug
      (setq use-package-verbose             t
            use-package-expand-minimally    nil
            use-package-compute-statistics  t
            debug-on-error                  t)
    (setq use-package-verbose           'errors
          use-package-expand-minimally  t))
  :config
  (message "Loading \"use-package\"")



  ;;; Взято у `xuchunyang'
  (defmacro my/use-package-keywords-add (keyword)
    "Add new keyword as placeholder."
    `(progn
       (add-to-list 'use-package-keywords ,keyword 'append)
       (defun ,(intern (format "use-package-normalize/%s" keyword)) (&rest _))
       (defun ,(intern (format "use-package-handler/%s" keyword)) (&rest _))))

  (my/use-package-keywords-add :about)
  (my/use-package-keywords-add :homepage)
  (my/use-package-keywords-add :info)
  (my/use-package-keywords-add :notes)



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
            "Status: " '("new" "installed" "dependency" "obsolete" "built-in"))))
    (package-menu-filter (concat "status:" status)))

  (bind-key "s" #'package-menu-filter-by-status   package-menu-mode-map)
  (bind-key "a" #'package-menu-find-marks         package-menu-mode-map)
  )




;;; QELPA
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
    (setq quelpa-checkout-melpa-p t)
    (setq quelpa-upgrade-p        nil)
    (setq quelpa-update-melpa-p   nil)
    (setq quelpa-self-upgrade-p   nil)
    (setq quelpa-stable-p         t)
    :config
    (message "Loading \"quelpa\""))
  ;; (add-to-list 'quelpa-melpa-recipe-stores "/path/to/custom/recipe/dir")
  )




(use-package benchmark-init
  :ensure t
  :config
  (message "Loading \"benchmark-init\""))



;; ;; GCMH - the Garbage Collector Magic Hack
;; ;; Применяйте скрытую стратегию сборки мусора,
;; ;; чтобы свести к минимуму вмешательство сборщика мусора в действия пользователя.
;; (use-package gcmh
;;   :ensure t
;;   :init
;;   (gcmh-mode 1)
;;   :config
;;   (message "Loading \"gcmh\"")
;;   (setq gcmh-verbose t))





(use-package diminish
  :ensure t
  :demand t
  :config
  (message "Loading \"diminish\"")
  )




;;; server.el
;; built-in
;; (use-package server
;;   :ensure nil
;;   :hook (after-init . server-mode))




(use-package bind-key
  :ensure t
  :preface
  ;; my/describe-personal-keybindings ("<f6> b")
  (defun my/describe-personal-keybindings ()
    "Вызывает `describe-personal-keybindings' и перемещается в новое окно. Так
  реально удобнее! (Мне так кажется)."
    (interactive)
    (describe-personal-keybindings)
    (other-window 1))

  :bind (("<f6> b" . my/describe-personal-keybindings))
  :config
  (message "Loading \"bind-key\"")
  (setq bind-key-describe-special-forms t)
  )



;; ;;; Unset keys
(global-unset-key (kbd "C-c"))      ; Эта комбинация изначально предназначалась для пользователя
(global-unset-key (kbd "C-d"))      ; `delete-char'
(global-unset-key (kbd "C-x C-l"))  ; `downcase-region' - у меня для этого функция есть
(global-unset-key (kbd "C-x C-u"))  ; `upcase-region' - у меня для этого функция есть
(global-unset-key (kbd "C-z"))      ; `suspend-frame'
(global-unset-key (kbd "M-h"))      ; `mark-paragraph'
(global-unset-key (kbd "M-k"))      ; `kill-sentence'
(global-unset-key (kbd "M-m"))      ; `back-to-indentation'
(global-unset-key (kbd "M-s h"))    ; `hi-lock-...', `highlight-...', `unhighlight-' - перебиндил
(global-unset-key (kbd "M-s o"))    ; `occur'





(setq inhibit-default-init                 t                            ; startup.el
      inhibit-startup-echo-area-message    t                            ; startup.el
      inhibit-startup-message              t                            ; startup.el
      initial-scratch-message              nil                          ; startup.el
      inhibit-startup-screen               t                            ; startup.el
      )


(setq ring-bell-function #'ignore)          ; C-code (emacs)
;; (setq ring-bell-function 'ignore)           ; C-code (emacs)


(fset 'display-startup-echo-area-message #'ignore)                  ; subr.el

;; (defalias 'yes-or-no-p #'y-or-n-p)                               ; subr.el
;; (advice-add 'yes-or-no-p :override #'y-or-n-p)
(fset 'yes-or-no-p 'y-or-n-p)

(defadvice yes-or-no-p (around hack-exit (prompt))
  (if
      (string= prompt "Active processes exist; kill them and exit anyway? ") t
    ad-do-it))
(defun my/y-or-n-p-optional (prompt)
  "Prompt the user for a yes or no response, but accept any non-y
response as a no."
  (let ((query-replace-map (copy-keymap query-replace-map)))
    (define-key query-replace-map [t] 'skip)
    (y-or-n-p prompt)))

(setq echo-keystrokes 0.6)                      ; C-code (emacs)


;; стартуем emacs на весь экран и устанавливаем цветовую тему в зависимости от того,
;; где работаем - гуй или терминал
(if (display-graphic-p)
    (progn
      (setq-default cursor-type     '(bar . 3))                             ; C-code (emacs)
      (set-scroll-bar-mode          'right)
      (tool-bar-mode                -1)
      (tooltip-mode                 -1)
      ;; (global-tab-line-mode)

      ;; Масштабируемые шрифты в графическом интерфейсе
      ;; C-x C-+ or C-x C--
      (setq scalable-fonts-allowed t)                                       ; C-code (emacs)

      ;; Mouse & Smooth Scroll
      ;; Scroll one line at a time (less "jumpy" than defaults)
      (setq mouse-wheel-scroll-amount '(1 ((shift) . 1) ((control) . nil))  ; mwheel.el
            ;; mouse-wheel-scroll-amount '(1 ((shift) . hscroll))           ; mwheel.el
            ;; mouse-wheel-scroll-amount '(1 ((shift) . 1))                 ; mwheel.el
            mouse-wheel-progressive-speed nil)                              ; mwheel.el

      (setq-default initial-frame-alist   (quote    ((fullscreen . maximized))))


      ;; ;; Следующие две строчки делают одно и то же -
      ;; ;; загружают мою тему из файла `abunbux-theme.el'
      ;; ;; (load-theme 'abunbux t)
      (require 'abunbux-theme)

      (message "Loading \"custom_section_gui\"")
      )
  (progn
    (menu-bar-mode       -1)
    (require 'custom_section_tty)
    (message "Loading \"custom_section_tty\"")))




;;; font-lock.el
(use-package font-lock
  :config
  (message "Loading built-in \"font-lock\"")
  ;; (jit-lock-debug-mode)
  (setq-default font-lock-multiline           t                     ; font-core.el
                font-lock-maximum-decoration  t                     ; font-core.el
                font-lock-support-mode        'jit-lock-mode        ; font-core.el
                ;; jit-lock-chunk-size           1000               ; jit-lock.el
                ;; jit-lock-defer-time           0.04               ; jit-lock.el
                ;; jit-lock-stealth-time         16                 ; jit-lock.el
                )
  ;; (global-font-lock-mode)
  )


;; (when (require 'font-lock nil :noerror)
;;   (global-font-lock-mode)                                           ; font-core.el
;;   ;; (jit-lock-debug-mode)
;;   (setq-default font-lock-multiline           t                     ; font-core.el
;;                 font-lock-maximum-decoration  t                     ; font-core.el
;;                 font-lock-support-mode        'jit-lock-mode        ; font-core.el
;;                 ;; jit-lock-chunk-size           1000                  ; jit-lock.el
;;                 ;; jit-lock-defer-time           0.04                  ; jit-lock.el
;;                 ;; jit-lock-stealth-time         16                    ; jit-lock.el
;;                 )
;;   )


;; Подсвечивать выделенные текст, между двумя метками
(add-hook 'after-init-hook 'transient-mark-mode)                    ; startup.el


;;; mode-line

(setq line-number-display-limit-width   300
      line-number-display-limit         6291456             ; 6 Mb
      display-time-24hr-format          t
      display-time-day-and-date         t
      display-time-format               "/ %R %d-%m-%y /"
      mode-line-end-spaces              t)

;; (display-battery-mode   t)                               ; loaddefs.el
;; (display-time-mode      1)
;; (display-time-update)

(line-number-mode      t)                                   ; simple.el
(column-number-mode    t)                                   ; simple.el
(size-indication-mode  t)                                   ; simple.el

;; (setq-default mode-line-format
;;               '("%e" ; print error message about full memory.
;;                 ;; mode-line-front-space
;;                 ;; mode-line-mule-info
;;                 " %n "
;;                 " %Z"
;;                 mode-line-modified " "
;;                 "%@ "
;;                 mode-line-buffer-identification " "
;;                 ;; mode-line-position
;;                 " %p " "%l" ":%C" " / " "%I "
;;                 ;; mode-name
;;                 ;; "  "
;;                 ;; Major mode
;;                 ;; "[%m] "
;;                 "   "
;;                 mode-line-modes
;;                 mode-line-misc-info
;;                 ;; battery-mode-line-string
;;                 mode-line-end-spaces
;;                 ))



;; (require 'centaur-tabs_init)
;; (require 'smart-mode-line_init)
(require 'doom-modeline_init)





(use-package emacs
  :custom
  (inhibit-x-resources                  t)              ; C-code (emacs)
  ;; Не сжимать кеши шрифтов во время сборки мусора.
  ;; Это нужно при «doom-modeline», если есть проблема с притормаживанием.
  ;; Я ничего не заметил, но на всякий пожарный случай поставил.
  (inhibit-compacting-font-caches       t)              ; C-code (emacs)

  (bidi-display-reordering              nil)            ; C-code (emacs)
  (completion-ignore-case               t)              ; C-code (emacs)
  (delete-by-moving-to-trash            t)              ; C-code (emacs)
  (focus-follows-mouse                  t)              ; C-code (emacs)
  (indent-tabs-mode                     nil)            ; C-code (emacs)
  (indicate-empty-lines                 t)              ; C-code (emacs)
  (indicate-buffer-boundaries   '((bottom . right)))    ; C-code (emacs)
  (left-margin-width                    0)              ; C-code (emacs)
  (max-lisp-eval-depth                  5000)           ; C-code (emacs)
  (max-mini-window-height               0.5)            ; C-code (emacs)
  (max-specpdl-size                     10000)          ; C-code (emacs)
  (right-margin-width                   0)              ; C-code (emacs)
  (read-buffer-completion-ignore-case   t)              ; C-code (emacs)
  (scroll-conservatively                100000)         ; C-code (emacs)
  (scroll-margin                        3)              ; C-code (emacs)
  (scroll-step                          1)              ; C-code (emacs)
  (select-active-regions                t)              ; C-code (emacs)
  (tab-width                            4)              ; C-code (emacs)
  (truncate-partial-width-windows       nil)            ; C-code (emacs)
  (visible-bell                         nil)            ; C-code (emacs)
  (visible-cursor                       nil)            ; C-code (emacs)
  (x-stretch-cursor                     t)              ; C-code (emacs)
  (use-dialog-box                       nil)            ; C-code (emacs)

  :config
  (message "Loading built-in \"C-code\" - \"pseudo emacs\"")
  (setq-default indent-tabs-mode        nil            ; C-code (emacs)
                tab-width               4)             ; C-code (emacs)
  (setq-default fill-column             80)            ; C-code (emacs)

  ;; ignore case
  (setq-default case-fold-search        t)             ; C-code (emacs)

  ;; C-v и M-v не отменяют друг друга, потому что положение точки не сохраняется.
  ;; Исправим это.
  (setq scroll-preserve-screen-position 'always)        ; C-code (emacs)
  (setq  enable-recursive-minibuffers   t)              ; C-code (emacs))

  )





(require 'built-in_window_config)
(require 'built-in_frame_config)
(require 'built-in_simple_config)
(require 'built-in_delsel_config)

(require 'built-in_whitespace_config)
(require 'built-in_time-stamp_config)
(require 'built-in_diff_config)         ; :disabled
(require 'built-in_ediff_config)
;; (require 'built-in_semantic_config)
(require 'built-in_hilit-chg_config)    ; :disabled
;; (require 'encryption_config)     ; built-in
;; (require 'shell_init)
(require 'tramp_init)


(setq browse-url-browser-function   'browse-url-generic             ; browse-url.el
	  ;; browse-url-generic-program    "firefox-bin"                ; browse-url.el
	  ;; browse-url-generic-program    "google-chrome-stable"       ; browse-url.el
	  browse-url-generic-program    "brave-bin"                     ; browse-url.el
	  user-full-name                "abunbux"                       ; C-code (emacs)
	  user-mail-address             "abunbux@gmail.com")            ; startup.el





(setq vc-make-backup-files          t)                 ; vc-hooks.el

(setq ad-redefinition-action            'accept                     ; advice.el
      auto-revert-verbose               t                           ; autorevert.el
      compilation-always-kill           t                           ; compile.el
      x-select-enable-clipboard         t                           ; select.el
      x-select-enable-primary           nil                         ; select.el
      )

(setq read-file-name-completion-ignore-case t)                      ; minibuffer.el
(setq minibuffer-depth-indicate-mode        99)                     ; mb-depth.el
(minibuffer-depth-indicate-mode)                                    ; mb-depth.el

(setq-default eww-bookmarks-directory           "~/.emacs.d/cache/"
              projectile-cache-file             "~/.emacs.d/cache/projectile/projectile.cache"
              projectile-known-projects-file    "~/.emacs.d/cache/projectile/known-projects.eld"
              url-configuration-directory       "~/.emacs.d/cache/url/")

(setq column-number-indicator-zero-based   nil)                     ; bindings.el

(setq mouse-drag-copy-region            nil                         ; mouse.el
      mouse-yank-at-point               t                           ; mouse.el
      mouse-wheel-follow-mouse          t                           ; mwheel.el
      mouse-wheel-follow-mouse          't)                         ; mwheel.el

;; (mouse-wheel-mode    't)                                         ; mwheel.el

(setq           sentence-end                                        ; paragraphs.el
                "\\([。、！？]\\|……\\|[,.?!][]\"')}]*\\($\\|[ \t]\\)\\)[ \t\n]*")
(setq           sentence-end-double-space   nil)                    ; paragraphs.el

(setq-default compilation-ask-about-save    nil)                    ; compile.el


(setq js-indent-level   4                                           ; js.el
      sgml-basic-offset 4                                           ; sgml-mode.el
      )


(setq-default indent-line-function  'insert-tab                     ; indent.el
              sh-basic-offset       4                               ; sh-script.el
              tab-always-indent     nil                             ; indent.el
              )


;;; https://git.shimmy1996.com/shimmy1996/.emacs.d
;; Use display-line-numbers instead of linum.
;; Enable relative line numbering, and set minimum width to 3.
(setq-default display-line-numbers-type (quote t))                  ; display-line-numbers.el
(setq-default display-line-numbers-width 3)                         ; C-code (emacs)



(setq-default major-mode    'text-mode)                             ; C-code (emacs)

(electric-indent-mode       -1)                                     ; electric.el
(global-eldoc-mode          -1)                                     ; eldoc.el

;; (desktop-save-mode   t)                                          ; loaddefs.el

;; (global-auto-revert-mode 1)                                      ; loaddefs.el
(file-name-shadow-mode      1)                                      ; rfn-eshadow.el

;; Высота временного буфера зависит от его содержимого
(temp-buffer-resize-mode    t)                                      ; help.el

;; (fringe-mode                '(12 . 0))                           ; fringe.el
(global-subword-mode        0)                                      ; subword.el

(auto-compression-mode      t)                                      ; jka-cmpr-hook.el




;;; Disabled Commands **************************************

;; enable all commands
;; (setq disabled-command-function  nil)                 ; novice.el

;; ;; Enable default disabled stuff
;; ;; Следующие команды выдают предупреждение при запуске.
;; ;; Для их отключения нужно раскомментировать нижеследующее
(put 'downcase-region   'disabled nil)
(put 'upcase-region     'disabled nil)
(put 'erase-buffer      'disabled nil)
(put 'scroll-left       'disabled nil)
(put 'set-goal-column   'disabled nil)








(setq help-window-select                        t               ; help.el
      apropos-do-all                            t               ; apropos.el
      apropos-sort-by-scores                    t               ; apropos.el
      apropos-documentation-sort-by-scores      nil             ; apropos.el
      )

(require 'help_config)

;;; interaction-log.el
(use-package interaction-log
  :ensure t
  :preface
  (defun my/ilog-buffer-name ()
    (interactive)
    (display-buffer ilog-buffer-name))
  :bind (("<f6> l"   . my/ilog-buffer-name))
  :hook
  (after-init . interaction-log-mode)
  :config
  (message "Loading \"interaction-log\""))








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

;; (require 'ido_init)



(use-package company
  :ensure t
  :diminish
  :hook
  (after-init . company-mode)
  :config
  (setq company-auto-complete-chars       '(32 40 41 119 46 34 36 47 124 33)
        company-backends                  '((company-yasnippet
                                             company-semantic
                                             company-capf
                                             company-etags
                                             company-files
                                             company-keywords
                                             company-dabbrev-code
                                             company-dabbrev
                                             company-shell
                                             company-shell-env
                                             company-fish-shell
                                             ))
        ;; company-begin-commands            '(self-insert-command)
        company-dabbrev-code-everywhere   t
        company-dabbrev-code-ignore-case  t
        company-dabbrev-downcase          nil
        company-dabbrev-other-buffers     t
        company-echo-delay                0
        company-idle-delay                0
        company-minimum-prefix-length     2
        company-selection-wrap-around     t
        company-show-numbers              nil
        company-tooltip-limit             20
        company-tooltip-align-annotations t)

  (global-company-mode 1)
  (eval-after-load 'company
    '(progn
       (bind-key "TAB" 'company-complete-common-or-cycle company-active-map)
       (bind-key "<tab>" 'company-complete-common-or-cycle company-active-map)
       (message "Loading \"company\"")))
  (bind-key "M-s" 'company-search-candidates  company-active-map)
  (bind-key "M-f" 'company-filter-candidates  company-active-map)
  (bind-key "M-l" 'company-show-location      company-active-map)
  (bind-key "M-n" 'company-select-next        company-active-map)
  (bind-key "M-p" 'company-select-previous    company-active-map)
  (bind-key "C-d" 'company-show-doc-buffer    company-active-map)

  (bind-key "C-c & c" 'company-yasnippet)


  (use-package company-shell
    :defer t
    :ensure t
    :after company
    :config
    (message "Loading \"company-shell\"")
    )

  (use-package company-flx
    :ensure t
    :after company
    :config
    (message "Loading \"company-flx\"")
    )
  )



(require 'which-key_init)
(require 'amx_init)

;; (require 'marginalia_init)


(require 'yasnippet_init)




(require 'all-the-icons_init)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;                                                                     ;;;
;;;                             PAREN                                   ;;;
;;;                                                                     ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'built-in_paren_config)
(require 'smartparens_init)
(use-package highlight-parentheses
  :ensure t
  :hook (prog-mode . highlight-parentheses-mode)
  :custom-face
  (highlight-parentheses-highlight ((t (:weight bold  :height 1.0 :background "#1d2014" ))))
  :config
  (message "Loading \"highlight-parentheses\"")
  )


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;                                                                     ;;;
;;;                         PAREN ends here                             ;;;
;;;                                                                     ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;                                                          ;;;
;;;              ЛОКАЛЬ, ВРЕМЯ, КАЛЕНДАРЬ                    ;;;
;;;                                                          ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Default Encoding
(use-package mule
  :custom
  (coding-system-for-write              'utf-8)                                     ; C-code (emacs)
  ( file-name-coding-system             'utf-8)                                     ; C-code (emacs)
  (prefer-coding-system                 'utf-8)                                     ; mule-cmds.el
  ;; (buffer-file-coding-system            'utf-8-unix)                             ; C-code (emacs)
  (selection-coding-system              'utf-8)                                     ; select.el
  (set-buffer-file-coding-system        'utf-8-unix)                                ; mule.el
  (set-clipboard-coding-system          'utf-8)                                     ; mule.el
  (set-default-coding-systems           'utf-8-unix)                                ; mule-cmds.el
  (set-keyboard-coding-system           'utf-8-unix)                                ; mule.el
  (set-language-environment             'utf-8)                                     ; mule-cmds.el
  (set-locale-environment               "ru_RU.utf8")                               ; mule-cmds.el
  (set-selection-coding-system          'utf-8-unix)                                ; mule.el
  (set-terminal-coding-system           'utf-8)                                     ; mule.el
  (system-time-locale                   "C")                                        ; C-code (emacs)
  (x-select-request-type                '(UTF8_STRING COMPOUND_TEXT TEXT STRING))   ; select.el

  :config
  (message "Loading built-in \"mule\"")
  (setq-default buffer-file-coding-system     'utf-8-unix                         ; C-code (emacs)
                coding-system-for-read        'utf-8                              ; C-code (emacs)
                )
  (define-coding-system-alias         'UTF-8 'utf-8)                              ; C-code (emacs)

  ;; Хоткеи при русской раскладке
  ;; https://www.linux.org.ru/forum/general/9959057?cid=9959379
  (defun reverse-input-method (input-method)
    "Build the reverse mapping of single letters from INPUT-METHOD."
    (interactive
     (list (read-input-method-name "Use input method (default current): ")))
    (if (and input-method (symbolp input-method))
        (setq input-method (symbol-name input-method)))
    (let ((current current-input-method)
          (modifiers '(nil (control) (meta) (control meta))))
      (when input-method
        (activate-input-method input-method))
      (when (and current-input-method quail-keyboard-layout)
        (dolist (map (cdr (quail-map)))
          (let* ((to (car map))
                 (from (quail-get-translation
                        (cadr map) (char-to-string to) 1)))
            (when (and (characterp from) (characterp to))
              (dolist (mod modifiers)
                (define-key local-function-key-map
                  (vector (append mod (list from)))
                  (vector (append mod (list to)))))))))
      (when input-method
        (activate-input-method current))))                                        ; mule-cmds.el

  (reverse-input-method 'russian-computer)
  )


(use-package calendar
  :defer t
  :custom
  (calendar-week-start-day          1)
  (calendar-date-style              'european)
  (calendar-mark-holidays-flag      t)
  (european-calendar-style          t)                                       ; icalendar.el
  :config
  (message "Loading built-in \"calendar\"")
  )


(use-package time
  :custom
  (display-time-default-load-average    nil)
  :config
  (message "Loading built-in \"time\"")
  ;; https://en.wikipedia.org/wiki/List_of_tz_database_time_zones
  (setq display-time-world-list '(("Europe/Paris"         "Paris")
                                  ("Europe/Berlin"        "Berlin")
                                  ("Europe/Kiev"          "Kiev")
                                  ("Europe/Zaporozhye"    "Zaporozhye")
                                  ("Europe/Uzhgorod"      "Uzhgorod")
                                  ("Europe/Moscow"        "Moscow")
                                  ("Europe/Minsk"         "Minsk")
                                  ("Asia/Baku"            "Baku")
                                  ("Asia/Tbilisi"         "Tbilisi")
                                  ("Asia/Ashgabat"        "Ashgabat")
                                  ("Asia/Almaty"          "Almaty")
                                  ("Asia/Bangkok"         "Bangkok")
                                  ("Asia/Krasnoyarsk"     "Krasnoyarsk")
                                  ("Asia/Shanghai"        "China")
                                  ("Asia/Irkutsk"         "Irkutsk")
                                  ("Asia/Tokyo"           "Tokyo")
                                  ("Asia/Vladivostok"     "Vladivostok")
                                  ("Australia/Melbourne"  "Melbourne")
                                  ("Asia/Magadan"         "Magadan")))

  )


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;                                                         ;;;
;;;         "ЛОКАЛЬ, ВРЕМЯ, КАЛЕНДАРЬ" ends here            ;;;
;;;                                                         ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;





(require 'defun_bind)

;; (require 'easy-menu_init)





;;;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
;;;                                                      >>>
;;;                     ПОДСВЕТКА                        >>>
;;;                     HIGHLIGHT                        >>>
;;;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

;; hl-line.el
(use-package hl-line
  :ensure nil
  :hook
  (after-init . global-hl-line-mode)
  :custom-face
  (hl-line ((((class color) (min-colors 89)) (:inherit t :background "#3d4753" :foreground nil))))
  (hl-tags-face ((((class color) (min-colors 89)) (:background "#FEFCAE"))))

  :config
  (message "Loading built-in \"hl-line\""))



;;; hi-lock.el
;; built-in
;; !!! Подправить `face'  !!!
;; 	* `hi-lock-mode'		* `highlight-lines-matching-regexp'
;; 	* `hi-lock-find-patterns'	* `unhighlight-regexp'
;; 	* `highlight-regexp'		* `highlight-phrase'
;;	* `hi-lock-write-interactive-patterns'
(use-package hi-lock
  :ensure nil
  :commands (hi-lock-write-interactive-patterns
             unhighlight-regexp
             highlight-regexp
             highlight-phrase
             highlight-lines-matching-regexp
             hi-lock-find-patterns)
  :bind (
         ;; ("C-x w h" . hi-lock-mode)
         ("C-x w u" . unhighlight-regexp)
         ("C-x w r" . highlight-regexp)
         ("C-x w p" . highlight-phrase)
         ("C-x w l" . highlight-lines-matching-regexp)
         ("C-x w i" . hi-lock-find-patterns)
         ("C-x w b" . hi-lock-write-interactive-patterns)
         )
  ;; :hook
  ;; (after-init . global-hi-lock-mode)
  :config
  (message "Loading built-in \"hi-lock\""))



(require 'highlight_init)


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

;;; HIGHLIGHT ends here <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<





;;;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
;;;                                                      >>>
;;;                 РЕДАКТИРОВАНИЕ ТЕКСТА                >>>
;;;                         EDIT                         >>>
;;;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

;; auto-formatting in text-mode
(add-hook 'text-mode-hook 'turn-on-auto-fill)                       ; text-mode.el

;;; duplicate-thing.el
(use-package duplicate-thing
  :ensure t
  :bind (:map global-map ("C-x <down>" . duplicate-thing))
  :config (message "Loading \"duplicate-thing\""))


;;; move-lines.el
;; up M-<up>" or M-<down>"
(use-package move-lines
  :quelpa (move-lines :fetcher github :repo "targzeta/move-lines")
  :hook (after-init . move-lines-binding)
  :config
  (message "Loading \"move-lines\"")
  ;; (move-lines-binding)
  (defun move-lines-binding ()
    "Sets the default key binding for moving lines. M-p or M-<up> for moving up
and M-n or M-<down> for moving down."
    (bind-key "M-<up>"          'move-lines-up)
    (bind-key "M-<down>"        'move-lines-down)
    ))


(require 'multiple-cursors_init)


;;; iedit.el
;; Выделить текст, либо поставить точку на необходимое слово,
;; нажать "C-c ;" - будут выделены все вхождения.
;; Чтобы ограничить видимое только нужными вхождениями нажимаем "C-'".
(use-package iedit
  :ensure t
  ;; :defer t
  :bind (("C-c ;" . iedit-mode))
  :config
  (message "Loading \"iedit\"")
  (setq iedit-is-narrowed t)
  (setq iedit-auto-narrow t)
  )


;;; bind, defun for edit, «pseudo emacs»
;; Клавиатурные сочетания и функции для редактирования текста.
;;
;; Удалить, линию, предложение, регион:
;;          "<C-delete>" ("M-d") `kill-word'
;;          "<C-backspase>"      `backward-kill-word'
;;          "<C-S-backspace>"    `kill-whole-line'
;;
;;          "C-x h"   `mark-whole-buffer' выделить весь буфер.
;;
;; Use word-wrapping for continuation lines
;; выравнивание текста (wrap mode).

(use-package emacs
  ;; :defer t
  :preface

  ;; auto-indent-after-yank
  ;; https://github.com/snosov1/dot-emacs#auto-indent-after-yank
  (defadvice insert-for-yank-1 (after indent-region activate)
    "Indent yanked region in certain modes, C-u prefix to disable"
    (if (and (not current-prefix-arg)
             (member major-mode '(sh-mode
                                  emacs-lisp-mode lisp-mode
                                  c-mode c++-mode objc-mode d-mode java-mode cuda-mode
                                  LaTeX-mode TeX-mode
                                  xml-mode html-mode css-mode)))
        (indent-region (region-beginning) (region-end) nil)))


  ;; <http://www.zafar.se/bkz/Articles/EmacsTips>
  ;; "M-w" если выделения нет - копирует всю строку.
  ;; "C-w" если выделения нет - вырезает всю строку
  ;; и остаётся на этой (пустой) строке:
  (defadvice kill-ring-save (before slickcopy activate compile)
    "When called interactively with no active region, copy the current line instead."
    (interactive
     (if mark-active
         (list (region-beginning) (region-end))
       (progn
         (message "Current line is copied")
         (list (line-beginning-position) (line-end-position))))))
  (defadvice kill-region (before slickcut activate compile)
    "When called interactively with no active region, cut the current line instead."
    (interactive
     (if mark-active
         (list (region-beginning) (region-end))
       (progn
         (message "Current line is cut.")
         (list (line-beginning-position) (line-end-position))))))


  ;; fill-paragraph
  ;; https://github.com/snosov1/dot-emacs#fillunfill-paragraph
  ;; Выделить region и "C-u M-q"
  (eval-after-load "unfill-autoloads"
    '(progn
       (if (require 'unfill nil t)
           (bind-key [remap fill-paragraph]
                     (defun fill-paragraph-dispatch (arg)
                       "Fill or unfill paragraph"
                       (interactive "P")
                       (if arg
                           (if (region-active-p)
                               (unfill-region (region-beginning) (region-end))
                             (unfill-paragraph))
                         (fill-paragraph 'nil 't))) global-map)
         (message "WARNING: unfill not found"))))



  ;; indent buffer-region
  ;; https://github.com/djui/dot-files/blob/master/dot-emacs ****************
  ;; my/indent-region-or-buffer ("C-M-\\")
  (defun my/indent-buffer ()
    "Indent the currently visited buffer."
    (interactive)
    (indent-region (point-min) (point-max)))
  (defun my/indent-region-or-buffer ()
    "Indent a region if selected, otherwise the whole buffer."
    (interactive)
    (save-excursion
      (if (region-active-p)
          (progn
            (indent-region (region-beginning) (region-end))
            (message "Indented selected region."))
        (progn
          (my/indent-buffer)
          (message "Indented buffer.")))))
  ;; (bind-key "C-M-\\" 'my/indent-region-or-buffer)


  ;; Если есть выделение - комментирует выделение, если выделения нет - комментирует строку.
  ;; https://github.com/rigidus/.emacs.d/blob/master/init.el
  ;; my/comment-or-uncomment-this ("C-x /")
  (defun my/comment-or-uncomment-this (&optional lines)
    (interactive "P")
    (if mark-active
        (if (< (mark) (point))
            (comment-or-uncomment-region (mark) (point))
          (comment-or-uncomment-region (point) (mark)))
      (comment-or-uncomment-region
       (line-beginning-position)
       (line-end-position lines))))
  ;; (bind-key "C-x /" 'my/comment-or-uncomment-this)


  ;; Открыть новую линию над строкой или под строкой
  ;; https://www.emacswiki.org/emacs/basic-edit-toolkit.el
  ;; my/open-newline-above ("C-c o")
  ;; my/open-newline-below ("C-o")
  (defun my/open-newline-above (arg)
    "Move to the previous line (like vi) and then opens a line."
    (interactive "p")
    (beginning-of-line)
    (open-line arg)
    (if (not (member major-mode '(haskell-mode org-mode literate-haskell-mode)))
        (indent-according-to-mode)
      (beginning-of-line)))
  (defun my/open-newline-below (arg)
    "Move to the next line (like vi) and then opens a line."
    (interactive "p")
    (end-of-line)
    (open-line arg)
    (call-interactively 'next-line arg)
    (if (not (member major-mode '(haskell-mode org-mode literate-haskell-mode)))
        (indent-according-to-mode)
      (beginning-of-line)))
  ;; (bind-key "C-c o"   'my/open-newline-above)
  ;; (bind-key "C-o"     'my/open-newline-below)


  ;; При выделении текста удаляет его,
  ;; при отсутствии выделения - удаляет слово вперёд.
  ;; my/delete-word-forward ([C-M-backspace])
  (defun my/delete-word-forward (arg)
    "Delete characters forward until encountering the end of a word.
With argument, do this that many times."
    (interactive "p")
    (if (use-region-p)
        (delete-region (region-beginning) (region-end))
      (delete-region (point) (progn (forward-word arg) (point)))))
  ;; (bind-key [C-M-backspace] 'my/delete-word-forward)

  ;; ;;; Удаляет всю строку целиком, независимо от положения точки, и поднимается на строку вверх.
  ;; ;; my/delete-line (" ")
  ;; (defun my/delete-line ()
  ;;   "Удаляет всю строку целиком, независимо от положения точки."
  ;;   (interactive)
  ;;   (kill-region
  ;;    (move-beginning-of-line 1)
  ;;    (save-excursion (move-end-of-line 1) (point)))
  ;;   (delete-char 1)
  ;;   (message "line deleted"))
  ;; (bind-key " " 'my/delete-line global-map)
  ;; То же самое делает родное сочетание "C-S-backspase"


  ;; При выравнивании текста пробелами, клавиша <backspace> будет удалять не один пробел,
  ;; а сразу столько, сколько входило в один "tab".
  ;; https://reangdblog.blogspot.com/2015/04/emacs-backspace-like-sublime.html
  ;; когда backspace будет удалять пробелы "пачками":
  ;;    --Должно быть отключено выравнивание табами "indent-tabs-mode == nil"
  ;;    --Курсор должен быть на столбце кратном ширине таба (tab-width) от начала строки
  ;;    --Ну и конечно перед курсором должно быть пробелов не меньше чем (tab-width)
  ;; my/backward-delete-tab-whitespace ("<backspace>"):
  (defun my/backward-delete-tab-whitespace ()
    (interactive)
    (let ((p (point)))
      (if (and (eq indent-tabs-mode nil)
               (>= p tab-width)
               (eq (% (current-column) tab-width) 0)
               (string-match "^\\s-+$" (buffer-substring-no-properties (- p tab-width) p)))
          (delete-backward-char tab-width)
        (delete-backward-char 1))))
  ;; (bind-key "<backspace>" 'my/backward-delete-tab-whitespace)


  ;; "M-^" берёт текущую строку и присоединяет её к предыдущей - встроенный функционал emacs.
  ;; Эта функция берёт следующую строку и присоединяет её к текущей.
  ;; https://github.com/snosov1/dot-emacs#join-following-line
  ;; my/join-following-line ("C-M-^")
  (defun my/join-following-line ()
    "Joins the following line or the whole selected region"
    (interactive)
    (if (use-region-p)
        (let ((fill-column (point-max)))
          (fill-region (region-beginning) (region-end)))
      (join-line -1)))
  ;; (bind-key "C-M-^" 'my/join-following-line global-map)

  ;; M-u - upcase word or region
  ;; M-l - lowercase word or region
  ;; M-c - capitalize word or region
  ;; https://github.com/snosov1/dot-emacs#upcase-lowercase-and-capitalize
  (defmacro action-dispatch (action)
    `(defun ,(intern (format "%s-dispatch" action)) (arg)
       "Perform action on word or region."
       (interactive "P")
       (if (region-active-p)
           (,(intern (format "%s-region" action)) (region-beginning) (region-end))
         (,(intern (format "%s-word" action)) (if arg arg 1)))))

  (bind-key [remap upcase-word]       (action-dispatch upcase)        global-map)
  (bind-key [remap downcase-word]     (action-dispatch downcase)      global-map)
  (bind-key [remap capitalize-word]   (action-dispatch capitalize)    global-map)

  :bind (
         ("C-M-\\"  . my/indent-region-or-buffer)
         ("C-x /"   . my/comment-or-uncomment-this)
         ("C-c o"   . my/open-newline-above)
         ("C-o"     . my/open-newline-below)
         ([C-M-backspace]   . my/delete-word-forward)
         ("<backspace>"     . my/backward-delete-tab-whitespace)

         :map global-map
         ;; Меняем местами "newline-and-indent" и "newline",
         ;; так-как при (electric-indent-mode -1) отступы в коде
         ;; нужно ставить "C-j", но "ENTER" ("RET") как-то привычнее
         ("RET"     . newline-and-indent)
         ("C-j"     . newline)
         ("C-M-^"   . my/join-following-line)
         )
  ;; :init
  :config
  (message "Loading \"bind_defun_for_edit\" - \"pseudo emacs\"")

  ;; ;; override insert key to change cursor in overwrite mode
  ;; (defvar cursor-mode-status 0)
  ;; (bind-key "<insert>"
  ;;           (lambda () (interactive)
  ;;             (cond ((eq cursor-mode-status 0)
  ;;                    (setq cursor-type 'box)
  ;;                    (overwrite-mode (setq cursor-mode-status 1))
  ;;                    (message "overwrite-mode enabled"))
  ;;                   (t
  ;;                    (setq cursor-type '(bar . 3))
  ;;                    (overwrite-mode (setq cursor-mode-status 0))
  ;;                    (message "insert-mode enabled")))))
  )




;;; "РЕДАКТИРОВАНИЕ ТЕКСТА" ends here <<<<<<<<<<<<<<<<<<<<<<




;;; defer
;;; эти моды загружаются по вызову или по необходимости




;;;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
;;;                                                      >>>
;;;          ПОИСК, ЗАМЕНА, СУЖЕНИЕ ОБЛАСТИ              >>>
;;;             SEARCH, REPLACE, NARROW                  >>>
;;;                                                      >>>
;;;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

;;; Полезные сочетания в режиме поиска:
;;      "М-r" - переключение regexp,
;;      "M-c" - переключение case sensitive,
;;      "M-e" - редактирование.
;;      "C-w" - искать слово в точке (ищет от позиции курсора и до конца слова
;;          нажимаем "C-w" ещё раз - добавляется в поиск следующее слово).
;;      "M-s C-e" - поиск остальной части строки после текущей метки.
;;      "C-M-y" - поиск символа после метки.
;;
;;; Для поиска символа под курсором можно воспользоваться
;;      "M-s ." `isearch-forward-symbol-at-point'


;;; замены (Regular Expression Replacements). Наиболее интересны следующие:
;;      \1...\9 — группы, то есть то что в исходном выражении ограничено скобками \( и \)
;;          в порядке следования слева — внутрь — направо
;;      \& — то что пришлось на все регулярное выражение (то есть группа 0)
;;      \d - in newstring, where d is a digit starting from 1,
;;          stands for whatever matched the dth parenthesized grouping in regexp.
;;          (This is called a “back reference”.)
;;      \# - refers to the count of replacements already made in this command,
;;          as a decimal number. In the first replacement,
;;          ‘\#’ stands for ‘0’; in the second, for ‘1’; and so on
;;      \? — приглашение пользователя к вводу. При каждом переименовании Emacs будет спрашивать, что ему вставить вместо \?



;; Следующие два hook-a нарушают работу  `ivy-occur'
;; (add-hook 'occur-hook       (lambda () (switch-to-buffer-other-window "*Occur*")))
;; (add-hook 'grep-mode-hook   (lambda () (switch-to-buffer-other-window "*grep*")))

(require 'built-in_grep_config)         ; :disabled

;; Focus on *Occur* window right away.
(add-hook 'occur-hook (lambda () (other-window 1)))                             ; replace.el

(setq query-replace-highlight       t)                                          ; replace.el


;; re-builder
(use-package re-builder
  :defer t
  :config
  (message "Loading built-in \"re-builder\"")
  (setq-default reb-re-syntax 'string)                                          ; re-builder.el
  )


;; isearch
(use-package isearch
  :defer t
  :config
  (message "Loading built-in \"isearch\"")
  (setq isearch-lax-whitespace        t                                         ; isearch.el
        ;; Allow scrolling while isearch is active
        ;; Example: C-s foo C-l (to recenter the point in buffer to center/top/bottom)
        ;; http://emacs.stackexchange.com/a/10313/115
        ;; Прелесть прокрутки во время поиска в том, что текущее совпадение никогда не идет за кадром.
        ;; Таким образом, вы даже можете использовать C-v / M-v.
        isearch-allow-scroll          t                                         ; isearch.el
        isearch-regexp-lax-whitespace t                                         ; isearch.el
        ;; search-default-mode        (quote isearch-symbol-regexp)             ; isearch.el
        search-highlight              t                                         ; isearch.el
        search-invisible              nil                                       ; isearch.el
        search-whitespace-regexp      "[ \t\r\n]+")                             ; isearch.el
  )


(require 'search_replace_config)

(require 'loccur_init)
(require 'hide-lines_init)
(require 'vimish-fold_init)
(require 'built-in_narrow_config)


;;; "ПОИСК, ЗАМЕНА, СУЖЕНИЕ ОБЛАСТИ" ends here <<<<<<<<<<<<<




;;;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
;;;                                                      >>>
;;;                  ПРОГРАММНЫЕ МОДЫ                    >>>
;;;                     PROG-MODES                       >>>
;;;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

(require 'web-mode_init)



(use-package lisp-mode
  :custom
  (lisp-body-indent  2)                                         ; lisp-mode.el
  :config
  (message "Loading built-in \"lisp-mode\"")
  )


;;; PROG-MODES ends here <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<




;;;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
;;;                                                      >>>
;;;                 ЯЗЫКИ РАЗМЕТКИ                       >>>
;;;                MARKUP LANGUAGES                      >>>
;;;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

(require 'org-mode_config)




(require 'markdown-mode_init)


;;; "ЯЗЫКИ РАЗМЕТКИ" ends here <<<<<<<<<<<<<<<<<<<<<<<<<<<<<






;;;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
;;;                                                      >>>
;;;           ФАЙЛЫ, ИСТОРИЯ, КОНТРОЛЬ ВЕРСИЙ            >>>
;;;           FILES, HISTORY, VERSION CONTROL            >>>
;;;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>


(setq history-delete-duplicates     t                ; C-code (emacs)
      history-length                250)             ; C-code (emacs)
(setq create-lockfiles              nil)             ; C-code (emacs)
(setq auto-save-list-file-name      nil)             ; C-code (emacs)
(setq auto-save-visited-file-name   nil)             ; C-code (emacs)


(require 'built-in_saveplace_config)
(require 'built-in_savehist_config)
(require 'built-in_recentf_config)
(require 'built-in_bookmark_config)
(require 'built-in_abbrev_config)
(require 'built-in_files_config)


;; (use-package desktop
;;   :disabled
;;   :config (desktop-save-mode))





(require 'backup-each-save_init)

;;; helm-backup.el
(use-package helm-backup
  :ensure t
  :defer 7
  :init
  (bind-key "C-c g h" 'helm-backup)
  (setq helm-backup-excluded-entries '("\\/cache/"))
  :config
  (message "Loading \"helm-backup\"")
  ;; (require 'helm-backup)
  (add-hook 'after-save-hook 'helm-backup-versioning)
  )


(require 'git_config)

;;; «ФАЙЛЫ, ИСТОРИЯ, КОНТРОЛЬ ВЕРСИЙ» ends here <<<<<<<<<<<<




(require 'syslog-mode_init)
(require 'emmet_init)
(require 'flycheck_init)


(setq kmacro-ring-max 30)                                   ; kmacro.el

;;; elmacro.el
(use-package elmacro
  :ensure t
  :hook (after-init . elmacro-mode)
  :config
  (elmacro-mode)
  (message "Loading \"elmacro-mode\"")

  (unless (lookup-key global-map [menu-bar extra-tools])
    (define-key-after global-map
      [menu-bar extra-tools]
      (cons "Extra Tools"
            (easy-menu-create-menu "Extra Tools" nil))
      'tools))

  (easy-menu-define my/elmacro-menu nil "Menu for Elmacro."
    '("Elmacro"
      ["Elmacro Mode" (customize-save-variable 'elmacro-mode (not elmacro-mode)) :style toggle :selected elmacro-mode :help "(elmacro-mode &optional ARG)\n\nToggle emacs activity recording (elmacro mode).\nWith a prefix argument ARG, enable elmacro mode if ARG is\npositive, and disable it otherwise. If called from Lisp, enable\nthe mode if ARG is omitted or nil."]
      "--"
      ["Show Last Commands" elmacro-show-last-commands :active elmacro-mode :help "(elmacro-show-last-commands &optional COUNT)\n\nTake the latest COUNT commands and show them as emacs lisp.\n\nThis is basically a better version of `kmacro-edit-lossage'.\n\nThe default number of commands shown is modifiable in variable\n`elmacro-show-last-commands-default'.\n\nYou can also modify this number by using a numeric prefix argument or\nby using the universal argument, in which case it'll ask for how many\nin the minibuffer."]
      ["Show Last Macro" elmacro-show-last-macro :active elmacro-mode :help "(elmacro-show-last-macro NAME)\n\nShow the last macro as emacs lisp with NAME."]
      "--"
      ["Clear Command History" elmacro-clear-command-history :active elmacro-mode :help "(elmacro-clear-command-history)\n\nClear the list of recorded commands."]))

  (easy-menu-add-item
   (current-global-map)
   '("menu-bar" "extra-tools")
   my/elmacro-menu)

  )








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



;;; autoinsert.el
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

  (auto-insert-mode 1)
  )





;;; fill-column-indicator.el
;; To toggle graphical indication of the fill column in a buffer,
;; use the command fci-mode
;; файл "fill-column-indicator.el" находится в директории "lisp"
(use-package fill-column-indicator
  :defer t
  :commands fci-mode
  :config
  (message "Loading \"fci-mode\" - fill-column-indicator"))




(use-package winnow-mode
  :defer t
  :hook
  (compilation-mode . winnow-mode)
  :config
  (message "Loading \"winnow-mode\""))






(use-package conf-mode
  :defer t
  :mode ("/etc/.*"  .  conf-unix-mode)
  :config
  (message "Loading \"conf-mode\"")
  (bind-key "RET" 'newline global-map)
  (bind-key "C-j" 'newline-and-indent global-map)
  )



;;; add-to-list ****************************************************
;; http://ergoemacs.org/emacs/emacs_auto-activate_a_major-mode.html
;;
;; auto-mode-alist - встроенная переменная.
;; Её значение - список ассоциаций. Каждый ключ представляет собой строку регулярных выражений,
;; а значение - название режима.





;;; Finalization
(add-hook 'after-init-hook
          `(lambda ()
             (let ((elapsed (float-time (time-subtract (current-time) emacs-start-time))))
	           (message "-------------------------------------------------------------------")
               (message "Loading %s...done (%.3fs) [after-init]" ,load-file-name elapsed))
             (message "        INITIALIZATION COMPLETED")
             (message "-------------------------------------------------------------------")) t)




(use-package page-break-lines
  :defer 2
  :ensure t
  :config
  (message "Loading \"page-break-lines\"")
  (global-page-break-lines-mode)
  )


;; ;; файл «pp-c-l.el» находится в директории «lisp».
;; (use-package pp-c-l
;;   :config
;;   (message "Loading \"pp-c-l\"")
;;   (pretty-control-l-mode 1)
;;   )




;; (use-package poet-theme
;;   :ensure t
;;   :config
;;   (message "Loading \"poet-theme\"")
;;   )


;; (add-hook 'text-mode-hook
;;           (lambda ()
;;             (variable-pitch-mode 1)))







;;; init.el ends here



;; ;;; hydra.el
;; (use-package hydra
;;   :ensure t
;;   :config (message "Loading \"hydra\"")
;;   (require 'hydra-dired_config)       ; переделать под себя
;;   (require 'hydra-help_config)
;;   (require 'hydra-highlight_config)
;;   (require 'hydra-info_config)
;;   (require 'hydra-insert-unicode_config)
;;   (require 'hydra-multiple-cursors_config)
;;   (require 'hydra-vimish-fold_config)
;;   (require 'hydra-rectangle_config)
;;   )


;; ;; hydra
;; (use-package hydra
;;   ;; :pin melpa-stable
;;   :config
;;   (use-package use-package-hydra
;;     ;; :pin melpa-stable
;;     :ensure t
;;     );use-package-hydra
;;   (use-package hydra-posframe
;;     :config
;;     (require 'hydra-posframe)
;;     :custom
;;     (hydra-posframe-parameters
;;      '((left-fringe . 4) (right-fringe . 4) (top-fringe . 4) (bottom-fringe . 4) (height . 18) (width . 105) (min-height . 17) (max-height . 30) (top . 25)))
;;     :custom-face
;;     (hydra-posframe-border-face ((t (:background "#ffffff"))))
;;     (hydra-posframe-face ((t (:background-color "#6272a4"))))
;;     :hook
;;     (after-init . hydra-posframe-enable)
;;     )
;;   ;; end use-package-hydra-posframe
;;   )
;; ;; end use-package hydra

;; ;; Pretty Hydra
;; (use-package pretty-hydra
;;   :ensure t
;;   :config
;;   (require 'pretty-hydra)
;;   )
;; ;; end use package pretty hyrda
;; ;; title generator
;; (require 's)
;; (require 'all-the-icons)
;; (with-eval-after-load 'all-the-icons
;;   (declare-function all-the-icons-faicon 'all-the-icons)
;;   (declare-function all-the-icons-fileicon 'all-the-icons)
;;   (declare-function all-the-icons-material 'all-the-icons)
;;   (declare-function all-the-icons-octicon 'all-the-icons)
;;   )

;; ;; with-faicon function allows an icon in hydra title.
;; ;; Requires following requires and aliases.
;; ;; To omit don't include 'with-faicon' in appearance-title

;; ;; define an icon function with all-the-icons-faicon
;; ;; to use filecon, etc, define same function with icon set%
;; (defun with-faicon (icon str &rest height v-adjust)
;;   (s-concat (all-the-icons-faicon icon :v-adjust (or v-adjust 0) :height (or height 1)) " " str))
;; ;; filecon
;; (defun with-fileicon (icon str &rest height v-adjust)
;;   (s-concat (all-the-icons-fileicon icon :v-adjust (or v-adjust 0) :height (or height 1)) " " str))



;; (use-package major-mode-hydra
;;   :ensure t
;;   ;; :bind
;;   ;; ("M-SPC" . major-mode-hydra)
;;   )

;; (pretty-hydra-define jp-toggles
;;   (:color amaranth :quit-key "q")
;;   ("Basic"
;;    (("n" linum-mode "line number" :toggle t)
;;     ("w" whitespace-mode "whitespace" :toggle t)
;;     ("W" whitespace-cleanup-mode "whitespace cleanup" :toggle t)
;;     ("r" rainbow-mode "rainbow" :toggle t)
;;     ("L" page-break-lines-mode "page break lines" :toggle t))
;;    "Highlight"
;;    (("s" symbol-overlay-mode "symbol" :toggle t)
;;     ("l" hl-line-mode "line" :toggle t)
;;     ("x" highlight-sexp-mode "sexp" :toggle t)
;;     ("t" hl-todo-mode "todo" :toggle t))
;;    "UI"
;;    (("d" jp-themes-toggle-light-dark "dark theme" :toggle jp-current-theme-dark-p))
;;    "Coding"
;;    (("p" smartparens-mode "smartparens" :toggle t)
;;     ("P" smartparens-strict-mode "smartparens strict" :toggle t)
;;     ("S" show-smartparens-mode "show smartparens" :toggle t)
;;     ("f" flycheck-mode "flycheck" :toggle t))
;;    "Emacs"
;;    (("D" toggle-debug-on-error "debug on error" :toggle (default-value 'debug-on-error))
;;     ("X" toggle-debug-on-quit "debug on quit" :toggle (default-value 'debug-on-quit)))))


;; (pretty-hydra-define+ jp-window ()
;;   (;; these heads are added to the existing "Windows" column
;;    "Windows"
;;    (("r" transpose-frame "rotate")
;;     ("z" zone "zone out!"))
;;    ;; this is a new column, which gets added
;;    "Appearance"
;;    (("f" set-frame-font "font")
;;     ("t" load-theme "theme"))))
