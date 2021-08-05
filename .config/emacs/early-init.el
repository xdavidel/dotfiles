;;; early-init.el --- early configurations -*- lexical-binding: t -*-
;;;
;;; Commentary:
;;; Emacs early init file
;;; This file is executed before any graphics (Emacs Version > 27)
;;;
;;; Code:

;; Disable package.el initialization at startup:
(setq package-enable-at-startup nil)
(advice-add 'package--ensure-init-file :override 'ignore)

;; inhibit resizing frame
(setq frame-inhibit-implied-resize t)

;; prevent glimpse of UI been disabled
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)

(setq gc-cons-threshold most-positive-fixnum)

;; Disable toolbar and scrollbar if not void
(when (fboundp 'scroll-bar-mode)
      (scroll-bar-mode -1))
(when (fboundp 'tool-bar-mode)
      (tool-bar-mode -1))

;; Disable truncated lines arrows.
(setq-default fringe-indicator-alist
              (assq-delete-all 'truncation fringe-indicator-alist))

(provide 'early-init)
;;; early-init.el ends here
