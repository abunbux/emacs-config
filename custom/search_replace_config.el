;;; search_replace_config.el -*- coding: utf-8; lexical-binding: t; -*-

;;; CREATED: <Fri May 24 19:11:57 EEST 2019>
;;; Time-stamp: <Последнее обновление -- Wednesday August 25 19:2:38 EEST 2021>



;;; Commentary:



;;; Code:



;;; occur-x.el
;; occur-x - действует в буфере occur
;;      "k" keep    `occur-x-filter'
;;      "f" flush   `occur-x-filter-out'
;;      "u" to undo `occur-x-undo-filter'
(use-package occur-x
  :ensure t
  :defer t
  :init
  (add-hook 'occur-mode-hook 'turn-on-occur-x-mode)
  :config
  (message "Loading \"occur-x\""))



;;; winnow.el
;; winnow - действует в буфере ag/grep
;;      "x"	    `winnow-exclude-lines'
;;      "m"	    `winnow-match-lines'
;;      "g"     `recompile' (revert)
(use-package winnow
  :ensure t
  :defer t
  :bind
  :config
  (message "Loading \"winnow\"")
  (add-hook 'ag-mode-hook 'winnow-mode)
  (add-hook 'grep-mode-hook 'winnow-mode))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                  ;;
;;                            WGREP                 ;;
;;                                                  ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; wgrep.el
;; wgrep - позволяет редактировать буфер grep и применять эти изменения к буферу файлов
;; (а также работает в буфере ag и helm-{ag, grep}).
;;
;;      "e" - начать редактировать ~(setq wgrep-enable-key "e")~
;;      "C-c C-e"  Apply the changes to file buffers.
;;      "C-c C-u"  All changes are unmarked and ignored.
;;      "C-c C-d"  Mark as delete to current line (including newline).
;;      "C-c C-r"  Remove the changes in the region
;;                  (these changes are not applied to the files.
;;                  Of course, the remaining changes can still be applied to the files.)
;;      "C-c C-p"  Toggle read-only area.
;;      "C-c C-k"  Discard all changes and exit.
;;      "C-x C-q"  Exit wgrep mode.
;;      ~M-x wgrep-save-all-buffers~  To save all buffers that wgrep has changed
(use-package wgrep
  :ensure t
  :defer t
  :init
  (add-hook 'ag-mode-hook 'wgrep-ag-setup)
  :config
  (message "Loading \"wgrep\"")
  ;; (require 'wgrep)
  (setq wgrep-enable-key "e")
  (setq wgrep-change-readonly-file t)
  ;; (setq wgrep-auto-save-buffer t)
  (eval-after-load 'grep
    '(bind-key (kbd "e") 'wgrep-change-to-wgrep-mode grep-mode-map)))


