;;; init.el -*- coding: utf-8; lexical-binding: t; -*-

;;; CREATED: <Fri Feb 01 16:50:27 EET 2019>
;;; Time-stamp: <Последнее обновление -- Monday August 30 21:4:35 EEST 2021>



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


(load "~/.emacs.d/lisp/benchmark-init.el")


(setq inhibit-default-init                 t                            ; startup.el
      inhibit-startup-echo-area-message    t                            ; startup.el
      inhibit-startup-message              t                            ; startup.el
      initial-scratch-message              nil                          ; startup.el
      inhibit-startup-screen               t                            ; startup.el
      )



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
             (garbage-collect)) t)



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





(when (not (file-directory-p "~/.emacs.d/cache"))
  (make-directory "~/.emacs.d/cache")
  (message "make directory \"~/.emacs.d/cache\"" ))





(eval-and-compile
  (setq load-prefer-newer t
        package--init-file-ensured t
        ))




(eval-when-compile
  (require 'package)
  ;; (unless (or (version= "27" emacs-version) package--initialized)
  (package-initialize)
  ;; )

  ;; for gnu repository
  (setq package-check-signature nil)


  (add-to-list 'package-archives '("melpa"          . "https://melpa.org/packages/") t)
  (add-to-list 'package-archives '("melpa-stable"   . "https://stable.melpa.org/packages/") t)
  (add-to-list 'package-archives '("org"            . "https://orgmode.org/elpa/") t)
  (add-to-list 'package-archives '("gnu"            . "https://elpa.gnu.org/packages/") t)



  (setq package-archive-priorities '(("melpa"         . 150)
                                     ("melpa-stable"  . 100)
                                     ("org"           . 50)
                                     ("gnu"           . 10)))

  (unless (and (package-installed-p 'quelpa-use-package)
               (package-installed-p 'use-package)
               (package-installed-p 'quelpa))
    (package-refresh-contents)
    (package-install 'quelpa-use-package)
    (message "EMACS install quelpa-use-package.el")
    (message "-------------------------------------------------------------------")
    )
  )





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
    (setq use-package-verbose 'errors
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
            "Status: " '("new" "installed" "dependency" "obsolete" "built-in"))))
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




;; ;; The idea of this simple package was taken from this Reddit post,
;; ;; https://www.reddit.com/r/emacs/comments/3kqt6e/2_easy_little_known_steps_to_speed_up_emacs_start/,
;; ;; all it does is temporary sets file-name-handler-alist to nil (or fnhh-initial-alist customizable)
;; ;; and restores the value on /’emacs-startup-hook/ (customizable fn-hook),
;; ;; so it can (sometimes) speed up emacs startup time a little bit.
;; (use-package fnhh
;;   :quelpa
;;   (fnhh :repo "a13/fnhh" :fetcher github :stable nil)
;;   :config
;;   (message "Loading \"fnhh\"")
;;   (fnhh-mode 1))




(use-package diminish
  :ensure t
  :demand t
  :config
  (message "Loading \"diminish\""))



(use-package bind-key
  :ensure t
  :init
  ;; my/describe-personal-keybindings ("<f6> b")
  (defun my/describe-personal-keybindings ()
    "Вызывает `describe-personal-keybindings' и перемещается в новое окно. Так
  реально удобнее! (Мне так кажется)."
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




;; ;; Mouse & Smooth Scroll
;; ;; Scroll one line at a time (less "jumpy" than defaults)
;; (when (display-graphic-p)
;;   (setq mouse-wheel-scroll-amount '(1 ((shift) . 1) ((control) . nil))   ; mwheel.el
;;         ;; mouse-wheel-scroll-amount '(1 ((shift) . hscroll))            ; mwheel.el
;;         ;; mouse-wheel-scroll-amount '(1 ((shift) . 1))                  ; mwheel.el
;;         mouse-wheel-progressive-speed nil))                              ; mwheel.el


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
      ;; (require 'custom_section_gui)
      (load-theme 'abunbux t)
      ;; (require 'poet-theme_section_gui)
      (message "Loading \"custom_section_gui\"")
      )
  (progn
    (menu-bar-mode       -1)
    ;; (load-theme 'abunbux t)
    (load-theme 'leuven t)
    ;; (require 'custom_section_tty)
    (message "Loading \"custom_section_tty\"")))




(require 'setq_built-in_config)

(require 'built-in_window_config)
(require 'built-in_frame_config)
(require 'built-in_simple_config)
(require 'built-in_files_config)
(require 'built-in_saveplace_config)
(require 'built-in_savehist_config)
(require 'built-in_delsel_config)
(require 'built-in_recentf_config)
(require 'built-in_bookmark_config)
(require 'built-in_abbrev_config)
(require 'built-in_narrow_config)
(require 'built-in_whitespace_config)
(require 'built-in_time-stamp_config)
(require 'built-in_diff_config)         ; :disabled
(require 'built-in_ediff_config)
(require 'built-in_grep_config)         ; :disabled
(require 'built-in_paren_config)



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

;; (require 'ido_init)

;; (use-package selectrum
;;   :quelpa (selectrum :fetcher github :repo "raxod502/selectrum")
;;   :init (selectrum-mode +1))


(require 'smartparens_init)
(require 'company_init)

(require 'which-key_init)
(require 'amx_init)

;; Enable richer annotations using the Marginalia package
(use-package marginalia
  :ensure t
  ;; Either bind `marginalia-cycle` globally or only in the minibuffer
  :bind (("M-A" . marginalia-cycle)
         :map minibuffer-local-map
         ("M-A" . marginalia-cycle))

  :init
  (marginalia-mode)
  :config
  (message "Loading \"marginalia\"")
  ;; (add-to-list 'marginalia-prompt-categories '("sketch" . sketch))
  (setq marginalia-align-offset 10)
  )


(require 'yasnippet_init)

;; (require 'smart-mode-line_init)


(use-package all-the-icons
  :ensure t
  ;; :defer t
  :config
  (message "Loading \"all-the-icons\"")
  ;; (unless (find-font (font-spec :name "all-the-icons"))
  ;; (all-the-icons-install-fonts t))
  )

(use-package all-the-icons-dired
  :ensure t
  :hook
  (dired-mode . all-the-icons-dired-mode)
  :config
  (message "Loading \"all-the-icons-dired\"")
  )

(use-package all-the-icons-ivy
  :defer t
  :ensure t
  :hook
  (after-init . all-the-icons-ivy-setup)
  ;; :custom
  ;; (all-the-icons-ivy-buffer-commands '() "Don't use for buffers.")
  :config
  (message "Loading \"all-the-icons-ivy\"")
  ;; (all-the-icons-ivy-setup)
  )






(use-package doom-modeline
  :ensure t
  ;; :after (all-the-icons)
  :hook (after-init . doom-modeline-mode)
  ;; :custom (doom-modeline-minor-modes t)
  :custom-face
  (mode-line ((t (:family "Noto Sans" :height 0.95))))
  (mode-line-inactive ((t (:family "Noto Sans" :height 0.95))))
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




(use-package highlight-parentheses
  :ensure t
  :hook (prog-mode . highlight-parentheses-mode)
  :custom-face
  (highlight-parentheses-highlight ((t (:weight bold  :height 1.0 :background "#1d2014" ))))
  :config
  (message "Loading \"highlight-parentheses\"")
  )



;; (use-package centaur-tabs
;;   :ensure t
;;   :demand
;;   :hook
;;   (dired-mode . centaur-tabs-local-mode)
;;   :config
;;   (message "Loading \"centaur-tabs\"")
;;   (centaur-tabs-mode t)
;;   (centaur-tabs-headline-match)
;;   (setq centaur-tabs-style "bar")
;;   (setq centaur-tabs-set-icons t)
;;   (setq centaur-tabs-plain-icons t)
;;   (setq centaur-tabs-gray-out-icons 'buffer)
;;   (setq centaur-tabs-set-bar 'left)
;;   (setq centaur-tabs-set-close-button nil)
;;   (centaur-tabs-change-fonts "arial" 1.0)

;; )


;; (use-package dashboard
;;   :ensure t
;;   :custom-face (dashboard-heading ((t (:inherit (font-lock-string-face bold)))))
;;   ;; :init
;;   ;; (defun my/dashboard-banner ()
;;   ;;   """Set a dashboard banner including information on package initialization
;;   ;;  time and garbage collections."""
;;   ;;   (setq dashboard-banner-logo-title
;;   ;;         (format "Emacs ready in %.2f seconds with %d garbage collections."
;;   ;;                 (float-time (time-subtract after-init-time before-init-time)) gcs-done)))
;;   ;; (add-hook 'after-init-hook 'dashboard-refresh-buffer)
;;   ;; (add-hook 'dashboard-mode-hook 'my/dashboard-banner)

;;   :config
;;   (message "Loading \"dashboard\"")
;;   (setq dashboard-items '((recents  . 10)
;;                           (bookmarks . 5)
;;                           ;; (agenda . 5)
;;                           (registers . 5)))
;;   (setq dashboard-banner-logo-title "Ну что, пошалим?!")
;;   ;; Set the banner:
;;   ;; Value can be
;;   ;; 'official which displays the official emacs logo
;;   ;; 'logo which displays an alternative emacs logo
;;   ;; 1, 2 or 3 which displays one of the text banners
;;   ;; "path/to/your/image.png" or "path/to/your/text.txt" which displays whatever image/text you would prefer
;;   ;; (setq dashboard-startup-banner [VALUE])
;;   ;; (setq dashboard-startup-banner 'logo)
;;   (setq dashboard-center-content t)
;;   (setq dashboard-set-heading-icons nil)
;;   (setq dashboard-set-file-icons nil)
;;   (setq dashboard-week-agenda nil)
;;   (setq dashboard-item-names '(("Recent Files:" . "Последние открытые файлы:")
;;                                ("Bookmarks:"    . "Закладки:")
;;                                ("Agenda for today:" . "Расписание на сегодня:")
;;                                ("Agenda for the coming week:" . "Расписание на грядущую неделю:")
;;                                ("Registers:"    . "Регистры:")
;;                                ))
;;   (setq dashboard-set-init-info t)
;;   (setq dashboard-set-navigator t)
;;   ;; Format: "(icon title help action face prefix suffix)"
;;   (setq dashboard-navigator-buttons
;;         `(;; line1
;;           ((,(all-the-icons-octicon "mark-github" :height 1.1 :v-adjust 0.0)
;;             "abunbux on github"
;;             "https://github.com/abunbux"
;;             (lambda (&rest _) (browse-url "https://github.com/abunbux")))
;;            (,(all-the-icons-octicon "home" :height 1.1 :v-adjust 0.0)
;;             "home"
;;             "~/"
;;             (lambda (&rest _) (dired "~/")))
;;            (,(all-the-icons-fileicon "emacs" :height 1.1 :v-adjust 0.0)
;;             "Config"
;;             "~/.emacs.d/init.el"
;;             (lambda (&rest _) (find-file "~/.emacs.d/init.el")))
;;            )
;;           ))
;;   (dashboard-setup-startup-hook)
;;   )



(require 'search_replace_config)
(require 'vimish-fold_init)

(require 'defun_bind)




(require 'easy-menu_init)





;; hl-line.el
(use-package hl-line
  :ensure nil
  :hook
  (after-init . global-hl-line-mode)
  :custom-face
  (hl-line ((((class color) (min-colors 89)) (:inherit t :background "#3d4753" :foreground nil))))
  (hl-tags-face ((((class color) (min-colors 89)) (:background "#FEFCAE"))))

  :config
  (message "Loading \"hl-line\""))



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




;;; duplicate-thing.el
(use-package duplicate-thing
  :ensure t
  :bind (:map global-map ("C-x <down>" . duplicate-thing))
  :config (message "Loading \"duplicate-thing\""))



;;; elmacro.el
(use-package elmacro
  :ensure t
  :hook (after-init . elmacro-mode)
  :config
  (elmacro-mode)
  (message "Loading \"elmacro-mode\""))





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



;;; defer
;;; эти моды работают по вызову


(require 'loccur_init)
(require 'hide-lines_init)


(require 'web-mode_init)
(require 'emmet_init)
(require 'org-mode_config)
(require 'markdown-mode_init)
(require 'flycheck_init)
(require 'git_config)
(require 'syslog-mode_init)
(require 'multiple-cursors_init)


;; (require 'shell_init)
(require 'tramp_init)



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




;; (use-package poet-theme
;;   :ensure t
;;   :config
;;   (message "Loading \"poet-theme\"")
;;   )


;; (add-hook 'text-mode-hook
;;           (lambda ()
;;             (variable-pitch-mode 1)))



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





;;; init.el ends here
