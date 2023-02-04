;;; init.el -*- coding: utf-8; lexical-binding: t; -*-

;;; CREATED: <Wed Jan 29 22:25:03 EET 2020>
;;; Time-stamp: <Последнее обновление -- Friday February 28 22:12:22 EET 2020>



;;; Commentary:

;;; Code:




(unless (lookup-key global-map [menu-bar extra-tools])
  (define-key-after global-map
    [menu-bar extra-tools]
    (cons "Extra Tools"
          (easy-menu-create-menu "Extra Tools" nil))
    'tools))


(with-eval-after-load 'elmacro
  (easy-menu-define my/elmacro-menu nil
    "Menu for Elmacro."
    '("Elmacro"
      ["Elmacro Mode" (customize-save-variable 'elmacro-mode (not elmacro-mode)) :style toggle :selected elmacro-mode :help "(elmacro-mode &optional ARG)\n\nToggle emacs activity recording (elmacro mode).\nWith a prefix argument ARG, enable elmacro mode if ARG is\npositive, and disable it otherwise. If called from Lisp, enable\nthe mode if ARG is omitted or nil."]
      "--"
      ["Show Last Commands" elmacro-show-last-commands :active elmacro-mode :help "(elmacro-show-last-commands &optional COUNT)\n\nTake the latest COUNT commands and show them as emacs lisp.\n\nThis is basically a better version of `kmacro-edit-lossage'.\n\nThe default number of commands shown is modifiable in variable\n`elmacro-show-last-commands-default'.\n\nYou can also modify this number by using a numeric prefix argument or\nby using the universal argument, in which case it'll ask for how many\nin the minibuffer."]
      ["Show Last Macro" elmacro-show-last-macro :active elmacro-mode :help "(elmacro-show-last-macro NAME)\n\nShow the last macro as emacs lisp with NAME."]
      "--"
      ["Clear Command History" elmacro-clear-command-history :active elmacro-mode :help "(elmacro-clear-command-history)\n\nClear the list of recorded commands."]))

  (easy-menu-add-item nil
                      '("Extra Tools")
                      my/elmacro-menu))



(easy-menu-define my/search-in-one-file-menu nil
  "Меню поиска в одном файле"
  '("search in one file"
    ["occur..."         occur]
    ["helm-occur"       helm-occur :visible (featurep 'helm-mode)]
    ["Flush Matching Lines..."  flush-lines]
    ["Keep Matching Lines..."   keep-lines]
    ["vr/isearch-backward" vr/isearch-backward]
    ["vr/isearch-forward" vr/isearch-forward]
    ["my/vr/query-replace-from-beginning" my/vr/query-replace-from-beginning]
    ["vr/replace" vr/replace]
    ["vr/query-replace" vr/query-replace]
    ))
(easy-menu-add-item nil
                    '("Extra Tools")
                    my/search-in-one-file-menu )

;; ["--" 'ignore :visible (featurep 'web-mode)]




(easy-menu-define my/search-in-many-files-menu nil
  "Меню поиска по многим файлам"
  '("search in files"
    ["helm-do-ag"   helm-do-ag :visible (featurep 'helm-mode)]
    ["ag"           ag]
    ["ag-regexp"    ag-regexp]
    ["ag-files"     ag-files]
    ))
(easy-menu-add-item nil
                    '("Extra Tools")
                    my/search-in-many-files-menu )


(easy-menu-define my/search-files-menu nil
  "Меню поиска файлов"
  '("file search"
    ["ag-dired"         ag-dired]
    ["ag-dired-regexp"  ag-dired-regexp]
    ["helm-find"        helm-find]
    ["helm-locate"      helm-locate]
    ["counsel-locate"   counsel-locate]
    ))
(easy-menu-add-item nil
                    '("Extra Tools")
                    my/search-files-menu )


(easy-menu-define my/information-menu nil
  "Information menu"
  '("Information"
    ["How Many..." how-many]
    ))
(easy-menu-add-item nil
                    '("Extra Tools")
                    my/information-menu)


(easy-menu-define my/su-menu nil
  "Work as root"
  '("su"
    ["find file and open as root"   my/su-find-file :help "(function my/su-find-file)"]
    ["open dired as root"           my/sudired      :help "(function my/sudired)"]
    ["open this file as root"       my/find-alternative-file-with-su :help "(function my/find-alternative-file-with-su)"]
    ))
(easy-menu-add-item nil
                    '("Extra Tools")
                    my/su-menu)



(provide 'easy-menu_init)
