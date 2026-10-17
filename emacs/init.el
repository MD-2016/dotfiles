(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/") t)
(add-to-list 'package-archives '("nongnu" . "https://elpa.gnu.org/packages/") t)
(package-initialize)
(package-refresh-contents)

;; Download Evil
(unless (package-installed-p 'evil)
  (package-install 'evil))

;; Enable Evil
(require 'evil)
(evil-mode 1)

;; Enable Dracula
;;(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(load-theme 'dracula t)
(use-package dracula-theme
  :ensure t)

;; Hooks
(add-hook 'after-init-hook 'global-company-mode)

;; vertical mode
(electric-pair-mode 1)
(global-display-line-numbers-mode 1)
;;(delete-selection-mode 1)
(which-key-mode 1)
(fido-vertical-mode 1)
(global-auto-revert-mode 1)
(setq backup-directory-alist `(("." . ,(concat user-emacs-directory "backups"))))

(setq inhibit-startup-screen t
      ring-bell-function 'ignore)
(tool-bar-mode -1)
(menu-bar-mode -1)

(global-hl-line-mode 1)
(show-paren-mode 1)
(setq use-short-answers t)
(setq-default indent-tabs-mode nil)
(setq scroll-step 1 scroll-conservatively 101)
(global-eldoc-mode 1)
(savehist-mode 1)
(save-place-mode 1)
(setq-default show-trailing-whitespace t)
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(setq display-line-numbers-type 'relative)
(setq create-lockfiles nil)

;; global keybindings
(global-set-key (kbd "<f8>") 'treemacs)

;; shell variables
(use-package exec-path-from-shell
  :ensure t
  :if (memq window-system '(mac ns x))
  :config
  (exec-path-from-shell-initialize))

;; time package
(use-package time
	:config
	;; TZs to display with 'world-clock'
	(setq world-clock-list
		'(("America/New_York" "New York")
		  ("Europe/London" "London")
		  ("Europe/Paris" "Paris")
		  ("Asia/Tokyo" "Tokyo")
		  ("America/Los_Angeles" "Seattle")
		  ("Europe/Berlin" "Berlin")

		)
	)
)

;; Dictionary
(use-package dictionary
	:bind (("C-c l" . dictionary-lookup-definition))
	:config
	(setq dictionary-server "dict.org")
)

;; which-key - show availabe keybindings in a popup
(use-package which-key
	:ensure nil
	:config
	(which-key-mode +1)
)

;; treemacs - file side bar roller
(use-package treemacs
	:ensure t
	:defer t
	:config
	(treemacs-git-mode 'simple)
)

;; Rust additions
(use-package rust-mode
  :ensure t)
(add-hook 'rust-mode-hook 'eglot-ensure)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(all-the-icons centaur-tabs company corfu doom-modeline doom-themes
                   dracula-theme eldoc-box evil-collection
                   exec-path-from-shell flycheck go-mode jsonrpc
                   markdown-mode rust-mode tree-sitter-langs
                   treemacs-evil treemacs-icons-dired zig-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Go
(use-package go-mode
  :ensure t
  :hook (go-mode . eglot-ensure))
(add-to-list 'exec-path "~/go/bin")
(setenv "PATH" (concat (expand-file-name "~/go/bin") ":" (getenv "PATH")))

;; Zig
(use-package zig-mode
  :ensure t
  :hook (zig-mode . eglot-ensure))

;; C and C++
(use-package eglot
  :ensure nil ; Built-in in Emacs 29.1+
  :hook
  ((c-mode . eglot-ensure)
   (c++-mode . eglot-ensure)
   (c-ts-mode . eglot-ensure)   ; If using Tree-Sitter modes
   (c++-ts-mode . eglot-ensure)))

;; =============================================================================
;; 4. MODERN AUTO-COMPLETION & HOVER (CORFU & ELDOC)
;; =============================================================================
(use-package corfu
   :ensure t
   :custom
   (corfu-auto t)
   (corfu-quit-no-match 'separator)
   (corfu-auto-delay 0.1)
   (corfu-auto-prefix 1)
   :config
   (global-corfu-mode)

   (define-key corfu-map (kbd "C-n") 'corfu-next)
   (define-key corfu-map (kbd "C-p") 'corfu-previous))

;; Documentation on hover
(use-package eldoc-box
   :ensure t
  :hook (eglot-managed-mode . eldoc-box-hover-mode))
