;;; hydra-insert-unicode_config.el -*- coding: utf-8; lexical-binding: t; -*-

;;; CREATED: <Sat Feb 22 23:18:50 EET 2020>
;;; Time-stamp: <Последнее обновление -- Thursday February 27 13:8:47 EET 2020>



;;; Commentary:

;;; Code:




;; https://github.com/abo-abo/hydra/wiki/Unicode-input
;; https://www.fileformat.info/info/unicode/index.htm

(defun my/insert-unicode (unicode-name)
  "Same as C-x 8 enter UNICODE-NAME."
  (insert-char (gethash unicode-name (ucs-names))))


 (defhydra my/hydra-insert-unicode (:hint nil)
   "
    money       misc        math    latin       punctuation         arrow
---------------------------------------------------------------------------------------------------
    _e_ €       _m_  ♂         _o_ °       _C_ ©       _-_ —            _→_ →
    _E_ $       _f_   ♀         _i_ ∞      _S_ §       _t_ ‣             _←_ ←
    _c_ ¢       _sb_  ★                  _M_ µ                       _↑_ ↑
              _sw_  ☆                                            _↓_ ↓

"
   ("e" (my/insert-unicode "EURO SIGN"))
   ("E" (my/insert-unicode "DOLLAR SIGN"))
   ("c" (my/insert-unicode "CENT SIGN"))

   ("m" (my/insert-unicode "MALE SIGN"))
   ("f" (my/insert-unicode "FEMALE SIGN"))
   ("sb" (my/insert-unicode "BLACK STAR"))
   ("sw" (my/insert-unicode "WHITE STAR"))

   ("o" (my/insert-unicode "DEGREE SIGN"))
   ("i" (my/insert-unicode "INFINITY"))

   ("C" (my/insert-unicode "COPYRIGHT SIGN"))
   ("S" (my/insert-unicode "SECTION SIGN"))
   ("M" (my/insert-unicode "MICRO SIGN"))

   ("-" (my/insert-unicode "EM DASH"))
   ("t" (my/insert-unicode "TRIANGULAR BULLET"))


   ("<right>"   (my/insert-unicode "RIGHTWARDS ARROW"))
   ("<left>"    (my/insert-unicode "LEFTWARDS ARROW"))
   ("<up>"      (my/insert-unicode "UPWARDS ARROW"))
   ("<down>"    (my/insert-unicode "DOWNWARDS ARROW"))
   )


(bind-key "C-x 9"   'my/hydra-insert-unicode/body)
(bind-key "s-u"     'my/hydra-insert-unicode/body)





(provide 'hydra-insert-unicode_config)
