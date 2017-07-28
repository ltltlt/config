(load "~/ppmx.lsp")
(load "~/dtrace.lsp")
(load "~/sdraw.lsp")
(defun lty-sh (cmd)
  "easy way to use bash"
  (if
      (not (stringp cmd))
      (progn
	(format t "usage: (lty-sh cmd), cmd must be string")
	(return-from lty-sh))) 
#+sbcl
  (sb-ext:run-program
   "/bin/sh" (list "-c" cmd) :input nil :output *standard-output*)
#+ccl
  (ccl:run-program "/bin/sh" (list "-c" cmd) :input nil :output *standard-output*)
#+clisp
  (let ((str (ext:run-shell-command cmd :output:stream)))
   (loop for line = (read-line str nil)
	until (null line)
	do (print line))))

(defmacro lty-documentation-abondoned (name)
  "easy to use documentation"
  (let ((forms '(function variable structure type setf))
	(str (concatenate 'string
			  "~:[~;~&Function:~%~0@*~a~]"
			  "~:[~;~&Variable:~%~1@*~a~]"
			  "~:[~;~&Structure:~%~2@*~a~]"
			  "~:[~;~&Type:~%~3@*~a~]"
			  "~:[~;~&Setf:~%~4@*~a~]")))
  `(format t ,str ,@(loop for f in forms collect
		    `(documentation ',name ',f)))))

(defmacro lty-documentation (name)
  "easy to use documentation"
  (let* ((syms '(Function Variable Structure Type Setf))
	(nums "01234")
	(str (apply #'concatenate 'string
			  (loop for sym in syms
			     for num across nums
			     collect (concatenate 'string
						  "~:[~;~&"
						  (string sym)
						  ":~%~" (string num)
						  "@*~a~]")))))
  `(format t ,str ,@(loop for s in syms collect
		    `(documentation ',name ',s)))))


#+ccl
(defmacro exit ()
 `(quit))

;;; The following lines added by ql:add-to-init-file:
#-quicklisp
(let ((quicklisp-init (merge-pathnames "quicklisp/setup.lisp"
                                       (user-homedir-pathname))))
  (when (probe-file quicklisp-init)
    (load quicklisp-init)))

