;;; hydra-undo-tree_config.el -*- coding: utf-8; lexical-binding: t; -*-

;;; CREATED: <Thu Feb 20 20:32:03 EET 2020>
;;; Time-stamp: <Последнее обновление -- Thursday February 20 20:32:45 EET 2020>



;;; Commentary:

;;; Code:



(defhydra my/hydra-undo-tree (:hint nil)
  "
  _p_: undo  _n_: redo _s_: save _l_: load   "
  ("p"   undo-tree-undo)
  ("n"   undo-tree-redo)
  ("s"   undo-tree-save-history)
  ("l"   undo-tree-load-history)
  ("u"   undo-tree-visualize "visualize" :color blue)
  ("q"   nil "quit" :color blue))




(provide 'hydra-undo-tree_config)
