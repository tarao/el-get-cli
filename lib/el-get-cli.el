;;; el-get-cli.el --- CLI for El-Get

;; Author: INA Lintaro <tarao.gnn at gmail.com>
;; URL: https://github.com/tarao/el-get-cli
;; Version: 0.1
;; Package-Requires: ((el-get "5.1"))
;; Keywords: emacs package install

;; This file is NOT part of GNU Emacs.

;;; License:
;;
;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Code:

(defun el-get-cli-can-el-get ()
  (unless (require 'el-get nil t)
    (error "`el-get' is not installed")))

(defun el-get-cli-can-lock ()
  (unless (require 'el-get-lock nil t)
    (error "`el-get-lock' is not installed")))

(defun el-get-cli-install (&rest packages)
  (if (null packages)
      (el-get 'sync)
    (mapc 'el-get-install packages)))

(defun el-get-cli-update (&rest packages)
  (if (null packages)
      (el-get-update-all t)
    (mapc #'el-get-update packages)))

(defun el-get-cli-checkout (&rest packages)
  (el-get-cli-can-lock)
  (apply 'el-get-lock-checkout packages))

(defun el-get-cli-lock (&rest packages)
  (el-get-cli-can-lock)
  (apply 'el-get-lock packages))

(defun el-get-cli-unlock (&rest packages)
  (el-get-cli-can-lock)
  (apply 'el-get-lock-unlock packages))

(defun el-get-cli-load-init (init)
  (load init))

(defun el-get-cli-run (command &rest packages)
  (el-get-cli-can-el-get)
  (let ((el-get-default-process-sync t)
        (cli-command (intern (concat "el-get-cli-" command))))
    (unless (fboundp cli-command)
      (error "Invalid command: %s" command))
    (apply cli-command packages)))

(defun el-get-cli-run-from-env ()
  (let* ((init (expand-file-name (getenv "EL_GET_CLI_INIT_FILE")))
         (command (getenv "EL_GET_CLI_COMMAND"))
         (packages (split-string (getenv "EL_GET_CLI_PACKAGES") " " t)))
    (el-get-cli-load-init init)
    (apply 'el-get-cli-run command packages)))

(provide 'el-get-cli)
;;; el-get-cli.el ends here
