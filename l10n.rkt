#lang racket
(require racket/runtime-path
         yaml)
(provide l10n-lookup)

;; OpenCC conversion
(define (cn->hk str)
  (with-input-from-string str
    (lambda()
      (with-output-to-string
        (lambda()
          (system "opencc -c s2hk.json"))))))
(define (hk->cn str)
  (with-input-from-string str
    (lambda()
      (with-output-to-string
        (lambda()
          (system "opencc -c hk2s.json"))))))

;; big mapping
(define-runtime-path l10n-yaml "l10n.yaml")
(define l10n-mapping
  (let ([original
         (with-input-from-file l10n-yaml
           (lambda ()
             (read-yaml)))])
    ;; Pass "missing" things to OpenCC
    (for/hash ([(key bindings) original])
      (let ([bindings (for/hash ([(k v) bindings]) (values k v))])
        (values key
                (cond
                  [(not (hash-has-key? bindings "zh-HK")) (hash-set bindings "zh-HK"
                                                                    (cn->hk (hash-ref bindings "zh-CN")))]
                  [(not (hash-has-key? bindings "zh-CN")) (hash-set bindings "zh-CN"
                                                                    (hk->cn (hash-ref bindings "zh-HK")))]
                  [else bindings]))))))





;; Look up a value
(define (l10n-lookup str lang)
  (hash-ref (hash-ref l10n-mapping str)  lang))