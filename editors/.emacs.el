;; wanted packages
(setq package-list
      '(
	;; general
	editorconfig
	flycheck
	markdown-mode
	dashboard
	yaml-mode
	counsel
	swiper
	neotree
	smex
	go-rename
	ivy
        vim-empty-lines-mode
	;; python
	elpy
	python-mode
	jedi
	;; golang
	go-autocomplete
	go-guru
	go-playground
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

;; editorconfig
(require 'editorconfig)
(editorconfig-mode 1)

;; dashboard
(require 'dashboard)
(dashboard-setup-startup-hook)

;; flycheck config
(require 'flycheck)
(global-flycheck-mode)

;; nicer dividing line
(set-face-background 'vertical-border "black")
(set-face-foreground 'vertical-border (face-background 'vertical-border))

;; emacs counsel
(setq ivy-initial-inputs-alist nil)

;; python config
(require 'elpy)
(elpy-enable)
(add-hook 'python-mode-hook (highlight-indentation-mode 0))
(setq python-fill-docstring-style 'symmetric)
;; (add-hook 'python-mode-hook 'jedi:setup)
;; (setq jedi:complete-on-dot t)
(setq py-use-font-lock-doc-face-p t)

;;; scroll buffer not cursor
(global-set-key "\M-n" "\C-u1\C-v")
(global-set-key "\M-p" "\C-u1\M-v")

;; ivy
(require 'ivy)
(require 'counsel)
;; (require 'swiper)
(require 'smex)
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
;; (global-set-key "\C-s" 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "<f6>") 'ivy-resume)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)

;; less style page up, and down
(global-set-key (kbd "C-u")  'backward-paragraph)
(global-set-key (kbd "C-d")  'forward-paragraph)

;; neotree
(require 'neotree)
(global-set-key (kbd "M-k") 'neotree-toggle)

;; moving lines
(defun move-line-up ()
  "Move up the current line."
  (interactive)
  (transpose-lines 1)
  (forward-line -2)
  (indent-according-to-mode))
(defun move-line-down ()
  "Move down the current line."
  (interactive)
  (forward-line 1)
  (transpose-lines 1)
  (forward-line -1)
    (indent-according-to-mode))
(global-set-key [(shift up)]  'move-line-up)
(global-set-key [(shift down)]  'move-line-down)

;; I don't care about emac's vc package, which always prompts me about editing
;; symlinked files.
(setq vc-handled-backends nil)

;; vim-style empty-lines
(global-vim-empty-lines-mode)

;; editor configuration, e.g. indent size for shell scripts
;;(add-to-list 'load-path "~/.emacs.d/lisp")
;;(require 'editorconfig)
;;(editorconfig-mode 1)

;; better move lines
;; (drag-stuff-global-mode)
;; (global-set-key (kbd "C-n") 'drag-stuff-up)
;; (global-set-key (kbd "C-m") 'drag-stuff-down)

;; misc built-in
(menu-bar-mode -1)
(column-number-mode 1)
(setq-default fill-column 79)
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(add-to-list 'auto-mode-alist '("\\.bashrc\\'" . shell-script-mode))
(add-to-list 'auto-mode-alist '("\\.bash_aliases\\'" . shell-script-mode))
(set-default 'truncate-lines t)
(global-set-key (kbd "C-f") 'goto-line)

;; misc third-party
;; (require 'smooth-scrolling)
;; (smooth-scrolling-mode 1)
;; (require 'pymacs)

;; store all backup and autosave files in the tmp dir
;; http://emacsredux.com/blog/2013/05/09/keep-backup-and-auto-save-files-out-of-the-way/
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; faster matching parens
(show-paren-mode 1)
(setq show-paren-delay 0)

(load-theme 'dracula t)

;; ;; ivy for the win
;; (ivy-mode 1)
;; (setq enable-recursive-minibuffers t)
;; (setq ivy-use-virtual-buffers t)
;; (setq ivy-re-builders-alist '((t . ivy--regex-fuzzy)))
;; (global-set-key (kbd "M-x") 'counsel-M-x)
;; (global-set-key (kbd "C-x C-f") 'counsel-find-file)
;; (define-key read-expression-map (kbd "C-r") 'counsel-expression-history)

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

;; kill freakin' pesky python buffers that won't die
;; https://emacs.stackexchange.com/a/14511
(setq kill-buffer-query-functions (delq 'process-kill-buffer-query-function kill-buffer-query-functions))

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
  (local-set-key (kbd "M-'") 'go-guru-definition-other-window)
  (local-set-key (kbd "M-p") 'compile)
  (auto-complete-mode 1))
(add-hook 'go-mode-hook 'my-go-mode-hook)

;; (custom-set-faces
;;  ;; custom-set-faces was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(font-lock-comment-face ((t (:foreground "green"))))
;;  '(font-lock-constant-face ((t (:foreground "black"))))
;;  '(font-lock-function-name-face ((t (:foreground "black" :weight bold))))
;;  '(font-lock-keyword-face ((t (:foreground "black"))))
;;  '(font-lock-string-face ((t (:foreground "red" :weight bold))))
;;  '(font-lock-type-face ((t (:foreground "blue"))))
;;  '(font-lock-variable-name-face ((t (:foreground "brightblue"))))
;;  '(highlight ((t (:background "paleturquoise"))))
;;  '(isearch ((t (:background "magenta" :foreground "black"))))
;;  '(lazy-highlight ((t (:background "paleturquoise"))))
;;  '(sh-quoted-exec ((t (:foreground "brightblue")))))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("aaffceb9b0f539b6ad6becb8e96a04f2140c8faa1de8039a343a4f1e009174fb" "ff7625ad8aa2615eae96d6b4469fcc7d3d20b2e1ebc63b761a349bebbb9d23cb" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" default)))
 '(git-commit-summary-max-length 50)
 '(package-selected-packages
   (quote
    (toml-mode toml multiple-cursors editorconfig drag-stuff vim-empty-lines-mode smart-mode-line esup pymacs flycheck-gometalinter evil ace-window counsel yaml-mode swiper smooth-scrolling smex python-mode python-docstring py-isort markdown-mode json-snatcher json-reformat go-guru go-autocomplete git-auto-commit-mode flycheck flx dracula-theme auto-package-update)))
 '(safe-local-variable-values
   (quote
    ((encoding . utf-8)
     (eval when
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



(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-lock-comment-face ((t (:foreground "black" :weight bold))))
 '(isearch ((t (:background "green" :foreground "white" :weight bold))))
 '(ivy-current-match ((t (:background "black" :foreground "white" :weight bold))))
 '(ivy-cursor ((t (:background "black" :foreground "white" :weight bold))))
 '(ivy-minibuffer-match-face-1 ((t (:background "cyan"))))
 '(ivy-minibuffer-match-face-2 ((t (:background "blue" :foreground "#000000"))))
 '(ivy-minibuffer-match-face-3 ((t (:background "blue" :foreground "black"))))
 '(ivy-minibuffer-match-face-4 ((t (:background "blue" :foreground "black" :weight bold))))
 '(ivy-prompt-match ((t (:inherit ivy-current-match :background "black" :weight bold))))
 '(lazy-highlight ((t (:background "turquoise3" :foreground "black"))))
 '(neo-file-link-face ((t (:foreground "white"))))
 '(region ((t (:background "white" :foreground "black" :slant italic))))
 '(show-paren-match ((t (:background "black" :foreground "cyan" :weight bold))))
 '(show-paren-mismatch ((t (:background "black" :foreground "red" :weight bold))))
 '(tty-menu-disabled-face ((t (:background "blue" :foreground "red"))))
 '(vim-empty-lines-face ((t (:foreground "white")))))
