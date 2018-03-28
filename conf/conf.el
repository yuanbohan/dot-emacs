;; https://github.com/jwiegley/use-package
(eval-when-compile
  (require 'use-package))
(require 'diminish)      ;; if you use :diminish
(require 'bind-key)      ;; if you use any :bind variant
(require 'all-the-icons) ;; all the fonts


(setq exec-path-from-shell-check-startup-files nil) ;; remove warning

;; http://andrewjamesjohnson.com/suppressing-ad-handle-definition-warnings-in-emacs/
(setq ad-redefinition-action 'accept)

;; hide the welcome screen
(setq inhibit-startup-screen t)

;; replace tab with space
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)

;; hide the tool bar
(tool-bar-mode -1)

;; show time
;; (display-time-mode -1)
;; (format-time-string "%m-%d %H:%M")

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

(require 'helm-projectile)
(projectile-global-mode)
(setq projectile-completion-system 'helm)
(helm-projectile-on)
(setq projectile-switch-project-action 'helm-projectile)
(global-set-key (kbd "C-c p s a") 'helm-projectile-ack)

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
;; (set-face-background 'hl-line "#0000CC")

;; To keep syntax highlighting in the current line:
;; (set-face-foreground 'highlight nil)
;; (set-face-foreground 'hl-line "#FF0000")

;; Highlights matching parenthesis
(show-paren-mode 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;; revert ;;;;;;;;;;;;;;;;;;;;;;;;;;;
(global-auto-revert-mode 1)


;;;;;;;;;;;;;;;;;;;;;;;;;;; paredit ;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;;; tutorial http://danmidwood.com/content/2014/11/21/animated-paredit.html
;;
;;;;  Wrapping an S-expression
;; paredit-wrap-round is bound to M-(
;; paredit-meta-doublequote is bound to M-"
;;
;;;; Slurping and Barfing
;; paredit-forward-slurp-sexp,  bound to C-)
;; paredit-forward-barf-sexp,   bound to C-}
;; paredit-backward-slurp-sexp, bound to C-(
;; paredit-backward-barf-sexp,  bound to C-{
;;
;;;; Splice
;; paredit-splice-sexp bound to M-s
;;
;;;; Splitting and Joining
;; Split is paredit-split-sexp and bound to M-S
;; Join is paredit-join-sexps and bound to M-J
;;

(add-hook 'clojure-mode-hook    #'enable-paredit-mode)
(add-hook 'cider-repl-mode-hook #'enable-paredit-mode)
(add-hook 'cider-mode-hook      #'enable-paredit-mode)
(add-hook 'emacs-lisp-mode-hook       'enable-paredit-mode)
(add-hook 'lisp-mode-hook             'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook 'enable-paredit-mode)
(add-hook 'scheme-mode-hook           'enable-paredit-mode)


;;;;;;;;;;;;;;;;;;;;;;;;;;; rainbow ;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook             #'rainbow-delimiters-mode)
(add-hook 'cider-repl-mode-hook       #'rainbow-delimiters-mode)
(add-hook 'cider-mode-hook            #'rainbow-delimiters-mode)
(require 'cl-lib)
(require 'color)
(defun rainbow-delimiters-using-stronger-colors ()
  (interactive)
  (cl-loop
   for index from 1 to rainbow-delimiters-max-face-count
   do
   (let ((face (intern (format "rainbow-delimiters-depth-%d-face" index))))
     (cl-callf color-saturate-name (face-foreground face) 30))))
(add-hook 'emacs-startup-hook 'rainbow-delimiters-using-stronger-colors)


;;;;;;;;;;;;;;;;;;;;;;;;;;; eldoc ;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-hook 'prog-mode-hook             #'eldoc-mode)
(add-hook 'cider-repl-mode-hook       #'eldoc-mode)
(add-hook 'cider-mode-hook            #'eldoc-mode)
(setq cider-eldoc-display-for-symbol-at-point nil)
(setq cider-repl-display-help-banner nil)


;;;;;;;;;;;;;;;;;;;;;;;;;;; company ;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-hook 'erlang-mode-hook           #'company-mode)
(add-hook 'clojure-mode-hook          #'company-mode)
(add-hook 'cider-mode-hook            #'company-mode)
(add-hook 'cider-repl-mode-hook       #'company-mode)


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

(setq cider-refresh-show-log-buffer t)

;;;; M-x cider-scratch. this is to evaluate clojure exp with repl needless
;;;; C-c C-m. Macroexpansion


;;;;;;;;;;;;;;;;;;;;;;;;;;; smartparens ;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; https://ebzzry.github.io/emacs-pairs.html
;;;; https://github.com/Fuco1/smartparens
(require 'smartparens-config)
(add-hook 'prog-mode-hook        #'smartparens-mode)
(add-hook 'clojure-mode-hook     #'smartparens-mode)
(add-hook 'cider-repl-mode-hook  #'smartparens-mode)
(add-hook 'cider-mode-hook       #'smartparens-mode)

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


;;;;;;;;;;;;;;;;;;;;;;;;;;; ace-jump-mode ;;;;;;;;;;;;;;;;;;;;;;;;;;;
(global-set-key (kbd "C-x SPC") 'ace-jump-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;; ace-window ;;;;;;;;;;;;;;;;;;;;;;;;;;;
(global-set-key (kbd "M-p") 'ace-window)


;;;;;;;;;;;;;;;;;;;;;;;;;;; shell ;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Sets up exec-path-from shell
;; https://github.com/purcell/exec-path-from-shell
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize)
  (exec-path-from-shell-copy-envs
   '("PATH")))

;;;;;;;;;;;;;;;;;;;;;;;;;;; ui related ;;;;;;;;;;;;;;;;;;;;;;;;;;;
(global-linum-mode 0)

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(add-to-list 'load-path "~/.emacs.d/themes")
(load-theme 'tomorrow-night-bright t)

(set-default-font "Menlo 16")


;;;;;;;;;;;;;;;;;;;;;;;;;;; recentf ;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-saved-items 200
      recentf-max-menu-items 15)
(run-at-time nil (* 5 60) 'recentf-save-list)


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


;;;;;;;;;;;;;;;;;;;;;;;;;;; multiple cursor ;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'multiple-cursors)
(global-set-key (kbd "C-x C-v") 'mc/edit-lines)
(global-set-key (kbd "C->")     'mc/mark-next-like-this)
(global-set-key (kbd "C-<")     'mc/mark-previous-like-this)
(global-set-key (kbd "C-x C-a") 'mc/mark-all-like-this)


;;;;;;;;;;;;;;;;;;;;;;;;;;; Org mode ;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (require 'org)
;; (setq org-log-done 'time)

;; ;; The following lines are always needed.  Choose your own keys.
;; (global-set-key (kbd "C-c l") 'org-store-link)
;; (global-set-key (kbd "C-c a") 'org-agenda)
;; (global-set-key (kbd "C-c b") 'org-iswitchb)
;; (global-set-key (kbd "C-c c") 'org-capture)

;; (define-key org-mode-map (kbd "C-c t ,") 'org-table-move-column-left)
;; (define-key org-mode-map (kbd "C-c t .") 'org-table-move-column-right)
;; (define-key org-mode-map (kbd "C-c t <") 'org-table-move-row-up)
;; (define-key org-mode-map (kbd "C-c t >") 'org-table-move-row-down)

;; (define-key org-mode-map (kbd "C-c t I") 'org-table-insert-column)
;; (define-key org-mode-map (kbd "C-c t K") 'org-table-delete-column)
;; (define-key org-mode-map (kbd "C-c t i") 'org-table-insert-row)
;; (define-key org-mode-map (kbd "C-c t k") 'org-table-kill-row)


;;;;;;;;;;;;;;;;;;;;;;;;;;; Nerd Tree like ;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'neotree)
(global-set-key (kbd "C-c p n") 'neotree-toggle)
(setq neo-theme (if (display-graphic-p) 'icons 'arrow))
(setq neo-smart-open t)
(setq projectile-switch-project-action 'neotree-projectile-action)


;;;;;;;;;;;;;;;;;;;;;;;;;;; expand-region ;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)


;;;;;;;;;;;;;;;;;;;;;;;;;;; cljs figwheel ;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'cider)
(setq cider-cljs-lein-repl
      "(do (require 'figwheel-sidecar.repl-api)
           (figwheel-sidecar.repl-api/start-figwheel!)
           (figwheel-sidecar.repl-api/cljs-repl))")


;;;;;;;;;;;;;;;;;;;;;;;;;;; markdown ;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))


;;;;;;;;;;;;;;;;;;;;;;;;;;; yasnippet ;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq mode-require-final-newline nil) ;; remove final newline
(require 'yasnippet)
(yas-reload-all)
(add-hook 'prog-mode-hook    #'yas-minor-mode)


;;;;;;;;;;;;;;;;;;;;;;;;;;; whitespace cleanup ;;;;;;;;;;;;;;;;;;;;;;;;;;;
(global-set-key (kbd "C-c C-SPC") 'whitespace-cleanup)

;;;;;;;;;;;;;;;;;;;;;;;;;;; go mode ;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'go-autocomplete)
(require 'auto-complete-config)
(require 'go-eldoc)
(require 'go-guru)
(ac-config-default)

(setq gofmt-command "goimports")

(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize)
  (exec-path-from-shell-copy-env "GOPATH"))

(defun my-go-mode-hook ()
  (add-hook 'before-save-hook 'gofmt-before-save) ; gofmt before every save
  (add-hook 'go-mode-hook 'go-eldoc-setup)
  (add-hook 'go-mode-hook #'go-guru-hl-identifier-mode)

  (local-set-key (kbd "M-.") 'godef-jump)         ; Godef jump key binding
  (local-set-key (kbd "M-*") 'pop-tag-mark)
  (local-set-key (kbd "C-c C-r") 'go-run)
  (local-set-key (kbd "C-c C-k") 'compile)        ; Invoke compiler
  (local-set-key (kbd "C-c C-l") 'recompile)      ; Redo most recent compile cmd
  (local-set-key (kbd "M-]") 'next-error)         ; Go to next error (or msg)
  (local-set-key (kbd "M-[") 'previous-error)     ; Go to previous error or msg
  )

(add-hook 'go-mode-hook 'my-go-mode-hook)


;;;;;;;;;;;;;;;;;;;; Rust ;;;;;;;;;;;;;;;;;;;;
(setq rust-format-on-save t)


;;;;;;;;;;;;;;;;;;;; Erlang Development Tool Suite ;;;;;;;;;;;;;;;;;;;;
(defun my-after-init-hook ()
  (require 'edts-start))
(add-hook 'after-init-hook 'my-after-init-hook)

(eval-after-load 'erlang
  '(progn
     (define-key erlang-mode-map "{" 'paredit-open-curly)
     (define-key erlang-mode-map "}" 'paredit-close-curly)
     (define-key erlang-mode-map (kbd "RET") 'reindent-then-newline-and-indent)))

(defun my-paredit-space-for-delimiter-predicate (endp delimiter)
  (if (and (member major-mode '(erlang-mode php-mode rust-mode c-mode))
           (not endp))
      (not (or (and (memq delimiter '(?\[ ?\{ ?\()))))
    t))

(add-hook 'paredit-space-for-delimiter-predicates
          #'my-paredit-space-for-delimiter-predicate)


;;;;;;;;;;;;;;;;;;;; js2 mode ;;;;;;;;;;;;;;;;;;;;
(require 'js2-mode)
(add-to-list 'auto-mode-alist (cons (rx ".js" eos) 'js2-mode))


;; https://github.com/weavejester/compojure/wiki/Emacs-indentation
(require 'clojure-mode)

(define-clojure-indent
  (defroutes 'defun)
  (GET 2)
  (POST 2)
  (PUT 2)
  (PATCH 2)
  (DELETE 2)
  (HEAD 2)
  (ANY 2)
  (context 2))

