;;;;;;;;;;;;;;;;;;REPOSITORY;;;;;;;;;;;;;;;;;;;;;
(require 'package)
(add-to-list 'package-archives
	'("marmalade" . "http://marmalade-repo.org/packages/") )
(package-initialize)

;;;;;;;;;;;;;;;;;;END;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;PACKAGES;;;;;;;;;;;;;;;;;;;;;;;

(when (not package-archive-contents)
  (package-refresh-contents))

(defvar my-packages 
  '(starter-kit-lisp
    ruby-mode
    inf-ruby
    clojure-mode 
    rainbow-delimiters
    ac-slime
    markdown-mode
    ruby-mode
    nrepl))

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

;;;;;;;;;;;;;;;;;;END;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;RAINBOW DELIMITERS;;;;;;;;;;;;;

(global-rainbow-delimiters-mode)

;;;;;;;;;;;;;;;;;;END;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;AUTO COMPLETE CONFIGURATION;;;;

(add-to-list 'load-path "~/.emacs.d/auto-complete")
(require 'auto-complete-config)

(add-to-list 'ac-dictionary-directories "~/.emacs.d/auto-complete/dict")
(setq-default ac-sources (add-to-list 'ac-sources 'ac-source-dictionary))

(global-auto-complete-mode t)
(setq ac-auto-start 2)
(setq ac-ignore-case nil)

;;;;;;;;;;;;;;;;;;END;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;YASNIPPET CONFIGURATION;;;;;;;;   
(add-to-list 'load-path
              "~/.emacs.d/yasnippet")
(require 'yasnippet)
(yas-global-mode 1)
;;;;;;;;;;;;;;;;;;END;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;PSVN CONFIGURATION;;;;;;;;;;;;;

(add-to-list 'load-path
              "~/.emacs.d")
(require 'psvn)

;;;;;;;;;;;;;;;;;;END;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;NAV CONFIGURATION;;;;;;;;;;;;;;

(add-to-list 'load-path "~/.emacs.d/nav/")
(require 'nav)
(nav-disable-overeager-window-splitting)

;;;;;;;;;;;;;;;;;;END;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;GLOBAL CONFIUGURATION;;;;;;;;;;;;
(global-set-key (kbd "C-x h") 'find-name-dired)
(global-set-key (kbd "C-x r") 'rgrep) 
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq c-basic-offset 4)
(setq c-basic-indent 4)
(setq make-backup-files nil)
(setq auto-save-default nil)
;;;;;;;;;;;;;;;;;;END;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;PHP MODE;;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'load-path "~/.emacs.d/php/")
(require 'php-mode)
(add-hook 'php-mode-hook (lambda ()
                           (defun ywb-php-lineup-arglist-intro (langelem)
                             (save-excursion
                               (goto-char (cdr langelem))
                               (vector (+ (current-column) c-basic-offset))))
                           (defun ywb-php-lineup-arglist-close (langelem)
                             (save-excursion
                               (goto-char (cdr langelem))
                               (vector (current-column))))
                           (c-set-offset 'arglist-intro 'ywb-php-lineup-arglist-intro)
                              (c-set-offset 'arglist-close 'ywb-php-lineup-arglist-close)))
(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.phtml$" . php-mode))
;;;;;;;;;;;;;;;;;;END;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;JS MODE;;;;;;;;;;;;;;;;;;;;;;;;
;;;;This is taken from the sttarter-kit-js
;;;;Changes indent to 4(otherwise the kit keeps overriding indent on js mode load)
(eval-after-load 'js
  '(progn (define-key js-mode-map "{" 'paredit-open-curly)
          (define-key js-mode-map "}" 'paredit-close-curly-and-newline)
          (add-hook 'js-mode-hook 'esk-paredit-nonlisp)
          (setq js-(insert )ndent-level 4)
          ;; fixes problem with pretty function font-lock
          (define-key js-mode-map (kbd ",") 'self-insert-command)
          (font-lock-add-keywords
           'js-mode `(("\\(function *\\)("
                       (0 (progn (compose-region (match-beginning 1)
                                                 (match-end 1) "\u0192")
                                 nil)))))))
;;;;;;;;;;;;;;;;;;END;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;RUBY;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq ruby-indent-level 2)
(add-to-list 'auto-mode-alist '("\\.rake$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.gemspec$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.ru$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Capfile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Vagrantfile$" . ruby-mode))
;;;;;;;;;;;;;;;;;;END;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;WORKSPACE;;;;;;;;;;;;;;;;;;;;;;
(defun setup-workspace ()
  "Setup the workspace."
  (interactive)
  (nav)
  (select-window (next-window))
  (split-window-vertically)
  (enlarge-window 5))
(add-hook 'emacs-startup-hook 'setup-workspace)
(add-hook 'before-save-hook 'delete-trailing-whitespace)
;;;;;;;;;;;;;;;;;;END;;;;;;;;;;;;;;;;;;;;;;;;;;;;
