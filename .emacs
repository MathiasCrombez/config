; Fichier de configuration d'Emacs (Editeur de texte)
;; Le fichier doit s'appeler ~/.emacs ou ~/.emacs.el
;; ENSIMAG 2009.

;; Auteur : Matthieu Moy <Matthieu.Moy@imag.fr> et l'équipe du Stage
;; Unix de rentrée.

;; Correspondance des parenthèses :
;; Avec ceci, positionnez le curseur sur une parenthèse ouvrante ou
;; une parenthèse fermante, Emacs met en couleur la paire de
;; parenthèses.
(show-paren-mode 1)

;; Afficher les numéros de lignes dans la mode-line (barre du bas de
;; fenêtre) :
(line-number-mode t)
(column-number-mode t)

;; Pour les curieux ...

;; La suite de ce fichier ne contient que des commentaires ! Ce sont
;; des suggestions pour vous constituer votre .emacs.el. Décommentez
;; les lignes de configuration (i.e. supprimer les ";") puis relancez
;; Emacs pour les activer.

;; Ne pas afficher le message d'accueil
(setq inhibit-startup-message t)

;; Des raccourcis claviers et une selection comme sous Windows
;; (C-c/C-x/C-v pour copier coller, ...)
;(cua-mode 1)
;; Sauver avec Control-s :
;; (global-set-key [(C s)] 'save-buffer)

;; Correction orthographique :
(ispell-change-dictionary "francais")
;; Souligner les mots incorrects en mode LaTeX
(add-hook 'latex-mode-hook 'flyspell-mode)

;; Se limiter à des lignes de 80 caractères dans les modes textes (y
;; compris le mode LaTeX) :
;; cf. http://www-verimag.imag.fr/~moy/emacs/#autofill
;;(add-hook 'text-mode-hook 'turn-on-auto-fill)

;; AUC-Tex, un mode amélioré pour LaTeX
;(require 'tex-site)
;; Et son ami preview-latex :
;; Il faut ajouter la ligne suivante au ~/.bashrc (sans les deux ;; en
;;début de ligne) :
;; export TEXINPUTS=/usr/local/src/auctex/install/lisp/texmf/tex/latex/preview/:"$TEXINPUTS"
;; et décommenter la ligne suivante :
;(load-file "/usr/local/src/auctex/install/lisp/preview-latex.el")


;; Changer le comportement de la selection de fichiers (C-x C-f)
;;(ido-mode 1)

;; Dans la même série : changer le comportement de la complétion.
(icomplete-mode)

;; Pour une interface graphique un peu dépouillée
(menu-bar-mode -1)
;;(scroll-bar-mode -1)
;;(tool-bar-mode -1)
(blink-cursor-mode -1)

;; Définir des touches pour se déplacer rapidement :
;; Aller à la parenthèse ouvrante correspondante :
(global-set-key [M-right] 'forward-sexp)
;; Aller à la parenthèse Fermante correspondante :
(global-set-key [M-left] 'backward-sexp)

;; Se souvenir des derniers fichiers ouverts
;(setq recentf-menu-path nil)
;(setq recentf-menu-title "Recentf")
;(recentf-mode 1)


;;; Put these lines at the end of your .emacs :

;;(setq auto-mode-alist (cons '("\\.lus$" . lustre-mode) auto-mode-alist))
;;(autoload 'lustre-mode "lustre" "Edition de code lustre" t)

;;; set the  load-path variable :

(setq load-path
      (append load-path
	      '("~/.emacs.d/")))


;;--------------------------------------------------------------------
;; Des espaces pour indenter.
(setq indent-tabs-mode nil)
(setq c-basic-offset 8)

;;----------------------------------------------------------------------
;; COMPILATION
;;----------------------------------------------------------------------

( setq-default 
  compile-command "make"
  -j 8 ;;pour lancer 8 processus en parallèle.
  compilation-read-command t
  compilation-ask-about-save nil
  compilation-window-height 12
  )

(defun make-install () (interactive) "Compile with \"make install\" as a compilation command"
  (setq old-compile-command compile-command)
  (setq compile-command "make install")
  (recompile)
  (setq compile-command old-compile-command)
  )

;;---------------------------------------------------------------------
;; Shell toggle
;; (autoload 'shell-toggle "shell-toggle" 
;;   "Toggles between the *shell* buffer and whatever buffer you are editing."
;;   t)
;; (autoload 'shell-toggle-cd "shell-toggle" 
;;   "Pops up a shell-buffer and insert a \"cd <file-dir>\" command." t)

;; (global-set-key [f8]   'shell-toggle)
;; (global-set-key [M-f8] 'shell-toggle-cd)
;; (global-set-key [C-f8] '(lambda () (interactive)
;; 			  (shell-toggle nil)
;; 			  (shell-toggle nil)
;; 			  (compile compile-command)))
(global-set-key [f8]   'ansi-term)
(global-set-key [C-f9]   'compile)
(global-set-key [f9]     'recompile)
(global-set-key [M-f9] 'make-install)
(global-set-key [f10]    'next-error)
(global-set-key [M-f10]  'previous-error)

(global-set-key [f12] 'ff-find-other-file)
;;---------------------------------------------------------------------
;;
(setq truncate-partial-width-windows nil)
(setq ring-bell-function 'ignore)

(display-time)
(setq display-time-24hr-format t)
;;(display-battery-mode t)

;;(setq major-mode 'text-mode)
;;(add-hook 'text-mode-hook 'turn-on-auto-fill)

;;(setq-default auto-fill-function 'do-auto-fill)
;; (add-hook 'text-mode-hook
;; 	  '(lambda ()
;; 	    (auto-fill-mode 1)
;; 	    (setq default-justification 'full))
;; 	  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Lua mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq auto-mode-alist (cons '("\.lua$" . lua-mode) auto-mode-alist))
(autoload 'lua-mode "lua-mode" "Lua editing mode." t)
