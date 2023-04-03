;; Disable UI elements
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; Store all backup and autosave files in the tmp dir
(setq backup-directory-alist `(("." . "~/.local/share/emacs/backup")))



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

;; Gruvbox theme
(use-package gruvbox-theme
  :config (load-theme 'gruvbox-dark-medium t))



;; Install and configure company
(use-package company
  :config
  (global-company-mode)
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 1))

;; Install and configure flycheck
(use-package flycheck
  :config (global-flycheck-mode))

;; Install and configure projectile
(use-package projectile
  :config (projectile-mode))

;; org-mode
(use-package org
  :config
  (setq org-startup-indented t)
  (setq org-hide-leading-stars t)
  (setq org-ellipsis " ▾")
  (setq org-src-fontify-natively t)
  (setq org-src-tab-acts-natively t)
  (setq org-src-preserve-indentation t)
  (setq org-confirm-babel-evaluate nil)
  (setq org-src-window-setup 'current-window)
  (setq org-log-done 'time)
  (setq org-todo-keywords
        '((sequence "TODO" "LATER" "DONE")))
)



(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
