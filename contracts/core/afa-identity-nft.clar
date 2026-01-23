
(define-non-fungible-token identity uint)
(define-data-var total-supply uint u0)
(define-map token-owner uint principal)
(define-map balances principal uint)

(define-read-only (totalSupply) (var-get total-supply))
(define-read-only (balanceOf (user principal)) (default-to u0 (map-get? balances user)))
(define-read-only (ownerOf (id uint)) (unwrap! (map-get? token-owner id) (err u404)))

(define-private (mint-core (to principal))
 (let ((id (+ (var-get total-supply) u1)))
  (map-set token-owner id to)
  (map-set balances to (+ (balanceOf to) u1))
  (var-set total-supply id)
  (nft-mint? identity id to)
  id))

(define-public (mintIdentity) (ok (mint-core tx-sender)))
(define-public (adminMint (recipient principal)) (ok (mint-core recipient)))
