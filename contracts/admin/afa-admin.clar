(define-data-var contract-owner principal tx-sender)
(define-data-var proposed-owner (optional principal) none)

;; Events
(define-constant event-ownership-transferred "ownership-transferred")
(define-constant event-ownership-renounced "ownership-renounced")
(define-constant event-ownership-proposed "ownership-proposed")
(define-constant event-ownership-accepted "ownership-accepted")
(define-constant event-ownership-revoked "ownership-revoked")

;; Error codes
(define-constant err-not-owner (err u401))
(define-constant err-no-proposal (err u402))
(define-constant err-already-proposed (err u403))
(define-constant err-invalid-address (err u404))

(define-read-only (get-owner) 
  (var-get contract-owner)
)

(define-read-only (get-proposed-owner) 
  (var-get proposed-owner)
)

;; Transfer ownership directly (one-step transfer)
(define-public (transfer-ownership (new-owner principal))
  (begin
    (asserts! (is-eq tx-sender (var-get contract-owner)) err-not-owner)
    (asserts! (not (is-eq new-owner (var-get contract-owner))) err-invalid-address)
    
    (let ((old-owner (var-get contract-owner)))
      (var-set contract-owner new-owner)
      (var-set proposed-owner none)
      
      ;; Emit ownership transferred event
      (print {
        event: event-ownership-transferred,
        previous-owner: old-owner,
        new-owner: new-owner,
        block-height: stacks-block-height,
        tx-sender: tx-sender
      })
      
      (ok true)
    )
  )
)

;; Two-step transfer: propose new owner
(define-public (propose-owner (new-owner principal))
  (begin
    (asserts! (is-eq tx-sender (var-get contract-owner)) err-not-owner)
    (asserts! (not (is-eq new-owner (var-get contract-owner))) err-invalid-address)
    (asserts! (is-none (var-get proposed-owner)) err-already-proposed)
    
    (var-set proposed-owner (some new-owner))
    
    ;; Emit ownership proposed event
    (print {
      event: event-ownership-proposed,
      proposer: tx-sender,
      proposed-owner: new-owner,
      block-height: stacks-block-height
    })
    
    (ok true)
  )
)

;; Accept proposed ownership (called by the proposed owner)
(define-public (accept-ownership)
  (let ((proposed-opt (var-get proposed-owner)))
    (if (is-some proposed-opt)
      (let ((proposed (unwrap-panic proposed-opt)))
        (if (is-eq tx-sender proposed)
          (let ((old-owner (var-get contract-owner)))
            (var-set contract-owner proposed)
            (var-set proposed-owner none)
            (print {
              event: event-ownership-accepted,
              previous-owner: old-owner,
              new-owner: proposed,
              block-height: stacks-block-height,
              accepted-by: tx-sender
            })
            (ok true)
          )
          (err err-not-owner)
        )
      )
      (err err-no-proposal)
    )
  )
)

;; Revoke ownership proposal (current owner can cancel)
(define-public (revoke-proposal)
  (begin
    (asserts! (is-eq tx-sender (var-get contract-owner)) err-not-owner)
    (asserts! (is-some (var-get proposed-owner)) err-no-proposal)
    (let ((proposed (unwrap-panic (var-get proposed-owner))))
      (var-set proposed-owner none)
      (print {
        event: event-ownership-revoked,
        revoked-by: tx-sender,
        previous-proposed: proposed,
        block-height: stacks-block-height
      })
      (ok true)
    )
  )
)

;; Renounce ownership (transfer to zero address/burn)
(define-public (renounce-ownership)
  (begin
    (asserts! (is-eq tx-sender (var-get contract-owner)) err-not-owner)
    (let ((old-owner (var-get contract-owner)))
      (var-set contract-owner 'SP000000000000000000002Q6VF78)
      (var-set proposed-owner none)
      (print {
        event: event-ownership-renounced,
        previous-owner: old-owner,
        new-owner: 'SP000000000000000000002Q6VF78,
        block-height: stacks-block-height,
        renounced-by: tx-sender
      })
      (ok true)
    )
  )
)

;; Emergency ownership recovery (in case of issues)
(define-public (emergency-recover (new-owner principal))
  (begin
    (asserts! (is-eq tx-sender (var-get contract-owner)) err-not-owner)
    (asserts! (not (is-eq new-owner (var-get contract-owner))) err-invalid-address)
    (let ((old-owner (var-get contract-owner)))
      (var-set contract-owner new-owner)
      (var-set proposed-owner none)
      (print {
        event: "emergency-recovery",
        previous-owner: old-owner,
        new-owner: new-owner,
        block-height: stacks-block-height,
        triggered-by: tx-sender,
        reason: "emergency"
      })
      (ok true)
    )
  )
)

;; Read-only functions for ownership info
(define-read-only (get-ownership-info)
  {
    current-owner: (var-get contract-owner),
    proposed-owner: (var-get proposed-owner),
    is-proposed: (is-some (var-get proposed-owner))
  }
)

;; Helper to check if an address is owner
(define-read-only (is-owner (address principal))
  (is-eq address (var-get contract-owner))
)

;; Helper to check if an address is proposed owner
(define-read-only (is-proposed-owner (address principal))
  (let ((proposed-opt (var-get proposed-owner)))
    (if (is-some proposed-opt)
      (is-eq address (unwrap-panic proposed-opt))
      false
    )
  )
)
