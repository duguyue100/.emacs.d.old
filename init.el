;; Author : Hu Yuhuang
;; Email  : duguyue100@gmail.com

;; This file is my general configuration of my emacs.
;; And hopefully the last time

;;; ------ General Settings ------ ;;;

; load path management

(add-to-list 'load-path "~/.emacs.d/site-lisp")
(add-to-list 'load-path "~/.emacs.d/site-lisp/color-theme")

; start at full screen

(custom-set-variables
 '(initial-frame-alist (quote ((fullscreen . maximized)))))

; font configuration

; (add-to-list 'default-frame-alist '(font .  "Courier 10 Pitch-14" ))

; choose theme

(require 'color-theme)
(color-theme-initialize)
(load-file "~/.emacs.d/site-lisp/color-theme/themes/color-theme-cobalt.el")
(color-theme-cobalt)
