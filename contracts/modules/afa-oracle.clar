
(define-data-var round uint u0)
(define-data-var value int 0)

(define-read-only (latestRoundData)
 {round: (var-get round), value: (var-get value), time: block-height})

(define-public (pushData (v int))
 (begin (var-set round (+ (var-get round) u1)) (var-set value v) (ok true)))
