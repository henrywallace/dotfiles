(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list
   'package-archives
   '("melpa" . "http://melpa.org/packages/")
   t)
  (package-initialize))

(add-hook 'before-save-hook 'delete-trailing-whitespace)
(add-to-list 'auto-mode-alist '("\\.bashrc\\'" . shell-script-mode))
(add-to-list 'auto-mode-alist '("\\.bash_aliases\\'" . shell-script-mode))

(defun get-point (symbol &optional arg)
  "get the point"
  (funcall symbol arg)
  (point)
  )

(set-default 'truncate-lines t)
(global-git-commit-mode)

(defun copy-thing (begin-of-thing end-of-thing &optional arg)
  "copy thing between beg & end into kill ring"
  (save-excursion
    (let ((beg (get-point begin-of-thing 1))
	  (end (get-point end-of-thing arg)))
      (copy-region-as-kill beg end)))
  )

(defun paste-to-mark(&optional arg)
  "Paste things to mark, or to the prompt in shell-mode"
  (let ((pasteMe
     	 (lambda()
     	   (if (string= "shell-mode" major-mode)
	       (progn (comint-next-prompt 25535) (yank))
	     (progn (goto-char (mark)) (yank) )))))
    (if arg
	(if (= arg 1)
	    nil
	  (funcall pasteMe))
      (funcall pasteMe))
    ))
(defun copy-word (&optional arg)
  "Copy words at point into kill-ring"
  (interactive "P")
  (copy-thing 'backward-word 'forward-word arg)
  ;;(paste-to-mark arg)
  )
(global-set-key (kbd "C-c w")         (quote copy-word))

;; faster kbd for goto-line
(global-set-key (kbd "C-f") 'goto-line)
;; (global-set-key (kbd "C-w") 'backward-kill-word)

;; smoother scrolling
(require 'smooth-scrolling)
(smooth-scrolling-mode 1)

(setq py-use-font-lock-doc-face-p t)

;; remove the menu bar from the top
(menu-bar-mode -1)

(column-number-mode 1)

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
(require 'ivy)
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
(require 'flx)
(setq ivy-re-builders-alist '((t . ivy--regex-fuzzy)))
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(define-key read-expression-map (kbd "C-r") 'counsel-expression-history)
(set-face-attribute 'ivy-current-match nil
		    :weight 'bold
		    :foreground "black"
                    :background "magenta")

(setq-default fill-column 79)

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
 '(isearch ((t (:background "yellow" :foreground "black"))))
 '(sh-quoted-exec ((t (:foreground "brightblue")))))

(custom-set-variables
 '(git-commit-summary-max-length 50)
 '(package-selected-packages
   (quote
    (magit counsel yaml-mode swiper smooth-scrolling smex python-mode python-docstring py-isort markdown-mode json-snatcher json-reformat go-guru go-autocomplete git-auto-commit-mode flycheck flx dracula-theme auto-package-update)))
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
