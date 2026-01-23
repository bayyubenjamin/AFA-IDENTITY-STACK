
(define-data-var owner principal tx-sender)
(define-map modules (string-ascii 32) principal)

(define-public (register (name (string-ascii 32)) (module principal))
 (begin (asserts! (is-eq tx-sender (var-get owner)) (err u401)) (map-set modules name module) (ok true)))

(define-read-only (getModule (name (string-ascii 32)))
 (map-get? modules name))

(define-public (route (name (string-ascii 32)) (fn (string-ascii 32)) (arg uint))
 (let ((m (unwrap! (map-get? modules name) (err u404))))
  (contract-call? m fn arg)))
