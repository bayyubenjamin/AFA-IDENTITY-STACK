
(define-data-var owner principal tx-sender)

(define-read-only (owner) (var-get owner))

(define-public (transferOwnership (new-owner principal))
 (begin (asserts! (is-eq tx-sender (var-get owner)) (err u401)) (var-set owner new-owner) (ok true)))

(define-public (renounceOwnership)
 (begin (asserts! (is-eq tx-sender (var-get owner)) (err u401)) (var-set owner 'SP000000000000000000002Q6VF78) (ok true)))
