;;; hydra-rectangle_config.el -*- coding: utf-8; lexical-binding: t; -*-

;;; CREATED: <Wed Feb 26 20:13:19 EET 2020>
;;; Time-stamp: <Последнее обновление -- Thursday February 27 7:15:25 EET 2020>



;;; Commentary:

;;; Code:



;; https://github.com/abo-abo/hydra/wiki/Rectangle-Operations#rectangle-2

(defhydra my/hydra-rectangle (:body-pre (rectangle-mark-mode 1)
                                        :color pink
                                        :hint nil
                                        :post (deactivate-mark))
  "
              Rectangle commands                                                Register commands
  _w_ copy      _o_pen       _N_umber-lines             ^_↑_^        _SPC_ save point           _n_: number to register
  _y_ank        _t_ype       _e_xchange-point         _←_   _→_      _j_ump to register        _+_ : increment register
  _k_ill        _c_lear      _r_eset-region-mark        ^_↓_^        _s_: copy to register      _h_: show registers
               _u_ndo      _q_ quit     ^ ^         ^^^^              _i_: insert register
"


  ("<up>" rectangle-previous-line)
  ("<down>" rectangle-next-line)
  ("<left>" rectangle-backward-char)
  ("<right>" rectangle-forward-char)
  ("k" kill-rectangle)                    ; C-x r k
  ("y" yank-rectangle)                    ; C-x r y
  ("w" copy-rectangle-as-kill)            ; C-x r M-w
  ("o" open-rectangle)                    ; C-x r o
  ("t" string-rectangle)                  ; C-x r t
  ("c" clear-rectangle)                   ; C-x r c
  ("e" rectangle-exchange-point-and-mark) ; C-x C-x
  ("N" rectangle-number-lines)            ; C-x r N
  ("r" (if (region-active-p)
           (deactivate-mark)
         (rectangle-mark-mode 1)))
  ("u" undo nil)

  ("SPC" point-to-register)                 ; C-x r SPC
  ("j" (if (region-active-p)                ; C-x r j
           (progn
             (deactivate-mark)
             (call-interactively 'jump-to-register))
         (rectangle-mark-mode 1)))
  ("s" copy-to-register)                    ; C-x r s

  ("i" insert-register)                     ; C-x r i
  ("h" helm-register)                       ; M-h b r
  ("n" number-to-register)
  ("+" increment-register)
  ("q"  nil))


(bind-key "s-r"         'my/hydra-rectangle/body)
(bind-key "C-x r C-r"   'my/hydra-rectangle/body)



(provide 'hydra-rectangle_config)
