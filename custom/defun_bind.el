;;; defun_bind.el -*- coding: utf-8; lexical-binding: t; -*-

;;; CREATED: <Sun Feb 09 16:18:21 EET 2020>
;;; Time-stamp: <Последнее обновление -- Tuesday July 5 18:33:21 EEST 2022>



;;; Commentary:

;;; Code:



(bind-key "M-0"     'kill-this-buffer global-map)
(bind-key "C-d - 1" 'kill-this-buffer global-map) ; в «konsole» и «yakuake» "M-0" не работает



(bind-key "<f5>"    'revert-buffer)

(bind-key "C-z W" 'superword-mode)
(bind-key "C-z w" 'subword-mode)


(bind-key "C-z t"   'toggle-truncate-lines)



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
;; http://xahlee.info/emacs/emacs/modernization_isearch.html
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
