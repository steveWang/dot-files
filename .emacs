;; Function to load a directory recursively, given a stringp.
(defun load-dir-recursive (str)
  (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
      (let* ((my-lisp-dir (expand-file-name str))
             (default-directory my-lisp-dir))
        (setq load-path (cons my-lisp-dir load-path))
        (normal-top-level-add-subdirs-to-load-path))))

;; Use said function.
(mapc 'load-dir-recursive (list "/home/steve/.emacs.d/elisp"
                                "/home/steve/local/share/emacs/site-lisp"
                                "/home/steve/.cabal/share/"))

;; zap-up-to-char is more useful than zap-to-char
(autoload 'zap-up-to-char "misc"
  "kill up to, but not including argth occurrence of char.
  
  \(fn arg char)"
  'interactive)
(global-set-key "\M-z" 'zap-up-to-char)

(require 'nnir)

;; get rid of useless bars.
(menu-bar-mode -1)
(tool-bar-mode -1)

;; various useful customizations
(blink-cursor-mode 0)
(setq inhibit-startup-message t)
(set-default 'truncate-lines t)
(set-default 'column-number-mode t)

;; google chrome as default browser
(defun browse-url-chrome (url &rest args)
  (interactive (browse-url-interactive-arg "url: "))
  (let ((browse-url-browser-function 'browse-url-generic)
        (browse-url-generic-program "google-chrome"))
    (apply #'browse-url url args)))
(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "google-chrome")

;; default viewer for auctex should be okular, not xdvi.
(defun dvi-with-okular ()
  (add-to-list 'tex-output-view-style 
               (quote ("^dvi$" "." "okular %o %(outpage)"))))

;; autoload js2 mode.
(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

;; load color-theme stuff.
(require 'color-theme)
(load "/home/steve/.emacs.d/elisp/color-theme-blackboard.el")
(eval-after-load "color-theme"
  '(progn
     (color-theme-initialize)
     ;; Use euphoria if in -nw mode, since blackboard is displayed
     ;; poorly in this case.
     (if window-system
         (color-theme-blackboard)
       (color-theme-euphoria))))


;; haskell-mode.
(load "/home/steve/.emacs.d/elisp/haskell-mode/haskell-site-file")
(require 'haskell-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)

;; Magit
(require 'magit)

;; various additions for better jabber.
(require 'hexrgb)
(require 'ssl)

;; jabber itself!
(require 'jabber-autoloads)
(setq jabber-vcard-avatars-publish nil)
(setq jabber-vcard-avatars-retrieve nil)

;; erc keywords
(setq erc-keywords '("\\b[nn]ow\\s?(js|js)\\b" "\\bdnode\\b"))

;; cperl-mode is superior to perl-mode, 'kay?
(mapc
 (lambda (pair)
   (if (eq (cdr pair) 'perl-mode)
       (setcdr pair 'cperl-mode)))
 (append auto-mode-alist interpreter-mode-alist))

;; various indenting / display stuff.
(setq c-default-style "linux"
      c-basic-offset 2
      js-indent-level 2)

;; no tabs by default. modes that really need tabs should enable
;; indent-tabs-mode explicitly. makefile-mode already does that, for
;; example.
(setq-default indent-tabs-mode nil)
;; if indent-tabs-mode is off, untabify before saving
(add-hook 'write-file-hooks 
          (lambda () (if (not indent-tabs-mode)
                         (untabify (point-min) (point-max)))))

;; indent cases of switch statements.
(c-set-offset 'case-label '+)

;; assembly mode
(require 'asm86-mode)
(setq auto-mode-alist
      (append '(("\\.asm$" . asm86-mode) ("\\.s$" . asm86-mode) ("\\.inc$" . asm86-mode)) auto-mode-alist))
(add-hook 'asm86-mode-hook 'turn-on-font-lock)
(setq asm86-extended-style-headers t)

;; markdown mode!
(autoload 'markdown-mode "markdown-mode.el"
  "major mode for editing markdown files" t)
(setq auto-mode-alist
      (cons '("\\.md" . markdown-mode) auto-mode-alist))

;;; emacs/w3 configuration
(setq load-path (cons "/usr/share/emacs/site-lisp" load-path))
(condition-case () (require 'w3-auto "w3-auto") (error nil))

;; custom variables. bleh.
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(c-basic-offset 2)
 '(delete-selection-mode nil)
 '(erc-autoaway-message "idle... (autoaway after %i seconds of idletime)")
 '(erc-autoaway-mode t)
 '(erc-email-userid "steve")
 '(erc-fill-column 75)
 '(erc-fill-static-center 25)
 '(erc-insert-away-timestamp-function (quote erc-insert-timestamp-right))
 '(erc-insert-timestamp-function (quote erc-insert-timestamp-right))
 '(erc-nick "`steve")
 '(erc-prompt "brillig >")
 '(erc-timestamp-format-left "[%a %b %e %y]")
 '(erc-timestamp-format-right " [%h:%m]  ")
 '(erc-try-new-nick-p nil)
 '(espresso-indent-level 2)
 '(exec-path (quote ("/home/steve/local/bin" "/home/steve/.cabal/bin" "/home/steve/bin" "/usr/local/bin" "/usr/bin" "/bin" "/usr/bin/x11" "/usr/x11r6/bin" "/usr/games" "/usr/lib/mit/bin" "/usr/lib/mit/sbin" "." "/usr/lib/emacs/23.3/x86_64-suse-linux")))
 '(global-mark-ring-max 32)
 '(hippie-expand-dabbrev-skip-space t)
 '(jabber-account-list (quote (("stevejohnwang@chat.facebook.com" (:network-server . "chat.facebook.com") (:connection-type . network)) ("steve.john.wang@gmail.com" (:network-server . "talk.google.com") (:connection-type . ssl)))))
 '(jabber-autoaway-priority 10)
 '(jabber-autoaway-timeout 15)
 '(jabber-backlog-days nil)
 '(jabber-backlog-number 10)
 '(jabber-browse-buffer-format "jabber-browse:-%n")
 '(jabber-history-enable-rotation t)
 '(jabber-history-enabled t)
 '(jabber-mode-line-mode t)
 '(jabber-muc-colorize-foreign t)
 '(jabber-muc-colorize-local t)
 '(jabber-use-global-history nil)
 '(jabber-vcard-avatars-publish nil)
 '(jabber-vcard-avatars-retrieve nil)
 '(js2-auto-indent-p t)
 '(js2-bounce-indent-p nil)
 '(js2-cleanup-whitespace t)
 '(js2-consistent-level-indent-inner-bracket-p t)
 '(js2-enter-indents-newline t)
 '(js2-highlight-level 3)
 '(js2-include-browser-externs t)
 '(js2-indent-on-enter-key nil)
 '(js2-mode-indent-inhibit-undo t)
 '(js2-pretty-multiline-decl-indentation-p t)
 '(js2-skip-preprocessor-directives t)
 '(kill-ring-max 100)
 '(lintnode-location "/home/steve/.emacs.d/elisp/lintnode")
 '(mark-even-if-inactive t)
 '(mark-ring-max 32)
 '(message-confirm-send t)
 '(mm-inline-text-html-with-images t)
 '(mode-require-final-newline (quote visit-save))
 '(require-final-newline (quote visit-save))
 '(rmail-preserve-inbox t)
 '(rmail-remote-password nil)
 '(rmail-remote-password-required nil)
 '(save-interprogram-paste-before-kill t)
 '(scroll-bar-mode nil)
 '(standard-indent 2)
 '(tex-pdf-mode t)
 '(tex-source-correlate-method (quote synctex))
 '(tex-source-correlate-mode t)
 '(tex-source-correlate-start-server t)
 '(tex-view-program-list (quote (("okular" "okular --unique %o#src:%n%b"))))
 '(tex-view-program-selection (quote (((output-dvi style-pstricks) "okular") (output-dvi "okular") (output-pdf "okular") (output-html "okular"))))
 '(transient-mark-mode 1)
 '(undo-limit 1000000)
 '(undo-strong-limit 1200000)
 '(user-mail-address "steve.john.wang@gmail.com")
 '(x-select-enable-clipboard t))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(jabber-chat-prompt-local ((t (:foreground "#0aa" :weight bold))))
 '(jabber-roster-user-online ((t (:foreground "#69f" :slant normal :weight bold)))))

;; hack to make js2-global-externs actually have an effect.
(set 'js2-global-externs (list "json" "console" "settimeout" "setinterval"
                               "cleartimeout" "clearinterval" "require"
                               "module" "exports" "process" "__dirname"
                               "__filename"))

(add-hook 'latex-mode-hook 'dvi-with-okular t)

;; flymake mode for js. lintnode-start is handled by the emacs daemon,
;; presumably.
(require 'flymake-jslint)
(add-hook 'js2-mode-hook
          (lambda () (flymake-mode t)))

;; flymake mode for haskell
(autoload 'ghc-init "ghc" nil t)
(add-hook 'haskell-mode-hook (lambda () (flymake-mode)))
(ghc-init)

;; Flyspell *everything*.
(dolist (hook '(text-mode-hook))
  (add-hook hook (lambda () (flyspell-mode 1))))
(dolist (hook '(change-log-mode-hook log-edit-mode-hook))
  (add-hook hook (lambda () (flyspell-mode -1))))

;; Enable disabled commands.
(put 'set-goal-column 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
