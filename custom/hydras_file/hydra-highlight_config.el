;;; hydra-highlight_config.el -*- coding: utf-8; lexical-binding: t; -*-

;;; CREATED: <Fri Feb 21 19:23:11 EET 2020>
;;; Time-stamp: <Последнее обновление -- Friday February 21 22:56:41 EET 2020>



;;; Commentary:

;;; Code:


(defhydra my/hydra-highlight (:color pink :exit nil)

  ("P"  hl-sentence-mode             "sentence"      :column "mode")
  ("H"  highlight-symbol-mode        "symbol"        :column "mode")
  ("N"  highlight-symbol-nav-mode    "nav-mode"      :column "mode")
  ("W"  whitespace-mode              "whitespace"    :column "mode")

  ("."  highlight-symbol-at-point    "at-point"    :column "symbol")
  ("+"  highlight-symbol-next        "next"        :column "symbol")
  ("-"  highlight-symbol-prev        "prev"        :column "symbol")
  ("a"  highlight-symbol-remove-all  "remove-all"  :column "symbol")
  ("M-%" highlight-symbol-query-replace "query-replace" :column "symbol")

  ("s"  hlt-highlight-symbol    "symbol"        :column "hlt...")
  ("}"  hlt-next-highlight      "next"          :column "hlt...")
  ("{"  hlt-previous-highlight  "prev"          :column "hlt...")
  ("ds" hlt-unhighlight-symbol  "unh-symbol"    :column "hlt...")

  ("l"  hlt-highlight-lines             "lines"             :column "highlight")
  ("r"  hlt-highlight-region            "region"            :column "highlight")
  ("RET" my/highlight-symbol-occur      "symbol-occur"      :column "highlight")
  ("C-s" hlt-highlight-isearch-matches  "isearch-matches"   :column "highlight")

  ("dr" hlt-unhighlight-region      "region"    :column "unhighlight")
  ("da" hlt-unhighlight-all-prop    "all-prop"  :column "unhighlight")


  ("M-r"  hlt-highlight-regexp-region           "regexp-region"         :column "specific")
  ("M-d"  hlt-highlight-line-dups-region        "line-dups-region"      :column "specific")
  ("M-g"  hlt-highlight-regexp-groups-region    "regexp-groups-region"  :column "specific")
  ("q"  nil "quit")
  )

(bind-key "s-h" 'my/hydra-highlight/body)


(provide 'hydra-highlight_config)
