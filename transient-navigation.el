;;; transient-navigation.el --- Navigate with a transient mode  -*- lexical-binding: t; -*-

;; Copyright (C) 2014  Tom Willemse

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

(defvar transient-navigation-mode-map (make-sparse-keymap))
(defvar transient-C-navigation-map (make-sparse-keymap))
(defvar transient-M-navigation-map (make-sparse-keymap))

(defmacro transnav-make-transient (key map func)
  "Bind KEY in MAP to FUNC with a transient map."
  (let* ((ofuncname (symbol-name func))
         (funcname (intern (concat "transient-" ofuncname))))
    `(progn
       (defun ,funcname (&rest args)
         (interactive)
         (ignore args)
         (call-interactively #',func)
         (set-transient-map ,map t))
       (define-key ,map (kbd ,key) #',func)
       (define-key transient-navigation-mode-map
         [remap ,func] #',funcname))))

(transnav-make-transient "f" transient-C-navigation-map forward-char)
(transnav-make-transient "b" transient-C-navigation-map backward-char)
(transnav-make-transient "n" transient-C-navigation-map next-line)
(transnav-make-transient "p" transient-C-navigation-map previous-line)
(transnav-make-transient "e" transient-C-navigation-map end-of-line)
(transnav-make-transient "a" transient-C-navigation-map beginning-of-line)

(transnav-make-transient "f" transient-M-navigation-map forward-word)
(transnav-make-transient "b" transient-M-navigation-map backward-word)
(transnav-make-transient "e" transient-M-navigation-map forward-sentence)
(transnav-make-transient "a" transient-M-navigation-map backward-sentence)

;;;###autoload
(define-minor-mode transient-navigation-mode
  "Remap certain navigation commands to ones with a transient map."
  nil nil transient-navigation-mode-map)

;;;###autoload
(define-globalized-minor-mode global-transient-navigation-mode
  transient-navigation-mode transient-navigation-mode)

(provide 'transient-navigation)
;;; transient-navigation.el ends here
