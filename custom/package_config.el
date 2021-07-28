;; -*- lexical-binding: t -*-

;;; CREATED: <Sun Jun 02 22:11:29 EEST 2019>
;;; Time-stamp: <Последнее обновление -- Thursday September 17 22:54:32 EEST 2020>



;;; Commentary:


;; Code:


(require 'cl)        ; Package cl is deprecated
(require 'cl-lib)




(setq my-packages
      '(
        ag
        amx
        anzu
        ;; avy                 ; очень не понравилось
        backup-each-save
        benchmark-init
        bash-completion
        company-mode
        company-shell
        ;; deadgrep         ; не понравилось
        diminish
        dired-filetype-face
        dired-hacks
        dired-rsync
        duplicate-thing
        elmacro
        emmet-mode
        flx
        flycheck
        git-modes
        ;; grep-at-point    ; чистым "grep" практически не пользуюсь
        guide-key
        helm
        helm-ag
        helm-backup
        helm-company
        helm-descbinds
        helm-describe-modes
        helm-helm-commands
        helm-ls-git
        helm-swoop
        helpful
        help+
        help-fns+
        highlight
        highlight-symbol
        hydra
        ido-completing-read-plus
        ido-vertical-mode
        iedit
        interaction-log
        ;; ivy-point-history   ; удалил за ненадобностью, никогда не пользовался
        loccur
        ;; logview          ; мне не нужно, часть функций либо не работает,
        ;;                  ; либо я не могу разобраться с ними
        magit
        markdown-mode
        move-lines
        multiple-cursors
        occur-x
        peep-dired
        phi-grep
        ;; point-history    ; удалил за ненадобностью, никогда не пользовался
        smart-mode-line
        smartparens
        swiper
        swiper-helm
        use-package
        vimish-fold
        visual-regexp-steroids
        volatile-highlights
        web-mode
        wgrep
        winnow
        yasnippet
        ))







(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(unless (require 'el-get nil t)
  (url-retrieve
   "https://github.com/dimitri/el-get/raw/master/el-get-install.el"
   (lambda (s)
     (end-of-buffer)
     (eval-print-last-sexp))))
(add-to-list 'el-get-recipe-path "~/.emacs.d/custom/recipes")
(el-get 'sync)
(el-get 'sync my-packages)



(message "Loading \"package_config.el\"")


(provide 'package_config)
;;; package_config.el ends here
