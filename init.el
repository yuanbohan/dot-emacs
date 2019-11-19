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

(load-file "~/.emacs.d/conf/conf.el")

(setq backup-directory-alist
      `((".*" . , "~/.emacs.d/backup/")))
(setq auto-save-file-name-transforms
      `((".*" , "~/.emacs.d/backup/" t)))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (company-restclient restclient helm-ack helm-cider helm-ag helm-rg docker-compose-mode protobuf-mode haskell-mode pyim ecukes clojure-snippets yasnippet-snippets racer toml-mode erlang dracula-theme ace-window helm helm-projectile helm-swoop projectile smartparens cargo cider clojure-mode company diminish dockerfile-mode exec-path-from-shell js2-mode magit markdown-mode multiple-cursors neotree nginx-mode paredit rainbow-delimiters rust-mode use-package which-key whitespace-cleanup-mode yaml-mode all-the-icons))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
