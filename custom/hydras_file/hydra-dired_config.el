;;; hydra-dired_config.el -*- coding: utf-8; lexical-binding: t; -*-

;;; CREATED: <Thu Feb 20 15:54:29 EET 2020>
;;; Time-stamp: <Последнее обновление -- Monday February 24 23:8:39 EET 2020>



;;; Commentary:

;;; Code:




;; переделать под себя - убрать лишнее, добавить свои привычные функции.


;;;  К сожалению, забыл записать где передрал основу этой функции,
;;;  по-моему где-то на https://www.reddit.com/r/emacs/
;; (with-eval-after-load 'hydra
(with-eval-after-load 'dired
  (defhydra my/hydra-dired (:hint nil :color pink)
    "
_+_ mkdir           _v_iew              _m_ark             _(_ details        _i_nsert-subdir    wdired
_C_opy              _P_: view other     _U_nmark all       _)_ omit-mode      _$_ hide-subdir    C-x C-q : edit
_D_elete            _o_pen other        _u_nmark           _l_ redisplay      _K_ kill-subdir    C-c C-c : commit
_R_ename                              _t_oggle           _g_ revert buf     _e_ ediff          C-c ESC : abort
_Y_ rel symlink                       _E_xtension mark   _s_ort             _=_ pdiff
_S_ymlink                                                _._ toggle hydra
_z_ compress-file
_Z_ compress
                                                                                 _C-d M-o_: my/dired-start-process (before mark)
T - tag prefix    _M-o_: open in external app    _M-e_ :open in window manager    _C-d D_: kill all dired buffers
"





    ("(" dired-hide-details-mode)
    (")" dired-omit-mode)
    ("+" dired-create-directory)
    ("=" diredp-ediff)         ;; smart diff
    ("$" diredp-hide-subdir-nomove)
    ("C" dired-do-copy)        ;; Copy all marked files
    ("D" dired-do-delete)
    ("E" dired-mark-extension)
    ("e" dired-ediff-files)
    ;; ("F" dired-do-find-marked-files)
    ("g" revert-buffer)        ;; read all directories again (refresh)
    ("i" dired-maybe-insert-subdir)
    ("l" dired-do-redisplay)   ;; relist the marked or singel directory
    ;; ("G" dired-do-chgrp)
    ;; ("M" dired-do-chmod)
    ("m" dired-mark)
    ("P" peep-dired)
    ("o" dired-find-file-other-window)
    ("R" dired-do-rename)
    ("S" dired-do-symlink)
    ("s" xah-dired-sort)
    ("t" dired-toggle-marks)
    ("U" dired-unmark-all-marks)
    ("u" dired-unmark)
    ("v" dired-view-file)      ;; q to exit, s to search, = gets line #
    ("K" dired-kill-subdir)
    ("Y" dired-do-relsymlink)
    ("z" diredp-compress-this-file)
    ("Z" dired-do-compress)
    ("M-o" xah-open-in-external-app)
    ("M-e" my/open-window-manager)
    ("C-d D" my/kill-all-dired-buffers)
    ("C-d M-o" my/dired-start-process)
    ("q" nil)
    ("." nil :color blue))
  ;; (define-key dired-mode-map "." 'my/hydra-dired/body)
  (bind-key "." 'my/hydra-dired/body dired-mode-map)
  )





(provide 'hydra-dired_config)
