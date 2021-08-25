;; -*- lexical-binding: t -*-

;;; CREATED: <Wed May 22 21:44:32 EEST 2019>
;;; Time-stamp: <Последнее обновление -- Saturday August 21 22:11:52 EEST 2021>




;; helm.el
(use-package helm
  :ensure t
  :diminish (helm-mode)
  :bind (("C-x C-b"     . helm-mini)
         ("C-x F"       . helm-find-files)

         ("M-h b f"     . helm-filtered-bookmarks)
         ("C-x r b"     . helm-bookmarks)
         ("M-h b r"     . helm-register)
         ("M-h b s"     . helm-surfraw)

         ("M-y"         . helm-show-kill-ring)
         ("M-h M-y"     . helm-all-mark-rings)

         ("M-h M-x"     . helm-M-x)

         ("<end>"       . helm-resume)

         ("M-s s o"     . helm-occur)
         ("M-s f l"     . helm-locate)
         ("M-s f f"     . helm-find)
         ("M-s g a"     . helm-do-grep-ag)

         ("C-h a"       . helm-apropos)

         ("<f6> h I"    . helm-info)
         ("<f6> h i"    . helm-info-at-point)
         ("<f6> h d"    . helm-documentation)

         :map helm-buffer-map
         ("M-d"         . helm-buffer-run-kill-buffers)
         ("M-SPC"       . helm-toggle-all-marks)

         :map isearch-mode-map
         ("M-s o"       . helm-occur-from-isearch)
         ("M-s O"       . helm-multi-occur-from-isearch)
         )

  :init
  (require 'helm)
  (require 'helm-config)
  (helm-mode 1)
  (require 'helm-command)
  (require 'helm-files)
  (require 'helm-bookmark)
  (require 'helm-imenu)
  (require 'helm-semantic)
  (require 'helm-elisp)
  (require 'helm-locate)
  (require 'helm-info)
  (require 'helm-grep)
  (require 'helm-ring)



  ;; helm-lib.el
  (setq helm-boring-file-regexp-list
        (append helm-boring-file-regexp-list
                '(
                  "/\\.$"
                  "/\\.\\.$"
                  "\\.undo\\.xz$"
                  "\\.elc$"
                  "\\#$"
                  "\\~$"
                  "\\.zwc\\.old$"
                  "\\.zwc$"))
        helm-scroll-amount          8
        helm-describe-variable-function 'helpful-variable
        helm-describe-function-function 'helpful-function)

  ;; helm.el
  (setq helm-candidate-number-limit nil
        helm-case-fold-search       'smart
        helm-display-header-line    nil
        helm-echo-input-in-header-line  t
        helm-exit-idle-delay        0.1
        helm-input-idle-delay       0.1
        ;; helm-follow-mode-persistent t                               ; в случае непонятных явлений - убрать
        ;; helm-move-to-line-cycle-in-source    t
        helm-reuse-last-window-split-state  t
        helm-split-window-in-side-p t
        helm-split-window-default-side 'right
        helm-split-window-preferred-function 'split-window-sensibly)  ; в случае непонятных явлений - убрать


  ;; https://github.com/emacs-helm/helm/wiki/FAQ#slow-frame-and-window-popup-in-emacs-26
  ;; This is an emacs bug which have been fixed in emacs-27 (development version),
  ;; to fix it in emacs-26, use
  (setq x-wait-for-event-timeout nil)                               ; в версии emacs-27 нужно убрать


  ;; https://github.com/emacs-helm/helm/wiki/FAQ#arrow-keys-behavior-have-changed
  ;; В новой версии helm изменились клавиш, следующие далее строки возвращают
  ;; прежнее поведение.
  (define-key helm-map (kbd "<left>") 'helm-previous-source)
  (define-key helm-map (kbd "<right>") 'helm-next-source)
  ;; for helm-find-files
  (customize-set-variable 'helm-ff-lynx-style-map t)
  ;; for helm-imenu
  (customize-set-variable 'helm-imenu-lynx-style-map t)
  ;; for semantic
  (customize-set-variable 'helm-semantic-lynx-style-map t)
  ;; for helm-occur
  (customize-set-variable 'helm-occur-use-ioccur-style-keys t)
  ;; for helm-grep
  (customize-set-variable 'helm-grep-use-ioccur-style-keys t)

  ;; helm-external.el
  ;; Files that helm should know how to open
  (setq helm-external-programs-associations
        '(("avi"  . "smplayer")
          ("part" . "smplayer")
          ("mkv"  . "smplayer")
          ("webm" . "smplayer")
          ("mp4"  . "smplayer")))

  (setq helm-ff-file-name-history-use-recentf t)    ; helm-files.el
  (setq helm-minibuffer-history 100)                ; helm-misc.el

  (setq helm-M-x-fuzzy-match        t               ; helm-command.el
        helm-apropos-fuzzy-match    t               ; helm-elisp.el
        helm-buffers-fuzzy-matching t               ; helm-buffers.el
        helm-completion-in-region-fuzzy-match   t   ; helm-mode.el
        helm-imenu-fuzzy-match      t               ; helm-imenu.el
        helm-lisp-fuzzy-completion  t
        helm-locate-fuzzy-match     nil             ; helm-locate.el
        helm-mode-fuzzy-match       t               ; helm-mode.el
        helm-recentf-fuzzy-match    t               ; helm-for-files.el
        helm-semantic-fuzzy-match   t)

  ;; helm-grep.el
  (setq helm-grep-default-command
        "grep --color=always -d skip %e -n%cH -e %p %f"
        helm-grep-default-recurse-command
        "grep --color=always -d recurse %e -n%cH -e %p %f")

  ;; helm-grep.el
  (setq helm-grep-ag-command
        "rg --color=always --colors 'match:fg:black' --colors 'match:bg:yellow' --smart-case --no-heading --line-number %s %s %s"
        helm-grep-ag-pipe-cmd-switches
        '("--colors 'match:fg:black'" "--colors 'match:bg:yellow'"))

  ;; helm-grep.el
  (setq helm-ls-git-grep-command
        "git grep -n%cH --color=always --full-name -e %p %f")


  :config
  (message "Loading \"helm\"")

  (add-to-list 'helm-sources-using-default-as-input 'helm-source-man-pages)

  ;; helm.el
  (helm-autoresize-mode t)
  (setq helm-autoresize-max-height 55
        helm-autoresize-min-height 30
        helm-display-buffer-default-height 15)

  (add-to-list 'helm-completing-read-handlers-alist ;helm-mode.el
               '(dired . nil))

  (setq helm-M-x-always-save-history    t)          ; helm-command.el

  (setq helm-man-or-woman-function      nil)        ;helm-man.el, в случае непонятных явлений - убрать

  (setq helm-window-show-buffers-function           ; helm-utils.el
        'helm-window-mosaic-fn)                     ; в случае непонятных явлений - убрать

  ;; helm-net.el
  (when (executable-find "curl")
    (setq helm-google-suggest-use-curl-p t))

  ;; helm-buffers.el
  (with-eval-after-load 'helm-buffers
    (unless helm-source-buffers-list
      (setq helm-source-buffers-list
            (helm-make-source "Buffers" 'helm-source-buffers))))

  ;; helm-buffers.el
  (setq helm-buffers-favorite-modes '(lisp-interaction-mode
                                      emacs-lisp-mode
                                      text-mode
                                      org-mode)
        helm-buffer-max-length      22
        helm-buffer-details-flag    t
        helm-buffer-skip-remote-checking nil
        helm-buffers-truncate-lines t
        helm-mini-default-sources '(helm-source-buffers-list
                                    helm-source-bookmarks
                                    helm-source-files-in-current-dir
                                    helm-source-recentf
                                    ;; helm-source-ido-virtual-buffers
                                    helm-source-buffer-not-found)
        helm-buffers-end-truncated-string "...")

  (with-eval-after-load 'helm-files
    (setq helm-ff-skip-boring-files    t
          helm-ff-file-compressed-list '("gz" "bz2" "zip" "tgz" "xz" "txz")
          helm-ff-file-name-history-use-recentf    t
          helm-ff-newfile-prompt-p                 nil
          helm-ff-search-library-in-sexp           t
          helm-ff-transformer-show-only-basename   nil))

  ;; helm-locate.el
  (with-eval-after-load 'helm-locate
    (setq helm-source-locate
          (helm-make-source "Locate" 'helm-locate-source
            :pattern-transformer 'helm-locate-pattern-transformer
            :candidate-number-limit 200)
          helm-locate-command     "locate %s --regex -i %s -e -l 200"))

  ;; helm-bookmark.el
  (use-package helm-bookmark
    :config
    (message "Loading \"helm-bookmark\""))

  ;; helm-buffers.el
  (use-package helm-buffers
    :config
    (message "Loading \"helm-buffers\""))

  ;; helm-command.el
  (use-package helm-command
    :config
    (message "Loading \"helm-command\""))

  ;; helm-files.el
  (use-package helm-files
    :config
    (message "Loading \"helm-files\""))

  ;; helm-for-files.el
  (use-package helm-for-files
    :config
    (message "Loading \"helm-for-files\""))

  ;; helm-elisp.el
  (use-package helm-elisp
    ;; :commands helm-apropos
    :config
    (message "Loading \"helm-elisp\""))

  ;; helm-imenu.el
  (use-package helm-imenu
    :commands helm-imenu
    :config
    (message "Loading \"helm-imenu\""))

  ;; helm-info.el
  (use-package helm-info
    :commands (helm-info
               helm-info-history
               helm-info-emacs
               helm-info-find
               helm-info-at-point)
    :config
    (message "Loading \"helm-info\""))


  ;; helm-grep.el
  ;; From helm-find-files (<helm-prefix> C-x C-f),
  ;; open the action menu with TAB and choose grep.
  ;; A prefix argument will launch recursive grep, or .

  ;; You can also launch grep directly with (C-u) "M-g s"
  ;; without switching to the action menu.
  (use-package helm-grep
    :config
    (message "Loading \"helm-grep\""))


  ;; helm-locate.el
  (use-package helm-locate
    :config
    (message "Loading \"helm-locate\""))

  ;; helm-man.el
  (use-package helm-man
    :defer t
    :commands helm-man-woman
    :config
    (message "Loading \"helm-man\""))

  ;; helm-misc.el
  (use-package helm-misc
    :defer t
    :commands (helm-world-time helm-minibuffer-history)
    :config
    (message "Loading \"helm-misc\""))

  ;; helm-occur.el
  (use-package helm-occur
    :defer t
    :config
    (message "Loading \"helm-occur\""))

  ;; helm-ring.el
  (use-package helm-ring
    :commands (helm-show-kill-ring)
    :config
    (message "Loading \"helm-ring\""))

  (use-package helm-semantic
    :defer t
    :config
    (message "Loading \"helm-semantic\""))

  ;; helm-utils.el
  (use-package helm-utils
    :defer t
    :config
    (message "Loading \"helm-utils\"")
    (setq helm-su-or-sudo "su")))



(use-package helm-ag
  :ensure t
  :preface
  ;; my/helm-do-ag-inverse ("M-s d i")
  (defun my/helm-do-ag-inverse ()
    (interactive)
    (let ((helm-ag-command-option "-v"))
      (call-interactively 'helm-do-ag)))

  :bind (
         ("M-s a h"  . helm-ag)
         ("M-s d a"  . helm-do-ag)
         ("M-s d b"  . helm-do-ag-buffers)
         ("M-s d f"  . helm-do-ag-this-file)
         ("M-s d i"  . my/helm-do-ag-inverse)
         )
  :config
  (message "Loading \"helm-ag\"")
  (setq helm-ag-fuzzy-match       t
        helm-ag-base-command      "ag --nocolor --nogroup --ignore-case"
        helm-ag-command-option    "--all-text"
        helm-ag-insert-at-point   'symbol
        helm-ag-use-temp-buffer   t))






;; helm-company.el
(use-package helm-company
  :ensure t
  :defer t
  :after company
  :commands (helm-company)
  :bind (
         :map company-mode-map
         ("C-:" . helm-company)

         :map company-active-map
         ("C-:" . helm-company)
         )
  :config
  (message "Loading \"helm-company\""))


;; helm-descbinds.el
(use-package helm-descbinds
  :ensure t
  :defer t
  :commands (helm-descbinds)
  :bind (("C-h b" . helm-descbinds))
  :config
  (message "Loading \"helm-descbinds\""))


;; helm-describe-modes.el
(use-package helm-describe-modes
  :ensure t
  :defer t
  :commands (helm-describe-modes)
  :bind (([remap describe-mode] . helm-describe-modes))     ; "C-h m"
  :config
  (message "Loading \"helm-describe-modes\""))


(use-package helm-helm-commands
  :ensure t
  :defer t
  :commands (helm-helm-commands)
  :bind ("<f6> h h" . helm-helm-commands)
  :config
  (message "Loading \"helm-helm-commands\""))


;; helm-ls-git.el
(use-package helm-ls-git
  :ensure t
  :defer t
  :commands (helm-ls-git-ls)
  :bind (("C-c g g" . helm-ls-git-ls))
  :init
  :config
  (message "Loading \"helm-ls-git\"")
  (require 'helm-ls-git))


(use-package swiper-helm
  :ensure t
  :defer t
  :commands (swiper-helm)
  :bind (
         ;; "C-r"
         ([remap isearch-backward] . swiper-helm)

         :map isearch-mode-map
         ("M-s M-s" . swiper-helm-from-isearch)
         )
  :init
  :config
  (message "Loading \"swiper-helm\"")
  ;; Делит окно в соответствии с общими настройками helm.
  ;; Я предпочитаю горизонтальное разделение.
  (setq swiper-helm-display-function 'helm-default-display-buffer)
  )


;; helm-swoop.el
(use-package helm-swoop
  :ensure t
  :defer t
  :bind (
         ("M-s s s" . helm-swoop)
         ("M-s s M" . helm-multi-swoop)
         ("M-s s A" . helm-multi-swoop-all)

         :map helm-swoop-map
         ("M-s A" . helm-multi-swoop-all-from-helm-swoop)
         ;; Instead of helm-multi-swoop-all, you can also use helm-multi-swoop-current-mode
         ("M-s M" . helm-multi-swoop-current-mode-from-helm-swoop)
         ("M-s b" . helm-swoop-back-to-last-point)

         :map helm-multi-swoop-map

         :map isearch-mode-map
         ;; When doing isearch, hand the word over to helm-swoop
         ("M-s s" . helm-swoop-from-isearch)
         ("M-s A" . helm-multi-swoop-all-from-isearch)
         )
  :config
  (message "Loading \"helm-swoop\"")

  ;; Save buffer when helm-multi-swoop-edit complete
  (setq helm-multi-swoop-edit-save  t)

  ;; If this value is t, split window inside the current window
  (setq helm-swoop-split-with-multiple-windows  nil)

  ;; Split direcion. 'split-window-vertically or 'split-window-horizontally
  (setq helm-swoop-split-direction 'split-window-horizontally)

  ;; If nil, you can slightly boost invoke speed in exchange for text color
  (setq helm-swoop-speed-or-color   nil)

  ;; Go to the opposite side of line from the end or beginning of line
  (setq helm-swoop-move-to-line-cycle   t)

  ;; If you prefer fuzzy matching
  (setq helm-swoop-use-fuzzy-match      t)

  ;; Optional face for line numbers
  ;; Face name is `helm-swoop-line-number-face`
  (setq helm-swoop-use-line-number-face t)
  )



;; (eval-after-load 'helm
;;   (custom-set-faces
;;    '(helm-source-header
;;      ((t (:foreground "white" :background "#511a1a" :weight bold :height 150))))
;;    '(helm-buffer-file         ((t (:foreground "White"))))
;;    '(helm-buffer-directory    ((t (:foreground "LimeGreen"))))           ;LimeGreen #32cd32
;;    '(helm-ff-denied           ((t (:foreground "red" :background nil :weight bold))))
;;    '(helm-ff-directory        ((t (:foreground "LimeGreen"))))           ;LimeGreen #32cd32
;;    '(helm-ff-dotted-directory ((t (:foreground "LimeGreen"))))
;;    '(helm-ff-dotted-symlink-directory   ((((class color) (background dark)) :foreground "#8b0000"))) ;DarkRed
;;    '(helm-ff-file             ((t (:foreground "gray75" :background nil))))
;;    '(helm-ff-invalid-symlink            ((((class color) (background dark)) :foreground "black" :background "red")))
;;    '(helm-ff-prefix           ((t (:foreground "red" :background nil :weight bold))))
;;    '(helm-ff-symlink          ((t (:foreground "blue" :background "DarkOliveGreen"))))
;;    '(helm-grep-match          ((t (:foreground "#511a1a"))))
;;    '(helm-match               ((t (:foreground "#511a1a"))))
;;    '(helm-match-item          ((t (:foreground "#511a1a" :weight bold))))
;;    '(helm-non-file-buffer     ((t (:foreground "red"))))
;;    '(helm-selection           ((t (:background "#575757" :weight bold))))   ;:foreground "DarkCyan" :background "grey34"
;;    '(helm-swoop-line-number-face ((t (:foreground "GreenYellow"))))
;;    '(helm-visible-mark        ((t (:foreground "black" :background "goldenrod"))))
;;    ))



;; ;; Отменяет многие комбинации клавиш helm.
;; ;; * `C-x c ...' -  многое мне не нужно, многое переназначил

(global-unset-key (kbd "C-x c C-c"))  ; {C-x}-helm-run-external-command
                                        ; {SPC}-helm-all-mark-rings
                                        ; {f}-helm-recentf
                                        ; {g}-helm-google-suggest

(global-unset-key (kbd "C-x c C-x"))  ; {C-b}-helm-buffers-list
                                        ; {C-f}-helm-find-files
                                        ; {r b}-helm-filtered-bookmarks
                                        ; {r i}-helm-register

(global-unset-key (kbd "C-x c a"))    ; helm-apropos
(global-unset-key (kbd "C-x c f"))    ; helm-multi-files
(global-unset-key (kbd "C-x c /"))    ; helm-find
(global-unset-key (kbd "C-x c h h"))  ; helm-documentation
(global-unset-key (kbd "C-x c b"))    ; helm-resume
(global-unset-key (kbd "C-x c I"))    ; helm-imenu-in-all-buffers
(global-unset-key (kbd "C-x c l"))    ; helm-locate

(global-unset-key (kbd "C-x c h"))      ; {g}-helm-info-gnus,
                                        ; {r}-helm-info-emacs,
                                        ; {i}-helm-info-at-point

(global-unset-key (kbd "C-x c C-,"))  ; helm-calcul-expression
(global-unset-key (kbd "C-x c p"))    ; helm-list-emacs-process
(global-unset-key (kbd "C-x c @"))    ; helm-list-elisp-packages
(global-unset-key (kbd "C-x c C-:"))  ; helm-eval-expression-with-eldoc

(global-unset-key (kbd "C-x c M-g"))  ; {a}-helm-do-grep-ag
                                        ; {i}-helm-gid

(global-unset-key (kbd "C-x c M-s"))  ; {o}-helm-occur

(global-unset-key (kbd "C-x c M-y"))  ; helm-show-kill-ring
(global-unset-key (kbd "C-x c M-x"))  ; helm-M-x

                                        ; и что-то там ещё (не могу понять что именно)

(message "Unset keys \"helm\"")


(provide 'helm_init)


;; Команды-------------------------------------------------

;; helm-recentf
;; helm-recentf
;; helm-execute-kmacro
;; helm-run-external-command
;; helm-multi-files
;; helm-for-files
;; helm-buffers-list
;; helm-world-time
;; helm-minibuffer-history
;; helm-mark-ring
;; helm-imenu-in-all-buffers

;; Keymap--------------------------------------------------

;;; helm-ag-map and helm-do-ag-map are inherited by helm-map.
;;; Key	    Action
;; C-c o    Open other window
;; C-l	    Search in parent directory
;; C-c C-e	Switch to edit mode
;; C-x C-s	Save ag results to buffer(Ask save buffer name if prefix key is specified)
;; C-c C-f	Enable helm-follow-mode
;; C-c >,   right	Move to next file
;; C-c <,   left	Move to previous file
;; C-c ?	Show help message

;;; Edit mode keymap
;;; Key	    Action
;; C-c C-c	Commit changes
;; C-c C-k	Abort
;; C-c C-d	Mark delete line
;; C-c C-u	Unmark


;; Многие команды можно начинать с "C-u"

;; C-x c M-x         helm-M-x               List commands
;;                   helm-show-kill-ring	Shows the content of the kill ring
;;                   helm-mini	            Shows open buffers, recently opened files
;; C-x c C-x C-f     helm-find-files	    The helm version of find-file
;; C-s	             helm-ff-run-grep	    Run grep from within helm-find-files (запускать в буфере helm-find-files)
;; C-x c m           helm-man-woman	        Jump to any man entry
;; C-x c /           helm-find	            Helm interface to find
;; C-x c l           helm-locate	        Helm interface to locate
;; C-x c M-s o       helm-occur	            Helm interface for occur
;; C-x c a           helm-apropos	        Describes commands, functions, variables, …
;;      	         helm-eshell-history	Interface to eshell history
;; C-x c h g	     helm-info-gnus
;; C-x c h i         helm-info-at-point
;; C-x c h r         helm-info-emacs
;; C-x c b           helm-resume	        Resumes a previous helm session
;; C-x c C-c SPC     helm-all-mark-rings	Views contents of local and global mark rings
;; C-x c r           helm-regex	            Visualizes regex matches
;; C-x c C-x r i     helm-register	        Shows content of registers
;; C-x c t           helm-top	            Helm interface to top
;; C-x c s           helm-surfraw	        Command line interface to many web search engines
;; C-x c C-c g       helm-google-suggest	Interactively enter search terms and get results from Google in helm buffer
;; C-x c c	         helm-color	            Lists all available faces

;; C-x c C-,         helm-calcul-expression	        Helm interface to calc
;;                   helm-comint-input-ring	        Interface to shell history
;; C-x c i           helm-semantic-or-imenu	        Helm interface to semantic/imenu
;;                   helm-mini-buffer-history	    Interface to mini-buffer history
;; C-x c <tab>       helm-lisp-completion-at-point	Provides a list of available functions

;; C-x c C-:	     helm-eval-expression-with-eldoc	Get instant results for Emacs lisp expressions in the helm buffer