;;; wgrep-helm.el
;; Дополнение к "wgrep.el" для работы с "helm".
(use-package wgrep-helm
  :ensure t
  :defer t
  :config
  (message "Loading \"wgrep-helm\"")
  (require 'wgrep-helm))


;;; wgrep-ag.el
;; Дополнение к "wgrep.el" для работы с "ag".
(use-package wgrep-ag
  :ensure t
  :defer t
  :hook
  (ag-mode-hook . wgrep-ag-setup)
  :init
  (autoload 'wgrep-ag-setup "wgrep-ag")
  (add-hook 'ag-mode-hook 'wgrep-ag-setup)
  :config
  (message "Loading \"wgrep-ag\""))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;; visual-regexp.el
(use-package visual-regexp
  :ensure t
  :defer t
  :preface
  (defun my/vr/query-replace-from-beginning ()
    (interactive)
    (save-excursion
      (goto-char (point-min))
      (call-interactively 'vr/query-replace)))

  :commands (vr/isearch-backward
             vr/isearch-forward
             vr/query-replace-from-beginning
             vr/replace
             vr/query-replace)
  :bind (
         ;; "C-M-r"
         ;; ([remap isearch-backward-regexp]   . vr/isearch-backward)
         ("M-s C-r"     . vr/isearch-backward)
         ;; "C-M-s"
         ;; ([remap isearch-forward-regexp]    . vr/isearch-forward)
         ("M-s C-s"     . vr/isearch-forward)

         :map global-map
         ;; C-M-%
         ([remap query-replace-regexp]  . vr/replace)
         ;; "M-%"
         ([remap query-replace]         . vr/query-replace)
         ("M-s M-%"     . my/vr/query-replace-from-beginning)
         )

  :init
  :config
  (message "Loading \"visual-regexp\"")

  ;; visual-regexp-steroids.el
  (use-package visual-regexp-steroids
    :ensure t
    :config
    (message "Loading \"visual-regexp-steroids\"")))



;;; ag.el
(use-package ag
  :ensure t
  :defer t
  :bind (
         ("M-s a a" . ag)
         ("M-s a f" . ag-files)
         ("M-s a d" . ag-dired)
         ("M-s a D" . ag-dired-regexp)
         ("M-s a r" . ag-regexp)
         ("C-d - A" . ag-kill-buffers)
         )
  :init
  (setq ag-highlight-search   t)
  (setq ag-reuse-buffers      't)
  (setq ag-reuse-window       't)
  (setq ag-arguments  (list "--smart-case" "--stats"))

  :config
  (message "Loading \"ag\"")
  (add-hook 'ag-mode-hook   (lambda () (switch-to-buffer-other-window "*ag search*"))))



;;; phi-grep.el
(use-package phi-grep
  :ensure t
  :defer t
  :bind (
         ("M-s g f" . phi-grep-in-file)      ; grep in a single file
         ("M-s g r" . phi-grep-in-directory) ; recursive grep in a directory tree

         :map dired-mode-map
         ;; In dired-mode buffers, following commands are available in addition.
         ("/ D"     . phi-grep-dired-in-dir-at-point)   ; grep in a directory at point
         ("/ ."     . phi-grep-dired-in-file-at-point)  ; grep in a file at point
         ("/ m"     . phi-grep-dired-in-marked-files)   ; grep in all marked files
         ("/ a"     . phi-grep-dired-in-all-files)      ; grep in all listed files
         ("/ w"     . phi-grep-dired-dwim)              ; automatically choose one of above

         :map  phi-grep-mode-map
         ;; In the phi-grep result buffer, you can also perform a recursive grep.
         ;; grep within the files in the current result
         ("r" . phi-grep-recursive)
         )
  :config
  (message "Loading \"phi-grep\"")
  (require 'phi-grep))



;;; anzu.el
;;     `anzu-isearch-query-replace'
;;     `anzu-isearch-query-replace-regexp'
;;     `anzu-query-replace'
;;     `anzu-query-replace-at-cursor'
;;     `anzu-query-replace-at-cursor-thing'
;;     `anzu-query-replace-regexp'
;;     `anzu-replace-at-cursor-thing'
(use-package anzu
  :ensure t
  :diminish

  ;; :hook
  ;; (after-init . global-anzu-mode)

  :config
  (message "Loading \"anzu\"")
  (global-anzu-mode 1)
  (defun my/anzu-update-func (here total)
    (when anzu--state
      (let ((status (cl-case anzu--state
                      (search (format "<%d/%d>" here total))
                      (replace-query (format "(%d Replaces)" total))
                      (replace (format "<%d/%d>" here total)))))
        (propertize status 'face 'anzu-mode-line))))

  (custom-set-variables
   '(anzu-mode-line-update-function #'my/anzu-update-func))

  (custom-set-variables
   '(anzu-mode-lighter " Az ")
   '(anzu-deactivate-region t)
   '(anzu-search-threshold 1000)
   '(anzu-replace-threshold 50)
   '(anzu-replace-to-string-separator " => "))

  (set-face-attribute 'anzu-mode-line nil
                      :foreground "red" :weight 'bold))





(provide 'search_replace_config)




;;; Слишком много функций поиска, хочу сделать интерактивное меню с выбором.
;;; Но пока руки не дошли
;; (defun my/choose-search ()
;;   (interactive)
;;   (ivy-read "Choose command: " '(("rg"          . rg)
;;                                  ("helm-rg"     . helm-rg)
;;                                  ("helm-do-ag"  . helm-do-ag))
;;             :action (lambda (func)
;;                       (call-interactively (cdr func)))))



;; (use-package grep-at-point
;;   :config
;;   (message "Loading \"grep-at-point\""))



;;; deadgrep.el
;; Не понравилось, для моих целей хватит инструментов попроще
;; (use-package deadgrep
;;   :defer t
;;   :commands (deadgrep)
;;   :bind (
;;          ("M-s g d" . deadgrep)
;;
;;          :map deadgrep-mode-map
;;          ("s"   . my/deadgrep-change-search-term)
;;          ("ts"  . my/deadgrep-change-search-type-to-string)
;;          ("tw"  . my/deadgrep-change-search-type-to-words)
;;          ("tr"  . my/deadgrep-change-search-type-to-regexp)
;;          ("cs"  . my/deadgrep-change-case-to-smart)
;;          ("cc"  . my/deadgrep-change-case-to-sensitive)
;;          ("ci"  . my/deadgrep-change-case-to-ignore)
;;          ("xn"  . my/deadgrep-change-context-to-none)
;;          ("xb"  . my/deadgrep-change-context-to-before)
;;          ("xa"  . my/deadgrep-change-context-to-after)
;;          ("d"   . my/deadgrep-change-directory)
;;          ("fa"  . my/deadgrep-search-all-files)
;;          ("ft"  . my/deadgrep-search-files-by-type)
;;          ("fg"  . my/deadgrep-search-files-by-glob)
;;          )
;;   :config
;;   (message "Loading \"deadgrep\"")
;;   (setq-default deadgrep--search-type 'regexp) ;Default is 'string
;;
;;   ;; https://github.com/kaushalmy/.emacs.d/blob/a03fadccb8a19a037045a1b2964235185e5dd085/setup-files/setup-rg.el
;;   (defun my/deadgrep--jump-to-and-execute (re)
;;     "Execute the button that matches RE and push it."
;;     (goto-char (point-min))
;;     (re-search-forward re)
;;     (backward-char 3)
;;     (push-button))
;;
;;   (defun my/deadgrep-change-search-term ()
;;     "Change the search term."
;;     (interactive)
;;     (my/deadgrep--jump-to-and-execute "^Search term: .*change$"))
;;
;;   (defun my/deadgrep-change-search-type-to-string ()
;;     "Change the search type to 'string'."
;;     (interactive)
;;     (my/deadgrep--jump-to-and-execute "^Search type: .*string"))
;;
;;   (defun my/deadgrep-change-search-type-to-words ()
;;     "Change the search type to 'words'."
;;     (interactive)
;;     (my/deadgrep--jump-to-and-execute "^Search type: .*words"))
;;
;;   (defun my/deadgrep-change-search-type-to-regexp ()
;;     "Change the search type to 'regexp'."
;;     (interactive)
;;     (my/deadgrep--jump-to-and-execute "^Search type: .*regexp"))
;;
;;   (defun my/deadgrep-change-case-to-smart ()
;;     "Change the case sensitivity to 'smart'."
;;     (interactive)
;;     (my/deadgrep--jump-to-and-execute "^Case: .*smart"))
;;
;;   (defun my/deadgrep-change-case-to-sensitive ()
;;     "Change the case sensitivity to 'sensitive'."
;;     (interactive)
;;     (my/deadgrep--jump-to-and-execute "^Case: .*sensitive"))
;;
;;   (defun my/deadgrep-change-case-to-ignore ()
;;     "Change the case sensitivity to 'ignore'."
;;     (interactive)
;;     (my/deadgrep--jump-to-and-execute "^Case: .*ignore"))
;;
;;   (defun my/deadgrep-change-context-to-none ()
;;     "Don't show ny context around the search results."
;;     (interactive)
;;     (my/deadgrep--jump-to-and-execute "^Context: .*none"))
;;
;;   (defun my/deadgrep-change-context-to-before ()
;;     "Set 'before' context for the search results."
;;     (interactive)
;;     (my/deadgrep--jump-to-and-execute "^Context: .*before"))
;;
;;   (defun my/deadgrep-change-context-to-after ()
;;     "Set 'after' context for the search results."
;;     (interactive)
;;     (my/deadgrep--jump-to-and-execute "^Context: .*after"))
;;
;;   (defun my/deadgrep-change-directory ()
;;     "Change the root directory for searches."
;;     (interactive)
;;     (my/deadgrep--jump-to-and-execute "^Directory: .*$")
;;     (forward-char 2))
;;
;;   (defun my/deadgrep-search-all-files ()
;;     "Change file search scope to 'all'."
;;     (interactive)
;;     (my/deadgrep--jump-to-and-execute "^Files: .*all"))
;;
;;   (defun my/deadgrep-search-files-by-type ()
;;     "Search only in the specified file types."
;;     (interactive)
;;     (my/deadgrep--jump-to-and-execute "^Files: .*type"))
;;
;;   (defun my/deadgrep-search-files-by-glob ()
;;     "Search in files names that match the specified glob."
;;     (interactive)
;;     (my/deadgrep--jump-to-and-execute "^Files: .*glob"))
;;   )
