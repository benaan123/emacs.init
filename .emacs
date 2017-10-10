(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
(package-initialize)

(electric-pair-mode 1)

(add-to-list 'load-path "/Users/BenjaminAanes/Desktop/ESS/lisp/")
(require 'ess-site)
(require 'flymake)
(require 'auto-complete)
(require 'auto-complete-config)
(require 'tex-site)
(ac-config-default)

(defun myindent-ess-hook()
  (setq ess-indent-level 4))

 (setq ring-bell-function 'ignore)

(defun ess-abort ()
  (interactive)
  (kill-process (ess-get-process)))
(define-key ess-mode-map (kbd "C-c C-a") 'ess-abort)
(define-key inferior-ess-mode-map (kbd "C-c C-a") 'ess-abort)

(add-hook 'ess-mode-hook 'myindent-ess-hook)

(setq ess-use-auto-complete 'script-only)
(define-key ac-completing-map (kbd "M-h") 'ac-quick-help)
(define-key ac-completing-map "\M-n" nil) ;; was ac-next
(define-key ac-completing-map "\M-p" nil) ;; was ac-previous
(define-key ac-completing-map "\M-," 'ac-next)
(define-key ac-completing-map "\M-k" 'ac-previous)
(define-key ac-completing-map [tab] 'ac-complete)
 (define-key ac-completing-map [return] nil)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((R . t)))

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.

(setq mac-option-modifier 'alt)
(setq mac-command-modifier 'meta)
(define-key key-translation-map (kbd "å") (kbd "{")) ;
(define-key key-translation-map (kbd "æ") (kbd "}")) ;
(define-key key-translation-map (kbd "@") (kbd  "\\" )) ;
(define-key key-translation-map (kbd "¨") (kbd  "@" )) ;
(define-key key-translation-map (kbd "A-å") (kbd  "[" )) ;
(define-key key-translation-map (kbd "A-æ") (kbd  "]" )) ;
(define-key key-translation-map (kbd "_") (kbd "_")) ;
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-archives
   (quote
    (("Melpa" . "http://melpa.org/packages/")
     ("package" . "http://elpa.gnu.org/packages/"))))
 '(package-selected-packages (quote (yasnippet auto-complete))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
 
(setq ispell-program-name "aspell") ; could be ispell as well, depending on your preferences
(setq ispell-dictionary "english") ; this can obviously be set to any language your spell-checking program supports

(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'flyspell-buffer)

(defun turn-on-outline-minor-mode ()
(outline-minor-mode 1))

(add-hook 'LaTeX-mode-hook 'turn-on-outline-minor-mode)
(add-hook 'latex-mode-hook 'turn-on-outline-minor-mode)
(setq outline-minor-mode-prefix "\C-c \C-o") ; Or something els

(defun flymake-get-tex-args (file-name)
(list "pdflatex"
(list "-file-line-error" "-draftmode" "-interaction=nonstopmode" file-name)))

(add-hook 'LaTeX-mode-hook 'flymake-mode)

(autoload 'reftex-mode "reftex" "RefTeX Minor Mode" t)
(autoload 'turn-on-reftex "reftex" "RefTeX Minor Mode" nil)
(autoload 'reftex-citation "reftex-cite" "Make citation" nil)
(autoload 'reftex-index-phrase-mode "reftex-index" "Phrase Mode" t)
(add-hook 'latex-mode-hook 'turn-on-reftex) ; with Emacs latex mode
;; (add-hook 'reftex-load-hook 'imenu-add-menubar-index)

(add-hook 'LaTeX-mode-hook 'turn-on-reftex)

(setq LaTeX-eqnarray-label "eq"
LaTeX-equation-label "eq"
LaTeX-figure-label "fig"
LaTeX-table-label "tab"
LaTeX-myChapter-label "chap"
TeX-auto-save t
TeX-newline-function 'reindent-then-newline-and-indent
TeX-parse-self t
TeX-style-path
'("style/" "auto/"
"/usr/share/emacs21/site-lisp/auctex/style/"
"/var/lib/auctex/emacs21/"
"/usr/local/share/emacs/site-lisp/auctex/style/")
LaTeX-section-hook
'(LaTeX-section-heading
LaTeX-section-title
LaTeX-section-toc
LaTeX-section-section
LaTeX-section-label))


(defgroup exec-path-from-shell nil
  "Make Emacs use shell-defined values for $PATH etc."
  :prefix "exec-path-from-shell-"
  :group 'environment)

(defcustom exec-path-from-shell-variables
  '("PATH" "MANPATH")
  "List of environment variables which are copied from the shell."
  :type '(repeat (string :tag "Environment variable"))
  :group 'exec-path-from-shell)

(defcustom exec-path-from-shell-check-startup-files t
  "If non-nil, warn if variables are being set in the wrong shell startup files.
Environment variables should be set in .profile or .zshenv rather than
.bashrc or .zshrc."
  :type 'boolean
  :group 'exec-path-from-shell)

(defcustom exec-path-from-shell-shell-name nil
  "If non-nil, use this shell executable.
Otherwise, use either `shell-file-name' (if set), or the value of
the SHELL environment variable."
  :type '(choice
          (file :tag "Shell executable")
          (const :tag "Use `shell-file-name' or $SHELL" nil))
  :group 'exec-path-from-shell)

(defvar exec-path-from-shell-debug nil
  "Display debug info when non-nil.")

(defun exec-path-from-shell--double-quote (s)
  "Double-quote S, escaping any double-quotes already contained in it."
  (concat "\"" (replace-regexp-in-string "\"" "\\\\\"" s) "\""))

(defun exec-path-from-shell--shell ()
  "Return the shell to use.
See documentation for `exec-path-from-shell-shell-name'."
  (or
   exec-path-from-shell-shell-name
   shell-file-name
   (getenv "SHELL")
   (error "SHELL environment variable is unset")))

(defcustom exec-path-from-shell-arguments
  (if (string-match-p "t?csh$" (exec-path-from-shell--shell))
      (list "-d")
    (list "-l" "-i"))
  "Additional arguments to pass to the shell.
The default value denotes an interactive login shell."
  :type '(repeat (string :tag "Shell argument"))
  :group 'exec-path-from-shell)

(defun exec-path-from-shell--debug (msg &rest args)
  "Print MSG and ARGS like `message', but only if debug output is enabled."
  (when exec-path-from-shell-debug
    (apply 'message msg args)))

(defun exec-path-from-shell--standard-shell-p (shell)
  "Return non-nil iff the shell supports the standard ${VAR-default} syntax."
  (not (string-match "\\(fish\\|t?csh\\)$" shell)))

(defun exec-path-from-shell-printf (str &optional args)
  "Return the result of printing STR in the user's shell.
Executes the shell as interactive login shell.
STR is inserted literally in a single-quoted argument to printf,
and may therefore contain backslashed escape sequences understood
by printf.
ARGS is an optional list of args which will be inserted by printf
in place of any % placeholders in STR.  ARGS are not automatically
shell-escaped, so they may contain $ etc."
  (let* ((printf-bin (or (executable-find "printf") "printf"))
         (printf-command
          (concat printf-bin
                  " '__RESULT\\000" str "\\000__RESULT' "
                  (mapconcat #'exec-path-from-shell--double-quote args " ")))
         (shell (exec-path-from-shell--shell))
         (shell-args (append exec-path-from-shell-arguments
                             (list "-c"
                                   (if (exec-path-from-shell--standard-shell-p shell)
                                       printf-command
                                     (concat "sh -c " (shell-quote-argument printf-command)))))))
    (with-temp-buffer
      (exec-path-from-shell--debug "Invoking shell %s with args %S" shell shell-args)
      (let ((exit-code (apply #'call-process shell nil t nil shell-args)))
        (exec-path-from-shell--debug "Shell printed: %S" (buffer-string))
        (unless (zerop exit-code)
          (error "Non-zero exit code from shell %s invoked with args %S.  Output was:\n%S"
                 shell shell-args (buffer-string))))
      (goto-char (point-min))
      (if (re-search-forward "__RESULT\0\\(.*\\)\0__RESULT" nil t)
          (match-string 1)
        (error "Expected printf output from shell, but got: %S" (buffer-string))))))

(defun exec-path-from-shell-getenvs (names)
  "Get the environment variables with NAMES from the user's shell.
Execute the shell according to `exec-path-from-shell-arguments'.
The result is a list of (NAME . VALUE) pairs."
  (let* ((random-default (md5 (format "%s%s%s" (emacs-pid) (random) (current-time))))
         (dollar-names (mapcar (lambda (n) (format "${%s-%s}" n random-default)) names))
         (values (split-string (exec-path-from-shell-printf
                                (mapconcat #'identity (make-list (length names) "%s") "\\000")
                                dollar-names) "\0")))
    (let (result)
      (while names
        (prog1
            (let ((value (car values)))
              (push (cons (car names)
                          (unless (string-equal random-default value)
                            value))
                    result))
          (setq values (cdr values)
                names (cdr names))))
      result)))

(defun exec-path-from-shell-getenv (name)
  "Get the environment variable NAME from the user's shell.
Execute the shell as interactive login shell, have it output the
variable of NAME and return this output as string."
  (cdr (assoc name (exec-path-from-shell-getenvs (list name)))))

(defun exec-path-from-shell-setenv (name value)
  "Set the value of environment var NAME to VALUE.
Additionally, if NAME is \"PATH\" then also set corresponding
variables such as `exec-path'."
  (setenv name value)
  (when (string-equal "PATH" name)
    (setq eshell-path-env value
          exec-path (append (parse-colon-path value) (list exec-directory)))))

;;;###autoload
(defun exec-path-from-shell-copy-envs (names)
  "Set the environment variables with NAMES from the user's shell.
As a special case, if the variable is $PATH, then `exec-path' and
`eshell-path-env' are also set appropriately.  The result is an alist,
as described by `exec-path-from-shell-getenvs'."
  (let ((pairs (exec-path-from-shell-getenvs names)))
    (when exec-path-from-shell-check-startup-files
      (exec-path-from-shell--maybe-warn-about-startup-files pairs))
    (mapc (lambda (pair)
            (exec-path-from-shell-setenv (car pair) (cdr pair)))
          pairs)))

(defun exec-path-from-shell--maybe-warn-about-startup-files (pairs)
  "Warn the user if the value of PAIRS seems to depend on interactive shell startup files."
  (let ((without-minus-i (remove "-i" exec-path-from-shell-arguments)))
    ;; If the user is using "-i", we warn them if it is necessary.
    (unless (eq exec-path-from-shell-arguments without-minus-i)
      (let* ((exec-path-from-shell-arguments without-minus-i)
             (alt-pairs (exec-path-from-shell-getenvs (mapcar 'car pairs)))
             different)
        (dolist (pair pairs)
          (unless (equal pair (assoc (car pair) alt-pairs))
            (push (car pair) different)))
        (when different
          (message "You appear to be setting environment variables %S in your .bashrc or .zshrc: those files are only read by interactive shells, so you should instead set environment variables in startup files like .profile, .bash_profile or .zshenv.  Refer to your shell's man page for more info.  Customize `exec-path-from-shell-arguments' to remove \"-i\" when done, or disable `exec-path-from-shell-check-startup-files' to disable this message." different))))))

;;;###autoload
(defun exec-path-from-shell-copy-env (name)
  "Set the environment variable $NAME from the user's shell.
As a special case, if the variable is $PATH, then `exec-path' and
`eshell-path-env' are also set appropriately.  Return the value
of the environment variable."
  (interactive "sCopy value of which environment variable from shell? ")
  (cdar (exec-path-from-shell-copy-envs (list name))))

;;;###autoload
(defun exec-path-from-shell-initialize ()
  "Initialize environment from the user's shell.
The values of all the environment variables named in
`exec-path-from-shell-variables' are set from the corresponding
values used in the user's shell."
  (interactive)
  (exec-path-from-shell-copy-envs exec-path-from-shell-variables))


(provide 'exec-path-from-shell)

;; Local Variables:
;; coding: utf-8
;; indent-tabs-mode: nil
;; mangle-whitespace: t
;; require-final-newline: t
;; checkdoc-minor-mode: t
;; End:

;;; exec-path-from-shell.el ends here
