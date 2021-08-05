;;; setq_built-in_config.el  -*- coding: utf-8; lexical-binding: t -*-

;;; CREATED: <Сб мая 11 07:59:33 EEST 2019>
;;; Time-stamp: <Последнее обновление -- Thursday August 5 19:45:6 EEST 2021>



;;; Commentary:

;;; Code:



(setq browse-url-browser-function   'browse-url-generic
	  ;; browse-url-generic-program    "google-chrome-stable"
	  browse-url-generic-program    "firefox-bin"
	  user-full-name                "abunbux"
	  user-mail-address             "abunbux@gmail.com")




;; Ignore split window vertically
(setq split-height-threshold            nil
      ;; split-height-threshold        48
      ;; split-height-threshold        4
      ;; split-width-threshold         140
      split-width-threshold             40)



;; Quiet Startup
(setq inhibit-default-init              t
      inhibit-startup-echo-area-message t
      inhibit-startup-message           t
      inhibit-startup-screen            t
      initial-scratch-message           nil)





(setq ad-redefinition-action            'accept
      apropos-do-all                    t
      apropos-sort-by-scores            t
      apropos-documentation-sort-by-scores   nil
      auto-revert-verbose               t
      blink-matching-paren-distance     nil
      compilation-always-kill           t
      completion-ignore-case            t
      delete-by-moving-to-trash         t
      echo-keystrokes                   0.4
      enable-recursive-minibuffers      t
      inhibit-x-resources               t
      interprogram-cut-function         (and (fboundp #'x-select-text)
                                             #'x-select-text)
      interprogram-paste-function       (and (fboundp #'x-selection-value)
                                             #'x-selection-value)
      help-window-select                t
      focus-follows-mouse               t
      kill-whole-line                   t
      kill-ring-max                     1000
      kmacro-ring-max                   30
      left-margin-width                 0
      max-lisp-eval-depth               5000
      max-mini-window-height            0.5
      max-specpdl-size                  10000
      minibuffer-depth-indicate-mode    99
      next-line-add-newlines            nil
      ring-bell-function                'ignore
      right-margin-width                0
      read-buffer-completion-ignore-case    t
      read-file-name-completion-ignore-case t
      require-final-newline             t
      resize-mini-windows               t
      save-interprogram-paste-before-kill   t
      select-active-regions             t
      ;; Allows navigation through the mark ring by doing C-u C-SPC once, then C-SPC
      ;; C-SPC.  instead of C-u C-SPC C-u C-SPC C-u C-SPC ...
      set-mark-command-repeat-pop       t
      smooth-scroll-margin              5
      truncate-partial-width-windows    nil
      x-select-enable-clipboard         t
      x-select-enable-primary           nil
      x-stretch-cursor                  t
      visible-bell                      nil
      visible-cursor                    nil
      use-dialog-box                    nil
      window-min-height                 7)



(setq auto-window-vscroll               nil
      mouse-drag-copy-region            nil
      mouse-yank-at-point               t
      mouse-wheel-follow-mouse          t
      mouse-wheel-follow-mouse          't
      mouse-wheel-progressive-speed     nil
      mouse-wheel-scroll-amount         '(1 ((shift) . 1))
      scroll-conservatively             10000
      scroll-margin                     3
      scroll-preserve-screen-position   t
      scroll-step                       1)


(setq           sentence-end
                "\\([。、！？]\\|……\\|[,.?!][]\"')}]*\\($\\|[ \t]\\)\\)[ \t\n]*")
(setq           sentence-end-double-space   nil)        ; paragraphs.el
(setq-default   sentence-end-double-space   nil)        ; paragraphs.el

(setq-default fill-column   80)
(setq-default find-file-visit-truename      t
              bidi-display-reordering       nil
              compilation-ask-about-save    nil
              cursor-type                   '(bar . 3)
              indicate-empty-lines          t
		      indicate-buffer-boundaries    '((bottom . right)))


(setq indent-tabs-mode  nil
	  js-indent-level   4
	  lisp-body-indent  2
	  sgml-basic-offset 4
	  tab-width         4)


(setq-default indent-tabs-mode      nil
		      c-basic-offset        4
		      indent-line-function  'insert-tab
		      sh-basic-offset       4
		      standart-indent       4
		      tab-width             4
		      tab-always-indent     nil
		      typescript-indent-level 4)


(setq-default major-mode 'text-mode)





;;; https://git.shimmy1996.com/shimmy1996/.emacs.d
;; Use display-line-numbers instead of linum.
;; Enable relative line numbering, and set minimum width to 3.
(setq-default display-line-numbers-type (quote t))
(setq-default display-line-numbers-width 3)
;; (global-display-line-numbers-mode)

(electric-indent-mode       -1)
(blink-cursor-mode          -1)
(global-eldoc-mode          -1)

;; (mouse-wheel-mode    't)
;; (desktop-save-mode   t)


(file-name-shadow-mode      1)
(minibuffer-depth-indicate-mode)

;; Высота временного буфера зависит от его содержимого
(temp-buffer-resize-mode    t)

;; (global-auto-revert-mode 1)



(global-visual-line-mode    t)
;; (fringe-mode                '(12 . 0))
(global-subword-mode        0)

;; Transparently open compressed files
(auto-compression-mode      nil)



;; (show-paren-mode            t)
(use-package paren
  :ensure nil
  :hook
  (after-init . show-paren-mode)
  :config
  (message "Loading \"paren\"")
  (setq show-paren-style  'expression
        ;; show-paren-style 'mixed
        show-paren-when-point-inside-paren t
        show-paren-when-point-in-periphery t
        show-paren-delay                  0))





(delete-selection-mode      nil)

(bind-key
 (kbd "d")
 (lambda (arg)
   (interactive "p")
   (if (region-active-p)
       (delete-active-region)
     (self-insert-command arg))))

(bind-key
 (kbd "w")
 (lambda (arg)
   (interactive "p")
   (if (region-active-p)
       (call-interactively 'kill-ring-save)
     (self-insert-command arg))))

(bind-key
 (kbd "c")
 (lambda (arg)
   (interactive "p")
   (if (region-active-p)
       (let ((str (buffer-substring-no-properties
                   (region-beginning)
                   (region-end))))
         (goto-char (region-end))
         (insert "\n" str))
     (self-insert-command arg))))




(when (require 'font-lock nil :noerror)
  (global-font-lock-mode)
  ;; (jit-lock-debug-mode)
  (setq-default font-lock-multiline           t
                font-lock-maximum-decoration  t
                font-lock-support-mode        'jit-lock-mode
                jit-lock-chunk-size           1000
                jit-lock-contextually         t
                jit-lock-context-time         0.5
                jit-lock-defer-contextually   t
                jit-lock-defer-time           0.04
                jit-lock-stealth-load         200
                jit-lock-stealth-nice         0.5
                jit-lock-stealth-time         16
                jit-lock-stealth-verbose      nil))


(use-package hl-line
  :ensure nil
  :hook
  (after-init . global-hl-line-mode)
  :config
  (message "Loading \"hl-line\""))


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



;;; hi-lock.el
;; built-in
;; * `hi-lock-...'
;; * `highlight-...'
;; * `unhighlight-'
(use-package hi-lock
  :ensure nil
  :commands (hi-lock-write-interactive-patterns
             unhighlight-regexp
             highlight-regexp
             highlight-phrase
             highlight-lines-matching-regexp
             hi-lock-find-patterns)
  :bind (
         ("C-x w h" . hi-lock-mode)
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
  (message "Loading \"hi-lock\""))



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



;;; semantic
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




;;; bookmark
;; По-умолчанию команды "bookmark" работают с клавишами ("C-x r {M, b, l, m}")
(use-package bookmark
  :ensure nil
  :defer t
  :preface
  ;; Put Last-Selected Bookmark on Top
  ;; Using this method you’ll find frequently used bookmarks easily
  (defadvice bookmark-jump (after bookmark-jump activate)
    (let ((latest (bookmark-get-bookmark bookmark)))
      (setq bookmark-alist (delq latest bookmark-alist))
      (add-to-list 'bookmark-alist latest)))

  :init
  (setq-default bookmark-default-file "~/.emacs.d/cache/bookmarks")
  ;; автоматически сохранять закладки в файл
  (setq bookmark-save-flag t)

  :config
  (message "Loading \"bookmark\""))




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;; mode-line
;; Строка состояния и заголовок окна
;; Display the name of the current buffer in the title bar
(setq frame-title-format
      '("emacs - %@"
        (:eval (system-name)) ": " (:eval
                                    (if (buffer-file-name)
                                        (abbreviate-file-name (buffer-file-name))
                                      "%b")) " [%*]"))

(setq line-number-display-limit-width   300
      line-number-display-limit         6291456             ; 6 Mb
      display-time-24hr-format          t
      display-time-day-and-date         t
      display-time-format               "/ %R %d-%m-%y /"
      mode-line-end-spaces              nil)

;; (setq global-mode-string (remove 'display-time-string global-mode-string))

;; (display-time-mode      1)
;; (display-time-update)
(line-number-mode       t)
(column-number-mode     t)
(size-indication-mode   t)

(setq-default mode-line-format
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


;; (setq battery-mode-line-format          "%p%%")
;; (display-battery-mode   t)

;; (setcar (cdr (assq 'smartparens-mode minor-mode-alist)) "")
;; (setcar (cdr (assq 'hi-lock-mode minor-mode-alist)) "")
;; (setcar (cdr (assq 'guide-key-mode minor-mode-alist)) "")
;; (setcar (cdr (assq 'ivy-mode minor-mode-alist)) "")
;; (setcar (cdr (assq 'yas-minor-mode minor-mode-alist)) "")

;; (defvar hidden-minor-modes
;;   '(
;;     abbrev-mode
;;     anzu-mode
;;     auto-fill-function
;;     eldoc-mode
;;     ivy-mode
;;     helm-mode
;;     guide-key-mode
;;     smartparens-mode
;;     yas-minor-mode
;;     volatile-highlights-mode
;;     ))

;; (defun purge-minor-modes ()
;;   (interactive)
;;   (dolist (x hidden-minor-modes nil)
;;     (let ((trg (cdr (assoc x minor-mode-alist))))
;;       (when trg
;;         (setcar trg "")))))

;; (add-hook 'after-change-major-mode-hook 'purge-minor-modes)


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

(setq isearch-lax-whitespace        t
      isearch-regexp-lax-whitespace t
      ;; search-default-mode        (quote isearch-symbol-regexp)
      search-invisible              nil
      search-highlight              t
      query-replace-highlight       t
      search-whitespace-regexp      "[ \t\r\n]+"
      grep-command    "ack --with-filename --nofilter --nogroup ")

(setq-default grep-highlight-matches    t
              case-fold-search          t)



;; Allow scrolling while isearch is active
;; Example: C-s foo C-l (to recenter the point in buffer to center/top/bottom)
;; http://emacs.stackexchange.com/a/10313/115
;; Прелесть прокрутки во время поиска в том, что текущее совпадение никогда не идет за кадром.
;; Таким образом, вы даже можете использовать C-v / M-v.
(setq isearch-allow-scroll          t)



;; Следующие два hook-a нарушают работу  `ivy-occur'
;; (add-hook 'occur-hook       (lambda () (switch-to-buffer-other-window "*Occur*")))
;; (add-hook 'grep-mode-hook   (lambda () (switch-to-buffer-other-window "*grep*")))
;; Focus on *Occur* window right away.
(add-hook 'occur-hook (lambda () (other-window 1)))



;; re-builder
(setq-default reb-re-syntax 'string)
(with-eval-after-load 're-builder
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



(use-package diff-mode
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






;; Масштабируемые шрифты в графическом интерфейсе
;; C-x C-+ or C-x C--
(if window-system (setq scalable-fonts-allowed t))


;; suppress the GNU spam
(fset 'display-startup-echo-area-message #'ignore)


(add-to-list 'display-buffer-alist
             '("*Apropos*" display-buffer-same-window))


;; auto-formatting in text-mode
(add-hook 'text-mode-hook 'turn-on-auto-fill)

;; Automatically delete trailing whitespace
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Подсвечивать выделенные текст, между двумя метками
(add-hook 'after-init-hook 'transient-mark-mode)
(setq transient-history-file "~/.emacs.d/cache/history.el")
(setq-default transient-history-file "~/.emacs.d/cache/history.el")

(defalias 'yes-or-no-p #'y-or-n-p)

(defadvice yes-or-no-p (around hack-exit (prompt))
  (if
      (string= prompt "Active processes exist; kill them and exit anyway? ") t
    ad-do-it))


;;; Prompt the user for a yes or no response, but accept any non-y response as a no
;; my/y-or-n-p-optional ()
(defun my/y-or-n-p-optional (prompt)
  "Prompt the user for a yes or no response, but accept any non-y
response as a no."
  (let ((query-replace-map (copy-keymap query-replace-map)))
    (define-key query-replace-map [t] 'skip)
    (y-or-n-p prompt)))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                        ;;
;;                  ЛОКАЛЬ, ВРЕМЯ                           ;;
;;                                                        ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Default Encoding

(prefer-coding-system               'utf-8)
(define-coding-system-alias         'UTF-8 'utf-8)

(set-buffer-file-coding-system      'utf-8-unix)
(set-clipboard-coding-system        'utf-8)
(set-default-coding-systems         'utf-8-unix)
(set-keyboard-coding-system         'utf-8-unix)
(set-language-environment           'utf-8)
(set-locale-environment             "ru_RU.utf8")
(set-selection-coding-system        'utf-8-unix)
(set-terminal-coding-system         'utf-8)


(setq buffer-file-coding-system         'utf-8-unix
      calendar-week-start-day           1
      coding-system-for-write           'utf-8
      default-buffer-file-coding-system 'utf-8-unix
      european-calendar-style           t
      file-name-coding-system           'utf-8
      selection-coding-system           'utf-8
      system-time-locale                "C"
      x-select-request-type             '(UTF8_STRING COMPOUND_TEXT TEXT STRING))


(setq-default buffer-file-coding-system     'utf-8-unix
              coding-system-for-read        'utf-8
              buffer-file-coding-system     'utf-8-auto)


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


;;; Хоткеи при русской раскладке
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
      (activate-input-method current))))

(reverse-input-method 'russian-computer)


;;; Time-stamp
;; when there is a "Time-stamp:
;; <Последнее обновление -- Sunday September 24 23:32:21 EEST 2017>"
;; in the first 15 lines of the file,
;; emacs will write time-stamp information there when saving the file.
(setq time-stamp-active         t
      ;; check first 10 buffer lines for Time-stamp: <>
      time-stamp-line-limit     15
      time-stamp-format "Последнее обновление -- %:a %:b %:d %:H:%:M:%:S %:Z %:Y")
;; update when saving
(add-hook 'before-save-hook     'time-stamp)


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
