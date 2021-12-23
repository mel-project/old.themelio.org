#lang racket
(require web-server/templates
         compatibility/defmacro
         (for-syntax racket/string))
(require "l10n.rkt")

(define-macro (generate fname)
  `(let ([FILENAME, fname])
     (with-output-to-file (string-append "build/" (if (equal? LANG "en-US")
                              ,fname
                              (string-replace ,fname ".html"
                                              (format "-~a.html"
                                                      (string-downcase (string-replace LANG "-" ""))))))
       #:exists 'replace
       (lambda ()
         (display (include-template , (string-append
                                       "templates/routes/" (string-replace fname ".html" ".src.html"))))))))

(define-macro (generate-all fname)
  `(let ()
     (generate ,fname)
    ;;;  (let ([LANG "zh-CN"])
    ;;;    (generate ,fname))
    ;;;  (let ([LANG "zh-HK"])
    ;;;    (generate ,fname))))
  ))
(define LANG "en-US")

(define-macro (l10n str)
  `(l10n-lookup ,str LANG))

(define-macro (l10n-url str)
  (define lang-suffix (gensym 'lsuf))
  `(if (equal? LANG "en-US") ,str
       (let ([,lang-suffix (string-downcase (string-replace LANG "-" ""))])
         (string-replace ,str ".html"
                         (format "-~a.html" ,lang-suffix)))))

(define-macro (l10n-url-foreign str lang)
  `(let ([LANG ,lang])
     (l10n-url ,str)))

;;; (displayln "HTML compilation...")
(generate-all "learn4.html")
;;; (generate-all "resources.html")
;;; (generate-all "roadmap.html")
(displayln "HTML compilation complete")
