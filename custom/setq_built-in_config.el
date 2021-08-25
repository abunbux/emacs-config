;;; setq_built-in_config.el  -*- coding: utf-8; lexical-binding: t -*-

;;; CREATED: <Сб мая 11 07:59:33 EEST 2019>
;;; Time-stamp: <Последнее обновление -- Monday August 23 22:2:5 EEST 2021>




;;; Commentary:

;;; Code:



(setq browse-url-browser-function   'browse-url-generic             ; browse-url.el
	  ;; browse-url-generic-program    "google-chrome-stable"       ; browse-url.el
	  browse-url-generic-program    "firefox-bin"                   ; browse-url.el
	  user-full-name                "abunbux"                       ; C-code (emacs)
	  user-mail-address             "abunbux@gmail.com")            ; startup.el




;; Ignore split window vertically
(setq split-height-threshold            nil                         ; window.el
      ;; split-height-threshold        48                           ; window.el
      ;; split-height-threshold        4                            ; window.el
      ;; split-width-threshold         140                          ; window.el
      split-width-threshold             40)                         ; window.el






(use-package emacs
  :hook
  ;; Подсвечивать выделенные текст, между двумя метками
  (after-init       . transient-mark-mode)                    ; startup.el
  ;; auto-formatting in text-mode
  (text-mode-hook   . turn-on-auto-fill)                      ; text-mode.el

  :custom
  (auto-window-vscroll                  nil)            ; C-code (emacs)
  ;; Quiet Startup
  (inhibit-default-init                 t)              ; startup.el
  (inhibit-startup-echo-area-message    t)              ; startup.el
  (inhibit-startup-message              t)              ; startup.el
  (initial-scratch-message              nil)            ; startup.el
  (inhibit-startup-screen               t)              ; startup.el
  (inhibit-x-resources                  t)              ; C-code (emacs)
  ;; Не сжимать кеши шрифтов во время сборки мусора.
  ;; Это нужно при «doom-modeline», если есть проблема с притормаживанием.
  ;; Я ничего не заметил, но на всякий пожарный случай поставил.
  (inhibit-compacting-font-caches       t)              ; C-code (emacs)

  (bidi-display-reordering              nil)            ; C-code (emacs)
  (cursor-type                          '(bar . 3))     ; C-code (emacs)
  (completion-ignore-case               t)              ; C-code (emacs)
  (delete-by-moving-to-trash            t)              ; C-code (emacs)
  (echo-keystrokes                      0.4)            ; C-code (emacs)
  (enable-recursive-minibuffers         t)              ; C-code (emacs)
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
  (scroll-preserve-screen-position      t)              ; C-code (emacs)
  (scroll-step                          1)              ; C-code (emacs)
  (select-active-regions                t)              ; C-code (emacs)
  (tab-width                            4)              ; C-code (emacs)
  (truncate-partial-width-windows       nil)            ; C-code (emacs)
  (visible-bell                         nil)            ; C-code (emacs)
  (visible-cursor                       nil)            ; C-code (emacs)
  (x-stretch-cursor                     t)              ; C-code (emacs)
  (use-dialog-box                       nil)            ; C-code (emacs)

  :config
  (message "Loading built-in \"emacs\"")
  (setq-default indent-tabs-mode        nil            ; C-code (emacs)
                tab-width               4)             ; C-code (emacs)
  (setq-default fill-column             80)            ; C-code (emacs)
  (setq-default major-mode              'text-mode)    ; C-code (emacs)

  )






(use-package simple
  :defer t
  :custom
  (column-number-indicator-zero-based   nil)                                    ; bindings.el
  (column-number-mode                   t)                                      ; simple.el
  (global-visual-line-mode              t)                                      ; simple.el

  (kill-whole-line                      t)                                      ; simple.el
  (kill-ring-max                        1000)                                   ; simple.el
  (next-line-add-newlines               nil)                                    ; simple.el
  (set-mark-command-repeat-pop          t)                                      ; simple.el
  (save-interprogram-paste-before-kill  t)                                      ; simple.el
  (blink-matching-paren-distance        nil)                                    ; simple.el
  (interprogram-cut-function            (and (fboundp #'x-select-text)          ; simple.el
                                             #'x-select-text))
  (interprogram-paste-function          (and (fboundp #'x-selection-value)      ; simple.el
                                             #'x-selection-value))
  (line-number-mode                     t)                                      ; simple.el

  (size-indication-mode                 t)                                      ; simple.el
  ;; (mark-ring-max                        16) ; 16 по умолчанию                ; simple.el
  :config
  (message "Loading built-in \"simple\"")
  )



(use-package frame
  :custom
  (blink-cursor-mode          -1)                                     ; frame.el
  ;; (initial-frame-alist '((vertical-scroll-bars)))
  :config
  (message "Loading built-in \"frame\"")
  ;; Display the name of the current buffer in the title bar
  (setq frame-title-format
        '("emacs - %@"
          (:eval (system-name)) ": " (:eval
                                      (if (buffer-file-name)
                                          (abbreviate-file-name (buffer-file-name))
                                        "%b")) " [%*]"))
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
  (setq display-time-world-list '(("Europe/Paris"         "Paris")                ; time.el
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



;;; Time-stamp
;; when there is a "Time-stamp:
;; <Последнее обновление -- Sunday September 24 23:32:21 EEST 2017>"
;; in the first 15 lines of the file,
;; emacs will write time-stamp information there when saving the file.
(use-package time-stamp
  :hook
  (before-save . time-stamp)
  :custom
  (time-stamp-active         t)
  ;; check first 15 buffer lines for Time-stamp: <>
  (time-stamp-line-limit     15)
  (time-stamp-format "Последнее обновление -- %:a %:b %:d %:H:%:M:%:S %:Z %:Y")
  :config
  (message "Loading built-in \"time-stamp\"")
  )



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
      minibuffer-depth-indicate-mode    99                          ; mb-depth.el

      read-file-name-completion-ignore-case t                       ; minibuffer.el


      smooth-scroll-margin              5                           ; is a variable without a source file
      x-select-enable-clipboard         t                           ; select.el
      x-select-enable-primary           nil                         ; select.el
      window-min-height                 7)                          ; window.el




(setq-default eww-bookmarks-directory           "~/.emacs.d/cache/"
              projectile-cache-file             "~/.emacs.d/cache/projectile/projectile.cache"
              projectile-known-projects-file    "~/.emacs.d/cache/projectile/known-projects.eld"
              url-configuration-directory       "~/.emacs.d/cache/url/")


(setq history-delete-duplicates     t
      history-length                250
      vc-make-backup-files          t)


(setq create-lockfiles              nil)
(setq auto-save-list-file-name      nil)
(setq auto-save-visited-file-name   nil)




;; Mouse & Smooth Scroll
;; Scroll one line at a time (less "jumpy" than defaults)
(when (display-graphic-p)
  (setq mouse-wheel-scroll-amount '(1 ((shift) . hscroll))          ; mwheel.el
        ;; mouse-wheel-scroll-amount '(1 ((shift) . 1))             ; mwheel.el
        mouse-wheel-scroll-amount-horizontal 1                     ; is a variable without a source file
        mouse-wheel-progressive-speed nil))                         ; mwheel.el




(setq mouse-drag-copy-region            nil                         ; mouse.el
      mouse-yank-at-point               t                           ; mouse.el
      mouse-wheel-follow-mouse          t                           ; mwheel.el
      mouse-wheel-follow-mouse          't)                         ; mwheel.el


(setq           sentence-end                                        ; paragraphs.el
                "\\([。、！？]\\|……\\|[,.?!][]\"')}]*\\($\\|[ \t]\\)\\)[ \t\n]*")
(setq           sentence-end-double-space   nil)                    ; paragraphs.el
(setq-default   sentence-end-double-space   nil)                    ; paragraphs.el

(setq-default compilation-ask-about-save    nil                     ; compile.el
              )




(setq
 js-indent-level   4                                           ; is a variable without a source file
 sgml-basic-offset 4                                           ; is a variable without a source file
 )


(setq-default c-basic-offset        4                               ; is a variable without a source file
		      indent-line-function  'insert-tab                     ; indent.el
		      sh-basic-offset       4                               ; is a variable without a source file
		      standart-indent       4                               ; is a variable without a source file
		      tab-always-indent     nil                             ; indent.el
		      typescript-indent-level 4)                            ; is a variable without a source file








;;; https://git.shimmy1996.com/shimmy1996/.emacs.d
;; Use display-line-numbers instead of linum.
;; Enable relative line numbering, and set minimum width to 3.
(setq-default display-line-numbers-type (quote t))                  ; display-line-numbers.el
(setq-default display-line-numbers-width 3)                         ; C-code (emacs)
;; (global-display-line-numbers-mode)                               ; display-line-numbers.el

(electric-indent-mode       -1)                                     ; electric.el
(global-eldoc-mode          -1)                                     ; eldoc.el

;; (mouse-wheel-mode    't)                                         ; mwheel.el
;; (desktop-save-mode   t)                                          ; loaddefs.el


(file-name-shadow-mode      1)                                      ; rfn-eshadow.el
(minibuffer-depth-indicate-mode)                                    ; mb-depth.el

;; Высота временного буфера зависит от его содержимого
(temp-buffer-resize-mode    t)                                      ; help.el

;; (global-auto-revert-mode 1)                                      ; loaddefs.el




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



;;; whitespace.el
;; built-in
;; "M-h h W"  `whitespace-mode'
(use-package whitespace
  :ensure nil
  :defer t
  :bind (("M-h h W" . whitespace-mode))
  :init
  :config
  (message "Loading \"whitespace\"")
  (setq whitespace-style
        '(face
          empty
          lines
          newline
          newline-mark
          spaces
          space-mark
          tab-mark
          tabs
          trailing))

  (setq whitespace-display-mappings
        '((space-mark 32 [183] [46])
          (space-mark 160 [164] [95])
          (newline-mark 10 [36 10])
          (tab-mark 9 [187 9] [92 9]))))




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



;;; semantic.el
(use-package semantic
  :ensure nil
  :defer t
  :commands (semantic-mode)
  :init
  :config
  (message "Loading \"semantic\"")
  (with-eval-after-load 'semantic-mode
    (progn
      (message "semantic-mode loaded")
      (setq semantic-idle-summary-function (quote semantic-format-tag-summarize))
      (setq semantic-imenu-bucketize-file t)
      (setq semantic-imenu-bucketize-type-members nil)
      (setq semantic-imenu-buckets-to-submenu nil)
      (setq semantic-imenu-expand-type-members nil)
      (setq semantic-imenu-sort-bucket-function (quote semantic-sort-tags-by-type-increasing-ci))
      (setq semantic-which-function-use-color t)
      ))

  (add-hook 'semantic-mode-hook 'global-semantic-highlight-func-mode)
  (add-hook 'semantic-mode-hook 'global-semantic-idle-completions-mode)
  (add-hook 'semantic-mode-hook 'global-semanticdb-minor-mode)
  (add-hook 'semantic-mode-hook 'global-semantic-highlight-edits-mode)
  (add-hook 'semantic-mode-hook 'global-semantic-idle-summary-mode)
  )






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


;; (display-battery-mode   t)                                                               ; loaddefs.el



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

(setq isearch-lax-whitespace        t                                                       ; isearch.el
      isearch-regexp-lax-whitespace t                                                       ; isearch.el
      ;; search-default-mode        (quote isearch-symbol-regexp)                           ; isearch.el
      search-invisible              nil                                                     ; isearch.el
      search-highlight              t                                                       ; isearch.el
      query-replace-highlight       t                                                       ; replace.el
      search-whitespace-regexp      "[ \t\r\n]+"                                            ; isearch.el
      grep-command    "ack --with-filename --nofilter --nogroup ")                          ; grep.el

(setq-default grep-highlight-matches    t                                                   ; grep.el
              case-fold-search          t)                                                  ; C-code (emacs)



;; Allow scrolling while isearch is active
;; Example: C-s foo C-l (to recenter the point in buffer to center/top/bottom)
;; http://emacs.stackexchange.com/a/10313/115
;; Прелесть прокрутки во время поиска в том, что текущее совпадение никогда не идет за кадром.
;; Таким образом, вы даже можете использовать C-v / M-v.
(setq isearch-allow-scroll          t)                                                      ; isearch.el



;; Следующие два hook-a нарушают работу  `ivy-occur'
;; (add-hook 'occur-hook       (lambda () (switch-to-buffer-other-window "*Occur*")))
;; (add-hook 'grep-mode-hook   (lambda () (switch-to-buffer-other-window "*grep*")))
;; Focus on *Occur* window right away.
(add-hook 'occur-hook (lambda () (other-window 1)))                                         ; replace.el



;; re-builder
(setq-default reb-re-syntax 'string)                                    ; is a variable without a source file
(with-eval-after-load 're-builder                                       ; re-builder.el
  (message "Loading \"re-builder\""))



;;; grep.el
;; Не использую - есть другие альтернативы, всё использовать невозможно, да и не нужно.
;; (use-package grep
;;   ;; :disabled t
;;   :defer t
;;   :preface
;;   ;;; https://github.com/mpolden/emacs.d/blob/master/lisp/init-grep.el
;;   ;; grep-visit-buffer-other-window ("o")
;;   ;; grep-visit-buffer-other-window-noselect ("C-o")
;;   (defun grep-visit-buffer-other-window (&optional event noselect)
;;     "Visit grep result in another window."
;;     (interactive)
;;     (let ((current-window (selected-window)))
;;       (compile-goto-error event)
;;       (when noselect
;;         (select-window current-window))))
;;
;;   (defun grep-visit-buffer-other-window-noselect (&optional event)
;;     "Visit grep result in another window, but don't select it."
;;     (interactive)
;;     (grep-visit-buffer-other-window event t))
;;
;;   :bind (
;;          ("M-s g ." . grep-at-point)
;;          ("M-s g s" . grep-selected-text)
;;
;;          :map grep-mode-map
;;          ;; make C-o and o behave as in dired
;;          ("o"   . grep-visit-buffer-other-window)
;;          ("C-o" . grep-visit-buffer-other-window-noselect)
;;          ;; n and p changes line as in ag-mode
;;          ("n"   . compilation-next-error)
;;          ("p"   . compilation-previous-error)
;;          )
;;   :init
;;   :config
;;   (message "Loading \"grep\"")
;;
;;   (add-hook 'grep-mode-hook
;;             (lambda ()
;;               ;; wrap lines
;;               (setq-local truncate-lines nil)))
;;   (setq grep-host-defaults-alist nil)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;






;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;                                                      ;;;
;;;                    DIFF                       ;;;
;;;                                                      ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; diff-mode.el
(use-package diff-mode                                                                          ; diff-mode.el
  :ensure nil
  :defer t
  :preface
    ;;; my/diff-region ()
  (defun my/diff-region ()
    "Select a region to compare"
    (interactive)
    (when (use-region-p) ; there is a region
      (let (buf)
        (setq buf (get-buffer-create "*Diff-regionA*"))
        (save-current-buffer
          (set-buffer buf)
          (erase-buffer))
        (append-to-buffer buf (region-beginning) (region-end)))
      )
    (message "Now select other region to compare and run `my/diff-region-now`"))

    ;;; my/diff-region-now ()
  (defun my/diff-region-now ()
    "Compare current region with region already selected by `diff-region`"
    (interactive)
    (when (use-region-p)
      (let (bufa bufb)
        (setq bufa (get-buffer-create "*Diff-regionA*"))
        (setq bufb (get-buffer-create "*Diff-regionB*"))
        (save-current-buffer
          (set-buffer bufb)
          (erase-buffer))
        (append-to-buffer bufb (region-beginning) (region-end))
        (ediff-buffers bufa bufb))))

  ;; :bind (("---------" . diff-buffer-with-file))
  :init
  (autoload 'diff-mode "diff-mode" "Diff major mode" t)
  :config
  (message "Loading \"diff-mode\"")
  (setq diff-switches "-u")
  ;; show important whitespace in diff-mode
  (add-hook 'diff-mode-hook
            (lambda ()
              (setq-local whitespace-style
                          '(face
                            tabs
                            tab-mark
                            spaces
                            space-mark
                            trailing
                            indentation::space
                            indentation::tab
                            newline
                            newline-mark))
              (whitespace-mode 1)))

  )



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;                                                      ;;;
;;;                    EDIFF                             ;;;
;;;                                                      ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; ediff.el
(use-package ediff
  :ensure nil
  :defer t
  ;; :bind (("----------" . ediff-current-file))
  :config
  (message "Loading \"ediff\"")
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

  (custom-set-faces
   '(ediff-current-diff-A   ((t (:background "orange"       :foreground "brown"))))
   '(ediff-current-diff-B   ((t (:background "red"          :foreground "blue"))))
   '(ediff-current-diff-C   ((t (:background "Pink"         :foreground "Navy"))))
   '(ediff-even-diff-A      ((t (:background "light grey"   :foreground "Black"))))
   '(ediff-even-diff-B      ((t (:background "Grey"         :foreground "White"))))
   '(ediff-even-diff-C      ((t (:background "light grey"   :foreground "Black"))))
   '(ediff-fine-diff-A      ((t (:background "sky blue"     :foreground "Navy"  :weight bold))))
   '(ediff-fine-diff-B      ((t (:background "cyan"         :foreground "Black" :weight bold))))
   '(ediff-fine-diff-C      ((t (:background "Turquoise"    :foreground "Black" :weight bold))))
   '(ediff-odd-diff-A       ((t (:background "Grey"         :foreground "White"))))
   '(ediff-odd-diff-B       ((t (:background "light grey"   :foreground "Black"))))
   '(ediff-odd-diff-C       ((t (:background "Grey"         :foreground "White"))))
   ))




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;










(add-to-list 'display-buffer-alist                                                      ; window.el
             '("*Apropos*" display-buffer-same-window))                                 ; window.el





(setq transient-history-file "~/.emacs.d/cache/history.el")                             ; is a variable without a source file
(setq-default transient-history-file "~/.emacs.d/cache/history.el")                     ; is a variable without a source file



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


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;








;;; Disabled Commands **************************************

;; (setq disabled-command-function  nil)                 ; novice.el
;; Enable default disabled stuff
;; Следующие команды выдают предупреждение при запуске.
;; Для их отключения нужно раскомментировать нижеследующее
(put 'downcase-region   'disabled nil)
(put 'upcase-region     'disabled nil)
(put 'erase-buffer      'disabled nil)
(put 'scroll-left       'disabled nil)
;; (put 'set-goal-column 'disabled nil)

;; (setq disabled-command-function "overwrite-mode")

;;; my/enable-all-commands ()
(defun my/enable-all-commands ()
  "Enable all commands, reporting on which were disabled."
  (interactive)
  (with-output-to-temp-buffer "*Commands that were disabled*"
    (mapatoms
     (function
      (lambda (symbol)
        (when (get symbol 'disabled)
          (put symbol 'disabled nil)
          (prin1 symbol)
          (princ "\n")))))))



(message "Loading \"setq_built-in_config.el\"")



(provide 'setq_built-in_config)
