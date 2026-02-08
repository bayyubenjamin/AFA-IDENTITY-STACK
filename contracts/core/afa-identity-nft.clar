;; contracts/core/afa-identity-nft.clar
;; Update: Menambahkan Metadata URI dan ownership check

(define-non-fungible-token identity uint)

;; Data Vars
(define-data-var total-supply uint u0)
(define-data-var base-uri (string-ascii 256) "https://api.afa-protocol.com/metadata/")
(define-data-var contract-owner principal tx-sender)

;; Maps
(define-map token-owner uint principal)
(define-map balances principal uint)

;; Read-Only Functions
(define-read-only (totalSupply) 
  (var-get total-supply))

(define-read-only (balanceOf (user principal)) 
  (default-to u0 (map-get? balances user)))

(define-read-only (ownerOf (id uint)) 
  (unwrap! (map-get? token-owner id) (err u404)))

;; Update: Fungsi SIP-009 Standard untuk Metadata
(define-read-only (get-token-uri (id uint))
  (ok (some (var-get base-uri))))

;; Private Functions
(define-private (mint-core (to principal))
 (let ((id (+ (var-get total-supply) u1)))
  (map-set token-owner id to)
  (map-set balances to (+ (balanceOf to) u1))
  (var-set total-supply id)
  (try! (nft-mint? identity id to))
  (ok id)))

;; Public Functions
(define-public (mintIdentity) 
  (mint-core tx-sender))

(define-public (adminMint (recipient principal)) 
  (begin
    ;; Simple check agar hanya admin/deployer yang bisa adminMint
    (asserts! (is-eq tx-sender (var-get contract-owner)) (err u403))
    (mint-core recipient)))

;; Update: Kemampuan mengubah Base URI (jika server pindah)
(define-public (set-base-uri (new-uri (string-ascii 256)))
  (begin
    (asserts! (is-eq tx-sender (var-get contract-owner)) (err u403))
    (var-set base-uri new-uri)
    (ok true)))
