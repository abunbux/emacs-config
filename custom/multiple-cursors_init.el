;;; multiple-cursors_init.el -*- lexical-binding: t -*-

;;; CREATED: <Tue Jun 11 20:55:05 EEST 2019>
;;; Time-stamp: <Последнее обновление -- Friday October 15 21:37:45 EEST 2021>



;;; Commentary:


;; Code:





(use-package multiple-cursors
  :ensure t
  :defer t
  :commands my/hydra-multiple-cursors/body
  :bind (
         ("M-m <SPC>"   . set-rectangular-region-anchor)
         ("M-m C-c"     . mc/edit-lines)
         ("C->"         . mc/mark-next-like-this)
         ("C-<"         . mc/mark-previous-like-this)
         ("M-m C-<"     . mc/mark-all-like-this)
         ("M-m E"       . mc/edit-ends-of-lines)
         ("M-m B"       . mc/edit-beginnings-of-lines)
         ("M-m e"       . mc/mark-more-like-this-extended)
         ("M-m P"       . mc/mark-pop)
         ("M-m W"       . mc/mark-all-dwim)
         ("M-m i n"     . mc/insert-numbers)
         ("M-m i l"     . mc/insert-letters)
         ("M-m r a"     . mc/mark-all-in-region)
         ("M-m r s"     . mc/sort-regions)
         ("M-m r r"     . mc/reverse-regions)
         ("M-m n u"     . mc/unmark-next-like-this)
         ("M-m n W"     . mc/mark-next-like-this-word)
         ("M-m n S"     . mc/mark-next-like-this-symbol)
         ("M-m n w"     . mc/mark-next-word-like-this)
         ("M-m n s"     . mc/mark-next-symbol-like-this)
         ("M-m n k"     . mc/skip-to-next-like-this)
         ("M-m p u"     . mc/unmark-previous-like-this)
         ("M-m p W"     . mc/mark-previous-like-this-word)
         ("M-m p S"     . mc/mark-previous-like-this-symbol)
         ("M-m p w"     . mc/mark-previous-word-like-this)
         ("M-m p s"     . mc/mark-previous-symbol-like-this)
         ("M-m p k"     . mc/skip-to-previous-like-this)
         )
  :preface

  ;;; https://ladicle.com/post/config/#multiple-cursor
  ;; insert specific serial number
  (defvar my/mc/insert-numbers-hist nil)
  (defvar my/mc/insert-numbers-inc 1)
  (defvar my/mc/insert-numbers-pad "%01d")

  (defun my/mc/insert-numbers (start inc pad)
    "Insert increasing numbers for each cursor specifically."
    (interactive
     (list (read-number "Start from: " 0)
           (read-number "Increment by: " 1)
           (read-string "Padding (%01d): " nil my/mc/insert-numbers-hist "%01d")))
    (setq mc--insert-numbers-number start)
    (setq my/mc/insert-numbers-inc inc)
    (setq my/mc/insert-numbers-pad pad)
    (mc/for-each-cursor-ordered
     (mc/execute-command-for-fake-cursor
      'my/mc--insert-number-and-increase
      cursor)))

  (defun my/mc--insert-number-and-increase ()
    (interactive)
    (insert (format my/mc/insert-numbers-pad mc--insert-numbers-number))
    (setq mc--insert-numbers-number (+ mc--insert-numbers-number my/mc/insert-numbers-inc)))

  :init
  (setq-default mc/list-file "~/.emacs.d/cache/mc-lists.el")
  :config
  (message "Loading \"multiple-cursors\"")
  (setq mc/list-file "~/.emacs.d/cache/mc-lists.el")

  )




