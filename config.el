(use-package spaceline
  :ensure t
  :config
  (require 'spaceline-config)
  (setq powerline-default-separator (quote arrow))
  (spaceline-spacemacs-theme))

(load-theme 'darktooth t)

(set-frame-font "Hack 10" nil t)

(menu-bar-mode -1)
(tool-bar-mode -1)
(setq ns-use-srgb-colorspace t)
(add-to-list 'load-path' "~/.emacs.d/lisp/")
;(load "xresources-theme")
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)
(global-linum-mode t)

(use-package better-defaults
  :ensure t)

(use-package org)
