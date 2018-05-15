(use-package powerline
  :ensure t)

(use-package spaceline
  :ensure t
  :config
  (require 'spaceline-config)
  (setq powerline-default-separator (quote arrow))
  (spaceline-emacs-theme))

(use-package gruvbox-theme
    :ensure t)
;  (use-package dracula-theme
;    :ensure t)
    (use-package doom-themes
    :ensure t)
  (load-theme 'doom-tomorrow-night t)

(set-default-font "Hasklug Nerd Font 13" nil t)

(menu-bar-mode -1)
(tool-bar-mode -1)
(setq ns-use-srgb-colorspace t)
(add-to-list 'load-path' "~/.emacs.d/lisp/")
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)
(add-hook 'prog-mode-hook 'linum-mode)

(setq make-backup-files nil
    auto-save-default nil
    visible-bell nil)
; Highlight tabs and trailing whitespace everywhere
(setq whitespace-style '(face trailing tabs))
(custom-set-faces
'(whitespace-tab ((t (:background "red")))))
(global-whitespace-mode)

(use-package better-defaults
  :ensure t)

(use-package org)
(use-package org-noter
  :ensure t)

(global-unset-key (kbd "C-z"))

(use-package flycheck
  :ensure t)

(use-package restart-emacs
  :ensure t)

(use-package swiper
:ensure t)

(use-package counsel
:ensure t)

(use-package ivy
  :ensure t)
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "<f6>") 'ivy-resume)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "<f1> f") 'counsel-describe-function)
(global-set-key (kbd "<f1> v") 'counsel-describe-variable)
(global-set-key (kbd "<f1> l") 'counsel-find-library)
(global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
(global-set-key (kbd "<f2> u") 'counsel-unicode-char)
(global-set-key (kbd "C-c g") 'counsel-git)
(global-set-key (kbd "C-c j") 'counsel-git-grep)
(global-set-key (kbd "C-c k") 'counsel-ag)
(global-set-key (kbd "C-x l") 'counsel-locate)
(global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
(define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history)

(use-package which-key
:ensure t)
(which-key-mode)

(use-package vi-tilde-fringe
:ensure t)
(add-hook 'prog-mode-hook 'vi-tilde-fringe-mode)

(use-package toc-org
:ensure t)
(add-hook 'org-mode-hook 'toc-org-enable)

(use-package smartparens
:ensure t)
(add-hook 'prog-mode-hook 'smartparens-mode)

(use-package rainbow-delimiters
:ensure t)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

(use-package popwin
:ensure t)
;(popwin-mode 1)

(use-package org-bullets
:ensure t)
(add-hook 'org-mode-hook 'org-bullets-mode)

(use-package mwim
:ensure t)
(global-set-key (kbd "C-a") 'mwim-beginning)
(global-set-key (kbd "C-e") 'mwim-end)

(use-package move-text
:ensure t)
(move-text-default-bindings)

(use-package link-hint
:ensure t 
:bind
("C-c l o" . link-hint-open-link)
("C-c l c" . link-hint-copy-link))

(use-package ivy-hydra
:ensure t)

(use-package iedit
:ensure t)

(use-package hungry-delete
:ensure t)
(global-hungry-delete-mode)

(use-package hl-todo
:ensure t)
(add-hook 'prog-mode-hook 'hl-todo-mode)

(use-package highlight-parentheses
:ensure t)
(global-highlight-parentheses-mode)

(use-package highlight-numbers
:ensure t)
(add-hook 'prog-mode-hook 'highlight-numbers-mode)

(use-package golden-ratio
:ensure t)
(golden-ratio-mode 1)
(setq golden-ratio-adjust-factor .8
      golden-ratio-wide-adjust-factor .8)

(use-package clean-aindent-mode
:ensure t)
(defun my-pkg-init()
  (electric-indent-mode -1)  ; no electric indent, auto-indent is sufficient
  (clean-aindent-mode t)
  (setq clean-aindent-is-simple-indent t)
  (define-key global-map (kbd "RET") 'newline-and-indent))
(add-hook 'after-init-hook 'my-pkg-init)

(use-package column-enforce-mode
:ensure t)
(add-hook 'prog-mode-hook 'column-enforce-mode)

(use-package anzu
:ensure t)
(global-anzu-mode +1)

(use-package fill-column-indicator
:ensure t)

(use-package diminish
:ensure t)
(diminish 'anzu-mode)
(diminish 'ivy-mode)
(diminish 'golden-ratio-mode)
(diminish 'which-key-mode)
(diminish 'highlight-parentheses-mode)
(diminish 'flycheck-mode)
(diminish 'hungry-delete-mode)
(diminish 'column-enforce-mode)
(diminish 'smartparens-mode)
(diminish 'vi-tilde-fringe-mode)
(diminish 'global-whitespace-mode)
(diminish 'subword-mode)

(use-package ace-window
:ensure t)
(global-set-key (kbd "M-o") 'ace-window)

(use-package haskell-mode
:ensure t)
;(use-package intero
;:ensure t)
;(add-hook 'haskell-mode-hook 'intero-mode)
(setq haskell-font-lock-symbols t)

(use-package exec-path-from-shell
:ensure t)
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

(defun pretty-lambdas-haskell ()
  (font-lock-add-keywords
   nil `((,(concat "\\(" (regexp-quote "\\") "\\)")
          (0 (progn (compose-region (match-beginning 1) (match-end 1)
                                    ,(make-char 'greek-iso8859-7 107))
                    nil))))))

(add-hook 'haskell-mode-hook 'pretty-lambdas-haskell)

(defun font-existsp (font)
  "Check to see if the named FONT is available."
  (if (null (x-list-fonts font))
      nil t))

(require 'cl)
(defun font-avail (fonts)
  "Finds the available fonts."
  (remove-if-not 'font-existsp fonts))

(defvar font-preferences
      '("PragmataPro"
        "Iosevka"
        "Hasklug Nerd Font"
        "Inconsolata"
        "DejaVu Sans Mono"
        "Bitstream Vera Sans Mono"
        "Anonymous Pro"
        "Menlo"
        "Consolas"))

(unless (eq window-system nil)
  (let ((fonts (font-avail font-preferences)))
    (unless (null fonts)
      (set-face-attribute
       'default nil :font
       (car fonts)))))

(add-hook 'haskell-mode-hook 'subword-mode)

(global-hl-line-mode +1)
