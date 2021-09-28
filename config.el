;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Kifah M"
      user-mail-address "contact@maskys.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12", or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(require 'company)
(setq company-idle-delay 0
      company-minimum-prefix-length 3)

(setq doom-font (font-spec :family "JetBrains Mono" :size 14 :weight 'semi-light))

(require 'evil-multiedit)
(evil-multiedit-default-keybinds)

(setq doom-theme 'doom-moonlight)

      ;; doom-variable-pitch-font (font-spec :family "Fira Sans") ; inherits `doom-font''s :size
      ;; doom-unicode-font (font-spec :family "Input Mono Narrow" :size 12)
      ;; doom-big-font (font-spec :family "Fira Mono" :size 19))

;https://emacs-lsp.github.io/lsp-mode/tutorials/debugging-clojure-script/; FROM https://emacs-lsp.github.io/lsp-mode/tutorials/debugging-clojure-script/
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)

(setq package-selected-packages '(clojure-mode lsp-mode cider lsp-treemacs flycheck company dap-mode))

(when (cl-find-if-not #'package-installed-p package-selected-packages)
  (package-refresh-contents)
  (mapc #'package-install package-selected-packages))

(add-hook 'clojure-mode-hook 'lsp)
(add-hook 'clojurescript-mode-hook 'lsp)
(add-hook 'clojurec-mode-hook 'lsp)

(setq gc-cons-threshold (* 100 1024 1024)
      read-process-output-max (* 1024 1024)
      treemacs-space-between-root-nodes nil
      company-minimum-prefix-length 1
      lsp-lens-enable t
      lsp-signature-auto-activate nil)

(with-eval-after-load 'dap-mode
  (require 'dap-chrome))


;; https://dev.to/alechstong/smartparens-keybindings-that-make-sense-to-a-vimmer-3lge
(map!
 :map smartparens-mode-map
 ;; smartparens maps (navigation ops)
 :nvie "C-M-f" #'sp-forward-sexp
 :nvie "C-M-b" #'sp-backward-sexp
 :nvie "C-M-u" #'sp-backward-up-sexp
 :nvie "C-M-d" #'sp-down-sexp
 ;; smartparens maps (split join slurp barf)
 :nie "M-s" #'sp-split-sexp
 :nie "M-j" #'sp-join-sexp
 :nvie "C->" #'sp-forward-slurp-sexp
 :nvie "C-<" #'sp-forward-barf-sexp
 :nvie "C-{" #'sp-backward-slurp-sexp
 :nvie "C-}" #'sp-backward-barf-sexp)

;; https://discord.com/channels/406534637242810369/406554085794381833/889382923520864278
(setq-hook! 'clojure-mode-hook +format-with-lsp nil)
(set-formatter! 'cljstyle "/usr/local/bin/cljstyle pipe" :modes '(clojure-mode clojurec-mode clojurescript-mode))
;; using cljstyle, according to their docs, doesn't work
;; (set-formatter! 'cljstyle "cljstyle pipe" :modes '(clojure-mode))
