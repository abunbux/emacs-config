;;; defun_bind.el -*- coding: utf-8; lexical-binding: t; -*-

;;; CREATED: <Sun Feb 09 16:18:21 EET 2020>
;;; Time-stamp: <Последнее обновление -- Monday August 30 17:4:9 EEST 2021>



;;; Commentary:

;;; Code:



(bind-key "M-0"     'kill-this-buffer global-map)
(bind-key "C-d - 1" 'kill-this-buffer global-map) ; в «konsole» и «yakuake» "M-0" не работает



(bind-key "<f5>"    'revert-buffer)

(bind-key "C-z W" 'superword-mode)
(bind-key "C-z w" 'subword-mode)


(bind-key "C-z t"   'toggle-truncate-lines)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;                                                             ;;;
;;;             РЕДАКТИРОВАНИЕ ТЕКСТА                              ;;;
;;;                                                            ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Удалить, линию, предложение, регион
;;          "<C-delete>" ("M-d") `kill-word'
;;          "<C-backspase>"      `backward-kill-word'
;;          "<C-S-backspace>"    `kill-whole-line'


;; "C-x h"   `mark-whole-buffer' выделить весь буфер.

;; Use word-wrapping for continuation lines
;; выравнивание текста (wrap mode)


;; Меняем местами "newline-and-indent" и "newline",
;; так-как при (electric-indent-mode -1) отступы в коде
;; нужно ставить "C-j", но "ENTER" ("RET") как-то привычнее
(bind-key "RET" 'newline-and-indent global-map)
(bind-key "C-j" 'newline global-map)



;;; indent buffer-region
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

(bind-key "C-M-\\" 'my/indent-region-or-buffer)



;;; Если есть выделение - комментирует выделение, если выделения нет - комментирует строку.
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

(bind-key "C-x /" 'my/comment-or-uncomment-this)



;;; Открыть новую линию над строкой или под строкой
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

(bind-key "C-c o"   'my/open-newline-above)
(bind-key "C-o"     'my/open-newline-below)



;;; При выделении текста удаляет его,
;; при отсутствии выделения - удаляет слово вперёд.
;; my/delete-word-forward ([C-M-backspace])
(defun my/delete-word-forward (arg)
  "Delete characters forward until encountering the end of a word.
With argument, do this that many times."
  (interactive "p")
  (if (use-region-p)
      (delete-region (region-beginning) (region-end))
    (delete-region (point) (progn (forward-word arg) (point)))))

(bind-key [C-M-backspace] 'my/delete-word-forward)



;; ;;; Удаляет всю строку целиком, независимо от положения точки, и поднимается на строку вверх.
;; ;; my/delete-line ("M-k")
;; (defun my/delete-line ()
;;   "Удаляет всю строку целиком, независимо от положения точки."
;;   (interactive)
;;   (kill-region
;;    (move-beginning-of-line 1)
;;    (save-excursion (move-end-of-line 1) (point)))
;;   (delete-char 1)
;;   (message "line deleted"))

;; (bind-key "M-k" 'my/delete-line global-map)
;; То же самое делает родное сочетание "C-S-backspase"



;;; <http://www.zafar.se/bkz/Articles/EmacsTips>
;; "M-w" если выделения нет - копирует всю строку.
;; "C-w" если выделения нет - вырезает всю строку
;; и остаётся на этой (пустой) строке.
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



;;; при выравнивании текста пробелами, клавиша <backspace> будет удалять не один пробел,
;; а сразу столько, сколько входило в один "tab".
;; https://reangdblog.blogspot.com/2015/04/emacs-backspace-like-sublime.html
;; когда backspace будет удалять пробелы "пачками":
;; --Должно быть отключено выравнивание табами "indent-tabs-mode == nil"
;; --Курсор должен быть на столбце кратном ширине таба (tab-width) от начала строки
;; --Ну и конечно перед курсором должно быть пробелов не меньше чем (tab-width)
;; my/backward-delete-tab-whitespace ("<backspace>")
(defun my/backward-delete-tab-whitespace ()
  (interactive)
  (let ((p (point)))
    (if (and (eq indent-tabs-mode nil)
             (>= p tab-width)
             (eq (% (current-column) tab-width) 0)
             (string-match "^\\s-+$" (buffer-substring-no-properties (- p tab-width) p)))
        (delete-backward-char tab-width)
      (delete-backward-char 1))))

(bind-key "<backspace>" 'my/backward-delete-tab-whitespace)



;;; "M-^" берёт текущую строку и присоединяет её к предыдущей - встроенный функционал emacs.
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

(bind-key "C-M-^" 'my/join-following-line global-map)



;;; M-u - upcase word or region
;;; M-l - lowercase word or region
;;; M-c - capitalize word or region
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



;;; auto-indent-after-yank
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



;;; fill-paragraph
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


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;                                                             ;;;
;;;             ПЕРЕМЕЩЕНИЕ ПО ТЕКСТУ                              ;;;
;;;                                                            ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; NavigatingParentheses
;; https://www.emacswiki.org/emacs/NavigatingParentheses
;;      C-M-n     `forward-list'    Move forward over a parenthetical group
;;      C-M-p     `backward-list'   Move backward over a parenthetical group
;;      C-M-f     `forward-sexp'    Move forward over a balanced expression
;;      C-M-b     `backward-sexp'   Move backward over a balanced expression
;;      C-M-k     `kill-sexp'       Kill balanced expression forward
;;      C-M-SPC   `mark-sexp'       Put the mark at the end of the sexp.


;; "C-x r SPC" ввести номер регистра - запомнит позицию,
;; "C-x r j" ввести номер регистра - переместиться в позицию.



(bind-key "\M-{" 'previous-logical-line)
(bind-key "\M-}" 'next-logical-line)


;;; C-a (home) goes to first Char in line, 2nd press beginning of line
;; my/smart-beginning-of-line ("C-a")
(defun my/smart-beginning-of-line ()
  "Move point to first non-whitespace character or beginning-of-line.
Move point to the first non-whitespace character on this line.
If point was already at that position, move point to beginning of line."
  (interactive)
  (let ((oldpos (point)))
    (back-to-indentation)
    (and (= oldpos (point))
         (beginning-of-line))))

(bind-key "C-a" 'my/smart-beginning-of-line)




;;; my/goto-line-with-feedback ("M-g M-g")
(defun my/goto-line-with-feedback ()
  "Show line numbers temporarily, while prompting for the line number input"
  (interactive)
  (unwind-protect
      (progn
        (linum-mode 1)
        (call-interactively 'goto-line))
    (linum-mode -1)))

(bind-key "M-g M-g" 'my/goto-line-with-feedback)




;;; Запомнить позицию в файле и затем переместиться туда.
;; https://www.emacswiki.org/emacs/basic-edit-toolkit.el
;; my/remember-init ("C-z r i")
;; my/remember-jump ("C-z r j")
(defun my/remember-init ()
  "Remember current position and setup."
  (interactive)
  (point-to-register 8)
  (message "Have remember one position"))

(defun my/remember-jump ()
  "Jump to latest position and setup."
  (interactive)
  (let ((tmp (point-marker)))
    (jump-to-register 8)
    (set-register 8 tmp))
  (message "Have back to remember position"))

(bind-key "C-z r i" 'my/remember-init)
(bind-key "C-z r j" 'my/remember-jump)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;                                                             ;;;
;;;                     РАБОТА С ФАЙЛАМИ                          ;;;
;;;                                                            ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;





;;; my/really-kill-emacs ()
(defun my/really-kill-emacs ()
  "Like `kill-emacs', but ignores `kill-emacs-hook'."
  (interactive)
  (let (kill-emacs-hook)
    (kill-emacs)))



;;; my/brutally-kill-emacs ()
(defun my/brutally-kill-emacs ()
  "Use `call-process' to send ourselves a KILL signal."
  (interactive)
  (call-process "kill" nil nil nil "-9" (number-to-string (emacs-pid))))



;;; Удаляет файл, связанный с текущим буфером и убивает буфер.
;; my/delete-current-buffer-file ("C-d - 0")
(defun my/delete-current-buffer-file ()
  "Removes file connected to current buffer and kills buffer."
  (interactive)
  (let ((filename (buffer-file-name))
        (buffer (current-buffer))
        (name (buffer-name)))
    (if (not (and filename (file-exists-p filename)))
        (ido-kill-buffer)
      (when (yes-or-no-p "Are you sure you want to remove this file? ")
        (delete-file filename)
        (kill-buffer buffer)
        (message "File '%s' successfully removed" filename)))))

(bind-key "C-d - 0" 'my/delete-current-buffer-file)



;;; open file fast
;; http://ergoemacs.org/emacs/emacs_hotkey_open_file_fast.html
;; xah-open-file-fast ("C-c r f")
(defun xah-open-file-fast ()
  "Prompt to open a file from bookmark `bookmark-bmenu-list'.
This command is similar to `bookmark-jump', but use `ido-mode' interface, and ignore cursor position in bookmark.

URL `http://ergoemacs.org/emacs/emacs_hotkey_open_file_fast.html'
Version 2019-02-26"
  (interactive)
  (require 'bookmark)
  (bookmark-maybe-load-default-file)
  (let (($this-bookmark
         (ido-completing-read "Open bookmark:" (mapcar (lambda ($x) (car $x)) bookmark-alist))))
    (find-file (bookmark-get-filename $this-bookmark))
    ;; (bookmark-jump $this-bookmark)
    ))

(bind-key "C-c r f" 'xah-open-file-fast)





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;                                                             ;;;
;;;                    РАБОТА С БУФЕРАМИ                          ;;;
;;;                                                            ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; Kill all other buffers
;; my/kill-other-buffers ("C-d - o")
(defun my/kill-other-buffers ()
  "Kill all other buffers."
  (interactive)
  (mapc 'kill-buffer (delq (current-buffer) (buffer-list)))
  (message "Kill all other buffers"))

(bind-key "C-d - o" 'my/kill-other-buffers)


;;; Kill all buffers, leaving *scratch* only
;; my/kill-all-buffers ("C-d - a")
(defun my/kill-all-buffers ()
  "Kill all buffers, leaving *scratch* only."
  (interactive)
  (mapc
   (lambda (buffer)
     (kill-buffer buffer)
     (message "Kill all buffers, leaving *scratch* only."))
   (buffer-list)))

(bind-key "C-d - a" 'my/kill-all-buffers)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                                           ;;
;;                          ЛОКАЛЬ, ВРЕМЯ                                      ;;
;;                                                                           ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;; insert date and time
;; my/insert-current-date-time ("C-c t d")
;; my/insert-current-time ("C-c t t")
(defvar current-date-time-format "%a %b %d %H:%M:%S %Z %Y"
  "Format of date to insert with `my/insert-current-date-time' func
See help of `format-time-string' for possible replacements")

(defvar current-time-format "%a %H:%M:%S"
  "Format of date to insert with `my/insert-current-time' func.
Note the weekly scope of the command's precision.")

(defun my/insert-current-date-time ()
  "insert the current date and time into current buffer.
Uses `current-date-time-format' for the formatting the date/time."
  (interactive)
  (insert "CREATED: <")
  (insert (format-time-string current-date-time-format (current-time)))
  (insert ">")
  ;; (comment-or-uncomment-this)
  )

(defun my/insert-current-time ()
  "insert the current time (1-week scope) into the current buffer."
  (interactive)
  (insert (format-time-string current-time-format (current-time)))
  (insert "\n"))

(bind-key "C-c t d" 'my/insert-current-date-time)
(bind-key "C-c t t" 'my/insert-current-time)


(bind-key "C-x RET R"   'recode-region)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;                                                             ;;;
;;;                    ПОИСК, ЗАМЕНА                              ;;;
;;;                                                            ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;; http://ergoemacs.org/emacs/emacs_isearch_by_arrow_keys.html
;;; set arrow keys in isearch. left/right is backward/forward, up/down is history. press Return to exit
;;; Этим пока не пользуюсь.
;; (bind-key "<up>"    'isearch-ring-retreat       isearch-mode-map)
;; (bind-key "<down>"  'isearch-ring-advance       isearch-mode-map)
;; (bind-key "<left>"  'isearch-repeat-backward    isearch-mode-map)
;; (bind-key "<right>" 'isearch-repeat-forward     isearch-mode-map)

;; (bind-key "<left>"  'isearch-reverse-exit-minibuffer minibuffer-local-isearch-map)
;; (bind-key "<right>" 'isearch-forward-exit-minibuffer minibuffer-local-isearch-map)

;;; Поиск по шаблонам регулярных выражений более актуален в качестве поиска по-умолчанию.
;;      (bind-key "C-r"     #'isearch-backward-regexp)
;;      (bind-key "C-s"     #'isearch-forward-regexp)
;;      (bind-key "C-M-s"   #'isearch-forward)
;;      (bind-key "C-M-r"   #'isearch-backward)



;; `flush-lines' alias for `delete-matching-lines'
(bind-key "M-s C-f" 'flush-lines)

;; `keep-lines' alias for `delete-non-matching-lines'
(bind-key "M-s C-k" 'keep-lines)


;; `occur' ("M-s s O")
;;      `next-error' (M-g M-n)
;;      `previous-error' (M-g M-p)
;;      `occur-mode-goto-occurrence' ("C-c C-c")
;;      `next-error-follow-minor-mode' ("C-c C-f")
(bind-key "M-s s O" 'occur)
(bind-key "e" 'occur-edit-mode occur-mode-map)



;;; https://www.reddit.com/r/emacs/comments/4rif8d/emacs_lisp_listnonmatchinglines/
;; my/invert-occur () запрашивает regexp и в соседнем буфере 'read-only'
;; отображает весь текст за исключением строк, совпавших с regexp.
;; Функция использует:
;;      invert-occur--find ()
;;      invert-occur--publish ()
;;  создаёт буфер 'invert-occur-mode', в котором в свою очередь используется
;;      invert-occur--follow ()
;; my/invert-occur ("M-s s i")
(require 'cl-lib)
(defun my/invert-occur (regexp)
  "Find all lines not matching REGEXP.
Запрашивает regexp и в соседнем буфере 'read-only'
отображает весь текст за исключением строк, совпавших с regexp.
Функция использует:
     invert-occur--find ()
     invert-occur--publish ()
 создаёт буфер 'invert-occur-mode', в котором в свою очередь используется
     invert-occur--follow ()"
  (interactive "sInverting match regexp: ")
  (invert-occur--publish (invert-occur--find regexp)))

(defun invert-occur--find (regexp)
  (save-excursion
    (setf (point) (point-min))
    (cl-loop while (< (point) (point-max))
             for line upfrom 1
             for beg = (point)
             for end = (line-end-position)
             unless (re-search-forward regexp end :noerror)
             collect (list line beg end)
             do (setf (point) (1+ end)))))

(define-derived-mode invert-occur-mode special-mode "ioccur"
  "Major more for displaying `invert-occur' results.")
(bind-key "RET"     #'invert-occur--follow invert-occur-mode-map)
(bind-key [mouse-2] #'invert-occur--follow invert-occur-mode-map)

(defun invert-occur--publish (results)
  (let ((source-buffer (current-buffer))
        (inhibit-read-only t))
    (with-current-buffer (get-buffer-create "*invert-occur*")
      (invert-occur-mode)
      (erase-buffer)
      (cl-loop for (line beg end) in results
               for marker = (set-marker (make-marker) beg source-buffer)
               for button = (propertize (format "% 3d " line)
                                        'mouse-face '(highlight)
                                        'target marker)
               do (insert button)
               do (insert-buffer-substring source-buffer beg end)
               do (insert "\n"))
      (setf (point) (point-min))
      (pop-to-buffer (current-buffer)))))

(defun invert-occur--follow ()
  (interactive)
  (let ((marker (get-text-property (point) 'target)))
    (pop-to-buffer (marker-buffer marker))
    (setf (point) (marker-position marker))))

(bind-key "M-s s i"   'my/invert-occur)


;;; xah-search-current-word ("M-s .")
;; http://ergoemacs.org/emacs/modernization_isearch.html
(defun xah-search-current-word ()
  "Call `isearch' on current word or text selection.
“word” here is A to Z, a to z, and hyphen 「-」 and underline 「_」, independent of syntax table.
URL `http://ergoemacs.org/emacs/modernization_isearch.html'
Version 2015-04-09"
  (interactive)
  (let ( $p1 $p2 )
    (if (use-region-p)
        (progn
          (setq $p1 (region-beginning))
          (setq $p2 (region-end)))
      (save-excursion
        (skip-chars-backward "-_A-Za-z0-9")
        (setq $p1 (point))
        (right-char)
        (skip-chars-forward "-_A-Za-z0-9")
        (setq $p2 (point))))
    (setq mark-active nil)
    (when (< $p1 (point))
      (goto-char $p1))
    (isearch-mode t)
    (isearch-yank-string (buffer-substring-no-properties $p1 $p2))))

;; "M-s ."
(bind-key [remap isearch-forward-symbol-at-point] 'xah-search-current-word)


;;; Показать строки в текущем буфере, соответствующие текущему слову или выделенному тексту.
;; Эта команда похожа на `list-match-lines ' (`occur').
;; Различия:
;; • Ввод этой команды - текущее слово.
;; • Если есть выделение текста, это используется в качестве ввода.
;; • Ввод простого текста, а не регулярное выражение
;; xah-list-matching-lines-no-regex ("M-s s x")
(defun xah-list-matching-lines-no-regex ()
  "Show lines in the current buffer matching current word or text selection.
This command is the similar to `list-matching-lines'.
The differences are:
• The input of this command is the current word.
• If there is a text selection, that is used as input.
• The input is plain text, not regex.

Я позволил себе вставить строчку ~(other-window 1)~, так более удобно."
  (interactive)
  (let ($p1 $p2 $searchStr )
    (if (use-region-p)
        (progn
          (setq $p1 (region-beginning) $p2 (region-end))
          (setq $searchStr (buffer-substring-no-properties $p1 $p2)))
      (progn
        (setq $searchStr (word-at-point))))
    (list-matching-lines (regexp-quote $searchStr))
    (other-window 1)))

(bind-key "M-s s x"   'xah-list-matching-lines-no-regex)



;;; Заменяет пустые повторяющиеся строки только одной пустой строкой (действует в целом буфере или в регионе)
;; xah-clean-empty-lines ("M-s C-e")
(defun xah-clean-empty-lines ()
  "Replace repeated blank lines to just 1.
Works on whole buffer or text selection, respects `narrow-to-region'.

URL `http://ergoemacs.org/emacs/elisp_compact_empty_lines.html'
Version 2017-09-22"
  (interactive)
  (let ($begin $end)
    (if (region-active-p)
        (setq $begin (region-beginning) $end (region-end))
      (setq $begin (point-min) $end (point-max)))
    (save-excursion
      (save-restriction
        (narrow-to-region $begin $end)
        (progn
          (goto-char (point-min))
          (while (re-search-forward "\n\n\n+" nil "move")
            (replace-match "\n\n")))))))

(bind-key "M-s C-e" 'xah-clean-empty-lines global-map)






(message "Loading \"defun_bind.el\"")




(provide 'defun_bind)



;;;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
;; РЕДАКТИРОВАНИЕ ТЕКСТА

;;; Вместо `my/copy-line' и `my/duplicate-line-or-region'
;;; теперь есть `duplicate-thing'
;; my/copy-line ("C-x <up>")
;; Нашёл  на https://github.com/hjking/emacs.d/blob/master/init.el defadvice,
;; которая позволяет, при отсутствии выделенния, по "C-w" и "M-w" вырезать текущую строку
;; или скопировать её, поэтому "my/copy-line" закомментировал,
;; "my/delete-line" оставил - так как она полностью удаляет строку и перемещает следующую
;; за удаляемой вверх, найденная же этого не делает.
;; (defun my/copy-line (arg)
;;   "Copy lines (as many as prefix argument) in the kill ring"
;;   (interactive "p")
;;   (kill-ring-save (line-beginning-position)
;;                   (line-beginning-position (+ 1 arg)))
;;   (message "%d line%s copied" arg (if (= 1 arg) "" "s")))
;; (bind-key "C-x <up>" 'my/copy-line global-map)

;; Эта версия функции не касается kill ring,, и курсор оказывается на новой строке, где он был на оригинале.
;; Будет дублироваться регион, если он активен (transient mark mode)
;; или дублируется строка (по-умолчанию).
;; Также будет сделано несколько копий, если присвоить префиксный аргумент ("C-u"),
;; и закомментирует исходную строку, если ему присваивается отрицательный префиксный аргумент
;; (это полезно для проверки другой версии команды / оператора при сохранении старой).
;; my/duplicate-line-or-region ("C-x <down>")
;; (defun my/duplicate-line-or-region (&optional n)
;;   "Duplicate current line, or region if active.
;; With argument N, make N copies.
;; With negative N, comment out original line and use the absolute value."
;;   (interactive "*p")
;;   (let ((use-region (use-region-p)))
;;     (save-excursion
;;       (let ((text (if use-region        ;Get region if active, otherwise line
;;                       (buffer-substring (region-beginning) (region-end))
;;                     (prog1 (thing-at-point 'line)
;;                       (end-of-line)
;;                       (if (< 0 (forward-line 1)) ;Go to beginning of next line, or make a new one
;;                           (newline))))))
;;         (dotimes (i (abs (or n 1)))     ;Insert N times, or once if not specified
;;           (insert text))))
;;     (if use-region nil                  ;Only if we're working with a line (not a region)
;;       (let ((pos (- (point) (line-beginning-position)))) ;Save column
;;         (if (> 0 n)                             ;Comment out original with negative arg
;;             (comment-region (line-beginning-position) (line-end-position)))
;;         (forward-line 1)
;;         (forward-char pos)))))
;; (bind-key "C-x <down>" 'my/duplicate-line-or-region global-map)
;;;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<


;; ;;; Функция очищает kill-ring
;; ;;; Ни разу не понадобилось
;; ;; my/clear-kill-ring ()
;; (defun my/clear-kill-ring ()
;;   "Clear the kill ring variable"
;;   (interactive)
;;   (setq kill-ring nil
;;         kill-ring-yank-pointer nil))



;;;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
;; ПЕРЕМЕЩЕНИЕ ПО ТЕКСТУ



;; ;;; Перемещение к самой длинной строке
;; ;;; Никогда не пользовался.
;; ;; https://www.emacswiki.org/emacs/basic-edit-toolkit.el
;; ;; my/goto-longest-line ()
;; (defun region-or-buffer-limits ()
;;   "Return the start and end of the region as a list, smallest first.
;; If the region is not active or empty, then bob and eob are used."
;;   (if (or (not mark-active) (null (mark)) (= (point) (mark)))
;;       (list (point-min) (point-max))
;;     (if (< (point) (mark)) (list (point) (mark)) (list (mark) (point)))))
;;
;; (defun my/goto-longest-line (beg end)
;;   "Goto the longest line of current buffer."
;;   (interactive `,(region-or-buffer-limits))
;;   (when (= beg end) (error "The buffer is empty"))
;;   (when (eq this-command last-command) (forward-line 1) (setq beg (point)))
;;   (goto-char beg)
;;   (let* ((start-line (line-number-at-pos))
;;          (max-width 0)
;;          (line start-line)
;;          long-lines col)
;;     (when (eobp) (error "End of buffer"))
;;     (while (and (not (eobp)) (or (not mark-active) (< (point) end)))
;;       (end-of-line)
;;       (setq col (current-column))
;;       (when (>= col max-width)
;;         (if (= col max-width)
;;             (setq long-lines (cons line long-lines))
;;           (setq long-lines (list line)))
;;         (setq max-width col))
;;       (forward-line 1)
;;       (setq line (1+ line)))
;;     (setq long-lines (nreverse long-lines))
;;     (let ((lines long-lines))
;;       (while (and lines (> start-line (car lines))) (pop lines))
;;       (goto-line (or (car lines) start-line)))
;;     (when (interactive-p)
;;       (let ((others (cdr long-lines)))
;;         (message
;;          "Line %d: %d chars%s (%d lines measured)"
;;          (car long-lines) max-width
;;          (concat (and others (format ", Others: {%s}"
;;                                      (mapconcat (lambda (line) (format "%d" line))
;;                                                 (cdr long-lines) ", "))))
;;          (- line start-line))))
;;     (list (car long-lines) max-width (cdr long-lines) (- line start-line))))



;;;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
;; РАБОТА С ФАЙЛАМИ

;; ;;; Не пользуюсь - закомментировал.
;; ;; https://github.com/magnars/.emacs.d/blob/master/defuns/file-defuns.el
;; ;; Следующие три функции взаимосвязаны -
;; ;; my/find-or-create-file-at-point () и my/find-or-create-file-at-point-other-window ()
;; ;; используют file-name-at-point ()
;; ;; file-name-at-point ()
;; (defun file-name-at-point ()
;;   (save-excursion
;;     (let* ((file-name-regexp "[./a-zA-Z0-9\-_~]")
;;            (start (progn
;;                     (while (looking-back file-name-regexp)
;;                       (forward-char -1))
;;                     (point)))
;;            (end (progn
;;                   (while (looking-at file-name-regexp)
;;                     (forward-char 1))
;;                   (point))))
;;       (buffer-substring start end))))
;;
;;
;; ;; Если в точке находится кокое-либо слово, будет создан буфер с этим именем
;; ;; и в этой же директории, если в точке находится имя уже существующего в этой
;; ;; директории буфера - он будет открыт в новом окне.
;; ;; my/find-or-create-file-at-point ("C-x M-1")
;; (defun my/find-or-create-file-at-point ()
;;   "Guesses what parts of the buffer under point is a file name and opens it."
;;   (interactive)
;;   (find-file (file-name-at-point)))
;;
;;
;; ;;; my/find-or-create-file-at-point-other-window ("C-x M-3")
;; (defun my/find-or-create-file-at-point-other-window ()
;;   "Guesses what parts of the buffer under point is a file name and opens it."
;;   (interactive)
;;   (find-file-other-window (file-name-at-point)))
;;
;; (bind-key "-------" 'my/find-or-create-file-at-point)
;; (bind-key "-------" 'my/find-or-create-file-at-point-other-window)



;;;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
;; РАБОТА С БУФЕРАМИ

;; ;;; Эмакс всегда открывает *scratch*-буфер после запуска. От него невозможно избавиться,
;; ;; но можно сделать более полезным, если добавить в него несколько ссылок на домашнюю директорию,
;; ;; файл с личными паролями зашифрованный эмаксом с помощью GNU Privacy Guard
;; ;; (https://ru.wikipedia.org/wiki/GnuPG), активные проекты, сайты и прочее.
;; ;; https://github.com/zahardzhan/well-tuned-emacs
;; ;; well-tuned-emacs-scratch-buffer-message ()
;; (add-hook 'emacs-startup-hook
;;           (defun well-tuned-emacs-scratch-buffer-message ()
;;             (with-current-buffer "*scratch*"
;;               (let ((scratch-buf-last-char (point-max)))
;;                 (goto-char scratch-buf-last-char)
;;                 (fancy-splash-insert
;;                  :link (list "File" (lambda (_button) (call-interactively #'find-file))
;;                              "Specify a new file's name, to edit the file")
;;                  " "
;;                  :link (list "Home" (lambda (_button) (dired "~"))
;;                              "Open home directory, to operate on its files")
;;                  " "
;;                  :link (list "Passwords" (lambda (_button)
;;                                            (let ((passwords "~/Dropbox/Passwords.org.gpg"))
;;                                              (when (file-exists-p passwords)
;;                                                (find-file passwords))))
;;                              "Open encrypted password vault"))
;;                 (comment-region scratch-buf-last-char (point))
;;                 (newline)
;;                 (goto-char (point-max))
;;                 (set-buffer-modified-p nil)))))



;;;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
;; РАБОТА С ОКНАМИ

;; ;;; Убивает соседнее окно при поделенном на несколько окон фрейме.
;; ;; Закомментировал ввиду ненадобности
;; ;; Сам писал, горжусь :)
;; ;; my/delete-other-window ("")
;; (defun my/delete-other-window()
;;   "Слишком долго каждый раз набирать 'C-x o ; M-x kill-this-buffer RET C-x 1'
;; То есть - открываешь окно справки или ещё чего-нибудь, когда окно разделено надвое,
;; а затем, чтобы не оставлять целую кучу буферов, лучше его прибить.
;; Также, в случае наличия только одного окна, убивает данный буфер"
;;   (interactive)
;;   (other-window 1)
;;   (kill-this-buffer)
;;   (delete-other-windows))

;; (bind-key "-----" 'my/delete-other-window)



;; (defun my/save-macro (name)
;;   "save a macro. Take a name as argument
;;      and save the last defined macro under
;;      this name at the end of your .emacs"
;;   (interactive "SName of the macro: ")  ; ask for the name of the macro
;;   (kmacro-name-last-macro name)         ; use this name for the macro
;;   (find-file "~/.emacs.d/custom/macros_config.el") ; open ~/.emacs.d/custom/macros_init.el
;;   (goto-char (point-max))               ; go to the end of the file
;;   (newline)                             ; insert a newline
;;   (insert-kbd-macro name)               ; copy the macro
;;   (newline)                             ; insert a newline
;;   (switch-to-buffer nil))               ; return to the initial buffer
