;;; browse-el.el --- nevigate in an elisp source code

;; Copyright (C) 2004  Free Software Foundation, Inc.

;; Author: Charles Wang <LeafWang@126.com>
;; Keywords: lisp, tools

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
;; Boston, MA 02111-1307, USA.

;;; Commentary:

;; intallaltion, put the following lines in your .emacs
;;               (add-to-list 'load-path "path/where/to/browse.el")
;;               (require 'browse-el)
;;
;;; Code:


(require  'find-func)
;;;###autoload
(defvar wcy-browse-el-point-ring nil)
(defvar wcy-browse-el-point-ring-max-number 200)

;;;###autoload
(defun wcy-browse-el-push-point-mark()
  (if (eq (length wcy-browse-el-point-ring ) wcy-browse-el-point-ring-max-number)
      (setq wcy-browse-el-point-ring (but wcy-browse-el-point-ring)))
  (let ((file (buffer-file-name)))
    (if file
        (push (cons  file (point-marker))
              wcy-browse-el-point-ring))))
;;;###autoload
(defun wcy-browse-el-pop-point-mark()
  (let ((val (pop wcy-browse-el-point-ring)))
    (if val
        (progn
          (find-file (car val))
          (goto-char (cdr val)))
      (error "reach buttome of ring"))))

(defun wcy-browse-el-find-funtion ()
  (interactive)
  (let ((fun (function-at-point)))
    (if fun
        (progn
          (wcy-browse-el-push-point-mark)          
          (find-function-do-it fun nil 'switch-to-buffer)))))

;;(defun foo ()
;;  (interactive)
;;  (print (format "function %s" (function-at-point))))
(defun wcy-browse-el-go-back()
  (interactive)
  (wcy-browse-el-pop-point-mark))
  


(provide 'browse-el)
;;; browse-el.el ends here
