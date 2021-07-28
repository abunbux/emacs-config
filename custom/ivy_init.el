;;; ivy_init.el -*- coding: utf-8; lexical-binding: t -*-

;;; CREATED: <Fri May 17 14:23:40 EEST 2019>
;;; Time-stamp: <Последнее обновление -- Tuesday February 25 17:47:47 EET 2020>



;;; Commentary:

;; `swiper' - поиск символа или слова в точке:
;;          `M-n' - `ivy-next-history-element' - получить символ в точке.
;;          `M-j' - `ivy-yank-word' - расширить ввод минибуфера следующим словом
;;                                      (аналогично `C-s' `C-w' в `isearch').
;; `swiper' - скопировать линию и вернуться в исходную точку:
;;          `M-o' `w'




;;; Code:




(use-package ivy
  :ensure t
  :diminish ivy-mode
  :hook
  (after-init . ivy-mode)
  :bind (
         ("C-x b"  . ivy-switch-buffer)
         ("C-x B"  . ivy-switch-buffer-other-window)

         ("<home>" . ivy-resume)

         :map ivy-occur-mode-map
         ;; "C-q" по-умолчанию
         ("e"   . ivy-wgrep-change-to-wgrep-mode)
         )

  :init
  (setq ivy-display-style               nil)
  (setq ivy-display-functions-alist
        '((counsel-M-x . ivy-display-function-lv)
          (ivy-completion-in-region . ivy-display-function-overlay)))
  (setq ivy-format-function             'ivy-format-function-line)
  (setq ivy-initial-inputs-alist        nil)
  (setq ivy-minibuffer-faces            nil)
  (setq ivy-on-del-error-function       nil)
  (setq ivy-count-format                "(ivy %d/%d) ")

  (setq ivy-re-builders-alist
        '(
          (ivy-switch-buffer        . ivy--regex-plus)
          (counsel-ack              . ivy--regex-plus)
          (counsel-ag               . ivy--regex-plus)
          (counsel-grep             . ivy--regex-plus)
          (counsel-find-file        . ivy--regex-plus)
          (counsel-M-x              . ivy--regex-fuzzy)
          (counsel-pt               . ivy--regex-plus)
          (counsel-rg               . ivy--regex-plus)
          (swiper                   . ivy--regex-plus)
          (swiper-all               . ivy--regex-plus)
          (swiper-isearch           . ivy--regex-plus)
          (read-file-name-internal  . ivy--regex-fuzzy)
          (t                        . ivy--regex-ignore-order)
          ;; (t                     . ivy--regex-fuzzy)
          ))

  (setq ivy-use-selectable-prompt       t)
  (setq ivy-use-virtual-buffers         t)
  (setq ivy-virtual-abbreviate          'full)


  (setq ivy-height                      15)
  (setq ivy-height-alist                nil)

  ;; Do not show "./" and "../" in the `counsel-find-file' completion list
  ;; (setq ivy-extra-directories nil)    ;Default value: ("../" "./")

  ;; (ivy-mode 1)

  :config
  (message "Loading \"ivy\"")

  (add-to-list 'ivy-completing-read-handlers-alist
               '(ido-find-file . nil))

  (ivy-set-occur 'swiper 'swiper-occur)
  (ivy-set-occur 'ivy-switch-buffer 'ivy-switch-buffer-occur)

  (use-package flx
    :ensure t
    :defer
    :config
    (message "Loading \"flx\""))

  (custom-set-faces
   `(ivy-modified-buffer ((t (:inherit default :weight bold :foreground "#FD971F"))))
   '(ivy-modified-outside-buffer ((t (:foreground "red" :weight bold))))
   `(ivy-virtual ((t (:inherit default :foreground "green"))))
   ))





(use-package counsel
  :ensure t
  :bind (
         ("C-h f"     . counsel-describe-function)
         ("C-h v"     . counsel-describe-variable)
         ("C-h l"     . counsel-find-library)
         ("C-h i"     . counsel-info-lookup-symbol)
         ("C-h C-b"   . counsel-descbinds)
         ("<f6> c f"  . counsel-describe-face)
         ("<f6> c e"  . counsel-colors-emacs)
         ("<f6> c w"  . counsel-colors-web)

         ;; ("------"     . counsel-ibuffer)

         ("C-c u"       . counsel-unicode-char)

         ("C-c a"       . counsel-linux-app)
         ("C-c b"       . counsel-ibuffer)
         ("C-x C-f"     . counsel-find-file)
         ("C-x d"       . counsel-dired)

         ("<kp-divide>" . counsel-recentf)
         ("C-c r c"     . counsel-recentf)

         ("C-c M-x"     . counsel-M-x)
         ("C-c C-r"     . counsel-command-history)

         ("M-s a c"     . counsel-ag)
         ("M-s g c"     . counsel-grep)
         ("M-s f c"       . counsel-locate)
         ("M-s s r"     . counsel-rg)

         ;;; Этими командами не пользуюсь (или почти не пользуюсь)
         ;; switch major-mode.
         ;; ("-------"   . counsel-major )
         ;; list buffers visiting files (highlighted) then the recentf file list.
         ;; ("-------"   . counsel-buffer-or-recentf)
         ;; ("-------"   . counsel-yank-pop)
         ;; ("-------"   . counsel-package)
         ;; ("-------"   . counsel-load-library)
         ;; ("-------"   . counsel-bookmark)
         ;; ("-------"   . counsel-dired)
         ;; ("-------"   . counsel-mark-ring)
         ;; ("-------"   . counsel-apropos)
         ;; ("-------"   . counsel-recentf)
         ;; ("-------"   . counsel-find-file)
         ;; ("-------"   . counsel-git)
         ;; ("-------"   . counsel-git-grep)
         ;; ("-------"   . counsel-load-theme)
         ;; Required program "pt" not found in your path
         ;; ("-------"   . counsel-pt)

         :map minibuffer-local-map
         ("C-r" . counsel-minibuffer-history)

         :map read-expression-map
         ("C-r" . counsel-expression-history)

         :map counsel-find-file-map
         ("C-u" . counsel-up-directory)
         ("C-d" . counsel-down-directory)
         )

  :config
  (message "Loading \"counsel\"")

  (setq counsel-root-command "su")

  (setq counsel-find-file-at-point      t)
  (setq counsel-mode-override-describe-bindings t
        counsel-describe-function-function 'helpful-function
        counsel-describe-variable-function 'helpful-variable)
  (setq counsel-yank-pop-separator      "\n----------------------\n")
  ;; Use faster search tools: ripgrep or the silver search
  (let ((cmd (cond ((executable-find "rg")
                    "rg -S -M 120 --no-heading --line-number --color never %s %s")
                   ((executable-find "ag")
                    "ag -S --noheading --nocolor --nofilename --numbers '%s' %s")
                   (t counsel-grep-base-command))))
    (setq counsel-grep-base-command cmd))
  (setq counsel-grep-post-action-hook '(recenter))
  )




(use-package swiper
  :ensure t
  :bind (
         ;; swiper-isearch

         ;; "C-s"
         ;; ([remap isearch-forward] . counsel-grep-or-swiper)

         ("M-s s c" . swiper-all)

         :map global-map
         ("C-s" . counsel-grep-or-swiper)

         :map swiper-map
         ("M-s C-s" . swiper-isearch-toggle)
         ("M-%"     . swiper-query-replace)
         ("C-l"     . swiper-recenter-top-bottom)

         :map isearch-mode-map
         ("M-s C-s" . swiper-isearch-toggle)
         )
  :config
  (message "Loading \"swiper\"")
  (setq swiper-include-line-number-in-search t)
  (setq swiper-action-recenter      t)
  ;; (setq swiper-completion-method 'ivy)              ; ?
  (setq swiper-goto-start-of-match  t))


(provide 'ivy_init)
