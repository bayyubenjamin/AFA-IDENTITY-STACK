
(define-public (withdraw (to principal) (amount uint))
 (stx-transfer? amount (as-contract tx-sender) to))
