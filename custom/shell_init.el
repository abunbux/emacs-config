;;; shell_init.el -*- coding: utf-8; lexical-binding: t; -*-

;;; CREATED: <Thu Dec 03 09:21:26 EET 2020>
;;; Time-stamp: <Последнее обновление -- Thursday December 3 16:43:43 EET 2020>



;;; Commentary:

;;; Code:




;; Use Emacs terminfo, not system terminfo
(setq system-uses-terminfo          nil)


(use-package bash-completion
  :ensure t
  :defer t
  :init
  (autoload 'bash-completion-dynamic-complete
    "bash-completion"
    "BASH completion hook")
  (add-hook 'shell-dynamic-complete-functions
            'bash-completion-dynamic-complete)

  ;; используем bash-completion в eshell
  (defun bash-completion-from-eshell ()
    (interactive)
    (let ((completion-at-point-functions
           '(bash-completion-eshell-capf)))
      (completion-at-point)))

  (defun bash-completion-eshell-capf ()
    (bash-completion-dynamic-complete-nocomint
     (save-excursion (eshell-bol) (point))
     (point) t))


  :config
  (message "Loading \"bash-completion\"")
  (setq bash-completion-process-timeout 0.5)
  )



(use-package shell
  :defer t
  :preface
  ;;; opening shells
  ;; my/shell-here ("C-z s")
  (defun my/shell-here ()
    "Open shell buffer in this window."
    (interactive)
    (let ((dir (or dired-directory default-directory)))
      (shell (switch-to-buffer
              (generate-new-buffer dir)))))

  (defun my-shell-other ()
    "Open shell buffer in the other window."
    (interactive)
    (progn
      (other-window 1)
      (my/shell-here)))

  (defun my-shell-split-up ()
    "Split other window up and open shell buffer."
    (interactive)
    (progn
      (other-window 1)
      (split-window-below)
      (my/shell-here)))

  (defun my-shell-split-below ()
    "Split other window down and open shell buffer."
    (interactive)
    (progn
      (other-window 1)
      (split-window-below)
      (other-window 1))
    (my/shell-here))

  (defun my/shell_mode_init ()
    (message "shell-mode loaded")
    (linum-mode -1)
    (smartparens-mode -1)
    (volatile-highlights-mode -1)
    (visual-line-mode -1))

  :mode
  ("\\.inputrc\\'" .  sh-mode)
  ("\\.bashrc\\'"  .  sh-mode)
  ("\\.bash$\\'"   .  sh-mode)
  ("\\.sh$\\'"     .  sh-mode)
  ("\\.csh$\\'"    .  sh-mode)
  ("\\.tcsh$\\'"   .  sh-mode)
  ("\\.zshrc\\'"   .  sh-mode)
  ("\\.zsh$\\'"    .  sh-mode)

  :hook (
         (shell-mode        . ansi-color-for-comint-mode-on)
         (shell-mode        . my/shell_mode_init)
         (shell-mode-hook   . compilation-shell-minor-mode)
         )

  :commands comint-send-string comint-simple-send comint-strip-ctrl-m
  :bind (
         ("C-z s" . my/shell-here)

         :map shell-mode-map
         ("C-SPC" . company-manual-begin)
         )
  ;; comint-previous-input
  ;; comint-next-input
  ;; comint-next-matching-input-from-input

  :init
  (setq comint-completion-addsuffix         t
        comint-completion-autolist          t
        comint-completion-recexact          t
        comint-input-ignoredups             t
        comint-process-echoes               t
        comint-prompt-read-only             nil
        comint-scroll-show-maximum-output   t
        comint-scroll-to-bottom-on-output   nil
        comint-scroll-to-bottom-on-input    t)

  :config
  (message "Loading \"shell\"")
  (add-hook 'comint-output-filter-functions #'comint-strip-ctrl-m)
  (setq explicit-bash-args
        '("-c" "export EMACS=; stty echo; bash"))
  (setq explicit-shell-file-name "bash")

  ;;; Поиск в истории по "M-r"
  ;; my/shell-mode-hook (M-r)
  (defun my/shell-mode-hook ()
    (setq comint-input-ring-file-name "~/.bash_history")
    (comint-read-input-ring t))
  (add-hook 'shell-mode-hook 'my/shell-mode-hook)

  (custom-set-faces
   '(comint-highlight-input ((t (:foreground "#2aa198"))))
   '(comint-highlight-prompt ((((min-colors 88) (background dark)) (:foreground "#268bd2"))))))




(use-package eshell
  :defer t
  :bind (("C-z e" . eshell))
  :init
  (setq-default eshell-directory-name "~/.emacs.d/cache/eshell/")
  :config
  (message "Loading \"eshell\"")


  (add-hook 'eshell-mode-hook
            (lambda ()
              (eshell-cmpl-initialize)
              ;; (bind-key [remap eshell-pcomplete] 'helm-esh-pcomplete eshell-mode-map)
              (bind-key "C-c C-SPC" 'helm-esh-pcomplete         eshell-mode-map)
              (bind-key "M-p"       'helm-eshell-history        eshell-mode-map)
              (bind-key "M-p"       'helm-eshell-history        eshell-mode-map)
              (bind-key "C-SPC"     'company-manual-begin       eshell-mode-map)
              (bind-key "C-<tab>"   'bash-completion-from-eshell eshell-mode-map)
              ))

  (defun my/helm/eshell-set-keys ()
    ;; (bind-key [remap eshell-pcomplete] 'helm-esh-pcomplete eshell-mode-map)
    (bind-key "C-c C-SPC"   'helm-esh-pcomplete         eshell-mode-map)
    (bind-key "M-p"         'helm-eshell-history        eshell-mode-map)
    ;; Useless when we have 'helm-eshell-history
    (bind-key "M-s"         nil                         eshell-mode-map)
    (bind-key "M-s f"       'helm-eshell-prompts-all    eshell-mode-map)
    (bind-key "C-<tab>"     'bash-completion-from-eshell eshell-mode-map))
  (add-hook 'eshell-mode-hook 'my/helm/eshell-set-keys))





(use-package term
  :defer t
  :commands (term)
  :init
  (setq term-buffer-maximum-size 10000)
  :config
  (message "Loading \"term\"")
  (eval-after-load 'term
    '(progn
       (defun my/term-send-delete-word-forward () (interactive) (term-send-raw-string "\ed"))
       (defun my/term-send-delete-word-backward () (interactive) (term-send-raw-string "\e\C-h"))
       (bind-key [C-delete] 'my/term-send-delete-word-forward term-raw-map)
       (bind-key [C-backspace] 'my/term-send-delete-word-backward term-raw-map)
       (defun my/term-send-forward-word () (interactive) (term-send-raw-string "\ef"))
       (defun my/term-send-backward-word () (interactive) (term-send-raw-string "\eb"))
       (bind-key [C-right] 'my/term-send-forward-word term-raw-map)
       (bind-key [C-left] 'my/term-send-backward-word term-raw-map)
       (defun my/term-send-m-right () (interactive) (term-send-raw-string "\e[1;3C"))
       (defun my/term-send-m-left () (interactive) (term-send-raw-string "\e[1;3D"))
       (bind-key [M-right] 'my/term-send-m-right term-raw-map)
       (bind-key [M-left] 'my/term-send-m-left term-raw-map)
       ))
  (defun my/term-mode-hook ()
    (goto-address-mode 1))
  (add-hook 'term-mode-hook #'my/term-mode-hook))





(provide 'shell_init)




;; M-x ping
;; M-x traceroute
;; M-x telnet
;; M-x dig
;; M-x ifconfig
;; M-x whois
;; M-x finger
;; M-x netstat
;; M-x nsloowkup
;; M-x arp
;; M-x route
