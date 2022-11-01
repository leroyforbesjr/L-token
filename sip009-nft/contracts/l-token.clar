
;; l-token
;; my first NFT project



(impl-trait .sip009-nft-trait.sip009-nft-trait)
;; SIP009 NFT trait on mainnet
;; (impl-trait 'SP2PABAF9FTAJYNFZH93XENAJ8FVY99RRM50D2JG9.nft-trait.nft-trait)

(define-constant contract-owner tx-sender)
ST1SJ3DTE5DN7X54YDH5D64R3BCB6A2AG2ZQ8YPD5
(define-constant err-owner-only (err u100))

(define-constant err-not-token-owner (err u101))

(define-non-fungible-token l-token uint)

(define-data-var last-token-id uint u0)

(define-read-only (get-last-token-id)
	(ok (var-get last-token-id))
)

(define-read-only (get-token-uri (token-id uint))
	(ok none)
)

(define-read-only (get-owner (token-id uint))
	(ok (nft-get-owner? l-token token-id))
)

(define-public (transfer (token-id uint) (sender principal) (recipient principal))
	(begin
		(asserts! (is-eq tx-sender sender) err-not-token-owner)
		(nft-transfer? l-token token-id sender recipient)
	)
)

(define-public (mint (recipient principal))
	(let
		(
			(token-id (+ (var-get last-token-id) u1))
		)
		(asserts! (is-eq tx-sender contract-owner) err-owner-only)
		(try! (nft-mint? l-token token-id recipient))
		(var-set last-token-id token-id)
		(ok token-id)
	)
)
