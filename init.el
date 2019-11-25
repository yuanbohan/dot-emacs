;;;;
;; Packages
;;;;

;; Define package repositories
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives
             '("melpa-stable" . "http://stable.melpa.org/packages/") t)

(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(org-babel-load-file (expand-file-name "~/.emacs.d/conf/conf.org"))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (yasnippet-snippets whitespace-cleanup-mode which-key use-package undo-tree toml-mode smartparens rainbow-delimiters racer pyim protobuf-mode powerline paren-face paredit ox-reveal ox-gfm org-bullets nginx-mode neotree multiple-cursors magit js2-mode htmlize helm-swoop helm-rg helm-projectile helm-cider helm-ag helm-ack haskell-mode expand-region exec-path-from-shell erlang ecukes dracula-theme dockerfile-mode docker-compose-mode diminish company-restclient clojure-snippets cargo beacon all-the-icons ace-window 2048-game))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
