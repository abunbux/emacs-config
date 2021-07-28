;; -*- lexical-binding: t -*-

;;; CREATED: <Fri May 17 17:12:07 EEST 2019>
;;; Time-stamp: <Последнее обновление -- Monday February 24 23:55:30 EET 2020>



(use-package guide-key
  :ensure t
  :diminish guide-key-mode
  :hook
  (after-init . guide-key-mode)
  :config
  (message "Loading \"guide-key\"")
  (setq guide-key/guide-key-sequence    t)
  (setq guide-key/idle-delay            1)
  (setq guide-key/text-scale-amount     0.6)
  (when (require 'guide-key nil :noerror)
    (setq guide-key/recursive-key-sequence-flag t
          guide-key/highlight-command-regexp
          '(
            ("helm"           . "gold")
            "rectangle"
            ("register"       . font-lock-type-face)
            ("bookmark"       . "hot pink")
            ("ivy"            . "brown")
            ("counsel"        . "brown")
            ("swiper"         . "brown")

            ("hlt-"           . "green")
            ("highlight-regexp"                 . "IndianRed1")
            ("highlight-phrase"                 . "IndianRed1")
            ("unhighlight-regexp"               . "IndianRed1")
            ("hi-lock-"                         . "IndianRed1")
            ("highlight-lines-matching-regexp"  . "IndianRed1")
            ("highlight-symbol-"                . "#ab82ff")

            ("loccur"  . "RosyBrown1")
            ;; ("hide-"    . "")

            ("dired-narrow"         . "goldenrod1")
            ("find-dired"           . "SeaGreen1")
            ("find-grep-dired"      . "SeaGreen1")
            ("find-name-dired"      . "SeaGreen1")
            ("dired-do-find"        . "DeepSkyBlue1")
            ))
    )


  ;; (guide-key-mode 1)
  )

(provide 'guide-key_init)
