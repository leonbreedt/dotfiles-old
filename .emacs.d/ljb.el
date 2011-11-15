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
    (set-frame-height (selected-frame) 55))

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
