;; Custom themes
(require 'color-theme)
(add-to-list 'load-path (concat dotfiles-dir "/themes"))
(require 'solarized-light-theme)

;; Font size
(let ((17pt (round (* 17.1 10))))
  (set-face-attribute 'default (not 'this-frame-only) :height 17pt)) 

;; Font face
(set-face-attribute 'default (not 'this-frame-only)
                    :font "Consolas")

;; Window size
(if (window-system)
    (set-frame-width (selected-frame) 90))
(if (window-system)
    (set-frame-height (selected-frame) 45))

;; Cursor color
(set-cursor-color "SlateGray") 
