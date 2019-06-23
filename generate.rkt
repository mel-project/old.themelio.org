#lang racket
(require web-server/templates
         compatibility/defmacro
         (for-syntax racket/string))

(define-macro (generate fname)
  `(with-output-to-file ,fname
     #:exists 'replace
     (lambda ()
       (display (include-template ,(string-replace fname ".html" ".src.html"))))))

(generate "index.html")
(generate "resources.html")
(generate "roadmap.html")
(displayln "HTML compilation complete")