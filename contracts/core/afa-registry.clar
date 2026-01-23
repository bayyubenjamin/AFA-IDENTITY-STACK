
(define-map identity-map principal uint)
(define-public (registerIdentity (user principal) (token-id uint))
 (begin (map-set identity-map user token-id) (ok true)))
(define-read-only (getIdentityId (user principal))
 (default-to u0 (map-get? identity-map user)))
