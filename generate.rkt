#lang racket
(require web-server/templates
         compatibility/defmacro
         (for-syntax racket/string))

(define-macro (generate fname)
  `(with-output-to-file ,fname
     #:exists 'replace
     (lambda ()
       (display (include-template ,(string-replace fname ".html" ".src.html"))))))

(void (system "sass scss/custom-bootstrap.scss css/custom-bootstrap.css"))
(displayln "SASS compilation complete")
(generate "index.html")
(displayln "HTML compilation complete")