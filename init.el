;; Author : Hu Yuhuang
;; Email  : duguyue100@gmail.com

;; This file is my general configuration of my emacs.
;; And hopefully the last time

;;; ------ General Settings ------ ;;;

; set PATH

(getenv "PATH")
 (setenv "PATH"
(concat
 "/usr/texbin" ":"

(getenv "PATH")))

; load path management

(add-to-list 'load-path "~/.emacs.d/site-lisp")
(add-to-list 'load-path "~/.emacs.d/site-lisp/color-theme") ; load color theme
(add-to-list 'load-path "~/.emacs.d/site-lisp/markdown-mode")
(add-to-list 'load-path "~/.emacs.d/site-lisp/Emacs-langtool") ; load for grammer check

; start at full screen

(tool-bar-mode -1)
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

; font configuration

(if (eq system-type 'gnu/linux)
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

; grammer check for Mac OS

(require 'langtool)
(setq langtool-language-tool-jar "~/Documents/latexspace/LanguageTool-2.9/languagetool-commandline.jar"
      langtool-mother-tongue "nl"
      langtool-disabled-rules '("WHITESPACE_RULE"
                                "EN_UNPAIRED_BRACKETS"
                                "COMMA_PARENTHESIS_WHITESPACE"
                                "EN_QUOTES"))
(setq langtool-mother-tongue "en")

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
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTeX t)
(setq TeX-PDF-mode t)

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
