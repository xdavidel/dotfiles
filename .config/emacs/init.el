;;; init.el --- Emacs main configuration file -*- lexical-binding: t -*-
;;;
;;; Commentary:
;;; Emacs Config
;;;
;;; Code:

;; Loading eraly-init.el if Emacs version < 27
(unless (featurep 'early-init)
  (load (expand-file-name "early-init" user-emacs-directory)))

;; At this point use-package should be installed
(require 'use-package)

(use-package restart-emacs)

;; General Settings
;; ------------------------------------
; 
;; Allow async compilation of packages
(use-package async
  :init
  (dired-async-mode 1)
  (async-bytecomp-package-mode 1)
  :custom (async-bytecomp-allowed-packages '(all)))

;; Set transparent background
(defvar my/frame-transparency '(95 . 95))
(set-frame-parameter (selected-frame) 'alpha my/frame-transparency)
(add-to-list 'default-frame-alist `(alpha . ,my/frame-transparency))

;; Save history between sessions
(use-package savehist
  :straight nil
  :config (savehist-mode 1))

;; Scratch is clean and for normal text
(use-package startup
  :no-require t
  :straight nil
  :custom
  (initial-major-mode 'fundamental-mode)
  (initial-scratch-message "")
  (inhibit-splash-screen t))

;; General Emacs stuff
(use-package emacs
  :straight nil
  :bind (:map global-map
  ;; Increase / Decrease font
  ("C-=" . text-scale-increase)
  ("C--" . text-scale-decrease)
  ("<C-mouse-4>" . text-scale-increase)
  ("<C-mouse-5>" . text-scale-decrease))
  :config
  (menu-bar-mode -1)
  (blink-cursor-mode -1)
  (fset 'yes-or-no-p 'y-or-n-p)
  (setq scroll-conservatively 101         ;; Don't center curser at off screen
        scroll-margin 5                   ;; Create a margin for off screen
        mouse-wheel-progressive-speed nil ;; Normal mouse scrolling
        ring-bell-function 'ignore)       ;; Disable bells
  (global-auto-revert-mode t)             ;; Auto refresh changed buffers
  (setq-default truncate-lines t))        ;; No line wrap be default

;; User profile
(setq user-full-name "David Delarosa"   
      user-mail-address "xdavidel@gmail.com")

(use-package tramp
  :straight nil
  :config
  ;; Set default connection mode to SSH
  (setq tramp-default-method "ssh"))

;; ------------------------------------


;; Clean emacs directory
;; ------------------------------------
;; No Lock Files
(setq create-lockfiles nil)

;; Move backups to emacs folder
(setq backup-directory-alist `(("." . ,(expand-file-name "tmp/backups/" user-emacs-directory))))

;; create directory for auto-save-mode
(make-directory (expand-file-name "tmp/auto-saves/" user-emacs-directory) t)
(setq auto-save-list-file-prefix (expand-file-name "tmp/auto-saves/sessions/" user-emacs-directory)
      auto-save-file-name-transforms `((".*" ,(expand-file-name "tmp/auto-saves/" user-emacs-directory) t)))

;; ------------------------------------


;; EVIL - Load it as fast as possible
;; ------------------------------------
;; Better undo for evil
(use-package undo-fu)
(use-package undo-fu-session
  :after undo-fu
  :init
  (global-undo-fu-session-mode))

;; Basic Evil mode
(use-package evil
  :after undo-fu-session
  :init
  (setq evil-want-integration t
	evil-want-keybinding nil
	evil-want-Y-yank-to-eol t
	evil-vsplit-window-right t
	evil-split-window-below t
	evil-want-C-i-jump nil
	evil-undo-system 'undo-fu)
  :config
  (evil-mode 1)
  (evil-set-leader 'normal " "))

;; Collection of bindings Evil does not cover
(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

;; Move quickly in the document
(use-package evil-easymotion
  :after evil
  :commands (evilem-motion-next-line evilem-motion-previous-line))

;; Comment code efficiently
(use-package evil-nerd-commenter
  :bind (:map global-map
	 ("C-/" . evilnc-comment-or-uncomment-lines))
  :after evil
  :commands (evilnc-comment-or-uncomment-lines))

;; Terminal cursor mode support
;; more readable :)
(unless (display-graphic-p)
  (use-package evil-terminal-cursor-changer
    :config
    (evil-terminal-cursor-changer-activate)))

;; Vim like surround package
(use-package evil-surround
  :after evil
  :config
  (global-evil-surround-mode))

;; View Registers and marks
(use-package evil-owl
  :after evil
  :custom
  (evil-owl-display-method 'posframe)
  (evil-owl-extra-posfram-args '(:width 50 :height 20))
  (evil-owl-idle-delay 0)
  :config
  (evil-owl-mode))

;; Increment / Decrement binary, octal, decimal and hex literals
(use-package evil-numbers
  :commands (evil-numbers/inc-at-pt evil-numbers/dec-at-pt))

;; Jump between opening/closing tags using %
(use-package evil-matchit
  :after evil)

;; Display keys in a menu
(use-package which-key
  :config
  (which-key-mode t))

;; ------------------------------------

;; Completions
;; ------------------------------------
;; Lightweight completion framwork
(use-package vertico
  :init
  (vertico-mode)
  :custom-face
  (vertico-current ((t (:background "#3a3f5a")))))

;; Fuzzy search
(use-package orderless
  :custom
  (completion-styles '(orderless))
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles . (partial-completion))))))

;; Save history between sessions
(use-package savehist
  :after vertico
  :straight nil
  :init (savehist-mode))

;; Rich completions
(use-package marginalia
  :after vertico
  :custom
  (marginalia-annotators '(marginalia-annotators-heavy marginalia-annotators-light nil))
  :init
  (marginalia-mode))

;; Menu completion
(use-package consult
  :after vertico
  :bind (:map global-map
    ("C-x b" . consult-buffer)           ; enhanced switch to buffer
    ("M-s" . consult-outline)            ; navigation by headings
    ("C-c o" . consult-imenu)            ; navigation by "imenu" items
    ("M-y" . consult-yank-pop)           ; editing cycle through kill-ring
    ("C-s" . consult-line))              ; search lines with preview
  :hook (completion-setup . hl-line-mode)
  :config
  ;; configure preview behavior
  (consult-customize
   consult-buffer consult-bookmark :preview-key '(:debounce 1 any)
   consult-line :preview-key '(:debounce 0 any))
  :custom
  (completion-in-region-function #'consult-completion-in-region))

;; Completion framwork for anything
(use-package company
  :bind
  (:map company-active-map
   ("<down>" . company-select-next)
   ("<up>" . company-select-previous)
   ("TAB" . company-complete-common-or-cycle)
   ("<tab>" . company-complete-common-or-cycle)
   ("<S-Tab>" . company-select-previous)
   ("<backtab>" . company-select-previous)
   ("RET"   . company-complete-selection)
   ("<ret>" . company-complete-selection)
   :map company-mode-map
   ("C-SPC" . company-complete))
  :hook
  (after-init . global-company-mode)
  :custom
  (company-idle-delay 0.1)
  (company-minimum-prefix-length 1))

;; ------------------------------------

;; Theme
;; ------------------------------------
(use-package doom-themes
  :custom
  (doom-themes-enable-bold t)
  (doom-themes-enable-italic t)
  :config
  (load-theme 'doom-palenight t)
  (doom-themes-visual-bell-config))

(use-package doom-modeline
  :defer 1
  :config
  (doom-modeline-mode)
  (when (display-graphic-p)
    (setq doom-modeline-icon t)))

;; Set color backgrounds to color names
(use-package rainbow-mode
  :hook (prog-mode . rainbow-mode))

;; Rainbow colors for brackets
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

;; ------------------------------------

;; Functions
;; ------------------------------------
(defun my/font-installed-p (font-name)
  "Check if font with FONT-NAME is available."
  (find-font (font-spec :name font-name)))

(defun toggle-line-wrap ()
  "Switch between line wraps"
  (interactive)
  (setq truncate-lines (not truncate-lines)))

(defun my/indent-buffer ()
  "Indent whole buffer."
  (interactive)
  (save-excursion
    (save-restriction
      (indent-region (point-min) (point-max)))))

(defun sudo-save ()
  "save this file as super user."
  (interactive)
  (if (not buffer-file-name)
      (write-file (concat "/sudo:root@localhost:" (read-file-name "File:")))
    (write-file (concat "/sudo:root@localhost:" buffer-file-name))))

;;; describe this point lisp only
(defun describe-thing-at-point ()
  "Show the documentation of the Elisp function and variable near point.
This checks in turn:
-- for a function name where point is
-- for a variable name where point is
-- for a surrounding function call"
  (interactive)
  (let (sym)
    ;; sigh, function-at-point is too clever.  we want only the first half.
    (cond ((setq sym (ignore-errors
		       (with-syntax-table emacs-lisp-mode-syntax-table
			 (save-excursion
			   (or (not (zerop (skip-syntax-backward "_w")))
			       (eq (char-syntax (char-after (point))) ?w)
			       (eq (char-syntax (char-after (point))) ?_)
			       (forward-sexp -1))
			   (skip-chars-forward "`'")
			   (let ((obj (read (current-buffer))))
			     (and (symbolp obj) (fboundp obj) obj))))))
	   (describe-function sym))
	  ((setq sym (variable-at-point)) (describe-variable sym))
	  ;; now let it operate fully -- i.e. also check the
	  ;; surrounding sexp for a function call.
	  ((setq sym (function-at-point)) (describe-function sym)))))

(defun delete-trailing-whitespace-except-current-line ()
  "An alternative to `delete-trailing-whitespace'.
The original function deletes trailing whitespace of the current line."
  (interactive)
  (let ((begin (line-beginning-position))
	(end (line-end-position)))
    (save-excursion
      (when (< (point-min) (1- begin))
	(save-restriction
	  (narrow-to-region (point-min) (1- begin))
	  (delete-trailing-whitespace)
	  (widen)))
      (when (> (point-max) (+ end 2))
	(save-restriction
	  (narrow-to-region (+ end 2) (point-max))
	  (delete-trailing-whitespace)
	  (widen))))))

(defun smart-delete-trailing-whitespace ()
  "Invoke `delete-trailing-whitespace-except-current-line' on selected major modes only."
  (unless (member major-mode '(diff-mode))
    (delete-trailing-whitespace-except-current-line)))

;; Auto-indent after paste yanked
(defadvice insert-for-yank-1 (after indent-region activate)
  "Indent yanked region in certain modes, \\<C-u> prefix to disable."
  (if (and (not current-prefix-arg)
	   (member major-mode '(sh-mode
				emacs-lisp-mode lisp-mode
				c-mode c++-mode objc-mode d-mode java-mode cuda-mode js-mode
				LaTeX-mode TeX-mode
				xml-mode html-mode css-mode)))
      (indent-region (region-beginning) (region-end) nil)))

(add-hook 'before-save-hook #'smart-delete-trailing-whitespace)

;; ------------------------------------

;; UI
;; ------------------------------------
;; Set fonts if possible
(cond ((my/font-installed-p "Cascadia Code")
       (set-face-attribute 'default nil :font "Cascadia Code 10"))
      ((my/font-installed-p "JetBrainsMono")
       (set-face-attribute 'default nil :font "JetBrainsMono 10"))
      ((my/font-installed-p "Hack")
       (set-face-attribute 'default nil :font "Hack 10")))

(use-package all-the-icons
  :hook (after-init . recentf-mode)
  :config
  (when (and (not (my/font-installed-p "all-the-icons"))
	     (window-system))
    (all-the-icons-install-fonts t)))
; 
;; Icons for dired
(use-package all-the-icons-dired
  :hook (dired-mode . all-the-icons-dired-mode))

;; Line numbers
(use-package display-line-numbers
  :straight nil
  ;; :when aorst-enable-line-numbers
  :hook (prog-mode . display-line-numbers-mode)
  :custom
  (display-line-numbers-width 4)
  (display-line-numbers-width-start t)
  (add-hook 'display-line-numbers-mode-hook
	    (lambda () (setq display-line-numbers-type 'relative))))

;; Show matching parens
(use-package paren
  :straight nil
  :hook (after-init . recentf-mode)
  :config (show-paren-mode 1))

;; Lightweight syntax highlighting improvement for numbers
(use-package highlight-numbers
  :hook (prog-mode . highlight-numbers-mode))

;; Lightweight syntax highlighting improvement for escape sequences (e.g. \n, \t).
(use-package highlight-escape-sequences
  :hook (prog-mode . hes-mode))


;; Be smart when using parens, and highlight content
(use-package smartparens
  :hook (prog-mode . smartparens-mode)
  :config
  ;; highligh matching brackets
  (show-smartparens-global-mode 0)
  ;; so that paren highlights do not override region marking (aka selecting)
  (setq show-paren-priority -1)
  (setq show-paren-when-point-inside-paren t)
  (setq sp-show-pair-from-inside t)
  (setq show-paren-style 'mixed))

;; ------------------------------------

;; LSP
;; ------------------------------------
;; LSP client
(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :bind (:map lsp-mode-map
	 ("TAB" . completion-at-point))
  :custom
  (lsp-auto-guess-root nil)
  (lsp-prefer-flymake nil) ; Use flycheck instead of flymake
  (lsp-keymap-prefix "C-c l")
  (lsp-headerline-breadcrumb-segments '(path-up-to-project file symbols))
  (lsp-headerline-breadcrumb-mode))

;; Ui for lsp
(use-package lsp-ui
  :after lsp-mode
  :hook (lsp-mode . lsp-ui-mode)
  :custom
  (lsp-ui-doc-enable nil)
  (lsp-ui-sideline-enable t)
  (lsp-ui-sideline-show-hover t)
  (lsp-ui-sideline-show-code-actions nil)
  :config
  ;; WORKAROUND Hide mode-line of the lsp-ui-imenu buffer
  ;; https://github.com/emacs-lsp/lsp-ui/issues/243
  (defadvice lsp-ui-imenu (after hide-lsp-ui-imenu-mode-line activate)
    (setq mode-line-format nil)))

;; (use-package eglot
;;   :commands eglot
;;   :config
;;   (add-hook 'c-mode-common-hook 'eglot)
;;   (add-to-list 'eglot-server-programs
;; 	       '(c-mode . ("clangd"))))

;; Debugger
(use-package dap-mode
  :commands dap-debug
  :init
  (setq dap-auto-configure-features '(sessions locals controls tooltip))
  :bind
  (:map dap-mode-map
   (("<f5>" . dap-debug)
    ("<f8>" . dap-continue)
    ("<f9>" . dap-next)
    ("<f11>" . dap-step-in)
    ("<f10>" . dap-step-out)
    ("<f2>" . dap-breakpoint-toggle))))

;; ------------------------------------

;; Org Stuff
;; ------------------------------------

;; Org Mode
(use-package org
  ;; :straight (:type built-in)
  :bind (:map global-map
	 ("C-c l" . org-store-link)
	 ("C-c a" . org-todo-list)
	 ("C-c c" . org-capture)
	 :map global-map
	 ("M-H" . org-shiftleft)
	 ("M-J" . org-shiftdown)
	 ("M-K" . org-shiftup)
	 ("M-L" . org-shiftright)
	 ("M-h" . org-metaleft)
	 ("M-j" . org-metadown)
	 ("M-k" . org-metaup)
	 ("M-l" . org-metaright)
	 ("C-c l" . org-store-link)
	 ("C-c a" . org-todo-list))
  :hook ((ediff-prepare-buffer . outline-show-all)
	 ((org-capture-mode org-src-mode) . my/discard-history))
  :commands (org-capture org-agenda)
  :custom
  (org-ellipsis " ▼")
  (org-startup-with-inline-images nil)
  (org-log-done 'time)
  (org-journal-date-format "%B %d, %Y (%A) ")
  (org-journal-file-format "%Y-%m-%d.org")
  (org-hide-emphasis-markers t)
  (org-link-abbrev-alist    ; This overwrites the default Doom org-link-abbrev-list
   '(("google" . "http://www.google.com/search?q=")
     ("arch-wiki" . "https://wiki.archlinux.org/index.php/")
     ("ddg" . "https://duckduckgo.com/?q=")
     ("wiki" . "https://en.wikipedia.org/wiki/")))
  (org-todo-keywords
   '((sequence
      "TODO(t)"
      "BUG(b)"
      "WAIT(w)"
      "|"                ; The pipe necessary to separate "active" states and "inactive" states
      "DONE(d)"
      "CANCELLED(c)" )))
  (org-hide-leading-stars t)
  (org-directory (let ((dir (file-name-as-directory (expand-file-name "org" user-emacs-directory))))
		   (make-directory dir :parents)
		   dir))
  (org-default-notes-file (expand-file-name "notes.org" org-directory))
  (org-capture-templates
   `(("t" "Tasks / Projects")
     ("tt" "Task" entry (file+olp+datetree "tasks.org")
      "* TODO %?\n  %U\n  %a\n  %i" :empty-lines 1)

     ("j" "Journal Entries")
     ("jj" "Journal" entry (file+olp+datetree "journal.org")
      "\n* %<%I:%M %p> - Journal :journal:\n\n%?\n\n"
      :clock-in :clock-resume
      :empty-lines 1)
     ("jm" "Meeting" entry
      (file+olp+datetree "meetings.org")
      "* %<%I:%M %p> - %a :meetings:\n\n%?\n\n"
      :clock-in :clock-resume
      :empty-lines 1)))
  :config
  ;; add plantuml to org sources
  (add-to-list 'org-src-lang-modes '("plantuml" . plantuml))
  (when (not (version<= org-version "9.1.9"))
    (use-package org-tempo
      :straight nil
      :config
      ;; add source templates
      (add-to-list 'org-structure-template-alist '("sh"  . "src shell"))
      (add-to-list 'org-structure-template-alist '("el"  . "src emacs-lisp"))
      (add-to-list 'org-structure-template-alist '("py"  . "src python"))
      (add-to-list 'org-structure-template-alist '("cpp"   . "src cpp"))
      (add-to-list 'org-structure-template-alist '("go"  . "src go"))
      ))

  ;; change header size on different levels
  (dolist (face '((org-level-1 . 1.2)
		  (org-level-2 . 1.1)
		  (org-level-3 . 1.05)
		  (org-level-4 . 1.0)
		  (org-level-5 . 1.1)
		  (org-level-6 . 1.1)
		  (org-level-7 . 1.1)
		  (org-level-8 . 1.1)))
    (set-face-attribute (car face) nil :height (cdr face)))

  ;; Save Org buffers after refiling!
  (advice-add 'org-refile :after 'org-save-all-org-buffers)

  (defun my/discard-history ()
    "Discard undo history of org src and capture blocks."
    (setq buffer-undo-list nil)
    (set-buffer-modified-p nil))
  (defun my/org-babel-tangle-dont-ask ()
    ;; Dynamic scoping to the rescue
    (let ((org-confirm-babel-evaluate nil))
      (org-babel-tangle)))
  (defun my/org-babel-tangle-async (file)
    "Invoke `org-babel-tangle-file' asynchronously."
    (message "Tangling %s..." (buffer-file-name))
    (async-start
     (let ((args (list file)))
       `(lambda ()
	  (require 'org)
	  (let ((start-time (current-time)))
	    (apply #'org-babel-tangle-file ',args)
	    (format "%.2f" (float-time (time-since start-time))))))
     (let ((message-string (format "Tangling %S completed after " file)))
       `(lambda (tangle-time)
	  (message (concat ,message-string
			   (format "%s seconds" tangle-time)))))))

  (defun my/org-babel-tangle-current-buffer-async ()
    "Tangle current buffer asynchronously."
    (my/org-babel-tangle-async (buffer-file-name)))
  (add-hook 'org-mode-hook (lambda () (add-hook 'after-save-hook #'my/org-babel-tangle-dont-ask))))

;; Show bullets in a nice way
(use-package org-bullets
  :after org
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))

;; Org Margins
(use-package visual-fill-column
  :after org
  :config
  (defun my/org-mode-visual-fill()
    "Set some margins in org documents"
    (setq visual-fill-column-width 100
	  visual-fill-column-center-text t)
    (visual-fill-column-mode 1))
  :hook (org-mode . my/org-mode-visual-fill))

;; Table of contents using `:toc:`
(use-package toc-org
  :after org
  :hook
  (org-mode . toc-org-mode)
  (markdown-mode . toc-org-mode))

;; Keep text indented with headlines
(use-package org-indent
  :straight nil
  :defer t)

;; ------------------------------------

;; Programming Languages
;; ------------------------------------
;; C source files
(use-package prog-mode
  :straight nil
  :hook (prog-mode . hl-line-mode))

;; Python
(use-package pyvenv
  :mode ("\\.py\\'" . python-mode)
  :config
  (setq pyvenv-workon "emacs")  ; Default venv
  (pyvenv-tracking-mode 1))  ; Automatically use pyvenv-workon via dir-locals

;; C / C++
(use-package cc-mode
  :straight nil
  :mode (("\\.c\\'" . c-mode)
	 ("\\.cpp\\'" . c-mode)
	 ("\\.h\\'" . c-mode)
	 ("\\.hpp\\'" . c-mode))
  :defines (lsp-clients-clangd-args)
  :config (defun my/cc-mode-setup ()
	    (c-set-offset 'case-label '+)
	    (setq c-basic-offset 4
		  c-default-style "linux"
		  indent-tabs-mode t
		  comment-start "//"
		  comment-end ""
		  tab-width 4))
  (with-eval-after-load 'lsp-mode
    (setq lsp-clients-clangd-args
	  '("-j=2"
	    "--background-index"
	    "--clang-tidy"
	    "--completion-style=bundled"
	    "--pch-storage=memory"
	    "--suggest-missing-includes")))
  :hook ((c-mode-common . my/cc-mode-setup)))

;; Format C code with Clang Format
(use-package clang-format
  :if (executable-find "clang")
  :after cc-mode
  :bind (:map c-mode-base-map
	 ("C-c C-M-f" . clang-format-buffer)))

;; Rust syntax highlighting
(use-package rust-mode
  :mode ("\\.rs\\'" . rust-mode)
  :commands (rust-format-buffer)
  :bind (:map rust-mode-map
	 ("C-c C-M-f" . rust-format-buffer)))

;; Rust - Use racer when RLS in not available (ex. Org mode)
(use-package racer
  :if (executable-find "racer")
  :hook (racer-mode . eldoc-mode)
  :init (defun org-babel-edit-prep:rust (&optional _babel-info)
	  "Run racer mode for Org Babel."
	  (racer-mode 1)))

;; Rust - Cargo integration
(use-package cargo
  :if (executable-find "cargo")
  :hook ((rust-mode toml-mode) . cargo-minor-mode))

;; Syntax highlighting of TOML files
(use-package toml-mode
  :mode ("\\.toml\\'" . toml-mode))

;; Syntax highlighting for vimscript
(use-package vimrc-mode
  :mode ("\\.vim\\(rc\\)?\\'" . vimrc-mode))

;; Lisp and ELisp mode
(use-package elisp-mode
  :straight nil
  :commands (my/emacs-lisp-indent-function)
  :hook ((emacs-lisp-mode . eldoc-mode)
	 (emacs-lisp-mode . (lambda ()
			      (setq-local lisp-indent-function
					  #'my/emacs-lisp-indent-function))))
  :config
  (defun my/emacs-lisp-indent-function (indent-point state)
    "A replacement for `lisp-indent-function'.
Indents plists more sensibly. Adapted from DOOM Emacs:
https://github.com/hlissner/doom-emacs/commit/a634e2c8125ed692bb76b2105625fe902b637998"
    (let ((normal-indent (current-column))
	  (orig-point (point)))
      (goto-char (1+ (elt state 1)))
      (parse-partial-sexp (point) calculate-lisp-indent-last-sexp 0 t)
      (cond ((and (elt state 2)
		  (or (not (looking-at-p "\\sw\\|\\s_"))
		      (eq (char-after) ?:)))
	     (unless (> (save-excursion (forward-line 1) (point))
			calculate-lisp-indent-last-sexp)
	       (goto-char calculate-lisp-indent-last-sexp)
	       (beginning-of-line)
	       (parse-partial-sexp (point) calculate-lisp-indent-last-sexp 0 t))
	     (backward-prefix-chars)
	     (current-column))
	    ((and (save-excursion
		    (goto-char indent-point)
		    (skip-syntax-forward " ")
		    (not (eq (char-after) ?:)))
		  (save-excursion
		    (goto-char orig-point)
		    (eq (char-after) ?:)))
	     (save-excursion
	       (goto-char (+ 2 (elt state 1)))
	       (current-column)))
	    ((let* ((function (buffer-substring (point) (progn (forward-sexp 1) (point))))
		    (method (or (function-get (intern-soft function) 'lisp-indent-function)
				(get (intern-soft function) 'lisp-indent-hook))))
	       (cond ((or (eq method 'defun)
			  (and (null method)
			       (> (length function) 3)
			       (string-match-p "\\`def" function)))
		      (lisp-indent-defform state indent-point))
		     ((integerp method)
		      (lisp-indent-specform method state
					    indent-point normal-indent))
		     (method
		      (funcall method indent-point state))))))))
  (defun org-babel-edit-prep:emacs-lisp (&optional _babel-info)
    "Setup Emacs Lisp buffer for Org Babel."
    (setq lexical-binding t)
    (setq-local flycheck-disabled-checkers '(emacs-lisp-checkdoc))))

;; Yaml support
(use-package yaml-mode
  :mode ("\\.yaml\\'" . yaml-mode)
  :custom (yaml-indent-offset 4))

;; Yaml linter with flycheck
(use-package flycheck-yamllint
  :if (executable-find "yamllint")
  :hook ((yaml-mode . flycheck-yamllint-setup)
	 (yaml-mode . flycheck-mode)))

;; Shell scripting
(use-package sh-script
  :straight nil
  :hook (sh-mode . flycheck-mode))

;; Lua mode
(use-package lua-mode
  :mode ("\\.lua\\'" . lua-mode))

;; CSS mode
(use-package css-mode
  :straight nil
  :mode ("\\.css\\'" . css-mode)
  :custom
  (css-indent-offset 2))

;; JSON mode
(use-package json-mode
  :mode ("\\.json\\'" . json-mode)
  :hook (json-mode . flycheck-mode)
  :custom (js-indent-level 2))

;; Plantuml mode
(use-package plantuml-mode
  :mode (("\\.plantuml\\'" . plantuml-mode)
         ("\\.pu\\'" . plantuml-mode))
  :config
  (add-to-list 'auto-mode-alist
	       '("\\.plantuml\\'" . plantuml-mode)))
;; ------------------------------------


;; Containers
;; ------------------------------------

;; Kubernetes
(use-package kubel-evil
  :commands kubel)

;; Docker
(use-package docker
  :commands docker)

;; ------------------------------------

;; Tools
;; ------------------------------------

;; Nerdtree like side bar
(use-package neotree)

(use-package disk-usage
  :commands (disk-usage))

;; RSS feed
(use-package elfeed
  :commands (elfeed)
  :custom
  (elfeed-feeds '(
		  ;;dev.to
		  "http://dev.to/feed"

		  ;;reddit
		  "http://reddit.com/r/cpp/.rss"
		  "http://reddit.com/r/emacs/.rss"
		  "http://reddit.com/r/golang/.rss"
		  "http://reddit.com/r/rust/.rss"
		  "http://reddit.com/r/bindingofisaac/.rss"

		  ;;hackernews
		  "https://news.ycombinator.com/rss")))

(use-package transmission
  :bind (:map transmission-mode-map
	 ("C-c a" . transmission-add)
	 ("C-c d" . transmission-delete)
	 ("C-c t" . transmission-toggle)
	 ("C-c f" . transmission-files))
  :config
  (setq transmission-refresh-modes '(transmission-mode))
  :commands (transmission))

;; Eshell
(setq eshell-highlight-prompt t
      eshell-history-size         10000
      eshell-buffer-maximum-lines 10000
      eshell-hist-ignoredups t)

(use-package eshell-toggle
  :bind ("C-M-'" . eshell-toggle)
  :custom
  (eshell-toggle-size-fraction 3)
  (eshell-toggle-use-projectile-root t)
  (eshell-toggle-run-command nil))

(use-package esh-autosuggest
  :after eshell-toggle
  :hook eshell) ;company for eshell

(global-set-key (kbd "C-`") 'eshell-toggle)

;; ------------------------------------

(use-package projectile
  :diminish projectile-mode
  :config
  (projectile-mode +1)
  (setq projectile-git-submodule-command nil)
  (setq projectile-indexing-method 'alien))

;; Search engines
(use-package engine-mode
  :straight (:branch "main")
  :defer t
  :config
  (defengine archwiki
    "https://wiki.archlinux.org/index.php?title=Special:Search&search=%s")
  (defengine cppreference
    "https://en.cppreference.com/mwiki/index.php?search=%s")
  (defengine cmake
    "https://cmake.org/cmake/help/latest/search.html?q=%s&check_keywords=yes&area=default")
  (defengine google
    "https://google.com/search?q=%s")
  (defengine youtube
    "https://www.youtube.com/results?search_query=%s")
  (defengine dockerhub
    "https://hub.docker.com/search?q=%s&type=image")
  (defengine github
    "https://github.com/search?q=%s")
  (defengine rustdoc
    "https://doc.rust-lang.org/rustdoc/what-is-rustdoc.html?search=%s")
  (defengine wikipedia
    "https://en.wikipedia.org/wiki/%s"))

;; Recent files
(use-package recentf
  :straight nil
  :hook (after-init . recentf-mode)
  :custom
  (recentf-max-saved-items 200)
  (recentf-exclude '((expand-file-name package-user-dir)
		     ".cache"
		     ".cask"
		     ".elfeed"
		     "bookmarks"
		     "cache"
		     "ido.*"
		     "persp-confs"
		     "recentf"
		     "undo-tree-hist"
		     "url"
		     "COMMIT_EDITMSG\\'")))

;; Auto focus help window
(use-package help
  :straight nil
  :custom (help-window-select t))

;; Better help override bindings
(use-package helpful
  :bind (:map global-map
  ("C-h C-k" . helpful-at-point))
  ([remap describe-function] . helpful-function)
  ([remap describe-symbol] . helpful-symbol)
  ([remap describe-variable] . helpful-variable)
  ([remap describe-command] . helpful-command)
  ([remap describe-key] . helpful-key))

;; Buitin file manager
(use-package dired
  :straight nil
  :bind (:map dired-mode-map
	 ("-" . dired-up-directory)
	 ("<backspace>" . dired-up-directory))
  :custom ((dired-listing-switches "-aghoA --group-directories-first"))
  :config
  (setq dired-omit-files
	(rx (or (seq bol (? ".") "#")
		(seq bol "." eol)
		(seq bol ".." eol)))))

;; Interface to Git
(use-package magit
  :hook ((git-commit-mode . flyspell-mode))
  :bind (:map global-map
  ("C-x g" . magit-status))
  :custom
  (magit-ediff-dwim-show-on-hunks t)
  (magit-diff-refine-ignore-whitespace nil)
  (magit-diff-refine-hunk 'all)
  (magit-blame-styles
   '((headings
      (heading-format . "%-20a %C %s\n"))
     (margin
      (margin-format " %s%f" " %C %a" " %H")
      (margin-width . 42)
      (margin-face . magit-blame-margin)
      (margin-body-face magit-blame-dimmed))
     (highlight
      (highlight-face . magit-blame-highlight))
     (lines
      (show-lines . nil)
      (show-message . t))))
  :config
  (advice-add 'magit-set-header-line-format :override #'ignore))

;; Show TODOs in magit
(use-package magit-todos
  :after magit
  :config
  (let ((inhibit-message t))
    (magit-todos-mode 1))
  (transient-append-suffix 'magit-status-jump '(0 0 -1)
    '("T " "Todos" magit-todos-jump-to-todos)))


;; Keybindings
;; ------------------------------------
;; Using general for key describtions

;; Use escape to close
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

(use-package general
  :config
  (general-create-definer my/leader-keys
    :prefix "SPC")

  (my/leader-keys
    :states 'normal
    :keymaps 'override

    ;; Evilmotion
    "<SPC>"  '(:ignore t :which-key "Evilmotion")
    "<SPC>j" '(evilem-motion-next-line :which-key "Sneak down")
    "<SPC>k" '(evilem-motion-previous-line :which-key "Sneak up")

    ;; Apps
    "a"  '(:ignore t :which-key "Apps")
    "gd" '(docker :which-key "Docker")
    "gc" '(docker-compose :which-key "Docker compose")
    "gk" '(kubel :which-key "Kubernetes")
    "an" '(elfeed :which-key "Feeds")

    ;; Buffers & windows
    "b"  '(:ignore t :which-key "Buffer")
    "bs" '(switch-to-buffer :which-key "Switch buffer")
    "bi" '(my/indent-buffer :which-key "Indent buffer")
    "be" '(ediff-buffers :which-key "Difference")

    "e" '(neotree-toggle :which-key "Explorer")

    ;; Files
    "f"  '(:ignore t :which-key "Files")
    "fd" '(dired-jump :which-key "Dired")
    "ff" '(find-file :which-key "Find file")
    "fj" '(find-journal :which-key "Journal")
    "fr" '(consult-buffer :which-key "Recent files")

    ;; Git
    "g"  '(:ignore t :which-key "Git")
    "gs" '(magit-status :which-key "Magit")
    "gm" '(magit-blame-addition :which-key "Blame")

    ;; Org
    "o"  '(:ignore t :which-key "Org")
    "oa" '(org-agenda :which-key "Agenda")
    "oc" '(org-capture :which-key "Capture")
    "ot" '(org-todo-list :which-key "Todo")

    ;; Quiting
    "q"  '(:ignore t :which-key "Quit")
    "qq" '(kill-buffer-and-window :which-key "Quit now")

    ;; Search
    "s"  '(:ignore t :which-key "Search")
    "si"  '(:ignore t :which-key "Internet")
    "sia" '(engine/search-archwiki :which-key "Archwiki")
    "sic" '(engine/search-cppreference :which-key "Cpp")
    "sib" '(engine/search-cmake :which-key "Cmake")
    "siy" '(engine/search-youtube :which-key "Youtube")
    "sid" '(engine/search-dockerhub :which-key "Dockerhub")
    "sir" '(engine/search-rustdoc :which-key "Rustdocs")
    "siw" '(engine/search-wikipedia :which-key "Wikipedia")
    "sig" '(engine/search-google :which-key "Google")
    "siG" '(engine/search-github :which-key "Github")
    "sM" '(consult-man :which-key "Manpages")
    "sc" '(consult-theme :which-key "Colorscheme")
    "sR" '(consult-register :which-key "Registers")
    "st" '(consult-grep :which-key "Text")


    "w"  '(:ignore t :which-key "Windows")
    "ww" '(tear-off-window :which-key "Tear off")
    "wh" '(windmove-swap-states-left :which-key "Swap left")
    "wj" '(windmove-swap-states-down :which-key "Swap down")
    "wk" '(windmove-swap-states-up :which-key "Swap up")
    "wl" '(windmove-swap-states-right :which-key "Swap right"))
  )

;; Mode Keybindings
(general-define-key
 :states 'normal
 :keymaps 'emacs-lisp-mode-map
 :prefix "SPC"
 :global-prefix "C-SPC"
 "k" '(eval-buffer :which-key "Eval-buffer")) ;

(general-def 'normal prog-mode-map
  "K" 'lsp-describe-thing-at-point)

(general-def 'normal emacs-lisp-mode-map
  "K" 'describe-thing-at-point)

(general-def 'normal 'compilation-mode-map
  "C-n" 'compilation-next-error
  "C-p" 'compilation-previous-error)

(general-def 'normal 'global-map
  "Q" 'insert-output-of-executed-line
  "gcc" 'evilnc-comment-or-uncomment-lines)

(general-def 'visual 'global-map
  "S" 'evil-surround-region
  "gc" 'evilnc-comment-or-uncomment-lines)

(general-def 'normal 'lsp-mode-map
  "gr" 'lsp-find-references)

;; ------------------------------------

;; Enable server
(use-package server
  :init
  (progn
    (when (equal window-system 'w32)
      (setq server-use-tcp t)))
  :config
  (unless (server-running-p)
    (server-start)))

(provide 'init)
;;; init.el ends here
