;; afa-treasury-v1.clar
;; Manajemen keuangan tingkat lanjut untuk protokol AFA

(define-data-var contract-owner principal tx-sender)
(define-map authorized-withdrawers principal bool)

;; Setel izin penarikan
(define-public (set-authorized (address principal) (status bool))
  (begin
    (asserts! (is-eq tx-sender (var-get contract-owner)) (err u401))
    (ok (map-set authorized-withdrawers address status))
  )
)

;; Penarikan dana tersertifikasi
(define-public (authorized-withdraw (amount uint) (recipient principal))
  (begin
    (asserts! (default-to false (map-get? authorized-withdrawers tx-sender)) (err u403))
    (stx-transfer? amount (as-contract tx-sender) recipient)
  )
)
