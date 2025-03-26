(define-fungible-token SUSTAINABLE-TOKEN 1000000000)

(define-non-fungible-token FashionAsset uint)

(define-map fashion-registry
  ((id uint))
  ((owner principal) (metadata (string-ascii 256)) (sustainability-score uint)))

(define-public (mint-fashion-asset (id uint) (owner principal) (metadata (string-ascii 256)) (score uint))
  (begin
    (asserts! (not (map-get? fashion-registry ((id id)))) "Asset ID already exists")
    (map-set fashion-registry ((id id)) ((owner owner) (metadata metadata) (sustainability-score score)))
    (nft-mint? FashionAsset id owner)))

(define-public (transfer-fashion-asset (id uint) (new-owner principal))
  (let ((asset (map-get? fashion-registry ((id id)))))
    (match asset
      entry (begin
        (asserts! (is-eq tx-sender (get owner entry)) "Unauthorized transfer")
        (map-set fashion-registry ((id id)) ((owner new-owner) (metadata (get metadata entry)) (sustainability-score (get sustainability-score entry))))
        (nft-transfer? FashionAsset id tx-sender new-owner))
      (err "Asset not found"))))

(define-public (update-sustainability-score (id uint) (new-score uint))
  (let ((asset (map-get? fashion-registry ((id id)))))
    (match asset
      entry (begin
        (asserts! (is-eq tx-sender (get owner entry)) "Unauthorized update")
        (map-set fashion-registry ((id id)) ((owner (get owner entry)) (metadata (get metadata entry)) (sustainability-score new-score))))
      (err "Asset not found"))))

(define-read-only (get-fashion-asset (id uint))
  (map-get? fashion-registry ((id id))))

;; New Features Added Below

(define-map marketplace
  ((asset-id uint))
  ((seller principal) (price uint)))

(define-public (list-fashion-asset (id uint) (price uint))
  (let ((asset (map-get? fashion-registry ((id id)))))
    (match asset
      entry (begin
        (asserts! (is-eq tx-sender (get owner entry)) "Only owner can list asset")
        (map-set marketplace ((asset-id id)) ((seller tx-sender) (price price))))
      (err "Asset not found"))))

(define-public (purchase-fashion-asset (id uint))
  (let ((listing (map-get? marketplace ((asset-id id)))))
    (match listing
      entry (begin
        (asserts! (>= (ft-get-balance tx-sender SUSTAINABLE-TOKEN) (get price entry)) "Insufficient balance")
        (ft-transfer? SUSTAINABLE-TOKEN (get price entry) tx-sender (get seller entry))
        (map-delete marketplace ((asset-id id)))
        (transfer-fashion-asset id tx-sender))
      (err "Asset not listed for sale"))))

(define-public (remove-listing (id uint))
  (let ((listing (map-get? marketplace ((asset-id id)))))
    (match listing
      entry (begin
        (asserts! (is-eq tx-sender (get seller entry)) "Only seller can remove listing")
        (map-delete marketplace ((asset-id id))))
      (err "Listing not found"))))

(define-read-only (get-listing (id uint))
  (map-get? marketplace ((asset-id id))))


