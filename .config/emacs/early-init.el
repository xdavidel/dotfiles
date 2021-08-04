;;; early-init.el --- early configurations -*- lexical-binding: t -*-
;;;
;;; Commentary:
;;; Emacs early init file
;;; This file is executed before any graphics (Emacs Version > 27)
;;;
;;; Code:


;; Profile Emacs startup speed
(add-hook 'emacs-startup-hook
	  (lambda ()
	    (message "*** Emacs loaded in %s with %d garbage collections."
		     (format "%.2f seconds"
			     (float-time
			      (time-subtract after-init-time before-init-time)))
		     gcs-done)))

;; Get current garbage collection setting to restore later
(defvar my/gc-cons-threshold gc-cons-threshold)
(defvar my/gc-cons-percentage gc-cons-percentage)
(defvar my/file-name-handler-alist file-name-handler-alist)

(defun fn/defer-garbage-collection ()
  "Defer garbage collection by increasing it's threshold."
  (setq gc-cons-threshold most-positive-fixnum
        gc-cons-percentage 0.6))

(defun fn/restore-garbage-collection ()
  "Defer garbage collection by restoring it's threshold values."
  (run-at-time
   1 nil (lambda () (setq gc-cons-threshold my/gc-cons-threshold
			  gc-cons-percentage my/gc-cons-percentage))))

;; Unset `file-name-handler-alist` temporarily
(setq file-name-handler-alist nil)

;; Restore GC and `file-name-handler-alist` after init
(add-hook 'emacs-startup-hook
	  (lambda ()
	    (setq file-name-handler-alist my/file-name-handler-alist)
	    (funcall 'fn/restore-garbage-collection)))

;; raise gc-cons-threshold while the minibuffer is active
(add-hook 'minibuffer-setup-hook #'fn/defer-garbage-collection)
(add-hook 'minibuffer-exit-hook #'fn/restore-garbage-collection)

;; Disable UI elements as early as possible
(setq initial-frame-alist '((tool-bar-lines . 0)
                            (bottom-divider-width . 0)
                            (right-divider-width . 1))
      default-frame-alist initial-frame-alist)

;; Disable toolbar and scrollbar if not void
(when (fboundp 'scroll-bar-mode)
      (scroll-bar-mode -1))
(when (fboundp 'tool-bar-mode)
      (tool-bar-mode -1))

;; OS consts
(defconst IS-MAC     (eq system-type 'darwin))
(defconst IS-LINUX   (eq system-type 'gnu/linux))
(defconst IS-WINDOWS (memq system-type '(cygwin windows-nt ms-dos)))
(defconst IS-BSD     (or IS-MAC (eq system-type 'berkeley-unix)))

;; Windows doesn't always has HOME env.
(when (and IS-WINDOWS (null (getenv-internal "HOME")))
  (setenv "HOME" (getenv "USERPROFILE"))
  (setq abbreviated-home-dir nil))

;; Make UTF-8 the default coding system
(set-language-environment "UTF-8")
(unless IS-WINDOWS
  (setq selection-coding-system 'utf-8))

;; Don't render cursors or regions in non-focused windows.
(setq-default cursor-in-non-selected-windows nil)
(setq highlight-nonselected-windows nil)

;; Rapid scrolling over unfontified regions.
(setq fast-but-imprecise-scrolling t)

;; Font compacting can be terribly expensive.
(setq inhibit-compacting-font-caches t
      redisplay-skip-fontification-on-input t)

;; Disable warnings from legacy advice system.
(setq ad-redefinition-action 'accept)

;; Inhibit resizing frame.
;; Setting x-gtk-resize-child-frames variable to resize-mode fixes issue with GNOME Shell.
(setq frame-inhibit-implied-resize t
      x-gtk-resize-child-frames 'resize-mode)

;; maybe improve performance on windows
(when IS-WINDOWS
  (setq w32-get-true-file-attributes nil   ; decrease file IO workload
        w32-pipe-read-delay 0              ; faster IPC
        w32-pipe-buffer-size (* 64 1024))) ; read more at a time (was 4K)

;; Remove cmdlines options that aren't relevant to our current OS.
(unless IS-MAC   (setq command-line-ns-option-alist nil))
(unless IS-LINUX (setq command-line-x-option-alist nil))

;; gccmacs?
(defvar comp-deferred-compilation t)

;; Increase how much is read from processes in a single chunk
(setq read-process-output-max (* 64 1024))  ; 64kb

;; Disable truncated lines arrows.
(setq-default fringe-indicator-alist
              (assq-delete-all 'truncation fringe-indicator-alist))

;; Use Straight el
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; Install use-package
(straight-use-package 'use-package)

;; Makes :straight t by default
(setq straight-use-package-by-default t)

;; Disable package.el initialization at startup:
(setq package-enable-at-startup nil)

(provide 'early-init)
;;; early-init.el ends here
