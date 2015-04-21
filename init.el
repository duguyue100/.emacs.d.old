;; Author : Hu Yuhuang
;; Email  : duguyue100@gmail.com

;; This file is my general configuration of my emacs.
;; And hopefully the last time

;;; ------ General Settings ------ ;;;

; load path management

(add-to-list 'load-path "~/.emacs.d/site-lisp")
(add-to-list 'load-path "~/.emacs.d/site-lisp/color-theme") ; load color theme
(add-to-list 'load-path "~/.emacs.d/site-lisp/markdown-mode")

; start at full screen

(tool-bar-mode -1)
(setq frame-resize-pixelwise t)
(custom-set-variables
 '(initial-frame-alist (quote ((fullscreen . maximized)))))

; font configuration

(if (eq system-type "gnu/linux")
    (add-to-list 'default-frame-alist '(font .  "Courier 10 Pitch-15" ))
)

(if (eq system-type 'darwin)
    (add-to-list 'default-frame-alist '(font .  "Courier-15" ))
)

; choose theme

(require 'color-theme)
(color-theme-initialize)
(load-file "~/.emacs.d/site-lisp/color-theme/themes/color-theme-cobalt.el")
(color-theme-cobalt)

; enable line numbers

(global-linum-mode t)

;;; ------ Language Settings ------ ;;;

; Python support

(load-file "~/.emacs.d/site-lisp/emacs-for-python/epy-init.el")

; Markdown support

(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
