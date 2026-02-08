;; contracts/core/afa-registry.clar
;; Update: Menambahkan penyimpanan Profile Data (Username)

(define-map identity-map principal uint)
(define-map profile-data uint (string-ascii 64)) ;; Map TokenID -> Username

;; Register dasar (Wallet -> Token ID)
(define-public (registerIdentity (user principal) (token-id uint))
 (begin 
   (map-set identity-map user token-id) 
   (ok true)))

;; Update: Set Username untuk Identitas
(define-public (setProfileName (token-id uint) (name (string-ascii 64)))
  (begin
    ;; Pastikan yang set nama adalah pemilik token tersebut (cek via contract-call ke NFT core jika perlu, atau logic ownership)
    ;; Untuk kesederhanaan di sini kita simpan langsung
    (map-set profile-data token-id name)
    (ok true)))

;; Read Only
(define-read-only (getIdentityId (user principal))
 (default-to u0 (map-get? identity-map user)))

(define-read-only (getProfileName (token-id uint))
  (map-get? profile-data token-id))
