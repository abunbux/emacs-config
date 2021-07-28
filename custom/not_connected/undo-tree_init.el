;;; undo-tree_init.el -*- coding: utf-8; lexical-binding: t; -*-

;;; CREATED: <Thu Feb 20 16:55:24 EET 2020>
;;; Time-stamp: <Последнее обновление -- Thursday February 20 20:25:31 EET 2020>



;;; Commentary:

;;         C-_  C-/  (`undo-tree-undo')     Undo changes.
;;
;;         M-_  C-?  (`undo-tree-redo')     Redo changes.
;;
;;         `undo-tree-switch-branch'        Switch undo-tree branch.
;;
;;         C-x u  (`undo-tree-visualize')   Visualize the undo tree.
;;
;;         C-x r u  (`undo-tree-save-state-to-register')
;;                                          Save current buffer state to register.
;;
;;         C-x r U  (`undo-tree-restore-state-from-register')
;;                                          Restore buffer state from register.
;;
;;
;; In the undo-tree visualizer:
;;
;;        <up>  p  C-p  (`undo-tree-visualize-undo')    Undo changes.
;;
;;        <down>  n  C-n  (`undo-tree-visualize-redo')  Redo changes.
;;
;;        <left>  b  C-b  (`undo-tree-visualize-switch-branch-left')
;;                                                      Switch to previous undo-tree branch.
;;
;;        <right>  f  C-f  (`undo-tree-visualize-switch-branch-right')
;;                                                      Switch to next undo-tree branch.
;;
;;        C-<up>  M-{  (`undo-tree-visualize-undo-to-x')
;;                                                      Undo changes up to last branch point.
;;
;;        C-<down>  M-}  (`undo-tree-visualize-redo-to-x')
;;                                                      Redo changes down to next branch point.
;;
;;        <down>  n  C-n  (`undo-tree-visualize-redo')  Redo changes.
;;
;;        <mouse-1>  (`undo-tree-visualizer-mouse-set') Set state to node at mouse click.
;;
;;        t  (`undo-tree-visualizer-toggle-timestamps') Toggle display of time-stamps.
;;
;;        d  (`undo-tree-visualizer-toggle-diff')       Toggle diff display.
;;
;;        s  (`undo-tree-visualizer-selection-mode')    Toggle keyboard selection mode.
;;
;;        q  (`undo-tree-visualizer-quit')              Quit undo-tree-visualizer.
;;
;;        C-q  (`undo-tree-visualizer-abort')           Abort undo-tree-visualizer.
;;
;;        ,  <             Scroll left.
;;
;;        .  >             Scroll right.
;;
;;        <pgup>  M-v      Scroll up.
;;
;;        <pgdown>  C-v    Scroll down.
;;
;;
;; In visualizer selection mode:
;;
;;        <up>  p  C-p  (`undo-tree-visualizer-select-previous')   Select previous node.
;;
;;        <down>  n  C-n  (`undo-tree-visualizer-select-next')     Select next node.
;;
;;        <left>  b  C-b  (`undo-tree-visualizer-select-left')     Select left sibling node.
;;
;;        <right>  f  C-f  (`undo-tree-visualizer-select-right')   Select right sibling node.
;;
;;        <pgup>  M-v              Select node 10 above.
;;
;;        <pgdown>  C-v            Select node 10 below.
;;
;;        <enter>  (`undo-tree-visualizer-set')        Set state to selected node and exit selection mode.
;;
;;        s  (`undo-tree-visualizer-mode')             Exit selection mode.
;;
;;        t  (`undo-tree-visualizer-toggle-timestamps')    Toggle display of time-stamps.
;;
;;        d  (`undo-tree-visualizer-toggle-diff')          Toggle diff display.
;;
;;        q  (`undo-tree-visualizer-quit')             Quit undo-tree-visualizer.
;;
;;        C-q  (`undo-tree-visualizer-abort')          Abort undo-tree-visualizer.
;;
;;        ,  <                 Scroll left.
;;
;;        .  >                 Scroll right.
;;
;;
;; Persistent undo history:
;;
;;         Note: Requires Emacs version 24.3 or higher.
;;
;;         `undo-tree-auto-save-history' (variable)
;;            automatically save and restore undo-tree history along with buffer
;;            (disabled by default)
;;
;;         `undo-tree-save-history' (command)
;;            manually save undo history to file
;;
;;         `undo-tree-load-history' (command)
;;            manually load undo history from file
;;
;;
;; Compressing undo history:
;;
;;          Undo history files cannot grow beyond the maximum undo tree size, which
;;          is limited by `undo-limit', `undo-strong-limit' and
;;          `undo-outer-limit'. Nevertheless, undo history files can grow quite
;;          large. If you want to automatically compress undo history, add the
;;          following advice to your .emacs file (replacing ".gz" with the filename
;;          extension of your favourite compression algorithm):
;;
;;          (defadvice undo-tree-make-history-save-file-name
;;            (after undo-tree activate)
;;            (setq ad-return-value (concat ad-return-value ".gz")))


;;; Code:



;;; undo-tree.el
;; C-_  C-/  (`undo-tree-undo')     Undo changes.
;; M-_  C-?  (`undo-tree-redo')     Redo changes.
;; C-x u  (`undo-tree-visualize')   Visualize the undo tree.


(use-package undo-tree
  :quelpa (undo-tree :fetcher github :stable nil :repo "emacsorphanage/undo-tree")
  :diminish
  :init
  (setq undo-tree-visualizer-timestamps t
        undo-tree-visualizer-diff t)
  :hook
  (after-init . undo-tree-mode)
  :config
  (message "Loading \"undo-tree\"")
  (eval-after-load 'undo-tree
    '(progn
       (setq undo-tree-visualizer-timestamps      t
             undo-tree-visualizer-diff            t
             undo-tree-auto-save-history          t
             undo-tree-visualizer-lazy-drawing    1000
             undo-limit                           100000
             undo-tree-mode-lighter               " UT")

       (defun my/undo-tree-enable-save-history ()
         "Enable auto saving of the undo history."
         (interactive)
         (setq undo-tree-auto-save-history t)
         ;; Persistent undo-tree history across emacs sessions
         (setq my/undo-tree-history-dir
               (let ((dir (concat user-emacs-directory
                                  "cache/undo-tree-history/")))
                 (make-directory dir :parents)
                 dir))
         (setq undo-tree-history-directory-alist
               `(("" . ,my/undo-tree-history-dir)))

         (add-hook 'write-file-functions #'undo-tree-save-history-hook)
         (add-hook 'find-file-hook #'undo-tree-load-history-hook))

       (unbind-key  "C-/")
       (unbind-key  "C-?")

       (my/undo-tree-enable-save-history)
       (global-undo-tree-mode 1)

       ))
  )



(provide 'undo-tree_init)
