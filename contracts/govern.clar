;; ProposalNet Governance Smart Contract
;; Allows community members to create, vote on, and execute proposals

(define-constant contract-owner tx-sender)
(define-constant err-not-owner (err u100))
(define-constant err-proposal-not-found (err u101))
(define-constant err-already-voted (err u102))
(define-constant err-voting-closed (err u103))
(define-constant err-insufficient-votes (err u104))

;; Proposal structure
(define-map proposals
  {proposal-id: uint}
  {
    creator: principal,
    description: (string-utf8 500),
    voting-start: uint,
    voting-end: uint,
    votes-for: uint,
    votes-against: uint,
    executed: bool
  }
)

;; Voter tracking
(define-map voter-votes
  {proposal-id: uint, voter: principal}
  {has-voted: bool}
)

;; Proposal counter
(define-data-var next-proposal-id uint u0)

;; Create a new proposal
(define-public (create-proposal (description (string-utf8 500)) (voting-duration uint))
  (let 
    (
      (proposal-id (var-get next-proposal-id))
      (current-block block-height)
    )
    (asserts! (> voting-duration u0) err-not-owner)
    
    (map-set proposals 
      {proposal-id: proposal-id}
      {
        creator: tx-sender,
        description: description,
        voting-start: current-block,
        voting-end: (+ current-block voting-duration),
        votes-for: u0,
        votes-against: u0,
        executed: false
      }
    )
    
    (var-set next-proposal-id (+ proposal-id u1))
    (ok proposal-id)
  )
)

;; Vote on a proposal
(define-public (vote (proposal-id uint) (vote-direction bool))
  (let 
    (
      (proposal (unwrap! (map-get? proposals {proposal-id: proposal-id}) err-proposal-not-found))
      (current-block block-height)
    )
    ;; Check if voting is still open
    (asserts! (< current-block (get voting-end proposal)) err-voting-closed)
    
    ;; Check if voter has already voted
    (asserts! (is-eq (default-to false (map-get? voter-votes {proposal-id: proposal-id, voter: tx-sender})) false) err-already-voted)
    
    ;; Record vote
    (map-set voter-votes 
      {proposal-id: proposal-id, voter: tx-sender}
      {has-voted: true}
    )
    
    ;; Update proposal votes
    (if vote-direction 
      (map-set proposals 
        {proposal-id: proposal-id}
        (merge proposal {votes-for: (+ (get votes-for proposal) u1)})
      )
      (map-set proposals 
        {proposal-id: proposal-id}
        (merge proposal {votes-against: (+ (get votes-against proposal) u1)})
      )
    )
    
    (ok true)
  )
)

;; Execute a proposal
(define-public (execute-proposal (proposal-id uint))
  (let 
    (
      (proposal (unwrap! (map-get? proposals {proposal-id: proposal-id}) err-proposal-not-found))
      (current-block block-height)
    )
    ;; Ensure voting is closed
    (asserts! (>= current-block (get voting-end proposal)) err-voting-closed)
    
    ;; Check if proposal is not already executed
    (asserts! (not (get executed proposal)) err-proposal-not-found)
    
    ;; Require a majority of votes
    (asserts! (> (get votes-for proposal) (get votes-against proposal)) err-insufficient-votes)
    
    ;; Mark proposal as executed
    (map-set proposals 
      {proposal-id: proposal-id}
      (merge proposal {executed: true})
    )
    
    (ok true)
  )
)

;; Read proposal details
(define-read-only (get-proposal-details (proposal-id uint))
  (map-get? proposals {proposal-id: proposal-id})
)