
(define-map premium-expirations uint uint)

(define-public (upgradeToPremium (token-id uint) (tier uint))
 (begin
  (map-set premium-expirations token-id (+ block-height (* tier u10000)))
  (print {event: "SubscriptionRenewed", tokenId: token-id, tier: tier})
  (ok true)))

(define-read-only (isPremium (token-id uint))
 (> (default-to u0 (map-get? premium-expirations token-id)) block-height))

(define-read-only (getPremiumExpiration (token-id uint))
 (default-to u0 (map-get? premium-expirations token-id)))
