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
    (rust-auto-use cargo racer rust-mode edts erlang smartparens helm-swoop groovy-mode company exec-path-from-shell rainbow-delimiters paredit whitespace-cleanup-mode all-the-icons neotree which-key helm-projectile markdown-mode color-theme-sanityinc-tomorrow ace-window expand-region kubernetes magit multiple-cursors helm projectile cider clojure-mode dockerfile-mode nginx-mode yaml-mode dracula-theme))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
