;; wanted packages
(setq package-list
      '(
	ace-window
	auto-package-update
	counsel
	flx
	flycheck
	go-autocomplete
	go-guru
	magit
	markdown-mode
	python-mode
	swiper
	yaml-mode
	))

;; where to install those packages
(setq package-archives
      '(("melpa" . "http://melpa.milkbox.net/packages/")
	("elpa" . "http://tromey.com/elpa/")
	("gnu" . "http://elpa.gnu.org/packages/")
	("marmalade" . "http://marmalade-repo.org/packages/")))

;; activate packages, autoload, refresh, and install missing
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

;; misc built-in
(menu-bar-mode -1)
(column-number-mode 1)
(setq-default fill-column 79)
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(add-to-list 'auto-mode-alist '("\\.bashrc\\'" . shell-script-mode))
(add-to-list 'auto-mode-alist '("\\.bash_aliases\\'" . shell-script-mode))
(set-default 'truncate-lines t)
(global-git-commit-mode)
(global-set-key (kbd "C-f") 'goto-line)

;; misc third-party
(setq py-use-font-lock-doc-face-p t)
(require 'smooth-scrolling)
(smooth-scrolling-mode 1)
(require 'ace-window)
(global-set-key (kbd "M-p") 'ace-window)

;; store all backup and autosave files in the tmp dir
;; http://emacsredux.com/blog/2013/05/09/keep-backup-and-auto-save-files-out-of-the-way/
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; clearer matching parens
(show-paren-mode 1)
(setq show-paren-delay 0)
(set-face-attribute 'show-paren-match nil
		    :weight 'bold
		    :foreground "black"
		    :background "yellow")

;; nice region selection color :)
(set-face-attribute 'region nil
		    :foreground "black"
		    :background "yellow")

;; ivy for the win
(ivy-mode 1)
(setq enable-recursive-minibuffers t)
(setq ivy-use-virtual-buffers t)
(setq ivy-re-builders-alist '((t . ivy--regex-fuzzy)))
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(define-key read-expression-map (kbd "C-r") 'counsel-expression-history)
(set-face-attribute 'ivy-current-match nil
		    :weight 'bold
		    :foreground "black"
                    :background "magenta")

;; Uncomment or comment single lines, in addition to regions.
;; http://stackoverflow.com/questions/9688748/emacs-comment-uncomment-current-line
(defun comment-or-uncomment-region-or-line ()
    "Comments or uncomments the region or the current line if there's no active region."
    (interactive)
    (let (beg end)
        (if (region-active-p)
            (setq beg (region-beginning) end (region-end))
            (setq beg (line-beginning-position) end (line-end-position)))
        (comment-or-uncomment-region beg end)))
(global-set-key (kbd "M-;") 'comment-or-uncomment-region-or-line)

;; golang! :D
(require 'go-guru)
(defun my-go-mode-hook ()
  (add-hook 'before-save-hook 'gofmt-before-save)
  (setq gofmt-command "goimports")
  (if (not (string-match "go" compile-command))
      (set (make-local-variable 'compile-command)
           "go build -v && go test -v && go vet"))
  (go-guru-hl-identifier-mode)
  (local-set-key (kbd "M-.") 'godef-jump)
  (local-set-key (kbd "M-,") 'pop-tag-mark)
  (local-set-key (kbd "M-p") 'compile)
  (auto-complete-mode 1))
(add-hook 'go-mode-hook 'my-go-mode-hook)
(with-eval-after-load 'go-mode
  (require 'go-autocomplete))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-lock-comment-face ((t (:foreground "green" :weight bold))))
 '(font-lock-constant-face ((t (:foreground "black"))))
 '(font-lock-function-name-face ((t (:foreground "black" :weight bold))))
 '(font-lock-keyword-face ((t (:foreground "black"))))
 '(font-lock-string-face ((t (:foreground "red" :weight bold))))
 '(font-lock-type-face ((t (:foreground "black"))))
 '(font-lock-variable-name-face ((t (:foreground "brightblue"))))
 '(highlight ((t (:background "paleturquoise"))))
 '(isearch ((t (:background "yellow" :foreground "black"))))
 '(lazy-highlight ((t (:background "paleturquoise"))))
 '(sh-quoted-exec ((t (:foreground "brightblue")))))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(git-commit-summary-max-length 50)
 '(package-selected-packages
   (quote
    (ace-window counsel magit yaml-mode swiper smooth-scrolling smex python-mode python-docstring py-isort markdown-mode json-snatcher json-reformat go-guru go-autocomplete git-auto-commit-mode flycheck flx dracula-theme auto-package-update)))
 '(safe-local-variable-values
   (quote
    ((eval when
	   (require
	    (quote js2-mode)
	    nil
	    (quote noerror))
	   (progn
	     (make-local-variable
	      (quote js2-basic-offset))
	     (setq js2-basic-offset 2)))
     (eval when
	   (require
	    (quote web-mode)
	    nil
	    (quote noerror))
	   (progn
	     (make-local-variable
	      (quote web-mode-indentation-params))
	     (make-local-variable
	      (quote web-mode-markup-indent-offset))
	     (make-local-variable
	      (quote web-mode-css-indent-offset))
	     (make-local-variable
	      (quote web-mode-code-indent-offset))
	     (make-local-variable
	      (quote web-mode-indent-offset))
	     (setf
	      (cdr
	       (assoc "case-extra-offset" web-mode-indentation-params))
	      nil)
	     (setq web-mode-markup-indent-offset 2)
	     (setq web-mode-css-indent-offset 2)
	     (setq web-mode-code-indent-offset 2)
	     (setq web-mode-indent-style 2)))))))
