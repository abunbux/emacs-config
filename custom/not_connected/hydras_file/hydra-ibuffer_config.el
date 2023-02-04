;;; hydra-ibuffer_config.el -*- coding: utf-8; lexical-binding: t; -*-

;;; CREATED: <Thu Feb 20 16:14:12 EET 2020>
;;; Time-stamp: <Последнее обновление -- Saturday February 22 19:53:57 EET 2020>



;;; Commentary:

;;; Code:



;; переделать под себя - убрать лишнее, добавить свои привычные функции.


;;; *** ibuffer hydra
;; from https://github.com/abo-abo/hydra/wiki/Ibuffer
(with-eval-after-load 'ibuffer
  (defhydra my/hydra-ibuffer-main (:color pink :hint nil)
    ("k" ibuffer-backward-line  "ʌ"     :column "navigation")
    ("RET" ibuffer-visit-buffer "visit" :column "navigation" :color blue)
    ("j" ibuffer-forward-line   "v"     :column "navigation")

    ("m" ibuffer-mark-forward       "mark"      :column "mark")
    ("u" ibuffer-unmark-forward     "unmark"    :column "mark")
    ("*" hydra-ibuffer-mark/body    "specific"  :column "mark" :color blue)

    ("D" ibuffer-do-delete          "Delete"        :column "actions")
    ("S" ibuffer-do-save            "save"          :column "actions")
    ("a" hydra-ibuffer-action/body  "all actions"   :column "actions" :color blue)

    ("g" ibuffer-update             "refresh"   :column "view")
    ("s" hydra-ibuffer-sort/body    "sort"      :column "view" :color blue)
    ("/" hydra-ibuffer-filter/body  "filter"    :column "view" :color blue)

    ("o" ibuffer-visit-buffer-other-window  "other window" :column "other" :color blue)
    ("q" ibuffer-quit                       "quit ibuffer" :column "other" :color blue)
    ("." nil                                "toggle hydra" :column "other" :color blue))

  (defhydra hydra-ibuffer-mark (:color teal :columns 5
                                       :after-exit (my/hydra-ibuffer-main/body))
    "Mark"
    ("*" ibuffer-unmark-all "unmark all")
    ("M" ibuffer-mark-by-mode "mode")
    ("m" ibuffer-mark-modified-buffers "modified")
    ("u" ibuffer-mark-unsaved-buffers "unsaved")
    ("s" ibuffer-mark-special-buffers "special")
    ("r" ibuffer-mark-read-only-buffers "read-only")
    ("/" ibuffer-mark-dired-buffers "dired")
    ("e" ibuffer-mark-dissociated-buffers "dissociated")
    ("h" ibuffer-mark-help-buffers "help")
    ("z" ibuffer-mark-compressed-file-buffers "compressed")
    ("b" my/hydra-ibuffer-main/body "back" :color blue))

  (defhydra hydra-ibuffer-action (:color teal :columns 4
                                         :after-exit
                                         (if (eq major-mode 'ibuffer-mode)
                                             (my/hydra-ibuffer-main/body)))
    "Action"
    ("A" ibuffer-do-view "view")
    ("E" ibuffer-do-eval "eval")
    ("F" ibuffer-do-shell-command-file "shell-command-file")
    ("I" ibuffer-do-query-replace-regexp "query-replace-regexp")
    ("H" ibuffer-do-view-other-frame "view-other-frame")
    ("N" ibuffer-do-shell-command-pipe-replace "shell-cmd-pipe-replace")
    ("M" ibuffer-do-toggle-modified "toggle-modified")
    ("O" ibuffer-do-occur "occur")
    ("P" ibuffer-do-print "print")
    ("Q" ibuffer-do-query-replace "query-replace")
    ("R" ibuffer-do-rename-uniquely "rename-uniquely")
    ("T" ibuffer-do-toggle-read-only "toggle-read-only")
    ("U" ibuffer-do-replace-regexp "replace-regexp")
    ("V" ibuffer-do-revert "revert")
    ("W" ibuffer-do-view-and-eval "view-and-eval")
    ("X" ibuffer-do-shell-command-pipe "shell-command-pipe")
    ("b" nil "back"))

  (defhydra hydra-ibuffer-sort (:color amaranth :columns 3)
    "Sort"
    ("i" ibuffer-invert-sorting "invert")
    ("a" ibuffer-do-sort-by-alphabetic "alphabetic")
    ("v" ibuffer-do-sort-by-recency "recently used")
    ("s" ibuffer-do-sort-by-size "size")
    ("f" ibuffer-do-sort-by-filename/process "filename")
    ("m" ibuffer-do-sort-by-major-mode "mode")
    ("b" my/hydra-ibuffer-main/body "back" :color blue))

  (defhydra hydra-ibuffer-filter (:color amaranth :columns 4)
    "Filter"
    ("m" ibuffer-filter-by-used-mode "mode")
    ("M" ibuffer-filter-by-derived-mode "derived mode")
    ("n" ibuffer-filter-by-name "name")
    ("c" ibuffer-filter-by-content "content")
    ("e" ibuffer-filter-by-predicate "predicate")
    ("f" ibuffer-filter-by-filename "filename")
    (">" ibuffer-filter-by-size-gt "size")
    ("<" ibuffer-filter-by-size-lt "size")
    ("/" ibuffer-filter-disable "disable")
    ("b" my/hydra-ibuffer-main/body "back" :color blue))

  ;; (define-key ibuffer-mode-map "." 'my/hydra-ibuffer-main/body)
  (bind-key "." 'my/hydra-ibuffer-main/body ibuffer-mode-map)
  )




(provide 'hydra-ibuffer_config)
