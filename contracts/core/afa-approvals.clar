
(define-map approvals uint principal)
(define-map operator-approvals {owner: principal, operator: principal} bool)

(define-public (approve (to principal) (token-id uint))
 (begin (map-set approvals token-id to) (ok true)))

(define-read-only (getApproved (token-id uint))
 (map-get? approvals token-id))

(define-public (setApprovalForAll (operator principal) (approved bool))
 (begin (map-set operator-approvals {owner: tx-sender, operator: operator} approved) (ok true)))

(define-read-only (isApprovedForAll (owner principal) (operator principal))
 (default-to false (map-get? operator-approvals {owner: owner, operator: operator})))
