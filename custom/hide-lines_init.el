;; -*- lexical-binding: t -*-

;;; CREATED: <Mon Apr 01 16:43:34 EEST 2019>
;;; Time-stamp: <Последнее обновление -- Thursday July 15 0:11:13 EEST 2021>



(use-package hide-lines
  ;; В принципе, `hide-lines' ставитс как зависимость `syslog-mode',
  ;; `:ensure' можно было бы и не указывать.
  :ensure t
  :defer t
  :bind (
         ("M-h l l" . hide-lines)
         ("M-h l n" . hide-lines-not-matching)
         ("M-h l m" . hide-lines-matching)
         ("M-h l -" . hide-lines-show-all)
         ("M-h l g" . hide-blocks-not-matching)
         ("M-h l b" . hide-blocks-matching)
         ("M-h l k" . hide-lines-kill-hidden)
         )
  :init
  :config
  (message "Loading \"hide-lines\"")
  (autoload 'hide-lines "hide-lines" "Hide lines based on a regexp" t)
  (add-hook 'after-change-major-mode-hook
            (lambda ()
              (add-to-invisibility-spec 'hl)))
  )




(provide 'hide-lines_init)



;;  `hide-lines'
;;    Hide lines matching the specified regexp.
;;    Keybinding: M-x hide-lines
;;  `hide-lines-not-matching'
;;    Hide lines that don't match the specified regexp.
;;    Keybinding: M-x hide-lines-not-matching
;;  `hide-lines-matching'
;;    Hide lines matching the specified regexp.
;;    Keybinding: M-x hide-lines-matching
;;  `hide-lines-show-all'
;;    Show all areas hidden by the filter-buffer command.
;;    Keybinding: M-x hide-lines-show-all
;;  `hide-blocks-not-matching'
;;    Hide text that is not between lines matching START-TEXT and END-TEXT.
;;    Keybinding: M-x hide-blocks-not-matching
;;  `hide-blocks-matching'
;;    Hide text that is between lines matching START-TEXT and END-TEXT.
;;    Keybinding: M-x hide-blocks-matching
;;  `hide-lines-kill-hidden'
;;    Kill or delete all hidden areas.
;;    Keybinding =M-x hide-lines-kill-hidden=
