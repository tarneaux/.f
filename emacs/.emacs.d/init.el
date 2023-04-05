(defun reload-config ()
  (interactive)
  (org-babel-tangle-file "~/.emacs.d/config.org")
  (load-file "~/.emacs.d/init.el"))

(global-set-key (kbd "C-c r") 'reload-config)

(setq default-directory "~/")

;; Prevent emacs from creating lockfiles because they are just annoying
(setq create-lockfiles nil)

;; Store a limited number of backup files in ~/.local/share/emacs/backups
(unless (file-exists-p "~/.local/share/emacs/backups")
  (make-directory "~/.local/share/emacs/backups" t))
(setq backup-directory-alist '(("." . "~/.local/share/emacs/backups")))
(setq backup-by-copying t
      delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)

;; Store auto-save files in ~/.local/share/emacs/autosaves
(unless (file-exists-p "~/.local/share/emacs/autosaves")
  (make-directory "~/.local/share/emacs/autosaves" t))
(setq auto-save-file-name-transforms
      `((".*" "~/.local/share/emacs/autosaves/\\1" t)))

;; Store undo history in ~/.local/share/emacs/undo
(unless (file-exists-p "~/.local/share/emacs/undo")
  (make-directory "~/.local/share/emacs/undo" t))
(setq undo-tree-history-directory-alist '(("." . "~/.local/share/emacs/undo")))

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))
(setq package-enable-at-startup nil)

(straight-use-package 'use-package)
(setq straight-use-package-by-default t)

(set-face-attribute 'default nil :font "BlexMono Nerd Font Mono-9")

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode)

(use-package gruvbox-theme
  :config
  (load-theme 'gruvbox-dark-medium t)
  ;; I don't like the default line number colors
  (set-face-attribute 'line-number nil :background "#0000" :foreground "#504945")
  (set-face-attribute 'line-number-current-line nil :background "#0000")
  ;; Disable highlighting of new lines
  (set-face-attribute 'fringe nil :background "#0000"))

(use-package powerline
  :config
  (powerline-default-theme))

(use-package evil
  :config
  (evil-mode 1))

(use-package evil-terminal-cursor-changer
  :config
  (evil-terminal-cursor-changer-activate))

(use-package org
   :config
   (setq org-starttup-indented t
         org-hide-leading-stars t
         org-ellipsis " ▾"
         org-src-fontify-natively t
         org-src-tab-acts-natively t
         org-src-preserve-indentation t
         org-confirm-babel-evaluate nil
         org-src-window-setup 'current-window
         org-log-done 'time
         org-todo-keywords '((sequence "TODO" "LATER" "DONE"))
         org-startup-folded t
         org-hide-emphasis-markers t))

(use-package org-superstar
  :hook (org-mode . org-superstar-mode)
  :config (setq org-superstar-headline-bullets-list '("•")))

(use-package org-evil
  :after (evil org)
  :config
  (org-evil-mode 1))

(use-package company
  :config
  (add-hook 'after-init-hook 'global-company-mode))

(use-package copilot
  :straight (:host github :repo "zerolfx/copilot.el" :files ("dist" "*.el"))
  :config (global-copilot-mode)
          (with-eval-after-load 'company
            ;; disable inline previews
            (delq 'company-preview-if-just-one-frontend company-frontends))
	    (define-key copilot-completion-map (kbd "<tab>") 'copilot-accept-completion)
	    (define-key copilot-completion-map (kbd "TAB") 'copilot-accept-completion))

(setenv "PATH" (concat (getenv "PATH") ":~/.local/bin"))
(setq exec-path (append exec-path '("~/.local/bin")))

(use-package lsp-mode
  :init
  (setq lsp-keymap-prefix "C-c l")
  :hook ((python-mode . lsp)
         (rust-mode . lsp)
	 (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp)

(use-package lsp-ui
  :commands lsp-ui-mode
  :config
  ;; Enable sideline
  (setq lsp-ui-sideline-enable t
        lsp-ui-sideline-show-diagnostics t
        lsp-ui-sideline-delay 0.5))

(use-package company-lsp
  :commands company-lsp)

(defun my-lsp-completion-at-point ()
  (if (and (bound-and-true-p lsp-mode)
	   (lsp-feature? "textDocument/completion"))
      (lsp-completion-at-point)
    (company-capf 'candidates)))

(use-package flycheck
  :init (global-flycheck-mode))

(electric-pair-mode 1)

(use-package rust-mode
  :mode "\\.rs\\'")

(use-package tree-sitter
  :config
  (global-tree-sitter-mode)
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))
(use-package tree-sitter-langs)

(use-package treemacs
  :config
  ;; icon size
  (setq treemacs-resize-icons 8))
(use-package treemacs-evil)

(use-package fountain-mode
  :mode "\\.fountain\\'")

(use-package which-key
  :config
  (which-key-mode))
