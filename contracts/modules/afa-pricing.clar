
(define-data-var price uint u1000000)
(define-map tier-price uint uint)

(define-read-only (priceInWei) (var-get price))
(define-read-only (getPriceForTier (tier uint)) (default-to u0 (map-get? tier-price tier)))

(define-public (setPriceInWei (p uint)) (begin (var-set price p) (ok true)))
(define-public (setPriceForTier (tier uint) (p uint)) (begin (map-set tier-price tier p) (ok true)))
