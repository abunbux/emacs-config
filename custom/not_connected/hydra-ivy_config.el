;;; hydra-ivy_config.el -*- coding: utf-8; lexical-binding: t; -*-

;;; CREATED: <Fri Feb 21 18:55:14 EET 2020>
;;; Time-stamp: <Последнее обновление -- Friday February 21 18:57:48 EET 2020>



;;; Commentary:

;;; Code:



(defun ivy--matcher-desc () ; used in `hydra-ivy'
  (if (eq ivy--regex-function
          'ivy--regex-fuzzy)
      "fuzzy"
    "ivy"))


(with-eval-after-load 'ivy
  (defhydra my/hydra-ivy (:hint nil :color pink)
    "
^^_,_        _f_ollow      occ_u_r      _g_o          ^^_c_alling %-7s(if ivy-calling \"on\" \"off\")      _w_/_s_/_a_: %-14s(ivy-action-name)
_p_/_n_      _d_one        ^^           _i_nsert      ^^_m_atcher %-7s(ivy--matcher-desc)^^^^^^^^^^^^      _C_ase-fold: %-10`ivy-case-fold-search
^^_._        _D_o it!      ^^           _q_uit        _<_/_>_ shrink/grow^^^^^^^^^^^^^^^^^^^^^^^^^^^^      _t_runcate: %-11`truncate-lines
"
    ;; arrows
    ("," ivy-beginning-of-buffer) ; default h
    ("p" ivy-previous-line) ; default j
    ("n" ivy-next-line) ; default k
    ("." ivy-end-of-buffer) ; default l
    ;; quit ivy
    ("q" keyboard-escape-quit :exit t) ; default o
    ("C-g" keyboard-escape-quit :exit t)
    ;; quit hydra
    ("i" nil)
    ("C-o" nil)
    ;; actions
    ("f" ivy-alt-done :exit nil)
    ;; Exchange the default bindings for C-j and C-m
    ("C-m" ivy-alt-done :exit nil) ; RET, default C-j
    ("C-j" ivy-done :exit t) ; default C-m
    ("d" ivy-done :exit t)
    ("g" ivy-call)
    ("D" ivy-immediate-done :exit t)
    ("c" ivy-toggle-calling)
    ("m" ivy-toggle-fuzzy)
    (">" ivy-minibuffer-grow)
    ("<" ivy-minibuffer-shrink)
    ("w" ivy-prev-action)
    ("s" ivy-next-action)
    ("a" ivy-read-action)
    ("t" (setq truncate-lines (not truncate-lines)))
    ("C" ivy-toggle-case-fold)
    ("u" ivy-occur :exit t))
  )


(provide 'hydra-ivy_config)
