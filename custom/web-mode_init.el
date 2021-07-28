;; -*- lexical-binding: t -*-

;;; CREATED: <Fri Mar 15 18:56:59 EET 2019>
;;; Time-stamp: <Последнее обновление -- Monday October 19 5:38:55 EEST 2020>



(use-package web-mode
  :ensure t
  :defer t
  :mode (
         ("\\.[agj]sp\\'"   . web-mode)
         ("\\.as[cp]x\\'"   . web-mode)
         ("\\.css\\'"       . web-mode)
         ("\\.djhtml\\'"    . web-mode)
         ("\\.erb\\'"       . web-mode)
         ("\\.fb2\\'"       . web-mode)
         ("\\.handlebars\\'" . web-mode)
         ("\\.hbs?\\'"      . web-mode)
         ("\\.html?\\'"     . web-mode)
         ("\\.[gj]sp\\'"    . web-mode)
         ("\\.gotmpl\\'"    . web-mode)
         ("\\.gtpl\\'"      . web-mode)
         ("\\.mustache\\'"  . web-mode)
         ("\\.phtml?\\'"    . web-mode)
         ("\\.tpl\\.php\\'" . web-mode)
         ("\\.jst\\'"       . web-mode)
         ("\\.vue\\'"       . web-mode)
         )

  :init
  (setq web-mode-engines-alist '(("django" . "\\.html\\'")
                                 ("razor" . "\\.scala.html\\'")
                                 ("go" . "\\.gotmpl\\'")
                                 ("jsx" . "\\.js\\'")))
  :config
  (message "Loading \"web-mode\"")
  (progn
    (message "web-mode loaded")
    (setq   web-mode-auto-close-style                   2         ; в случае непонятных явлений - убрать
            web-mode-code-indent-offset                 2         ; JavaScript
            web-mode-css-indent-offset                  2         ; CSS
            web-mode-enable-auto-pairing                t
            web-mode-enable-comment-keywords            t
            web-mode-enable-css-colorization            t
            web-mode-enable-current-element-highlight   t
            web-mode-enable-current-column-highlight    nil
            web-mode-enable-heredoc-fontification       t
            web-mode-enable-html-entities-fontification t         ; в случае непонятных явлений - убрать
            web-mode-enable-part-face                   t
            web-mode-extra-auto-pairs   '(("erb" . (("open" "close"))))
            web-mode-extra-snippets     '(("erb" . (("name" . ("beg" . "end")))))
            web-mode-markup-indent-offset               2         ; HTML
            )

    ;; Web-mode hook
    (add-hook 'web-mode-hook
              '(lambda()
                 (company-mode)
                 (progn
                   (bind-key "RET"   'newline-and-indent web-mode-map)
                   (bind-key "M-RET" 'newline web-mode-map)
                   (eval-after-load "company"
                     '(progn
                        (unless (member 'company-css (car company-backends))
                          (setq comp-back (car company-backends))
                          (push 'company-css comp-back)
                          (push 'company-nxml comp-back)
                          (setq company-backends (list comp-back)))
                        )))))
    ))


(provide 'web-mode_init)




;; (define-key web-mode-map (kbd "C-,")    'sgml-tag)
;; (define-key web-mode-map (kbd "C-o")    'open-file-in-browser)
;; (define-key web-mode-map (kbd "C-j")    'newline-and-indent)
;; (define-key web-mode-map (kbd "C-;")    'emmet-expand-line)
;; (define-key web-mode-map (kbd "M-n")    'sp-html-next-tag)
;; (define-key web-mode-map (kbd "M-p")    'sp-html-previous-tag)
;; (define-key web-mode-map (kbd "C-M-n")  'web-mode-element-next)
;; (define-key web-mode-map (kbd "C-M-p")  'web-mode-element-previous)
;; (define-key web-mode-map (kbd "C-M-d")  'web-mode-element-child)
;; (define-key web-mode-map (kbd "C-M-u")  'web-mode-element-parent)
;; (define-key web-mode-map (kbd "C-M-a")  'web-mode-element-beginning)
;; (define-key web-mode-map (kbd "C-M-e")  'web-mode-element-end)
;; (define-key web-mode-map (kbd "C-M-f")  'web-mode-attribute-next)
;; (define-key web-mode-map (kbd "C-M-b")  'web-mode-attribute-previous)
;; (define-key web-mode-map (kbd "C-M-k")  'web-mode-element-kill)
;; (define-key web-mode-map (kbd "C-S-i")  'web-mode-element-content-select)
;; (define-key web-mode-map (kbd "C-S-c")  'web-mode-element-clone)
;; (define-key web-mode-map (kbd "<C-M-backspace>") 'backward-kill-element)
;;;********************************************************************
