;;; hydra-multiple-cursors_config.el -*- coding: utf-8; lexical-binding: t; -*-

;;; CREATED: <Wed Feb 26 22:51:35 EET 2020>
;;; Time-stamp: <Последнее обновление -- Thursday February 27 12:35:12 EET 2020>



;;; Commentary:

;;; Code:




  (defhydra my/hydra-multiple-cursors (:color pink :hint nil)
    "

    Point^^^^^^             Misc^^            Insert/Sort
  ──────────────────────────────────────────────────────────────────────────────
    _k_     _K_     _M-k_    [_l_] edit lines  [_I_] 0...            [_<SPC>_] set-rectangular-region-anchor
    ^↑^    ^↑^     ^↑^     [_m_] mark all    [_L_] letters         [_w_] all dwim
    mark^^  skip^^^ un-mk^   [_s_] sort        [_N_] numbers
    ^↓^    ^↓^     ^↓^     [_b_] beginnings  [_S_] sort
    _j_     _J_     _M-j_    [_e_] ends        [_R_] revers
  ──────────────────────────────────────────────────────────────────────────────
                           [_q_]: quit, [Click]: point
"
    ("<SPC>"   set-rectangular-region-anchor)
    ("w"        mc/mark-all-dwim)
    ("l"      mc/edit-lines :exit t)
    ("b"        mc/edit-beginnings-of-lines :exit t)
    ("e"        mc/edit-ends-of-lines :exit t)
    ("m"      mc/mark-all-like-this :exit t)
    ("j"      mc/mark-next-like-this)
    ("J"      mc/skip-to-next-like-this)
    ("M-j"    mc/unmark-next-like-this)
    ("k"      mc/mark-previous-like-this)
    ("K"      mc/skip-to-previous-like-this)
    ("M-k"    mc/unmark-previous-like-this)
    ("s"      mc/mark-all-in-region-regexp :exit t)
    ("I"      mc/insert-numbers :exit t)
    ("L"      mc/insert-letters :exit t)
    ("N"      my/mc/insert-numbers :exit t)
    ("S"        mc/sort-regions)
    ("R"        mc/reverse-regions)
    ("<mouse-1>" mc/add-cursor-on-click)
    ;; Help with click recognition in this hydra
    ("<down-mouse-1>" ignore)
    ("<drag-mouse-1>" ignore)
    ("q" nil))

(bind-key "M-m h"   ' my/hydra-multiple-cursors/body)
(bind-key "s-m"     ' my/hydra-multiple-cursors/body)



(provide 'hydra-multiple-cursors_config)
