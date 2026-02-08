;; contracts/modules/afa-subscription.clar
;; Update: Integrasi Pembayaran STX & Validasi Owner

(define-map premium-expirations uint uint)
(define-data-var treasury principal tx-sender) ;; Wallet penampung hasil langganan

;; Read-Only: Cek status premium
(define-read-only (isPremium (token-id uint))
  (> (default-to u0 (map-get? premium-expirations token-id)) block-height))

(define-read-only (getPremiumExpiration (token-id uint))
  (default-to u0 (map-get? premium-expirations token-id)))

;; Public: Upgrade Berbayar
(define-public (upgradeToPremium (token-id uint) (tier uint))
 (let 
    (
      ;; 1. Ambil harga dinamis dari kontrak Pricing
      ;; Menggunakan notasi '.' untuk memanggil kontrak dalam project yang sama
      (price (unwrap! (contract-call? .afa-pricing getPriceForTier tier) (err u500)))
      
      ;; 2. Cek pemilik NFT Identitas saat ini
      (owner (unwrap! (contract-call? .afa-identity-nft ownerOf token-id) (err u404)))
    )
    ;; Validasi A: Pastikan yang melakukan upgrade adalah pemilik identitas
    (asserts! (is-eq tx-sender owner) (err u401))

    ;; Validasi B: Pastikan harga valid (> 0)
    (asserts! (> price u0) (err u402))

    ;; 3. EKSEKUSI PEMBAYARAN (User -> Treasury)
    (try! (stx-transfer? price tx-sender (var-get treasury)))

    ;; 4. Update Status Premium (Durasi ~30 hari / 4320 blok)
    ;; Logika durasi bisa disesuaikan, disini kita set fix 30 hari dari sekarang
    (map-set premium-expirations token-id (+ block-height u4320))
    
    (print {event: "SubscriptionRenewed", tokenId: token-id, tier: tier, price: price, paidTo: (var-get treasury)})
    (ok true)
 )
)

;; Admin: Ganti alamat treasury (penampung dana)
(define-public (setTreasury (new-treasury principal))
  (begin
    ;; Sebaiknya tambahkan admin check disini (asserts! (is-eq tx-sender ...))
    (var-set treasury new-treasury)
    (ok true)))