(provide 'multiple-cursors_init)
;;; multiple-cursors_init.el ends here



;; ;;; Mark one more occurrence
;; * `mc/mark-next-like-this'              -    Adds a cursor and region at the next part of the buffer
;;                                              forwards that matches the current region.
;;
;; * `mc/mark-next-like-this-word'         -    Adds a cursor and region at the next part of the buffer
;;                                              forwards that matches the current region, if no region
;;                                              is selected it selects the word at the point.
;;
;; * `mc/mark-next-like-this-symbol'       -    Adds a cursor and region at the next part of the buffer
;;                                              forwards that matches the current region, if no region
;;                                              is selected it selects the symbol at the point.
;;
;; * `mc/mark-next-word-like-this'         -    Like mc/mark-next-like-this but only for whole words.
;; * `mc/mark-next-symbol-like-this'       -    Like mc/mark-next-like-this but only for whole symbols.
;; * `mc/mark-previous-like-this'          -    Adds a cursor and region at the next part of the buffer
;;                                              backwards that matches the current region.
;;
;; * `mc/mark-previous-like-this-word'     -    Adds a cursor and region at the next part of the buffer
;;                                              backwards that matches the current region, if no region
;;                                              is selected it selects the word at the point.
;;
;; * `mc/mark-previous-like-this-symbol'   -    Adds a cursor and region at the next part of the buffer
;;                                              backwards that matches the current region, if no region
;;                                              is selected it selects the symbol at the point.
;;
;; * `mc/mark-previous-word-like-this'     -    Like mc/mark-previous-like-this but only for whole words.
;; * `mc/mark-previous-symbol-like-this'   -    Like mc/mark-previous-like-this but only for whole symbols.
;; * `mc/mark-more-like-this-extended'     -    Use arrow keys to quickly mark/skip next/previous occurances.
;; * `mc/add-cursor-on-click'              -    Bind to a mouse event to add cursors by clicking. See tips-section.
;; * `mc/mark-pop'                         -    Set a cursor at the current point and move to the next (different)
;;                                              position on the mark stack. This allows for fine grained
;;                                              control over the placement of cursors.

;; ;;; Juggle around with the current cursors
;; * `mc/unmark-next-like-this'            -    Remove the cursor furthest down in the buffer.
;; * `mc/unmark-previous-like-this'        -    Remove the cursor furthest up in the buffer.
;; * `mc/skip-to-next-like-this'           -    Remove the cursor furthest down, marking the next occurance down.
;; * `mc/skip-to-previous-like-this'       -    Remove the cursor furthest up, marking the next occurance up.

;; ;;; Mark many occurrences
;; * `mc/edit-lines'                       -    Adds one cursor to each line in the current region.
;; * `mc/edit-beginnings-of-lines'         -    Adds a cursor at the start of each line in the current region.
;; * `mc/edit-ends-of-lines'               -    Adds a cursor at the end of each line in the current region.
;; * `mc/mark-all-like-this'               -    Marks all parts of the buffer that matches the current region.
;; * `mc/mark-all-words-like-this'         -    Like mc/mark-all-like-this but only for whole words.
;; * `mc/mark-all-symbols-like-this'       -    Like mc/mark-all-like-this but only for whole symbols.
;; * `mc/mark-all-in-region'               -    Prompts for a string to match in the region, adding cursors to all of them.
;; * `mc/mark-all-like-this-in-defun'      -    Marks all parts of the current defun that matches the current region.
;; * `mc/mark-all-words-like-this-in-defun'    -    Like mc/mark-all-like-this-in-defun but only for whole words.
;; * `mc/mark-all-symbols-like-this-in-defun'  -    Like mc/mark-all-like-this-in-defun but only for whole symbols.
;; * `mc/mark-all-dwim'                    -    Tries to be smart about marking everything you want. Can be pressed multiple times.

;; ;;; Special
;; * `set-rectangular-region-anchor'       -    Think of this one as set-mark except you're marking a rectangular region.
;; * `mc/mark-sgml-tag-pair'               -    Mark the current opening and closing tag.
;; * `mc/insert-numbers'                   -    Insert increasing numbers for each cursor, top to bottom.
;; * `mc/insert-letters'                   -    Insert increasing letters for each cursor, top to bottom.
;; * `mc/sort-regions'                     -    Sort the marked regions alphabetically.
;; * `mc/reverse-regions'                  -    Reverse the order of the marked regions.


;; ;;; Tips and tricks
;;  Чтобы выйти из режима нескольких курсоров, нажмите клавишу <return> или C-g. Последний сначала отключит несколько областей перед отключением нескольких курсоров. Если вы хотите вставить новую строку в режиме нескольких курсоров, используйте C-j.

;;  *   Иногда вы заканчиваете с курсорами вне вашего поля зрения.
;;  Вы можете прокручивать экран по центру каждого курсора с помощью "C-v" и "M-v" или вы можете нажать "C-'",
;;  чтобы скрыть все строки без курсора, снова нажмите "C-'", чтобы отобразить.

;;  *   Попробуйте нажать ``mc/mark-next-like-this'' без выбранного региона. Это просто добавит курсор на следующую строку.

;;  *   Попробуйте нажать `mc/mark-next-like-this-word' или `mc/mark-next-like-this-symbol' без выбранной области.
;;  Он помечает слово или символ и добавляет курсор при следующем появлении

;;  *   Попробуйте нажать `mc/mark-all-like-this-dwim' для тэга в html-режиме

;;  *   Обратите внимание, что количество активных курсоров можно увидеть на модельной линии.

;;  *   Когда вы используете `mc/edit-lines', вы можете дать ему положительный или отрицательный префикс,
;;  чтобы изменить его поведение на слишком коротких строках.
