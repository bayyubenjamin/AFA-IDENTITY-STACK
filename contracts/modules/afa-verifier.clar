
(define-data-var verifier principal tx-sender)
(define-map nonces principal uint)

(define-read-only (verifierAddress) (var-get verifier))
(define-read-only (nonces (u principal)) (default-to u0 (map-get? nonces u)))

(define-public (useNonce (u principal))
 (begin (map-set nonces u (+ (nonces u) u1)) (ok true)))
