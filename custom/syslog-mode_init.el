;;; syslog-mode_init.el -*- lexical-binding: t -*-

;;; CREATED: <Thu Jun 27 23:49:24 EEST 2019>
;;; Time-stamp: <Последнее обновление -- Saturday February 1 11:45:56 EET 2020>



;;; Commentary:


;; Code:


(use-package syslog-mode
  :ensure t
  :defer t
  :mode (
         ("/var/log.*\\'"   . syslog-mode)
         ("\\.log\\'"       . syslog-mode)
         ("messages"        . syslog-mode)
         )

  :commands (syslog-mode)

  ;; Below are complete command list:

  ;; * `syslog-shell-command’   : Execute a shell COMMAND synchronously, with prefix arg (SUDOP) run under sudo. (Keybinding: !)
  ;; * `syslog-append-files’    : Append FILES into buffer BUF. (Keybinding: a)
  ;; * `syslog-prepend-files’   : Prepend FILES into buffer BUF. (Keybinding: M-x syslog-prepend-files)
  ;; * `syslog-open-files’      : Insert log FILES into new buffer. (Keybinding: o)
  ;; * `syslog-view’            : Open a view of syslog files with optional filters and highlights applied. (Keybinding: v)
  ;; * `syslog-previous-file’   : Open the previous logfile backup, or the next one if a prefix arg is used. (Keybinding: <)
  ;; * `syslog-next-file’       : Open the next logfile. (Keybinding: >)
  ;; * `syslog-move-next-file’  : Move to the next file in the current `syslog-mode’ buffer. (Keybinding: <M-down>)
  ;; * `syslog-move-previous-file’  : Move to the next file in the current `syslog-mode’ buffer. (Keybinding: <M-up>)
  ;; * `syslog-toggle-filenames’    : Toggle the display of filenames before each line. (Keybinding: t)
  ;; * `syslog-filter-lines’    : Restrict buffer to blocks of text between matching regexps. (Keybinding: /)
  ;; * `syslog-filter-dates’    : Restrict buffer to lines between times START and END (Emacs time lists). (Keybinding: C-/)
  ;; * `syslog-mode’            : Major mode for working with system logs. (Keybinding: M-x syslog-mode)
  ;; * `syslog-count-matches’   : Count strings which match the given pattern. (Keybinding: c)
  ;; * `syslog-boot-start’      : Jump forward in the log to when the system booted. (Keybinding: <C-down>)
  ;; * `syslog-whois-reverse-lookup’ : This is a wrapper around the `whois’ command using symbol at point as default search string. (Keybinding: W)

  :bind

  ;; Keybindings
  ;;    "C-down" : syslog-boot-start
  ;;    "R" : revert-buffer
  ;;    "/" : syslog-filter-lines
  ;;    "g" : show-all-invisible
  ;;    "h r" : highlight-regexp
  ;;    "h p" : highlight-phrase
  ;;    "h l" : highlight-lines-matching-regexp
  ;;    "h u" : unhighlight-regexp
  ;;    "C-/" : syslog-filter-dates
  ;;    "D" : open dired buffer in log directory (`syslog-log-file-directory’)
  ;;    "j" : ffap
  ;;    "<" : syslog-previous-file
  ;;    ">" : syslog-next-file
  ;;    "o" : syslog-open-files
  ;;    "q" : quit-window

  :init
  :config
  (message "Loading \"syslog-mode\"")
  ;; (require 'syslog-mode)
  )


(provide 'syslog-mode_init)
;;; syslog-mode_init.el ends here
