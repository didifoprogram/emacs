(use-package spaceline
  :ensure t
  :config
  (require 'spaceline-config)
  (setq powerline-default-separator (quote arrow))
  (spaceline-emacs-theme))

(load-theme 'gruvbox-dark-medium t)

(set-default-font "Hack 12" nil t)

(menu-bar-mode -1)
(tool-bar-mode -1)
(setq ns-use-srgb-colorspace t)
(add-to-list 'load-path' "~/.emacs.d/lisp/")
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)
(add-hook 'prog-mode-hook 'linum-mode)

(use-package better-defaults
  :ensure t)

(use-package org)
(use-package org-noter
  :ensure t)





(global-unset-key (kbd "C-z"))
