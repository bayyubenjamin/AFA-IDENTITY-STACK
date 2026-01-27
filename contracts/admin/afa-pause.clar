;; afa-pause.clar
;; Kontrak untuk mekanisme penghentian darurat protokol

(define-data-var is-paused bool false)
(define-data-var guardian principal tx-sender)

;; Cek status protokol
(define-read-only (is-protocol-paused) 
    (var-get is-paused)
)

;; Fungsi untuk mengubah status (hanya untuk guardian)
(define-public (set-paused (paused bool))
  (begin
    (asserts! (is-eq tx-sender (var-get guardian)) (err u403))
    (ok (var-set is-paused paused))
  )
)
