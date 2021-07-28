;; -*- lexical-binding: t -*-

;;; CREATED: <Tue Apr 02 19:32:26 EEST 2019>
;;; Time-stamp: <Последнее обновление -- Tuesday April 2 21:17:14 EEST 2019>


(define-key-after
  global-map
  [menu-bar extra-tools]
  (cons "Extra Tools"
        (easy-menu-create-menu "Extra Tools" nil))
  'tools)

(easy-menu-define my/loccur-menu nil "Menu for Loccur."
  '("Loccur" :visible (featurep 'loccur)
    ["Loccur Current Word" loccur-current :help "Call `loccur' for the current word."]
    "--"
    ["Loccur ..." loccur :help "Perform a simple grep in current buffer.\n\nThis command hides all lines from the current buffer except those\ncontaining the regular expression REGEX.  A second call of the function\nunhides lines again.\n\nWhen called interactively, either prompts the user for REGEXP or,\nwhen called with an active region, uses the content of the\nregion.\n\n(fn REGEX)"]
    ["Loccur, but Don't Highlight" loccur-no-highlight :help "Perform search like loccur, but temporary removing match highlight.\nREGEX is regexp to search\n\n(fn REGEX)"]
    "--"
    ["Loccur Previous Match" loccur-previous-match :help "Call `loccur' for the previously found word."]
    "--"
    ["Highlight Matches" loccur-toggle-highlight :style toggle :selected loccur-highlight-matching-regexp :help "Toggle the highlighting of the match."]
    ["Loccur Mode" loccur-mode :style toggle :selected loccur-mode :help "Minor mode for navigating through the file.\nHides all lines without matches like `occur' does, but without opening\na new window.\n\n(fn &optional ARG)"]
    ))

(easy-menu-define my/navigation-menu nil "navigation"
  '("navigation"
    ["Next Line" next-line]
    ["Previous Line" previous-line]
    ["Next 5 line" my/super-next-line]
    ["Previous 5 line" my/super-previous-line]
    ["Forward 5 chars" my/super-forward-char]
    ["Backward 5 chars" my/super-backward-char]
    ))

(easy-menu-add-item (current-global-map) '("menu-bar" "extra-tools") my/loccur-menu)
(easy-menu-add-item (current-global-map) '("menu-bar" "extra-tools") my/navigation-menu)

(provide 'menu_init)


;; (easy-menu-add-item nil '("Extra Tools") ["IRC" erc-select t])
;; ["--" 'ignore :visible (featurep 'bookmark+-lit)]



;; ;; Creating a new menu pane in the menu bar to the right of “Tools” menu
;; (define-key-after
;;   global-map
;;   [menu-bar mymenu]
;;   (cons "MyMenu" (make-sparse-keymap "hoot hoot"))
;;   '"Extra Tools" )

;; Creating a menu item, under the menu by the id “[menu-bar mymenu]”
(define-key
  global-map
  [menu-bar mymenu nl]
  '("Next Line" . next-line))


;; creating another menu item
(define-key
  global-map
  [menu-bar mymenu pl]
  '("Previous Line" . previous-line))
