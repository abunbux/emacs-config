;; -*- lexical-binding: t -*-

;;; CREATED: <Mon May 27 11:52:22 EEST 2019>
;;; Time-stamp: <Последнее обновление -- Saturday February 4 20:36:12 MSK 2023>



;;; dired.el
(use-package dired
  :preface
    ;;; xah-dired-sort ("s")
  (defun xah-dired-sort ()
    "Sort dired dir listing in different ways.
Prompt for a choice.
URL `http://ergoemacs.org/emacs/dired_sort.html'
Version 2015-07-30"
    (interactive)
    (let ($sort-by $arg)
      ;; У Xah Lee эта функция работала с ido ->
      ;; (setq $sort-by (ido-completing-read "Sort by:"
      ;; я от ido пока-что отказался - переделал под ivy.
      (setq $sort-by (ivy-read "Sort by:"
                               '( "access-time (atime)"
                                  "creation-time (ctime)"
                                  "date"
                                  "dir"
                                  "extension"
                                  "name"
                                  "recursive"
                                  "reverse"
                                  "size")))
      (cond
       ((equal $sort-by "name") (setq $arg "-lahLp --si --time-style long-iso --group-directories-first"))
       ((equal $sort-by "date") (setq $arg "-lahLp --si --time-style long-iso -t --group-directories-first"))
       ((equal $sort-by "size") (setq $arg "-lahLp --si --time-style long-iso -S --group-directories-first"))
       ((equal $sort-by "dir") (setq $arg "-lahLp --si --time-style long-iso --group-directories-first"))
       ((equal $sort-by "reverse") (setq $arg "-lahLpr --si --time-style long-iso --group-directories-first"))
       ((equal $sort-by "recursive") (setq $arg "-lahLpR --si --time-style long-iso --group-directories-first"))
       ((equal $sort-by "extension") (setq $arg "-lahLpX --si --time-style long-iso --group-directories-first"))
       ((equal $sort-by "creation-time (ctime)") (setq $arg "-lahLptc --si --time-style long-iso --group-directories-first"))
       ((equal $sort-by "access-time (atime)") (setq $arg "-lahLput --si --time-style long-iso --group-directories-first"))
       (t (error "logic error 09535" )))
      (dired-sort-other $arg )))


    ;;; Вот функция emacs, чтобы открыть текущий файл или отмеченные файлы во внешнем приложении,
  ;; (как если бы вы дважды щелкнули файл на рабочем столе).
  ;; Это полезно для файлов изображений, файлов PDF, видео, аудио файлов.
  ;; xah-open-in-external-app ("M-o")
  (defun xah-open-in-external-app (&optional @fname)
    "Open the current file or dired marked files in external app.
The app is chosen from your OS's preference.

When called in emacs lisp, if @fname is given, open that.

URL `http://ergoemacs.org/emacs/emacs_dired_open_file_in_ext_apps.html'
Version 2019-01-18"
    (interactive)
    (let* (
           ($file-list
            (if @fname
                (progn (list @fname))
              (if (string-equal major-mode "dired-mode")
                  (dired-get-marked-files)
                (list (buffer-file-name)))))
           ($do-it-p (if (<= (length $file-list) 5)
                         t
                       (y-or-n-p "Open more than 5 files? "))))
      (when $do-it-p
        (cond
         ((string-equal system-type "windows-nt")
          (mapc
           (lambda ($fpath)
             (w32-shell-execute "open" (replace-regexp-in-string "/" "\\" $fpath t t))) $file-list))
         ((string-equal system-type "darwin")
          (mapc
           (lambda ($fpath)
             (shell-command
              (concat "open " (shell-quote-argument $fpath))))  $file-list))
         ((string-equal system-type "gnu/linux")
          (mapc
           (lambda ($fpath) (let ((process-connection-type nil))
                              (start-process "" nil "xdg-open" $fpath))) $file-list))))))


    ;;; my/dired-go-up-dir ("^")
  (defun my/dired-go-up-dir ()
    "Navigates to the parent dir."
    (interactive)
    (find-alternate-file ".."))


    ;;; https://github.com/snosov1/dot-emacs#native-explorer
  ;; Находясь в dired нажимаем "E" - запускается dolphin с обзором этой папки
  ;; my/open-window-manager ("M-e")
  (defun my/open-window-manager ()
    "Open default system windows manager in current directory"
    (interactive)
    (save-window-excursion
      (if (equal window-system 'w32)
          (async-shell-command "explorer .")
        (if (equal window-system 'x)
            (async-shell-command "dolphin .")))))


    ;;; my/kill-all-dired-buffers ("C-d D")
  (defun my/kill-all-dired-buffers ()
    "Kill all dired buffers."
    (interactive)
    (save-excursion
      (let ((count 0))
        (dolist (buffer (buffer-list))
          (set-buffer buffer)
          (when (equal major-mode 'dired-mode)
            (setq count (1+ count))
            (kill-buffer buffer)))
        (message "Killed %i dired buffer(s)." count))))


    ;;; dired-back-to-start-of-lines ("C-a")
  (defun dired-back-to-start-of-lines ()
    (interactive)
    (backward-char (- (current-column) 2)))


    ;;; https://github.com/snosov1/dot-emacs#jumping-back-and-forth
  ;; beginning-of-buffer and end-of-buffer commands should move the point to better positions
  ;; my/dired-jump-to-bottom    ("M->") - на последнюю строку
  ;; my/dired-jump-to-top       ("M-<") - на первую строку
  (defun my/dired-jump-to-bottom ()
    "Jumps to the last file"
    (interactive)
    (goto-char (point-max))
    (dired-previous-line 1))

  (defun my/dired-jump-to-top ()
    "Jumps to the .. entry"
    (interactive)
    (goto-char (point-min))
    (dired-next-line 1)
    ;; skip another line depending on hidden/shown state of dired-details
    (with-no-warnings
      (when (or (not (boundp 'dired-details-state))
                (equal dired-details-state 'shown))
        (dired-next-line 1)))
    (if (looking-at "\\.") ;; top-level directories don't have a
        ;; .. entry
        (dired-next-line 1)))

  :bind (
         :map dired-mode-map
         ("s"       . xah-dired-sort)
         ("M-o"     . xah-open-in-external-app)
         ("M-e"     . my/open-window-manager)
         ("^"       . my/dired-go-up-dir)
         ("C-a"     . dired-back-to-start-of-lines)
         ("C-d D"   . my/kill-all-dired-buffers)
         ;; "M->"    переместиться в конец буфера
         ([remap end-of-buffer]         . my/dired-jump-to-bottom)
         ;; "M-<"    переместиться в начало буфера
         ([remap beginning-of-buffer]   . my/dired-jump-to-top)
         )

  :init
  (setq dired-dwim-target             t                 ; Move files between split panels
        dired-recursive-copies        'always
        ;; чтобы можно было непустые директории удалять...
        ;; 'top means ask for each directory at the top level
        ;; but delete subdirectories without asking.
        dired-recursive-deletes       'top
        )
  :config
  (message "Loading \"dired\"")

  (when (string-equal system-type "gnu/linux")
    (setq dired-listing-switches "-alh --time-style long-iso --group-directories-first"))
  (add-hook 'dired-mode-hook 'auto-revert-mode)

  ;; Disable annoying warining
  (put 'dired-find-alternate-file 'disabled nil)



  ;; dired-aux.el
  ;; * `dired-backup-diff'
  ;; * `dired-compare-directories'
  ;; * `dired-diff'
  ;; * `dired-do-byte-compile'
  ;; * `dired-do-chmod'
  ;; * `dired-do-chown'
  ;; * `dired-do-chgrp'
  ;; * `dired-do-compress'
  ;; * `dired-do-isearch'
  ;; * `dired-do-isearch-regexp'
  ;; * `dired-do-kill-lines'
  ;; * `dired-do-load'
  ;; * `dired-do-query-replace-regexp'
  ;; * `dired-do-print'
  ;; * `dired-do-search'
  ;; * `dired-do-touch'
  ;; * `dired-downcase'
  ;; * `dired-hide-all'
  ;; * `dired-hide-subdir'
  ;; * `dired-isearch-filenames'
  ;; * `dired-isearch-filenames-regexp'
  ;; * `dired-kill-line'
  ;; * `dired-kill-subdir'
  ;; * `dired-kill-tree'
  ;; * `dired-show-file-type'
  ;; * `dired-tree-up'
  ;; * `dired-upcase'
  (use-package dired-aux
    :defer t
    :bind (
           :map dired-mode-map
           ;; Отмечаем ненужное для работы и скрываем выделенное, чтобы не мешало.
           ("k"         . dired-do-kill-lines)
           ("K"         . dired-kill-subdir)
           ("M-k"       . dired-kill-line)
           ("C-d M-o"   . my/dired-start-process)
           )

    :config
    (message "Loading \"dired-aux\"")

    ;; Use unzip for .zip files
    (add-to-list 'dired-compress-file-suffixes '("\\.zip\\'" ".zip" "unzip"))
    ;; Use tar for .tar.xz files
    (add-to-list 'dired-compress-file-suffixes '("\.tar\.xz" ".tar" "tar xf %i"))


    ;;; https://oremacs.com/2015/01/04/dired-nohup/
    ;; Отмечаем ("m") в буфере "dired" и запускаем команду.
    ;; Переменная `dired-filelist-cmd' необходима, потому что vlc странно не создает список воспроизведения,
    ;; когда ему предоставляется список файлов.
    ;; my/dired-start-process ("C-d M-o")
    (defvar dired-filelist-cmd '(("vlc" "-L")))

    (defun my/dired-start-process (cmd &optional file-list)
      (interactive
       (let ((files (dired-get-marked-files
                     t current-prefix-arg)))
         (list
          (dired-read-shell-command "& on %s: "
                                    current-prefix-arg files)
          files)))
      (let (list-switch)
        (start-process
         cmd nil shell-file-name
         shell-command-switch
         (format
          "nohup 1>/dev/null 2>/dev/null %s \"%s\""
          (if (and (> (length file-list) 1)
                   (setq list-switch
                         (cadr (assoc cmd dired-filelist-cmd))))
              (format "%s %s" cmd list-switch)
            cmd)
          (mapconcat #'expand-file-name file-list "\" \"")))))
    )



  ;; image-dired.el
  (use-package image-dired
    :init
    (setq image-dired-dir "~/.emacs.d/cache/image-dired/")
    :config
    (message "Loading \"image-dired\"")
    )



  ;; dired-x.el
  (use-package dired-x
    :init
    (setq-default dired-omit-files-p t)
    (setq dired-omit-files    "^\\...+$")
    :config
    (message "Loading \"dired-x\"")
    ;; (add-hook 'dired-mode-hook (lambda() (dired-omit-mode 1)))
    (setq dired-guess-shell-alist-user
          '(("\\.pdf\\'" "evince" "okular")
            ("\\.\\(?:djvu\\|eps\\)\\'" "djview")
            ("\\.\\(?:jpg\\|jpeg\\|png\\|gif\\|xpm\\)\\'" "gwenview")
            ("\\.\\(?:xcf\\)\\'" "gimp")
            ("\\.csv\\'" "libreoffice")
            ("\\.\\(?:mp4\\|mkv\\|avi\\|flv\\|ogv\\)\\(?:\\.part\\)?\\'" "vlc")
            ("\\.\\(?:mp3\\|flac\\)\\'" "smplayer")
            ("\\.html?\\'" "google-chrome-stable")))
    )


  ;; find-dired.el
  (use-package find-dired
    :commands (find-dired       ; позволяет указать аргументы произвольной формы для поиска
               find-name-dired  ; найти все имена файлов, соответствующие заданному шаблону подстановки оболочки
               find-grep-dired) ; найти все файлы, содержащие совпадения
    :bind (
           ("M-s s d" . find-dired)
           ("M-s s n" . find-name-dired)
           ("M-s s g" . find-grep-dired)

           :map dired-mode-map
           ("/ d" . find-dired)
           ("/ N" . find-name-dired)
           ("/ g" . find-grep-dired)
           )
    :init
    :config
    (message "Loading \"find-dired\"")
    (setq find-ls-option '("-print0 | xargs -0 ls -alhd" . "")))
  )



;;; dired+.el
;; файл "dired+.el" находится в директории "lisp"
(use-package dired+
  :init
  (setq diredp-bind-problematic-terminal-keys nil)

  :config
  (message "Loading \"dired+\"")

  (bind-key "/ Q" 'dired-do-find-regexp-and-replace dired-mode-map)
  (bind-key "/ A" 'dired-do-find-regexp dired-mode-map)
  )


;;;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
;;;>>>>>>>>>>>>>>>>>>> DIRED-HACKS >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
;;;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

;;; dired-hacks включает в себя
;; dired-avfs.el
;; dired-collapse.el
;; dired-filter.el
;; dired-hacks-utils.el
;; dired-list.el
;; dired-narrow.el
;; dired-open.el
;; dired-rainbow.el
;; dired-ranger.el
;; dired-subtree.el


;; dired-narrow.el from dired-hacks
(use-package dired-narrow
  :ensure t
  :defer t
  :bind (
         :map dired-mode-map
         ("/ /"     . dired-narrow)
         ("/ n"     . dired-narrow-fuzzy)
         ("/ r"     . dired-narrow-regexp)
         )
  :init
  :config
  (message "Loading \"dired-narrow\" from \"dired-hacks\""))



;; dired-subtree.el from dired-hacks
;; * `dired-subtree-beginning'
;; * `dired-subtree-cycle'
;; * `dired-subtree-down'
;; * `dired-subtree-end'
;; * `dired-subtree-insert'
;; * `dired-subtree-mark-subtree'
;; * `dired-subtree-next-sibling'
;; * `dired-subtree-only-this-file'
;; * `dired-subtree-only-this-directory'
;; * `dired-subtree-previous-sibling'
;; * `dired-subtree-remove'
;; * `dired-subtree-unmark-subtree'
;; * `dired-subtree-up'
(use-package dired-subtree
  :ensure t
  :defer t
  :bind (
         :map dired-mode-map
         ("C-d <right>" . dired-subtree-toggle)
         ("<f5>"        . dired-subtree-revert)
         ;; ("-----"       . dired-subtree-narrow)
         ;; ("-----"       . dired-subtree-apply-filter)
         )
  :init
  :config
  (message "Loading \"dired-subtree\" from \"dired-hacks\""))

;;;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
;;;<<<<<<<<<<<<<<<<<<< DIRED-HACKS end <<<<<<<<<<<<<<<<<<<<<<<<<<<
;;;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<



(use-package peep-dired
  :ensure t
  :defer t
  :bind (
         :map dired-mode-map
         ("P" . peep-dired)
         )
  :init
  (setq peep-dired-cleanup-on-disable t)
  :config
  (message "Loading \"peep-dired\""))


;;; wdired.el
;; wdired allows you to edit a Dired buffer and write changes to disk
;; - Switch to Wdired by C-x C-q
;; - Edit the Dired buffer, i.e. change filenames
;; - Commit by C-c C-c, abort by C-c C-k
(use-package wdired
  :ensure t
  :defer t
  :bind (
         :map dired-mode-map
         ;; Dired uses "e", "f" or RET to open a file you can reuse one of these keys
         ;; for different purpose for example, you can bind it to "wdired-change-to-wdired-mode".
         ;; "wdired-change-to-wdired-mode" allows you to edit your Dired buffer like a normal text buffer,
         ;; such as edit file/directory names, permission bits.. and then commit the changes to disk.
         ;; "e" is short for "edit".
         ;; After finish your editing, "C-c C-c" to commit, "C-c C-k" to abort
         ("e" . wdired-change-to-wdired-mode)
         )
  :init
  (setq-default wdired-allow-to-change-permissions    nil
                wdired-use-interactive-rename         t
                wdired-confirm-overwrite              t)

  :config
  (message "Loading \"wdired\""))




(provide 'dired_init)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; "d"     Установить флаг удаления для этого файла.
;; "%d"    Помечает флагом удаления все файлы, чьи имена соответствуют заданному регулярному-выражению.
;; "u"     Убрать флаг удаления на этой строке.
;; "DEL"   Передвинуть точку на строку выше и убрать на этой строке флаг удаления.
;; "x"     Удалить файлы, помеченные флагом удаления.

;; "m"     dired-mark (пометить нужные файлы)
;; "%m"    dired-mark-files-regexp
;; "%g"    dired-mark-files-containing-regexp

;; "%R"    dired-do-rename-regexp
;; "%r"    dired-do-rename-regexp

;; замены (Regular Expression Replacements). Наиболее интересны следующие:
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

;; "y/n"    согласиться или отказаться переименовывать файл.
;; "!"      обработать остальные файлы без запросов
;; "q"      выйти

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;; KEY BINDINGS.
;; (define-key ctl-x-map "\C-j" 'dired-jump)
;; (define-key ctl-x-4-map "\C-j" 'dired-jump-other-window))
;; (define-key dired-mode-map "\C-x\M-o" 'dired-omit-mode)
;; (define-key dired-mode-map "*O" 'dired-mark-omitted)
;; (define-key dired-mode-map "\M-(" 'dired-mark-sexp)
;; (define-key dired-mode-map "*(" 'dired-mark-sexp)
;; (define-key dired-mode-map "*." 'dired-mark-extension)
;; (define-key dired-mode-map "\M-!" 'dired-smart-shell-command)
;; (define-key dired-mode-map "\M-G" 'dired-goto-subdir)
;; (define-key dired-mode-map "F" 'dired-do-find-marked-files)
;; (define-key dired-mode-map "Y"  'dired-do-relsymlink)
;; (define-key dired-mode-map "%Y" 'dired-do-relsymlink-regexp)
;; (define-key dired-mode-map "V" 'dired-do-run-mail)



;;;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
;;; Неиспользуемое
;; dired-avfs.el from dired-hacks
;; Не пользуюсь - закомментировал
;; * `dired-avfs-open'
;; (use-package dired-avfs
;;   :after (dired)
;;   :config
;;   (message "Loading \"dired-avfs\" from \"dired-hacks\""))


;; Такие сложности мне без надобности - закомментировал
;; dired-filter.el from dired-hacks
;; * `dired-filter-by-directory'
;; * `dired-filter-by-executable'
;; * `dired-filter-by-file'
;; * `dired-filter-by-garbage'
;; * `dired-filter-by-mode'
;; * `dired-filter-by-omit'
;; * `dired-filter-by-predicate'
;; * `dired-filter-by-symlink'
;; (use-package dired-filter
;;   :after (dired)
;;   :config
;;   (message "Loading \"dired-filter\" from \"dired-hacks\"")
;;   (dired-filter-mode))


;; dired-list.el from dired-hacks
;; Не разобрался как работает - закомментировал.
;; * `dired-list-find-file'
;; * `dired-list-find-name'
;; * `dired-list-hg-locate'
;; * `dired-list-locate'
;; * `dired-list-mpc'
;; * `dired-list-git-ls-files'
;; * `dired-list-grep'
;; (use-package dired-list
;;   :defer t
;;   :commands (dired-list-locate
;;              dired-list-find-file
;;   ;;; my/diff-region-now ()
;;   ;;; my/diff-region-now ()
;;   ;;; my/diff-region-now ()
;;   ;;; my/diff-region-now ()
;;   ;;; my/diff-region-now ()
;;   ;;; my/diff-region-now ()
;;   ;;; my/diff-region-now ()
;;   ;;; my/diff-region-now ()
;;   ;;; my/diff-region-now ()
;; (defun my/diff-region-now ()
;;   "Compare current region with region already selected by `diff-region`"
;;   (interactive)
;;   (when (use-region-p)
;;     (let (bufa bufb)
;;       (setq bufa (get-buffer-create "*Diff-regionA*"))
;;       (setq bufb (get-buffer-create "*Diff-regionB*"))
;;       (save-current-buffer
;;         (set-buffer bufb)
;;         (erase-buffer))
;;       (append-to-buffer bufb (region-beginning) (region-end))
;;       (ediff-buffers bufa bufb))))
;; (defun my/diff-region-now ()
;;   "Compare current region with region already selected by `diff-region`"
;;   (interactive)
;;   (when (use-region-p)
;;     (let (bufa bufb)
;;       (setq bufa (get-buffer-create "*Diff-regionA*"))
;;       (setq bufb (get-buffer-create "*Diff-regionB*"))
;;       (save-current-buffer
;;         (set-buffer bufb)
;;         (erase-buffer))
;;       (append-to-buffer bufb (region-beginning) (region-end))
;;       (ediff-buffers bufa bufb))))
;; (defun my/diff-region-now ()
;;   "Compare current region with region already selected by `diff-region`"
;;   (interactive)
;;   (when (use-region-p)
;;     (let (bufa bufb)
;;       (setq bufa (get-buffer-create "*Diff-regionA*"))
;;       (setq bufb (get-buffer-create "*Diff-regionB*"))
;;       (save-current-buffer
;;         (set-buffer bufb)
;;         (erase-buffer))
;;       (append-to-buffer bufb (region-beginning) (region-end))
;;       (ediff-buffers bufa bufb))))
;; (defun my/diff-region-now ()
;;   "Compare current region with region already selected by `diff-region`"
;;   (interactive)
;;   (when (use-region-p)
;;     (let (bufa bufb)
;;       (setq bufa (get-buffer-create "*Diff-regionA*"))
;;       (setq bufb (get-buffer-create "*Diff-regionB*"))
;;       (save-current-buffer
;;         (set-buffer bufb)
;;         (erase-buffer))
;;       (append-to-buffer bufb (region-beginning) (region-end))
;;       (ediff-buffers bufa bufb))))
;; (defun my/diff-region-now ()
;;   "Compare current region with region already selected by `diff-region`"
;;   (interactive)
;;   (when (use-region-p)
;;     (let (bufa bufb)
;;       (setq bufa (get-buffer-create "*Diff-regionA*"))
;;       (setq bufb (get-buffer-create "*Diff-regionB*"))
;;       (save-current-buffer
;;         (set-buffer bufb)
;;         (erase-buffer))
;;       (append-to-buffer bufb (region-beginning) (region-end))
;;       (ediff-buffers bufa bufb))))
;; (defun my/diff-region-now ()
;;   "Compare current region with region already selected by `diff-region`"
;;   (interactive)
;;   (when (use-region-p)
;;     (let (bufa bufb)
;;       (setq bufa (get-buffer-create "*Diff-regionA*"))
;;       (setq bufb (get-buffer-create "*Diff-regionB*"))
;;       (save-current-buffer
;;         (set-buffer bufb)
;;         (erase-buffer))
;;       (append-to-buffer bufb (region-beginning) (region-end))
;;       (ediff-buffers bufa bufb))))
;; (defun my/diff-region-now ()
;;   "Compare current region with region already selected by `diff-region`"
;;   (interactive)
;;   (when (use-region-p)
;;     (let (bufa bufb)
;;       (setq bufa (get-buffer-create "*Diff-regionA*"))
;;       (setq bufb (get-buffer-create "*Diff-regionB*"))
;;       (save-current-buffer
;;         (set-buffer bufb)
;;         (erase-buffer))
;;       (append-to-buffer bufb (region-beginning) (region-end))
;;       (ediff-buffers bufa bufb))))
;; (defun my/diff-region-now ()
;;   "Compare current region with region already selected by `diff-region`"
;;   (interactive)
;;   (when (use-region-p)
;;     (let (bufa bufb)
;;       (setq bufa (get-buffer-create "*Diff-regionA*"))
;;       (setq bufb (get-buffer-create "*Diff-regionB*"))
;;       (save-current-buffer
;;         (set-buffer bufb)
;;         (erase-buffer))
;;       (append-to-buffer bufb (region-beginning) (region-end))
;;       (ediff-buffers bufa bufb))))
;; (defun my/diff-region-now ()
;;   "Compare current region with region already selected by `diff-region`"
;;   (interactive)
;;   (when (use-region-p)
;;     (let (bufa bufb)
;;       (setq bufa (get-buffer-create "*Diff-regionA*"))
;;       (setq bufb (get-buffer-create "*Diff-regionB*"))
;;       (save-current-buffer
;;         (set-buffer bufb)
;;         (erase-buffer))
;;       (append-to-buffer bufb (region-beginning) (region-end))
;;       (ediff-buffers bufa bufb))))
;;              dired-list-find-name
;;              dired-list-grep)
;;   :bind ()
;;   :init
;;   :config
;;   (message "Loading \"dired-list\" from \"dired-hacks\""))


;; ;; dired-rainbow.el from dired-hacks
;; (use-package dired-rainbow
;;   :config
;;   (message "Loading \"dired-rainbow\" from \"dired-hacks\"")
;;   (progn
;;     (dired-rainbow-define-chmod directory "#6cb2eb" "d.*")
;;     (dired-rainbow-define html "#eb5286" ("css" "less" "sass" "scss" "htm" "html" "jhtm" "mht" "eml" "mustache" "xhtml"))
;;     (dired-rainbow-define xml "#f2d024" ("xml" "xsd" "xsl" "xslt" "wsdl" "bib" "json" "msg" "pgn" "rss" "yaml" "yml" "rdata"))
;;     (dired-rainbow-define document "#9561e2" ("docm" "doc" "docx" "odb" "odt" "pdb" "pdf" "ps" "rtf" "djvu" "epub" "odp" "ppt" "pptx"))
;;     (dired-rainbow-define markdown "#ffed4a" ("org" "etx" "info" "markdown" "md" "mkd" "nfo" "pod" "rst" "tex" "textfile" "txt"))
;;     (dired-rainbow-define database "#6574cd" ("xlsx" "xls" "csv" "accdb" "db" "mdb" "sqlite" "nc"))
;;     (dired-rainbow-define media "#de751f" ("mp3" "mp4" "MP3" "MP4" "avi" "mpeg" "mpg" "flv" "ogg" "mov" "mid" "midi" "wav" "aiff" "flac"))
;;     (dired-rainbow-define image "#f66d9b" ("tiff" "tif" "cdr" "gif" "ico" "jpeg" "jpg" "png" "psd" "eps" "svg"))
;;     (dired-rainbow-define log "#c17d11" ("log"))
;;     (dired-rainbow-define shell "#f6993f" ("awk" "bash" "bat" "sed" "sh" "zsh" "vim"))
;;     (dired-rainbow-define interpreted "#38c172" ("py" "ipynb" "rb" "pl" "t" "msql" "mysql" "pgsql" "sql" "r" "clj" "cljs" "scala" "js"))
;;     (dired-rainbow-define compiled "#4dc0b5" ("asm" "cl" "lisp" "el" "c" "h" "c++" "h++" "hpp" "hxx" "m" "cc" "cs" "cp" "cpp" "go" "f" "for" "ftn" "f90" "f95" "f03" "f08" "s" "rs" "hi" "hs" "pyc" ".java"))
;;     (dired-rainbow-define executable "#8cc4ff" ("exe" "msi"))
;;     (dired-rainbow-define compressed "#51d88a" ("7z" "zip" "bz2" "tgz" "txz" "gz" "xz" "z" "Z" "jar" "war" "ear" "rar" "sar" "xpi" "apk" "xz" "tar"))
;;     (dired-rainbow-define packaged "#faad63" ("deb" "rpm" "apk" "jad" "jar" "cab" "pak" "pk3" "vdf" "vpk" "bsp"))
;;     (dired-rainbow-define encrypted "#ffed4a" ("gpg" "pgp" "asc" "bfe" "enc" "signature" "sig" "p12" "pem"))
;;     (dired-rainbow-define fonts "#6cb2eb" ("afm" "fon" "fnt" "pfb" "pfm" "ttf" "otf"))
;;     (dired-rainbow-define partition "#e3342f" ("dmg" "iso" "bin" "nrg" "qcow" "toast" "vcd" "vmdk" "bak"))
;;     (dired-rainbow-define vc "#0074d9" ("git" "gitignore" "gitattributes" "gitmodules"))
;;     (dired-rainbow-define-chmod executable-unix "#38c172" "-.*x.*")
;;     ))
