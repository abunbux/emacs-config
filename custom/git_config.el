;; -*- lexical-binding: t -*-

;;; CREATED: <Thu Jun 20 05:47:58 EEST 2019>
;;; Time-stamp: <Последнее обновление -- Wednesday August 25 17:36:35 EEST 2021>



;;; Commentary:


;; Code:



(use-package magit
  :ensure t
  :preface
  (defun my/delete-other-windows ()
    (interactive)
    (other-window 1)
    (delete-window))

  :bind (
         ("C-c g s" . magit-status)
         ("C-c g l" . magit-log-buffer-file)
         ;; ("-------" . magit-clone)
         ;; ("-------" . magit-staging)
         ;; ("-------" . magit-blame)
         ;; ("-------" . magit-pull)
	     ;; ("-------" . magit-dispatch-popup)

         :map git-commit-mode-map
         ("M-1"     . my/delete-other-windows)
         )
  :config
  (message "Loading \"magit\"")
  (setq magit-completing-read-function 'ivy-completing-read
        magit-save-repository-buffers 'dontask
        magit-refs-show-commit-count 'all
        ;; Use separate buffers for one-file logs so that we don't need to reset
        ;; the filter everytime for full log view
        magit-log-buffer-file-locked t
        ;; This is creepy, Magit
        magit-revision-show-gravatars nil
        ;; Show status buffer in fullscreen
        magit-display-buffer-function #'magit-display-buffer-fullframe-status-v1
        )

  (setq transient-history-file "~/.emacs.d/cache/history.el")                             ; transient.el
  (setq-default transient-history-file "~/.emacs.d/cache/history.el")                     ; transient.el


    ;;; https://github.com/magit/magit/wiki/Tips-and-Tricks
    ;;; Show staged and unstaged changes, but nothing else
  ;; To get a buffer with just the staged and unstaged changes,
  ;; but not all the other things displayed in the status buffer, use this:
  ;; magit-staging ("C-c g S")
  (define-derived-mode magit-staging-mode magit-status-mode "Magit staging"
    "Mode for showing staged and unstaged changes."
    :group 'magit-status)

  (defun magit-staging-refresh-buffer ()
    (magit-insert-section (status)
                          (magit-insert-unstaged-changes)
                          (magit-insert-staged-changes)))

  (defun magit-staging ()
    (interactive)
    (magit-mode-setup #'magit-staging-mode))


    ;;; https://github.com/magit/magit/wiki/Tips-and-Tricks
    ;;; Иногда может быть желательно отслеживать точные команды Git,
  ;; которые выполняются в результате таких операций Magit,
  ;; как постановка и разархивирование, выборка, объединение и т. Д.
  ;; Это может быть легко сделано путем отображения буфера процесса
  ;; с использованием соответствующего ключа ( "$" по-умолчанию) в любом буфере Magit,
  ;; но если требуется мониторинг всех команд, следующий совет автоматически отображает буфер процесса
  ;; при каждом его обновлении. (Как таковой, он будет избегать фокусировки автоматически отображаемого буфера,
  ;; таким образом, крадя фокус из любого буфера, созданного командой, но это можно легко изменить, если необходимо).
  (defun auto-display-magit-process-buffer (&rest args)
    "Automatically display the process buffer when it is updated."
    (let ((magit-display-buffer-noselect t))
      (magit-process-buffer)))

  (advice-add 'magit-process-insert-section :before #'auto-display-magit-process-buffer)


  (custom-set-faces
   ;; custom-set-faces was added by Custom.
   ;; If you edit it by hand, you could mess it up, so be careful.
   ;; Your init file should contain only one such instance.
   ;; If there is more than one, they won't work right.
   '(magit-diff-added ((t (:background "black" :foreground "green3"))))
   '(magit-diff-removed ((t (:background "black" :foreground "red3"))))))


;;; gitattributes-mode
;; Auto-/loading the library gitattributes-mode enabled the mode for
;; .gitattributes,
;; .git/info/attributes, and
;; git/attributes files.
(use-package gitattributes-mode
  :ensure t
  :defer t
  :config
  (message "Loading \"gitattributes-mode\"")
  )



;;; gitconfig-mode
;; Auto-/loading the library gitconfig-mode enables the mode for
;; .gitconfig,
;; .git/config,
;; git/config, and
;; .gitmodules files.
;; gitconfig-mode derives from conf-unix-mode.
(use-package gitconfig-mode
  :ensure t
  :defer t
  :config
  (message "Loading \"gitconfig-mode\"")
  )




;;; gitignore-mode
;; Auto-/loading the library gitignore-mode enables the mode for
;; .gitignore,
;; .git/info/exclude, and
;; git/ignore files.
;; gitignore-mode derives from conf-unix-mode.
(use-package gitignore-mode
  :ensure t
  :defer t
  :config
  (message "Loading \"gitignore-mode\""))





(provide 'git_config)
;;; git_config.el ends here


;;; `git commit --amend -m "--------"' - исправить предыдущий коммит;
;;; `git commit --amend --no-edit'     - добавить файл и внести коммит, сделанный ранее;


;;; `magit-stage-file' - добавить изменённый файл или "s" в буфере magit;
;;; "cc" - в буфере "magit" - добавить коммит;
;;; "C-c C-c" сохранить коммит;
;;; "Pu" в буфере "magit" - "push";



;;; Section commands
;; _______________________

;; These commands are for navigation and to change the visibility of sections.
;;      TAB	toggle body of current section
;;      C-<tab>	cycle visibility of current section and its children
;;      M-<tab>	cycle visibility of all diff sections
;;      s-<tab>	cycle visibility of all sections
;;      1, 2, 3, 4	show surrounding sections up to level N, hide deeper levels
;;      M-1, M-2, M-3, M-4	globally show sections up to level N, hide deeper levels
;;      ^	goto parent section
;;      p	goto beginning of section, from there to previous section
;;      n	goto next section
;;      M-p	goto beginning of section, from there to previous sibling section
;;      M-n	goto next sibling section



;;; Buffer commands
;;      g	refresh current buffer and status buffer, possibly revert file-visiting buffers
;;      G	refresh all Magit buffers and revert all file-visiting buffers in repository
;;      q	bury the current Magit buffer, restoring previous window configuration
;;      C-u q	kill the current Magit buffer, restoring previous window configuration



;;; Various common commands
;;      SPC	scroll up (1)
;;      DEL	scroll down (1)
;;      RET	show the thing at point in another buffer (2)
;;      j	jump somewhere (3)
;;      $	show output of recent calls to git
;;
;;  (1) In most Magit buffers this scrolls the current buffer. In log buffers this instead scrolls the diff buffer shown in another window.
;;  (2) What is being shown depends on the context.
;;  (3) Where this jumps to depends on the context.



;;; Various assorted commands
;;      i	add a gitignore rule globally
;;      I	add a gitignore rule locally
;;      x	reset using --mixed
;;      C-u x	reset using --hard



;;; Prefix commands
;; _________________________

;; These commands show popup buffers listing infix arguments and suffix commands. Note that you don’t have to remember all these prefixes initially - use h to show a popup listing all these prefixes as well as many (but not all) of the commands that are not prefixes themselves.

;;      A	cherry-pick
;;      b	branch
;;      B	bisect
;;      c	commit
;;      d	diff
;;      E	ediff
;;      f	fetch
;;      F	pull
;;      h, ?	show popup of popups
;;      l	log
;;      m	merge
;;      M	remote
;;      o	submodule
;;      P	push
;;      r	rebase
;;      t	tag
;;      T	note
;;      V	revert
;;      w	apply patches
;;      C-u y	list refs (1)
;;      z	stash
;;      !	run git or gui tool
;;
;;  (1) Actually y is bound to a popup/prefix command, but it is one of the few popups which default to a suffix command and therefore has to be called with a prefix argument to actually show the popup buffer.



;;; Applying changes
;; ________________________

;;      a	apply the change at point
;;      k	discard the change at point
;;      s	stage the change at point
;;      S	stage all unstaged changes
;;      u	unstage the change at point
;;      U	unstage all staged changes (1)
;;      v	reverse the change at point
;;
;;  (1) Actually this asks for a commit to reset the index too. If you just press RET, then what this equivalent to unstaging everything. If that is too confusing then just bind this key to magit-unstage-all.



;;; Diffing
;; _____________

;; These commands show diffs or manipulate the diff arguments used to generate the diffs in the current buffer.

;;      RET	(on commit) show commit
;;      RET	(on stash) show stash
;;      d	show diffing popup
;;      D	show popup for changing diff arguments
;;      e	use ediff to stage, compare, or stage (dwim)
;;      E	show ediffing popup (for when dwimming fails)
;;      +	show more context lines
;;      -	show less context lines
;;      0	show default amount of context lines (three)



;;; Rebasing
;; _______________

;; The following commands can be used from the magit-rebase-popup which is activated using r

;;      i	Start an interactive rebase sequence.
;;      f	Combine squash and fixup commits with their intended targets.
;;      m	Edit a single older commit using rebase.
;;      w	Reword a single older commit using rebase.
;;      k	Remove a single older commit using rebase.
;;      Whilst performing a rebase the following editing sequences are available.

;;; Whilst performing a rebase the following editing sequences are available.
;;      C-c C-c	Finish the current editing session by returning with exit code 0. Git then uses the rebase instructions it finds in the file.
;;      C-c C-k	Cancel the current editing session by returning with exit code 1. Git then forgoes starting the rebase sequence.
;;      RET	Show the commit on the current line in another buffer and select that buffer.
;;      SPC	Show the commit on the current line in another buffer without selecting that buffer. If the revision buffer is already visible in another window of the current frame, then instead scroll that window up.
;;      DEL	Show the commit on the current line in another buffer without selecting that buffer. If the revision buffer is already visible in another window of the current frame, then instead scroll that window down.
;;      p	Move to previous line.
;;      n	Move to next line.
;;      M-p	Move the current commit (or command) up.
;;      M-n	Move the current commit (or command) down.
;;      r	Edit message of commit on current line.
;;      e	Stop at the commit on the current line.
;;      s	Meld commit on current line into previous commit, and edit message.
;;      f	Meld commit on current line into previous commit, discarding the current commit’s message.
;;      k	Kill the current action line.
;;      c	Use commit on current line.
;;      x	Insert a shell command to be run after the proceeding commit.
;;      y	Read an arbitrary commit and insert it below current line.
;;      C-x u	Undo some previous changes. Like undo but works in read-only buffers.
;;      If a rebase is already in progress then magit-rebase-popup offers the following commands.

;;; If a rebase is already in progress then magit-rebase-popup offers the following commands.
;;      r	Restart the current rebasing operation.
;;      s	Skip the current commit and restart the current rebase operation.
;;      e	Edit the todo list of the current rebase operation.
;;      a	Abort the current rebase operation, restoring the original branch.
