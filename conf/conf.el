;; use 2 spaces for tabs
(defun die-tabs ()
  (interactive)
  (set-variable 'tab-width 2)
  (mark-whole-buffer)
  (untabify (region-beginning) (region-end))
  (keyboard-quit))

;;;;;;;;;;;;;;;;;;;;;;;;;;; helm ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; https://emacs-helm.github.io/helm
;; https://github.com/ShingoFukuyama/helm-swoop
(require 'helm-config)
(require 'helm)

(global-set-key (kbd "M-x")     'helm-M-x)
(global-set-key (kbd "C-x b")   'helm-mini)
(global-set-key (kbd "C-x r b") 'helm-bookmarks)
(global-set-key (kbd "M-y")     'helm-show-kill-ring)
(global-set-key (kbd "C-x C-f") 'helm-find-files)

(setq helm-buffers-fuzzy-matching t
      helm-recentf-fuzzy-match    t
      helm-M-x-fuzzy-match        t)

(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)

(helm-mode 1)


;;;;;;;;;;;;;;;;;;;;;;;;;;; Helm Swoop ;;;;;;;;;;;;;;;;;;;;;;;;;;;
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
(setq helm-swoop-use-fuzzy-match t)


;;;;;;;;;;;;;;;;;;;;;;;;;;; which key ;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'which-key)
(which-key-mode)


;;;;;;;;;;;;;;;;;;;;;;;;;;; magit ;;;;;;;;;;;;;;;;;;;;;;;;;;;
(global-set-key (kbd "C-x g") 'magit-status)


;;;;;;;;;;;;;;;;;;;;;;;;;;; highlight ;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Highlight current line
(global-hl-line-mode 1)

;; Set any color as the background face of the current line:
(set-face-background 'hl-line "#3e4446")

;; To keep syntax highlighting in the current line:
(set-face-foreground 'highlight nil)

;; Highlights matching parenthesis
(show-paren-mode 1)


;;;;;;;;;;;;;;;;;;;;;;;;;;; paredit ;;;;;;;;;;;;;;;;;;;;;;;;;;;
; (autoload 'enable-paredit-mode        "paredit" t)
(add-hook 'prog-mode-hook             #'enable-paredit-mode)
(add-hook 'cider-repl-mode-hook       #'enable-paredit-mode)
(add-hook 'cider-mode-hook            #'enable-paredit-mode)


;;;;;;;;;;;;;;;;;;;;;;;;;;; rainbow ;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-hook 'prog-mode-hook             #'rainbow-delimiters-mode)
(add-hook 'cider-repl-mode-hook       #'rainbow-delimiters-mode)
(add-hook 'cider-mode-hook            #'rainbow-delimiters-mode)


;;;;;;;;;;;;;;;;;;;;;;;;;;; eldoc ;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-hook 'prog-mode-hook             #'eldoc-mode)
(add-hook 'cider-repl-mode-hook       #'eldoc-mode)
(add-hook 'cider-mode-hook            #'eldoc-mode)
(setq cider-eldoc-display-for-symbol-at-point nil)


;;;;;;;;;;;;;;;;;;;;;;;;;;; company ;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-hook 'prog-mode-hook             #'company-mode)
(add-hook 'cider-repl-mode-hook       #'company-mode)
(add-hook 'cider-mode-hook            #'company-mode)


;;;;;;;;;;;;;;;;;;;;;;;;;;; minibufer to exec clojure form. `C-c C-:` ;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-hook 'eval-expression-minibuffer-setup-hook #'company-mode)
(add-hook 'eval-expression-minibuffer-setup-hook #'eldoc-mode)
(add-hook 'eval-expression-minibuffer-setup-hook #'paredit-mode)


;;;;;;;;;;;;;;;;;;;;;;;;;;; Clojure related tips ;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; M-x cider-scratch. this is to evaluate clojure exp with repl needless
;;; C-c C-m. Macroexpansion 


;;;;;;;;;;;;;;;;;;;;;;;;;; cider-refresh C-c C-x ;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq cider-refresh-show-log-buffer t)


;;;;;;;;;;;;;;;;;;;;;;;;;;; cider ;;;;;;;;;;;;;;;;;;;;;;;;;;;
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


;;;;;;;;;;;;;;;;;;;;;;;;;;; smartparens ;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; https://ebzzry.github.io/emacs-pairs.html
;;;; https://github.com/Fuco1/smartparens
(require 'smartparens-config)
(add-hook 'clojure-mode-hook     #'smartparens-mode)
(add-hook 'cider-repl-mode-hook  #'smartparens-mode)
(add-hook 'cider-mode-hook       #'smartparens-mode)

(global-set-key (kbd "C-M-a") 'sp-beginning-of-sexp)
(global-set-key (kbd "C-M-e") 'sp-end-of-sexp)
(global-set-key (kbd "C-M-f") 'sp-forward-sexp)
(global-set-key (kbd "C-M-b") 'sp-backward-sexp)
(global-set-key (kbd "C-S-f") 'sp-forward-symbol)
(global-set-key (kbd "C-S-b") 'sp-backward-symbol)

(global-set-key (kbd "C-M-k") 'sp-kill-sexp)
(global-set-key (kbd "C-M-w") 'sp-copy-sexp)
(global-set-key (kbd "C-k") 'sp-kill-hybrid-sexp)
(global-set-key (kbd "M-k") 'sp-backward-kill-sexp)

(global-set-key (kbd "M-[") 'sp-backward-unwrap-sexp)
(global-set-key (kbd "M-]") 'sp-unwrap-sexp)

(sp-pair "(" ")"   :wrap "C-c (")
(sp-pair "[" "]"   :wrap "C-c [")
(sp-pair "{" "}"   :wrap "C-c {")
(sp-pair "'" "'"   :wrap "C-c '")
(sp-pair "\"" "\"" :wrap "C-c \"")
(sp-pair "`" "`"   :wrap "C-c `")

;;;;;;;;;;;;;;;;;;;;;;;;;;; ace-jump-mode ;;;;;;;;;;;;;;;;;;;;;;;;;;;
(global-set-key (kbd "C-x SPC") 'ace-jump-mode)


;;;;;;;;;;;;;;;;;;;;;;;;;;; clojure refactor ;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'clj-refactor)

(defun my-clojure-mode-hook ()
    (clj-refactor-mode 1)
    (yas-minor-mode 1) ; for adding require/use/import statements
    (cljr-add-keybindings-with-prefix "C-c C-r"))

(add-hook 'clojure-mode-hook #'my-clojure-mode-hook)


;;;;;;;;;;;;;;;;;;;;;;;;;;; shell ;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Sets up exec-path-from shell
;; https://github.com/purcell/exec-path-from-shell
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize)
  (exec-path-from-shell-copy-envs
   '("PATH")))

;;;;;;;;;;;;;;;;;;;;;;;;;;; ui related ;;;;;;;;;;;;;;;;;;;;;;;;;;;
(menu-bar-mode -1)
(global-linum-mode t)

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(add-to-list 'load-path "~/.emacs.d/themes")
(load-theme 'tomorrow-night-bright t)

(set-default-font "Menlo 16")
