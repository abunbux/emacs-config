;;; setq_built-in_config.el  -*- coding: utf-8; lexical-binding: t -*-

;;; CREATED: <Сб мая 11 07:59:33 EEST 2019>
;;; Time-stamp: <Последнее обновление -- Monday August 30 11:25:35 EEST 2021>




;;; Commentary:

;;; Code:




;; Подсвечивать выделенные текст, между двумя метками
(add-hook 'after-init-hook 'transient-mark-mode)                    ; startup.el


(setq browse-url-browser-function   'browse-url-generic             ; browse-url.el
	  ;; browse-url-generic-program    "google-chrome-stable"       ; browse-url.el
	  browse-url-generic-program    "firefox-bin"                   ; browse-url.el
	  user-full-name                "abunbux"                       ; C-code (emacs)
	  user-mail-address             "abunbux@gmail.com")            ; startup.el

;; auto-formatting in text-mode
(add-hook 'text-mode-hook 'turn-on-auto-fill)                       ; text-mode.el



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
  (echo-keystrokes                      0.4)            ; C-code (emacs)
  (focus-follows-mouse                  t)              ; C-code (emacs)
  (indent-tabs-mode                     nil)            ; C-code (emacs)
  (indicate-empty-lines                 t)              ; C-code (emacs)
  (indicate-buffer-boundaries   '((bottom . right)))    ; C-code (emacs)
  (left-margin-width                    0)              ; C-code (emacs)
  (max-lisp-eval-depth                  5000)           ; C-code (emacs)
  (max-mini-window-height               0.5)            ; C-code (emacs)
  (max-specpdl-size                     10000)          ; C-code (emacs)
  (ring-bell-function                   'ignore)        ; C-code (emacs)
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
  (setq-default major-mode              'text-mode)    ; C-code (emacs)
  ;; ignore case
  (setq-default case-fold-search        t)             ; C-code (emacs)

  (setq history-delete-duplicates     t                ; C-code (emacs)
        history-length                250)             ; C-code (emacs)
  (setq create-lockfiles              nil)             ; C-code (emacs)
  (setq auto-save-list-file-name      nil)             ; C-code (emacs)
  (setq auto-save-visited-file-name   nil)             ; C-code (emacs)

  ;; C-v и M-v не отменяют друг друга, потому что положение точки не сохраняется.
  ;; Исправим это.
  (setq scroll-preserve-screen-position 'always)        ; C-code (emacs)
  (setq  enable-recursive-minibuffers   t)              ; C-code (emacs))

  )



;; (display-battery-mode              t)               ; loaddefs.el
(setq vc-make-backup-files          t)                 ; vc-hooks.el






(fset 'display-startup-echo-area-message #'ignore)    ; subr.el

;; (defalias 'yes-or-no-p #'y-or-n-p)                    ; subr.el
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



(use-package lisp-mode
  :custom
  (lisp-body-indent  2)                                         ; lisp-mode.el
  :config
  (message "Loading built-in \"lisp-mode\"")
  )





(setq ad-redefinition-action            'accept                     ; advice.el
      apropos-do-all                    t                           ; apropos.el
      apropos-sort-by-scores            t                           ; apropos.el
      apropos-documentation-sort-by-scores   nil                    ; apropos.el
      auto-revert-verbose               t                           ; autorevert.el
      compilation-always-kill           t                           ; compile.el
      help-window-select                t                           ; help.el
      kmacro-ring-max                   30                          ; kmacro.el
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

(setq column-number-indicator-zero-based   nil)                      ; bindings.el






(setq mouse-drag-copy-region            nil                         ; mouse.el
      mouse-yank-at-point               t                           ; mouse.el
      mouse-wheel-follow-mouse          t                           ; mwheel.el
      mouse-wheel-follow-mouse          't)                         ; mwheel.el

;; (mouse-wheel-mode    't)                                         ; mwheel.el


(setq           sentence-end                                        ; paragraphs.el
                "\\([。、！？]\\|……\\|[,.?!][]\"')}]*\\($\\|[ \t]\\)\\)[ \t\n]*")
(setq           sentence-end-double-space   nil)                    ; paragraphs.el
(setq-default   sentence-end-double-space   nil)                    ; paragraphs.el

(setq-default compilation-ask-about-save    nil                     ; compile.el
              )




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








(when (require 'font-lock nil :noerror)
  (global-font-lock-mode)                                           ; font-core.el
  ;; (jit-lock-debug-mode)
  (setq-default font-lock-multiline           t                     ; font-core.el
                font-lock-maximum-decoration  t                     ; font-core.el
                font-lock-support-mode        'jit-lock-mode        ; font-core.el
                jit-lock-chunk-size           1000                  ; jit-lock.el
                jit-lock-contextually         t                     ; jit-lock.el
                jit-lock-context-time         0.5                   ; jit-lock.el
                jit-lock-defer-contextually   t                     ; jit-lock.el
                jit-lock-defer-time           0.04                  ; jit-lock.el
                jit-lock-stealth-load         200                   ; jit-lock.el
                jit-lock-stealth-nice         0.5                   ; jit-lock.el
                jit-lock-stealth-time         16                    ; jit-lock.el
                jit-lock-stealth-verbose      nil))                 ; jit-lock.el


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;; hilit-chg.el - highlight-changes-mode
;; ;; built-in
;; ;; не пользуюсь
;; ;; * `highlight-changes-...'
;; (use-package hilit-chg
;;   :ensure nil
;;   :defer t
;;   :bind (
;;          ("C-z m C"         . highlight-changes-mode)
;;          ("M-h c v"         . highlight-changes-visible-mode)
;;          ("M-h c <right>"   . highlight-changes-next-change)
;;          ("M-h c <left>"    . highlight-changes-previous-change)
;;          ("M-h c -"         . highlight-changes-remove-highlight)
;;          ;; highlight-compare-with-file
;;          ;; highlight-compare-buffers
;;          )
;;   :init
;;   ;; (global-highlight-changes-mode t)
;;   ;; ;; initially hide
;;   ;; (setq highlight-changes-visibility-initial-state nil)
;;
;;   :config
;;   (message "Loading \"highlight-changes-mode\""))




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;; ;;; semantic.el
;; (use-package semantic
;;   :ensure nil
;;   ;; :disabled
;;   :commands (semantic-mode)
;;   :init
;;   :config
;;   (message "Loading \"semantic\"")
;;   (with-eval-after-load 'semantic-mode
;;     (progn
;;       (message "semantic-mode loaded")
;;       (setq semantic-idle-summary-function (quote semantic-format-tag-summarize))
;;       (setq semantic-imenu-bucketize-file t)
;;       (setq semantic-imenu-bucketize-type-members nil)
;;       (setq semantic-imenu-buckets-to-submenu nil)
;;       (setq semantic-imenu-expand-type-members nil)
;;       (setq semantic-imenu-sort-bucket-function (quote semantic-sort-tags-by-type-increasing-ci))
;;       (setq semantic-which-function-use-color t)
;;       ))

;;   (add-hook 'semantic-mode-hook 'global-semantic-highlight-func-mode)
;;   (add-hook 'semantic-mode-hook 'global-semantic-idle-completions-mode)
;;   (add-hook 'semantic-mode-hook 'global-semanticdb-minor-mode)
;;   (add-hook 'semantic-mode-hook 'global-semantic-highlight-edits-mode)
;;   (add-hook 'semantic-mode-hook 'global-semantic-idle-summary-mode)
;;   )






;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;; mode-line
;; Строка состояния

(setq line-number-display-limit-width   300                                                 ; C-code (emacs)
      line-number-display-limit         6291456             ; 6 Mb                          ; C-code (emacs)
      mode-line-end-spaces              nil)                                                ; bindings.el

;; (setq global-mode-string (remove 'display-time-string global-mode-string))               ; C-code (emacs)



(setq-default mode-line-format                                                              ; C-code (emacs)
              '("%e" ; print error message about full memory.
                ;; mode-line-front-space
                ;; mode-line-mule-info
                " %n "
                " %Z"
                mode-line-modified " "
                "%@ "
                mode-line-buffer-identification " "
                ;; mode-line-position
                " %p " "%l" ":%C" " / " "%I "
                ;; mode-name
                ;; "  "
                ;; Major mode
                ;; "[%m] "
                "   "
                mode-line-modes
                mode-line-misc-info
                ;; battery-mode-line-string
                mode-line-end-spaces
                ))






;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;                                                      ;;;
;;;                    ПОИСК, ЗАМЕНА                       ;;;
;;;                                                      ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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






;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                        ;;
;;                  ЛОКАЛЬ, ВРЕМЯ                           ;;
;;                                                        ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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
  (display-time-24hr-format             t)
  (display-time-day-and-date            t)
  (display-time-format                  "/ %R %d-%m-%y /")
  ;; (display-time-mode                    1)
  ;; (display-time-update)

  :config
  (message "Loading built-in \"time\"")
  ;; (display-time-mode t)
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


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;








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




(message "Loading \"setq_built-in_config.el\"")



(provide 'setq_built-in_config)
