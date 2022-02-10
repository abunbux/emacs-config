;;; built-in_time-stamp_config.el -*- coding: utf-8; lexical-binding: t; -*-
;;; --- insert here summary

;;; CREATED: <Mon Aug 30 04:57:45 EEST 2021>
;;; Time-stamp: <Последнее обновление -- Monday October 4 5:36:16 EEST 2021>



;;; Commentary:

;;; Code:




;;; Code:



;;; Time-stamp
;; when there is a "Time-stamp:
;; <Последнее обновление -- Sunday September 24 23:32:21 EEST 2017>"
;; in the first 15 lines of the file,
;; emacs will write time-stamp information there when saving the file.
(use-package time-stamp
  :hook
  (before-save . time-stamp)

  :config
  (message "Loading built-in \"time-stamp\"")
  (setq time-stamp-active         t)
  ;; check first 15 buffer lines for Time-stamp: <>
  (setq time-stamp-line-limit     15)
  (setq time-stamp-format "Последнее обновление -- %:a %:b %:d %:H:%:M:%:S %:Z %:Y")
  )




(provide 'built-in_time-stamp_config)

;;; built-in_time-stamp_config.el ends here
