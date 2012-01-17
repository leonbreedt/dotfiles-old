;; Custom themes
(require 'color-theme)
(add-to-list 'load-path (concat dotfiles-dir "/themes"))
(require 'solarized-light-theme)

;; Font size
(let ((18pt (round (* 18.1 10))))
  (set-face-attribute 'default (not 'this-frame-only) :height 18pt)) 

;; Font face
(set-face-attribute 'default (not 'this-frame-only)
                    :font "Inconsolata")

;; Window size
(if (window-system)
    (set-frame-width (selected-frame) 90))
(if (window-system)
    (set-frame-height (selected-frame) 50))

;; color
(set-cursor-color "SlateGray")

;; Default directory
(setq default-directory "~/Projects")

;; Italics
(set-face-italic-p 'italic nil)

;; Disable visible bell, and beeping
(setq visible-bell nil)
(setq ring-bell-function 'ignore)

;; Start server by default
(server-start)

;; Never use tabs, only spaces, and 4 of them
(setq indent-tabs-mode nil)
(setq c-basic-offset 4)
(setq tab-width 4)

;; Custom PATH for subprocesses
(if (equal system-type 'darwin)
    (progn
      (setenv "PATH" (concat "/usr/local/bin:/usr/local/sbin:/Users/ljb/.rbenv/bin:/Users/ljb/.rbenv/shims:" (getenv "PATH")))
      (setq exec-path (append '("/usr/local/bin"
                                "/usr/local/sbin"
                                "~/.rbenv/bin"
                                "~/.rbenv/shims") exec-path))))

