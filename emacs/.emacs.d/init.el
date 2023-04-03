;; keybinding to reload emacs config
(defun reload-emacs-config ()
  (interactive)
  (load-file "~/.emacs.d/init.el"))

(global-set-key (kbd "C-c r") 'reload-emacs-config)

;; Disable UI elements
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; Store all backup and autosave files in the tmp dir
(setq backup-directory-alist `(("." . "~/.local/share/emacs/backup")))

;; Disable auto-save
(setq auto-save-default nil)

;; Enable automatic bracket insertion by pairs.
(electric-pair-mode 1)

;; Set the font
(set-face-attribute 'default nil :font "BlexMono Nerd Font Mono" :height 90)

;; relative line numbers
(global-display-line-numbers-mode t)
(setq display-line-numbers 'relative)

(require 'package)

;; Prevent cluttering of .emacs.d
(setq package-user-dir "~/.local/share/emacs/packages")

;; Add melpa to package-archives
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)

(package-initialize)


;; Install use-package if not already installed
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; Use use-package to install and configure packages
(eval-when-compile
  (require 'use-package))

;; Always ensure packages are installed
(setq use-package-always-ensure t)

;; Install evil
(use-package evil
  :config (evil-mode 1))

;; Actually change the cursor in terminal
(use-package evil-terminal-cursor-changer
  :config (evil-terminal-cursor-changer-activate))

;; Surround text objects with "S<textobject>"
(use-package evil-surround
  :config (global-evil-surround-mode 1))

;; Gruvbox theme
(use-package gruvbox-theme
  :config (load-theme 'gruvbox-dark-medium t)
  (set-face-attribute 'line-number nil :background "#0000" :foreground "#504945")
  (set-face-attribute 'line-number-current-line nil :background "#0000"))


;; set color of line numbers

;; LSP
(use-package lsp-mode
  :init
  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  (setq lsp-keymap-prefix "C-l")
  :hook ((python-mode . lsp)
         (rust-mode . lsp)
         (org-mode . lsp)
         ;; which-key integration
         (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp)

;; which-key
(use-package which-key
  :config (which-key-mode))

;; Install and configure projectile
(use-package projectile
  :config (projectile-mode))

;; org-mode
(use-package org
  :config
  (setq org-startup-indented t)
  (setq org-hide-leading-stars t)
  (setq org-ellipsis " ")
  (setq org-src-fontify-natively t)
  (setq org-src-tab-acts-natively t)
  (setq org-src-preserve-indentation t)
  (setq org-confirm-babel-evaluate nil)
  (setq org-src-window-setup 'current-window)
  (setq org-log-done 'time)
  (setq org-todo-keywords
        '((sequence "TODO" "LATER" "DONE")))
  ;; Open files folded
  (setq org-startup-folded t)
  (setq org-hide-emphasis-markers t)
)

;; Install and configure org-superstar
(use-package org-superstar
  :config
  (add-hook 'org-mode-hook (lambda () (org-superstar-mode 1)))
  (setq org-superstar-headline-bullets-list '("◉" "○" "✸" "✿")))


;; org-evil: shortcuts like >> to demote headings
(use-package org-evil
  :config (add-hook 'org-mode-hook 'org-evil-mode))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(which-key use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
