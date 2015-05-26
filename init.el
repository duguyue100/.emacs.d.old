;; Author : Hu Yuhuang
;; Email  : duguyue100@gmail.com

;; This file is my general configuration of my emacs.
;; And hopefully the last time

;;; ------ General Settings ------ ;;;

; set PATH

(getenv "PATH")
 (setenv "PATH"
(concat
 "/usr/texbin:/usr/local/bin" ":"

 (getenv "PATH")))

; load path management

(add-to-list 'load-path "~/.emacs.d/site-lisp")
(add-to-list 'load-path "~/.emacs.d/site-lisp/color-theme") ; load color theme
(add-to-list 'load-path "~/.emacs.d/site-lisp/markdown-mode")
(add-to-list 'load-path "~/.emacs.d/site-lisp/Emacs-langtool") ; load for grammer check
(add-to-list 'load-path "~/.emacs.d/site-lisp/writegood-mode") ; write good mode
(add-to-list 'load-path "~/.emacs.d/site-lisp/exec-path-from-shell")

; set up MELPA

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)

; set up shell support

(require 'exec-path-from-shell)
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

; start at full screen and turn of toolbar and menu bar

(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq frame-resize-pixelwise t)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(exec-path
   (quote
    ("/opt/local/bin" "/usr/bin" "/bin" "/usr/sbin" "/sbin" "/Applications/MacPorts/Emacs.app/Contents/MacOS/libexec" "/Applications/MacPorts/Emacs.app/Contents/MacOS/bin" "/usr/textbin")))
 '(initial-frame-alist (quote ((fullscreen . maximized)))))

; set keys setting

(if (eq system-type 'darwin)
    ;; set keys for Apple keyboard, for emacs in OS X
    ;(setq mac-command-modifier 'meta) ; make cmd key do Meta
    (setq mac-option-modifier 'meta) ; make opt key do Super
    (setq mac-control-modifier 'control) ; make Control key do Control
    ;(setq ns-function-modifier 'hyper)  ; make Fn key do Hyper
)

(global-set-key (kbd "RET") 'newline-and-indent)
(global-set-key (kbd "C-;") 'comment-or-uncomment-region)
(global-set-key (kbd "M-/") 'hippie-expand)
(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)

; font configuration

(if (eq system-type 'gnu/linux)
    (add-to-list 'default-frame-alist '(font .  "Courier 10 Pitch-15" ))
)

(if (eq system-type 'darwin)
    (add-to-list 'default-frame-alist '(font .  "Courier-15" ))
)

; marking text

(delete-selection-mode t)
(transient-mark-mode t)
(setq x-select-enable-clipboard t)

; setting tabs

(setq tab-width 2
      indent-tabs-mode nil)

; set electric-pair-mode

(electric-pair-mode 1)

; yes and no simplify

(defalias 'yes-or-no-p 'y-or-n-p)

; setting aspell for flyspell

(setq flyspell-issue-welcome-flag nil)
(if (eq system-type 'darwin)
    (setq-default ispell-program-name "/opt/local/bin/aspell")
  (setq-default ispell-program-name "/usr/bin/aspell"))
(setq-default ispell-list-command "list")
(global-set-key (kbd "C-c r") 'ispell-word)

;; enable flyspell to all modes
(add-hook 'text-mode-hook 'flyspell-mode)
(add-hook 'prog-mode-hook 'flyspell-prog-mode)

; setup writegood mode

(require 'writegood-mode)
(global-set-key "\C-cg" 'writegood-mode)
(global-set-key "\C-c\C-gg" 'writegood-grade-level)
(global-set-key "\C-c\C-ge" 'writegood-reading-ease)

; choose theme

(require 'color-theme)
(color-theme-initialize)
(load-file "~/.emacs.d/site-lisp/color-theme/themes/color-theme-cobalt.el")
(color-theme-cobalt)

; enable line numbers

(global-linum-mode t)

; grammer check for Mac OS

(require 'langtool)
(setq langtool-language-tool-jar "~/Documents/latexspace/LanguageTool-2.9/languagetool-commandline.jar"
      langtool-mother-tongue "nl"
      langtool-disabled-rules '("WHITESPACE_RULE"
                                "EN_UNPAIRED_BRACKETS"
                                "COMMA_PARENTHESIS_WHITESPACE"
                                "EN_QUOTES"))
(setq langtool-mother-tongue "en")

; set up mac dictionary

(if (eq system-type 'darwin)
    (global-set-key (kbd "C-c d") 'osx-dictionary-search-pointer)
  (global-set-key (kbd "C-c i") 'osx-dictionary-search-input))

;;; ------ Language Settings ------ ;;;

; Python support

(load-file "~/.emacs.d/site-lisp/emacs-for-python/epy-init.el")

; Markdown support

(setq markdown-enable-math t)
(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

(add-hook 'markdown-mode-hook
	  (lambda ()
            (visual-line-mode t)
            (writegood-mode t)
            (flyspell-mode t)))

; Tex setup

;; AucTeX
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)
(add-hook 'LaTeX-mode-hook 'visual-line-mode)
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'writegood-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTeX t)
(setq TeX-PDF-mode t)

(add-hook 'LaTeX-mode-hook
      (lambda()
        (local-set-key [C-tab] 'TeX-complete-symbol)))

;; Use Skim as viewer, enable source <-> PDF sync
;; make latexmk available via C-c C-c
;; Note: SyncTeX is setup via ~/.latexmkrc (see below)
(add-hook 'LaTeX-mode-hook (lambda ()
  (push
    '("latexmk" "latexmk -pdf %s" TeX-run-TeX nil t
      :help "Run latexmk on file")
    TeX-command-list)))

(add-hook 'TeX-mode-hook '(lambda () (setq TeX-command-default "latexmk")))

;; use Skim as default pdf viewer
;; Skim's displayline is used for forward search (from .tex to .pdf)
;; option -b highlights the current line; option -g opens Skim in the background  
(setq TeX-view-program-selection '((output-pdf "PDF Viewer")))
(setq TeX-view-program-list
     '(("PDF Viewer" "/Applications/Skim.app/Contents/SharedSupport/displayline -b -g %n %o %b")))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

; JavaScript support

(add-hook 'js-mode-hook 'js2-minor-mode)
(add-hook 'js2-mode-hook 'ac-js2-mode)

; Lua support

(autoload 'lua-mode "lua-mode" "Lua editing mode." t)
(add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))
(add-to-list 'interpreter-mode-alist '("lua" . lua-mode))
