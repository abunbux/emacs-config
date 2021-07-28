;; -*- lexical-binding: t -*-

;;; CREATED: <Tue May 14 05:54:34 EEST 2019>
;;; Time-stamp: <Последнее обновление -- Sunday July 18 13:56:33 EEST 2021>



(use-package yasnippet
  :ensure t
  :diminish yas-minor-mode
  :hook
  (after-init . yas-minor-mode)
  :bind (
         :map yas-keymap
         ("C-g" . yas-exit-all-snippets)
         )

  :init
  ;; (add-hook 'c-mode-hook                      #'yas-minor-mode)
  ;; (add-hook 'conf-unix-mode-hook              #'yas-minor-mode)
  ;; (add-hook 'emacs-lisp-mode-hook             #'yas-minor-mode)
  ;; (add-hook 'fish-mode-hook                   #'yas-minor-mode)
  ;; (add-hook 'go-mode-hook                     #'yas-minor-mode)
  ;; (add-hook 'js-mode-hook                     #'yas-minor-mode)
  ;; (add-hook 'java-mode-hook                   #'yas-minor-mode)
  ;; (add-hook 'lisp-interaction-mode-hook       #'yas-minor-mode)
  ;; (add-hook 'markdown-mode-hook               #'yas-minor-mode)
  ;; (add-hook 'nxml-mode-hook                   #'yas-minor-mode)
  ;; (add-hook 'python-mode-hook                 #'yas-minor-mode)
  ;; (add-hook 'rust-mode-hook                   #'yas-minor-mode)
  ;; (add-hook 'scala-mode-hook                  #'yas-minor-mode)
  ;; (add-hook 'web-mode-hook                    #'yas-minor-mode)

  (add-hook 'prog-mode-hook                   #'yas-minor-mode)
  (add-hook 'org-mode-hook                    #'yas-minor-mode)

  :config
  (message "Loading \"yas-minor-mode\"")
  (add-hook 'snippet-mode-hook '(lambda () (setq-local require-final-newline nil)))
  (progn
    (setq yas-wrap-around-region t
          yas-snippet-dirs
          '("~/.emacs.d/snippets"                           ; personal snippets
            ;; "~/.emacs.d/el-get/yasnippet/snippets/"      ; the yasmate collection
            )
          yas-prompt-functions '(yas-ido-prompt
                                 yas-completing-prompt))
    ;; To use YASnippet as a non-global minor mode
    (yas-reload-all))

  )



(provide 'yasnippet_init)
