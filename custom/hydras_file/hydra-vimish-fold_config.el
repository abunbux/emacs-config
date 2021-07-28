;;; hydra-vimish-fold_config.el -*- coding: utf-8; lexical-binding: t; -*-

;;; CREATED: <Thu Feb 20 21:21:20 EET 2020>
;;; Time-stamp: <Последнее обновление -- Thursday February 27 7:20:29 EET 2020>



;;; Commentary:

;;; Code:



(defhydra my/hydra-vimish-fold (:color pink :hint nil :delay 0.5)
  "
Vimish Fold
-----------
[_f_]old    [_d_]elete    [_u_]nfold    [_r_]efold    [_t_]oggle    my/fold-d[_w_]im
    Prefix CTRL for `*-all' variants
  [_q_]uit
"
  ("f"      vimish-fold)
  ("C-f"    vimish-fold-all)
  ("d"      vimish-fold-delete)
  ("C-d"    vimish-fold-delete-all)
  ("u"      vimish-unfold)
  ("C-u"    vimish-fold-unfold-all)
  ("r"      vimish-fold-refold)
  ("C-r"    vimish-fold-refold-all)
  ("t"      vimish-fold-toggle)
  ("C-t"    vimish-fold-toggle-all)
  ("w"      my/fold-dwim)
  ("q"      nil :color blue))

(bind-key "s-f"     #'my/hydra-vimish-fold/body)
(bind-key "C-z v h" #'my/hydra-vimish-fold/body)



(provide 'hydra-vimish-fold_config)
