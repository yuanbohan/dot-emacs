;;;;;;;;;;;;;;;;;;;; Link References ;;;;;;;;;;;;;;;;;;;;;;;;
;; - [use package](https://github.com/jwiegley/use-package)
;; - good config samples
;;   - https://github.com/bbatsov/emacs.d/blob/master/init.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;; use-package ;;;;;;;;;;;;;;;;
(eval-when-compile
  (require 'use-package))
(require 'use-package-ensure)
(setq use-package-always-ensure t)

(use-package diminish
  :ensure t
  :config
  (require 'diminish)  ;; if you use :diminish
  )

(use-package bind-key
  :ensure t
  :config
  (require 'bind-key) ;; if you use any :bind variant
  )

;;;;;;;;;;;;;;;;; replace tab with space ;;;;;;;;;;;;;;;;
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)

;;;;;;;;;;;;;;;;;;;;;;;;;;; ui related ;;;;;;;;;;;;;;;;;;
;; (set-default-font "Menlo 16")
(setq inhibit-startup-screen t) ; hide the welcome screen
(menu-bar-mode -1) ; hide menu bar
(global-linum-mode -1) ; hide line number
(tool-bar-mode -1) ; hide tool bar
(scroll-bar-mode -1) ; hide scroll bar
(global-hl-line-mode 1) ; highlight current line
(show-paren-mode 1) ; Highlights matching parenthesis


;;;;;;;;;;;;;;;;;;;;;; global set key ;;;;;;;;;;;;;;;;;;;;;;;;;;;
(global-set-key (kbd "s-l") 'goto-line)
(global-set-key (kbd "s-k") 'kill-this-buffer)
(global-set-key (kbd "S-C-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-C-<down>") 'shrink-window)
(global-set-key (kbd "S-C-<up>") 'enlarge-window)

;;;;;;;;;;;;;;;;;;;;;; duplicate line ;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun duplicate-line()
  (interactive)
  (move-beginning-of-line 1)
  (kill-line)
  (yank)
  (open-line 1)
  (next-line 1)
  (yank))
(global-set-key (kbd "C-c C-d") 'duplicate-line)

;;;;;;;;;;;;;;;;;;;;;;;;;;; comment ;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun comment-region-or-line ()
  "Comments or uncomments the region or the current line if there's no active region."
  (interactive)
  (let (beg end)
    (if (region-active-p)
        (setq beg (region-beginning) end (region-end))
      (setq beg (line-beginning-position) end (line-end-position)))
    (comment-or-uncomment-region beg end)))

(global-set-key (kbd "C-;") 'comment-region-or-line)

;;;;;;;;;;;;;;;;;;;;;;;;;;; ensure mode installed ;;;;;;;;;;;;;;
(use-package yaml-mode
  :ensure t)

(use-package toml-mode
  :ensure t)

(use-package markdown-mode
  :ensure t)

;;;;;;;;;;;;;;;;;;;;;;;;;;; theme related ;;;;;;;;;;;;;;
(use-package dracula-theme
  :ensure t
  :config
  (load-theme 'dracula t))

;;;;;;;;;;;;;;;;;;;;;;;;;;; exec-path-from-shell ;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package exec-path-from-shell
  :ensure t
  :config
  (when (memq window-system '(mac ns))
    (exec-path-from-shell-initialize)
    (exec-path-from-shell-copy-envs
     '("PATH"))))

;;;;;;;;;;;;;;;;;;;;;;;;;;; yasnippet ;;;;;;;;;;;;;;
(use-package yasnippet
  :ensure t
  :config
  (yas-reload-all)
  (setq yas-wrap-around-region t)
  :hook ('prog-mode . 'yas-minor-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;; recentf ;;;;;;;;;;;;;;;;;;;;;
(use-package recentf
  :ensure t
  :config
  (recentf-mode 1)
  (setq recentf-max-saved-items 200
        recentf-max-menu-items 15)
  (run-at-time nil (* 5 60) 'recentf-save-list))

;;;;;;;;;;;;;;;;;;;;;;;; projectile ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package projectile
  :ensure t
  :config
  (projectile-mode +1)
  :bind-keymap
  ("C-c p"   . projectile-command-map))

;;;;;;;;;;;;;;;;;;;;;;;;;;; helm ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package helm
  :ensure t
  :config
  (helm-mode 1)
  (setq helm-buffers-fuzzy-matching t
        helm-recentf-fuzzy-match    t
        helm-M-x-fuzzy-match        t)
  :bind
  (("M-x" .     'helm-M-x)
   ("C-x b" .   'helm-mini)
   ("C-x r b" . 'helm-bookmarks)
   ("M-y" .     'helm-show-kill-ring)
   ("C-x C-f" . 'helm-find-files)))

;;;;;;;;;;;;;;;;;;;;;;;;;;; helm projectile ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package helm-projectile
  :ensure t
  :config
  (projectile-global-mode 1)
  (helm-projectile-on)
  (setq projectile-completion-system 'helm)
  (setq projectile-switch-project-action 'helm-projectile))

;;;;;;;;;;;;;;;;;;;;;;;;;;; helm swoop ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package helm-swoop
  :ensure t
  :config
  ;; Save buffer when helm-multi-swoop-edit complete
  (setq helm-multi-swoop-edit-save t)

  ;; If this value is t, split window inside the current window
  (setq helm-swoop-split-with-multiple-windows nil)

  ;; Split direcion. 'split-window-vertically or 'split-window-horizontally
  (setq helm-swoop-split-direction 'split-window-vertically)

  ;; If nil, you can slightly boost invoke speed in exchange for text color
  (setq helm-swoop-speed-or-color nil)

  ;; ;; Go to the opposite side of line from the end or beginning of line
  (setq helm-swoop-move-to-line-cycle t)

  ;; Optional face for line numbers
  ;; Face name is `helm-swoop-line-number-face`
  (setq helm-swoop-use-line-number-face t)

  ;; If you prefer fuzzy matching
  (setq helm-swoop-use-fuzzy-match nil)
  :bind
  (("M-i" . 'helm-swoop)
   ("C-c M-i" . 'helm-multi-swoop)

   :map isearch-mode-map
   ("M-i" . 'helm-swoop-from-isearch)

   :map helm-swoop-map
   ("M-i" . 'helm-multi-swoop-all-from-helm-swoop)
   ("M-m" . 'helm-multi-swoop-current-mode-from-helm-swoop)
   ("C-r" . 'helm-previous-line)
   ("C-s" . 'helm-next-line)

   :map helm-multi-swoop-map
   ("C-r" . 'helm-previous-line)
   ("C-s" . 'helm-next-line)))

;;;;;;;;;;;;;;;;;;;;;;;;;;; multiple cursor ;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package multiple-cursors
  :ensure t
  :bind
  (("C-x C-v" . 'mc/edit-lines)
   ("C->" . 'mc/mark-next-like-this)
   ("C-<" . 'mc/mark-previous-like-this)
   ("C-x C-a" . 'mc/mark-all-like-this)))

;;;;;;;;;;;;;;;;;;;;;;;;;;; magit ;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package magit
  :ensure t
  :bind (("C-x g" . magit-status)))

;;;;;;;;;;;;;;;;;;;;;;;;;;; ace-window ;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package ace-window
  :ensure t
  :bind (("s-2" . 'ace-window)))

;;;;;;;;;;;;;;;;;;;;;;;;;;; which key ;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package which-key
  :ensure t
  :config
  (which-key-mode))

;;;;;;;;;;;;;;;;;;;;;;; whitespace cleanup ;;;;;;;;;;;;;;;;;;;;;;
(use-package whitespace-cleanup-mode
  :ensure t
  :bind (("C-c C-SPC". 'whitespace-cleanup))
  :hook 'after-save)

;;;;;;;;;;;;;;;;;;;;;;;;;;; neo tree ;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; https://github.com/jaypei/emacs-neotree
(use-package neotree
  :ensure t
  :init
  ;; NOTE:
  ;;;; uncomment the following 4 lines, restart emacs and comment them again
  ;;;; link: https://github.com/domtronn/all-the-icons.el
  ;; (use-package all-the-icons
  ;;   :ensure t
  ;;   :config
  ;;   (all-the-icons-install-fonts))
  :bind
  (("s-1". 'neotree-toggle))
  :config
  (setq neo-theme (if (display-graphic-p) 'icons 'arrow))
  (setq neo-smart-open t)
  (setq projectile-switch-project-action 'neotree-projectile-action))
;; `n` next line, p previous line.
;; `SPC` or RET or TAB Open current item if it is a file. Fold/Unfold current item if it is a directory.
;; `U` Go up a directory
;; `g` Refresh
;; `A` Maximize/Minimize the NeoTree Window
;; `H` Toggle display hidden files
;; `O` Recursively open a directory
;; `C-c C-n` Create a file or create a directory if filename ends with a ‘/’
;; `C-c C-d` Delete a file or a directory.
;; `C-c C-r` Rename a file or a directory.
;; `C-c C-c` Change the root directory.
;; `C-c C-p` Copy a file or a directory.

;;;;;;;;;;;;;;;;;;;;;;;;;;; paredit ;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (add-hook 'prog-mode-hook #'enable-paredit-mode)
(use-package paredit
  :ensure t
  :config
  (add-hook 'cider-repl-mode-hook       #'enable-paredit-mode)
  (add-hook 'cider-mode-hook            #'enable-paredit-mode)
  (add-hook 'clojure-mode-hook          #'enable-paredit-mode)
  (add-hook 'emacs-lisp-mode-hook       #'enable-paredit-mode)
  (add-hook 'ielm-mode-hook             #'enable-paredit-mode)
  (add-hook 'lisp-mode-hook             #'enable-paredit-mode)
  (add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
  (add-hook 'scheme-mode-hook           #'enable-paredit-mode)
  (add-hook 'toml-mode-hook             #'enable-paredit-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;; smartparens ;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package smartparens
  :ensure t
  :hook ('prog-mode . 'smartparens-mode)
  :bind
  (("C-M-a" . 'sp-beginning-of-sexp)
   ("C-M-e" . 'sp-end-of-sexp)
   ("C-M-f" . 'sp-forward-sexp)
   ("C-M-b" . 'sp-backward-sexp)
   ("C-M-n" . 'sp-next-sexp)
   ("C-M-p" . 'sp-previous-sexp)
   ("C-S-f" . 'sp-forward-symbol)
   ("C-S-b" . 'sp-backward-symbol)
   ("C-M-k" . 'sp-kill-sexp)
   ("C-M-w" . 'sp-copy-sexp)
   ("C-k"   . 'sp-kill-hybrid-sexp)
   ("M-k"   . 'sp-backward-kill-sexp)))
(require 'smartparens-config)

;;;;;;;;;;;;;;;;;;;;;;;;;;; rainbow ;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package rainbow-delimiters
  :ensure t
  :hook ('prog-mode . 'rainbow-delimiters-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;; clojure and cider ;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package clojure-mode
  :ensure t)

;; compojure indentation
(define-clojure-indent
  (defroutes 'defun)
  (GET 2)
  (POST 2)
  (PUT 2)
  (DELETE 2)
  (HEAD 2)
  (ANY 2)
  (OPTIONS 2)
  (PATCH 2)
  (rfn 2)
  (let-routes 1)
  (context 2))

(use-package cider
  :ensure t
  ;; :hook ('cider-repl-mode . 'eldoc-mode)
  :config
  ;; go right to the REPL buffer when it's finished connecting
  (setq cider-repl-pop-to-buffer-on-connect t)

  ;; When there's a cider error, show its buffer and switch to it
  (setq cider-show-error-buffer t)
  (setq cider-auto-select-error-buffer t)
  (setq cider-test-show-report-on-success t)

  ;; Where to store the cider history.
  (setq cider-repl-history-file "~/.emacs.d/cider-history")

  ;; Wrap when navigating history.
  (setq cider-repl-wrap-history t)

  ;; turn off eldoc displayed when the cursor is over code
  (setq cider-prompt-for-symbol nil)

  ;; Just save without prompting, C-c C-k
  (setq cider-prompt-save-file-on-load 'always-save)

  ;; evaluate code in Clojure files, display result overlay to be font-locked
  (setq cider-overlays-use-font-lock t)

  (setq cider-refresh-show-log-buffer t)

  (setq cider-repl-tab-command #'indent-for-tab-command)

  (setq cider-eldoc-display-for-symbol-at-point nil)
  (setq cider-repl-display-help-banner nil))


;;;;;;;;;;;;;;;;;;;;;;;;;;; company ;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package company
  :ensure t
  :hook ('after-init . 'global-company-mode)
  :config
  (company-tng-configure-default)
  (setq company-idle-delay 0.5)
  (setq company-minimum-prefix-length 3)
  (setq company-selection-wrap-around t)
  (setq company-tooltip-align-annotations t))

;;;;;;;;;;;;;;;;;;;;;;;;;;; Rust ;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DO ensure `rust` and `racer` installed in your operating system !!!!!!!!!
(use-package rust-mode
  :ensure t

  :init
  (use-package racer
    :ensure t
    :init (setq racer-rust-src-path
                (concat (string-trim
                         (shell-command-to-string "rustc --print sysroot"))
                        "/lib/rustlib/src/rust/src"))
    :hook ('rust-mode . 'racer-mode))
  (use-package cargo
    :ensure t
    :hook ('rust-mode . 'cargo-minor-mode))

  :config
  (setq rust-format-on-save t)

  :bind (("TAB". 'company-indent-or-complete-common)
         ("C-c C-b". 'cargo-process-build)
         ("C-c C-r". 'cargo-process-run)))

;;;;;;;;;;;;;;;;;;;;;;;;;;; expand region ;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package expand-region
  :ensure t
  :bind (("C-=". 'er/expand-region)))

;;;;;;;;;;;;;;;;;;;; chinese input on gnu/linux ;;;;;;;;;;;;;;;;;;;;
;; https://github.com/tumashu/pyim
(use-package pyim
  :ensure t
  :if (string-equal system-type "gnu/linux")
  :config
  (use-package pyim-basedict
    :ensure t
    :config (pyim-basedict-enable))
  (setq default-input-method "pyim")
  ;; (setq pyim-default-scheme 'quanpin) ;; 全拼
  :bind (("C-\\". 'toggle-input-method)))

;;;;;;;;;;;;;;;;;;;; rest client ;;;;;;;;;;;;;;;;;;;;
(use-package restclient
  :ensure t
  :mode "\\.http\\'")

;;;;;;;;;;;;;;;;;;;; org ;;;;;;;;;;;;;;;;;;;;
(use-package org
  :ensure t
  :init
  (use-package org-bullets
    :ensure t
    :hook ('org-mode . (lambda () (org-bullets-mode 1))))
  :bind
  (("C-c l". 'org-store-link)
   ("C-c a" . 'org-agenda)
   ("C-c b" . 'org-switchb))
  :config
  (setq org-log-done 'time)
  (setq org-hide-emphasis-markers t)
  (setq org-todo-keywords
        '((sequence "TODO" "DOING"  "|" "DONE" "CANCEL"))))
