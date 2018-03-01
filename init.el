;;;;
;; Packages
;;;;

;; Define package repositories
(require 'package)
;; (add-to-list 'package-archives
;;              '("melpa-milkbox" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives
             '("melpa-stable" . "http://stable.melpa.org/packages/") t)

;; Load and activate emacs packages. Do this first so that the
;; packages are loaded before you start trying to modify them.
;; This also sets the load path.
(package-initialize)

(load-file "~/.emacs.d/conf/conf.el")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (go-guru memoize markdown-mode js2-mode diminish all-the-icons proceed pos-tip ace-window helm-projectile projectile go-playground auto-highlight-symbol expand-region go-autocomplete company-erlang erlang auto-complete edts helm-cider rainbow-delimiters go-errcheck nginx-mode dockerfile-mode groovy-mode yasnippet yaml-mode whitespace-cleanup-mode which-key use-package tagedit smex smartparens rust-mode paredit neotree multiple-cursors magit inflections hydra highlight-current-line helm-swoop helm-go-package go-eldoc flycheck exec-path-from-shell evil edn company-go clojure-mode-extra-font-locking ace-jump-mode 2048-game))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(setq backup-directory-alist
      `((".*" . , "~/.emacs.d/backup/")))
(setq auto-save-file-name-transforms
      `((".*" , "~/.emacs.d/backup/" t)))

