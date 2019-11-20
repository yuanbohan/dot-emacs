;;;;;;;;;;;;;;;;; use-package ;;;;;;;;;;;;;;;;
(eval-when-compile
  (require 'use-package))
(require 'use-package-ensure)
(setq use-package-always-ensure t)
(require 'diminish)                ;; if you use :diminish
(require 'bind-key)                ;; if you use any :bind variant

;;;;;;;;;;;;;;;;; replace tab with space ;;;;;;;;;;;;;;;;
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)

;;;;;;;;;;;;;;;;;;;;;;;;;;; ui related ;;;;;;;;;;;;;;;;;;
;; (set-default-font "Menlo 16")
(setq inhibit-startup-screen t) ; hide the welcome screen
(menu-bar-mode -1)
(global-linum-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(global-hl-line-mode 1)
(show-paren-mode 1) ; Highlights matching parenthesis

(global-set-key (kbd "S-C-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-C-<down>") 'shrink-window)
(global-set-key (kbd "S-C-<up>") 'enlarge-window)

;;;;;;;;;;;;;;;;;;;;;; jump to line ;;;;;;;;;;;;;;;;;;;;;;;;;;;
(global-set-key (kbd "s-l") 'goto-line)


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


;;;;;;;;;;;;;;;;;;;;;;;;;;; theme related ;;;;;;;;;;;;;;
(load-theme 'dracula t)


;;;;;;;;;;;;;;;;;;;;;;;;;;; buffer managerment ;;;;;;;;;;;;;;
(global-set-key (kbd "s-k") 'kill-this-buffer)


;;;;;;;;;;;;;;;;;;;;;;;;;;; yasnippet ;;;;;;;;;;;;;;
(require 'yasnippet)
(yas-reload-all)

(add-hook 'prog-mode-hook #'yas-minor-mode)
(setq yas-wrap-around-region t)


;;;;;;;;;;;;;;;;;;;;;;;;;;; recentf ;;;;;;;;;;;;;;;;;;;;;
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-saved-items 200
      recentf-max-menu-items 15)
(run-at-time nil (* 5 60) 'recentf-save-list)


;;;;;;;;;;;;;;;;;;;;;;;; projectile ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(projectile-mode +1)
(define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)


;;;;;;;;;;;;;;;;;;;;;;;;;;; helm ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'helm)
(helm-mode 1)

(global-set-key (kbd "M-x")     'helm-M-x)
(global-set-key (kbd "C-x b")   'helm-mini)
(global-set-key (kbd "C-x r b") 'helm-bookmarks)
(global-set-key (kbd "M-y")     'helm-show-kill-ring)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)

(setq helm-buffers-fuzzy-matching t
      helm-recentf-fuzzy-match    t
      helm-M-x-fuzzy-match        t)


;;;;;;;;;;;;;;;;;;;;;;;;;;; helm projectile ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'helm-projectile)
(projectile-global-mode)
(setq projectile-completion-system 'helm)
(helm-projectile-on)
(setq projectile-switch-project-action 'helm-projectile)
(global-set-key (kbd "C-c p s a") 'helm-projectile-ack)


;;;;;;;;;;;;;;;;;;;;;;;;;;; helm swoop ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'helm-swoop)

;; Change the keybinds to whatever you like :)
(global-set-key (kbd "M-i") 'helm-swoop)
; (global-set-key (kbd "M-I") 'helm-swoop-back-to-last-point)
(global-set-key (kbd "C-c M-i") 'helm-multi-swoop)
; (global-set-key (kbd "C-x M-i") 'helm-multi-swoop-all)

;; When doing isearch, hand the word over to helm-swoop
(define-key isearch-mode-map (kbd "M-i") 'helm-swoop-from-isearch)
;; From helm-swoop to helm-multi-swoop-all
(define-key helm-swoop-map (kbd "M-i") 'helm-multi-swoop-all-from-helm-swoop)
;; When doing evil-search, hand the word over to helm-swoop
;; (define-key evil-motion-state-map (kbd "M-i") 'helm-swoop-from-evil-search)

;; Instead of helm-multi-swoop-all, you can also use helm-multi-swoop-current-mode
(define-key helm-swoop-map (kbd "M-m") 'helm-multi-swoop-current-mode-from-helm-swoop)

;; Move up and down like isearch
(define-key helm-swoop-map (kbd "C-r") 'helm-previous-line)
(define-key helm-swoop-map (kbd "C-s") 'helm-next-line)
(define-key helm-multi-swoop-map (kbd "C-r") 'helm-previous-line)
(define-key helm-multi-swoop-map (kbd "C-s") 'helm-next-line)

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


;;;;;;;;;;;;;;;;;;;;;;;;;;; multiple cursor ;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'multiple-cursors)
(global-set-key (kbd "C-x C-v") 'mc/edit-lines)
(global-set-key (kbd "C->")     'mc/mark-next-like-this)
(global-set-key (kbd "C-<")     'mc/mark-previous-like-this)
(global-set-key (kbd "C-x C-a") 'mc/mark-all-like-this)

;;;;;;;;;;;;;;;;;;;;;;;;;;; magit ;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package magit
  :ensure t
  :bind (("C-x g" . magit-status)))


;;;;;;;;;;;;;;;;;;;;;;;;;;; ace-window ;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package ace-window
  :ensure t
  :bind (("M-p" . 'ace-window)))


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
(require 'all-the-icons)
(require 'neotree)
(global-set-key (kbd "C-c p n") 'neotree-toggle)
(setq neo-theme (if (display-graphic-p) 'icons 'arrow))
(setq neo-smart-open t)
(setq projectile-switch-project-action 'neotree-projectile-action)


;;;;;;;;;;;;;;;;;;;;;;;;;;; paredit ;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (add-hook 'prog-mode-hook #'enable-paredit-mode)
(add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
(add-hook 'cider-repl-mode-hook       #'enable-paredit-mode)
(add-hook 'cider-mode-hook            #'enable-paredit-mode)
(add-hook 'clojure-mode-hook          #'enable-paredit-mode)
(add-hook 'emacs-lisp-mode-hook       #'enable-paredit-mode)
(add-hook 'ielm-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
(add-hook 'scheme-mode-hook           #'enable-paredit-mode)
(add-hook 'toml-mode-hook             #'enable-paredit-mode)


;;;;;;;;;;;;;;;;;;;;;;;;;;; smartparens ;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'smartparens-config)
(add-hook 'prog-mode-hook        #'smartparens-mode)
;; (add-hook 'clojure-mode-hook     #'smartparens-mode)
;; (add-hook 'cider-repl-mode-hook  #'smartparens-mode)
;; (add-hook 'cider-mode-hook       #'smartparens-mode)
;; (add-hook 'R-mode-hook           #'smartparens-mode)
;; (add-hook 'ess-mode-hook         #'smartparens-mode)

(global-set-key (kbd "C-M-a") 'sp-beginning-of-sexp)
(global-set-key (kbd "C-M-e") 'sp-end-of-sexp)
(global-set-key (kbd "C-M-f") 'sp-forward-sexp)
(global-set-key (kbd "C-M-b") 'sp-backward-sexp)
(global-set-key (kbd "C-M-n") 'sp-next-sexp)
(global-set-key (kbd "C-M-p") 'sp-previous-sexp)

(global-set-key (kbd "C-S-f") 'sp-forward-symbol)
(global-set-key (kbd "C-S-b") 'sp-backward-symbol)

(global-set-key (kbd "C-M-k") 'sp-kill-sexp)
(global-set-key (kbd "C-M-w") 'sp-copy-sexp)
(global-set-key (kbd "C-k") 'sp-kill-hybrid-sexp)
(global-set-key (kbd "M-k") 'sp-backward-kill-sexp)


;;;;;;;;;;;;;;;;;;;;;;;;;;; rainbow ;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)


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


;;;;;;;;;;;;;;;;;;;;;;;;;;; exec-path-from-shell ;;;;;;;;;;;;;;;;;;;;;;;;;;;
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize)
  (exec-path-from-shell-copy-envs
   '("PATH")))


;;;;;;;;;;;;;;;;;;;;;;;;;;; cider ;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'cider)
(add-hook 'cider-repl-mode-hook #'eldoc-mode)

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
(setq cider-repl-display-help-banner nil)


;;;;;;;;;;;;;;;;;;;;;;;;;;; company ;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-hook 'after-init-hook 'global-company-mode)

(setq company-idle-delay 0.5)
(setq company-minimum-prefix-length 3)
(setq company-selection-wrap-around t)
(setq company-tooltip-align-annotations t)
(company-tng-configure-default)


;;;;;;;;;;;;;;;;;;;;;;;;;;; Rust ;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package rust-mode
  :ensure t

  :init
  (use-package racer
    :ensure t
    :hook ('rust-mode . 'racer-mode))
  (use-package cargo
    :ensure t
    :hook ('rust-mode . 'cargo-minor-mode))

  :config
  (setq rust-format-on-save t)

  :bind (("TAB". 'company-indent-or-complete-common)
         ("C-c C-b". 'cargo-process-build)
         ("C-c C-r". 'cargo-process-run)))


;;;;;;;;;;;;;;;;;;;; Erlang ;;;;;;;;;;;;;;;;;;;;;;;;
(setq load-path (cons  "/usr/lib/erlang/lib/tools-3.1/emacs" load-path))
(setq erlang-root-dir "/usr/lib/erlang")
(setq exec-path (cons "/usr/lib/erlang/bin" exec-path))
(require 'erlang-start)
(setq erlang-electric-commands '())

(defun my-paredit-space-for-delimiter-predicate (endp delimiter)
  (if (and (member major-mode '(erlang-mode php-mode rust-mode c-mode))
           (not endp))
      (not (or (and (memq delimiter '(?\[ ?\{ ?\()))))
    t))

(add-hook 'paredit-space-for-delimiter-predicates
          #'my-paredit-space-for-delimiter-predicate)


;;;;;;;;;;;;;;;;;;;;;;;;;;; Avy ;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package avy
  :ensure t
  :bind (("C-:". 'avy-goto-char)
         ("C-'". 'avy-goto-char-2)))


;;;;;;;;;;;;;;;;;;;; chinese input on ubuntu ;;;;;;;;;;;;;;;;;;;;
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


;;;;;;;;;;;;;;;;;;;; haskell ;;;;;;;;;;;;;;;;;;;;
(require 'haskell-mode)
(require 'haskell-interactive-mode)
(require 'haskell-process)

(define-key haskell-mode-map (kbd "<f8>")    'haskell-navigate-imports)
(define-key haskell-mode-map (kbd "C-`")     'haskell-interactive-bring)
(define-key haskell-mode-map (kbd "M-.")     'haskell-mode-jump-to-def-or-tag)
(define-key haskell-mode-map (kbd "C-c C-,") 'haskell-mode-format-imports)
(define-key haskell-mode-map (kbd "C-c C-l") 'haskell-process-load-or-reload)
(define-key haskell-mode-map (kbd "C-c C-t") 'haskell-process-do-type)
(define-key haskell-mode-map (kbd "C-c C-i") 'haskell-process-do-info)
(define-key haskell-mode-map (kbd "C-c C-c") 'haskell-process-cabal-build)
(define-key haskell-mode-map (kbd "C-c C-k") 'haskell-interactive-mode-clear)
(define-key haskell-mode-map (kbd "C-c c") 'haskell-process-cabal)
;; (define-key haskell-mode-map (kbd "M-.") 'haskell-mode-jump-to-def)
;; (define-key haskell-mode-map (kbd "M-.") 'haskell-mode-tag-find)

(setq haskell-stylish-on-save t
      haskell-tags-on-save t)

(add-hook 'haskell-mode-hook 'interactive-haskell-mode)

;; http://haskell.github.io/haskell-mode/manual/latest/Completion-support.html#Completion-support
(add-hook 'haskell-mode-hook
          (lambda ()
            (set (make-local-variable 'company-backends)
                 (append '((company-capf company-dabbrev-code))
                         company-backends))))

;;;;;;;;;;;;;;;;;;;; compojure indentation ;;;;;;;;;;;;;;;;;;;;
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
