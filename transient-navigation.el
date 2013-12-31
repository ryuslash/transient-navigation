;;; transient-navigation.el --- Navigate with a transient mode  -*- lexical-binding: t; -*-

;; Copyright (C) 2013  Tom Willemse

;; Author: Tom Willemse <tom@ryuslash.org>
;; Keywords: convenience
;; Version: 0.1.0

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;;

;;; Code:

(defvar transient-navigation-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "f") #'transient-forward-char)
    (define-key map (kbd "b") #'transient-backward-char)
    (define-key map (kbd "n") #'transient-next-line)
    (define-key map (kbd "p") #'transient-previous-line)
    map))

(defmacro transnav-make-transient (func)
  "Wrap FUNC with a transient map."
  (let ((funcname (intern (concat "transient-" (symbol-name func)))))
    `(defun ,funcname (&optional n)
       (interactive)
       (ignore n)
       (call-interactively #',func)
       (set-transient-map transient-navigation-map t))))

(transnav-make-transient forward-char)
(transnav-make-transient backward-char)
(transnav-make-transient next-line)
(transnav-make-transient previous-line)

;;;###autoload
(define-minor-mode transient-navigation-mode
  "Remap certain navigation commands to ones with a transient map."
  nil nil nil
  (if transient-navigation-mode
      (progn
        (define-key global-map [remap forward-char] #'transient-forward-char)
        (define-key global-map [remap backward-char] #'transient-backward-char)
        (define-key global-map [remap next-line] #'transient-next-line)
        (define-key global-map [remap previous-line] #'transient-previous-line))
    (define-key global-map [remap transient-forward-char] #'forward-char)
    (define-key global-map [remap transient-backward-char] #'backward-char)
    (define-key global-map [remap transient-next-line] #'next-line)
    (define-key global-map [remap transient-previous-line] #'previous-line)))

(provide 'transient-navigation)
;;; transient-navigation.el ends here
