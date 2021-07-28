;;; hydra-help_config.el -*- coding: utf-8; lexical-binding: t; -*-

;;; CREATED: <Thu Feb 20 23:43:04 EET 2020>
;;; Time-stamp: <Последнее обновление -- Saturday February 22 16:18:49 EET 2020>



;;; Commentary:

;;; Code:



(defhydra my/hydra-help (:columns 4 :hint nil)
    "
    Describe        ^^Keys              ^^Search                ^^Documentation
    ---------------------------------------------------------------------------------------
    _f_unction      _w_: counsel-descb.     _a_propros              _i_nfo
    _p_ackage       _h_elm-descbinds        _p_ackage by Keyword    ma_n_
    _m_ode          _k_eys                                        _r_: emacs-manual
    _v_ariable      _b_: all bindings
    _s_yntax        _W_here-is
    symb_o_l                                                 _q_uit
    "
  ("f" counsel-describe-function)
  ("P" describe-package)
  ("m" describe-mode)
  ("v" counsel-describe-variable)
  ("s" describe-syntax)
  ("o" describe-symbol)


  ("w" counsel-descbinds)
  ("h" helm-descbinds)
  ("k" describe-key)
  ("b" describe-bindings)
  ("W" where-is)

  ("a" my/hydra-apropos/body :color blue)
  ("p" finder-by-keyword)


  ("i" info)
  ("n" helm-man-woman)
  ("r" info-emacs-manual)



  ("l" view-lossage "view-lossage")
  ("e" view-echo-area-messages "*Messages*")
  ("S" info-lookup-symbol "Lookup Symbol in Info")


  ("I" describe-input-method "input-method")
  ("c" describe-key-briefly "key-briefly")
  ("C" describe-coding-system "coding-system")

  ("q" nil))

(bind-key "<f6> <f6>" 'my/hydra-help/body)


;; https://github.com/abo-abo/hydra/wiki/Emacs#apropos
(defhydra my/hydra-apropos (:color blue)
  "Apropos"
  ("a" apropos "apropos")
  ("c" apropos-command "cmd")
  ("d" apropos-documentation "doc")
  ("e" apropos-value "val")
  ("l" apropos-library "lib")
  ("o" apropos-user-option "option")
  ("u" apropos-user-option "option")
  ("v" apropos-variable "var")
  ("i" info-apropos "info")
  ("t" tags-apropos "tags")
  ("z" hydra-customize-apropos/body "customize")
  ("b" my/hydra-help/body "back"))

(defhydra hydra-customize-apropos (:color blue)
  "Apropos (customize)"
  ("a" customize-apropos "apropos")
  ("f" customize-apropos-faces "faces")
  ("g" customize-apropos-groups "groups")
  ("o" customize-apropos-options "options")
  ("b" my/hydra-apropos/body "back"))




(provide 'hydra-help_config)
