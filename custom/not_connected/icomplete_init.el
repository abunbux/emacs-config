;; -*- lexical-binding: t -*-

;;; CREATED: <Fri Feb 01 16:50:27 EET 2019>
;;; Time-stamp: <Последнее обновление -- Tuesday April 16 22:35:21 EEST 2019>



;; show choices vertically
;; (setq icomplete-separator "\n")
(setq icomplete-hide-common-prefix  nil
      icomplete-in-buffer           t
      icomplete-prospects-height    4)

;; (require 'icomplete)
(icomplete-mode 1)

(with-eval-after-load 'icomplete
  ;; (define-key icomplete-minibuffer-map (kbd "<right>") 'icomplete-forward-completions)
  (bind-key "<right>" 'icomplete-forward-completions icomplete-minibuffer-map)
  ;; (define-key icomplete-minibuffer-map (kbd "<left>") 'icomplete-backward-completions)
  (bind-key "<left>" 'icomplete-backward-completions icomplete-minibuffer-map))


(provide 'icomplete_init)
