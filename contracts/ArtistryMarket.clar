;; ArtistryMarket: Decentralized Artwork Marketplace
;; Version: 1.0.0
(define-constant ERR-NOT-AUTHORIZED (err u1))
(define-constant ERR-ARTWORK-NOT-FOUND (err u2))
(define-constant ERR-ALREADY-LISTED (err u3))
(define-constant ERR-INVALID-STATUS (err u4))
(define-constant ERR-INVALID-PRICE (err u5))
(define-constant ERR-INVALID-MEDIUM (err u6))
(define-constant ERR-INVALID-STYLE (err u7))
(define-constant ERR-INVALID-TITLE (err u8))
(define-constant ERR-INVALID-DESCRIPTION (err u9))
(define-constant MIN-PRICE u100)
(define-data-var next-artwork-id uint u1)
(define-map artworks
    uint
    {
        artist: principal,
        title: (string-utf8 50),
        description: (string-utf8 200),
        medium: (string-utf8 15),
        style: (string-utf8 20),
        status: (string-utf8 10),
        price: uint
    }
)
(define-private (validate-medium (medium (string-utf8 15)))
    (or 
        (is-eq medium u"Oil")
        (is-eq medium u"Acrylic")
        (is-eq medium u"Watercolor")
        (is-eq medium u"Digital")
        (is-eq medium u"Sculpture")
        (is-eq medium u"Photography")
    )
)
(define-private (validate-style (style (string-utf8 20)))
    (or 
        (is-eq style u"Abstract")
        (is-eq style u"Realism")
        (is-eq style u"Impressionism")
        (is-eq style u"Surrealism")
        (is-eq style u"Contemporary")
    )
)
(define-private (validate-text-length (text (string-utf8 200)) (min-length uint) (max-length uint))
    (let 
        (
            (text-length (len text))
        )
        (and 
            (>= text-length min-length)
            (<= text-length max-length)
        )
    )
)
(define-public (list-artwork 
    (title (string-utf8 50))
    (description (string-utf8 200))
    (medium (string-utf8 15))
    (style (string-utf8 20))
    (price uint)
)
    (let
        (
            (artwork-id (var-get next-artwork-id))
        )
        (asserts! (validate-text-length title u3 u50) ERR-INVALID-TITLE)
        (asserts! (validate-text-length description u10 u200) ERR-INVALID-DESCRIPTION)
        (asserts! (>= price MIN-PRICE) ERR-INVALID-PRICE)
        (asserts! (validate-medium medium) ERR-INVALID-MEDIUM)
        (asserts! (validate-style style) ERR-INVALID-STYLE)
        
        (map-set artworks artwork-id {
            artist: tx-sender,
            title: title,
            description: description,
            medium: medium,
            style: style,
            status: u"for-sale",
            price: price
        })
        (var-set next-artwork-id (+ artwork-id u1))
        (ok artwork-id)
    )
)
(define-public (delist-artwork (artwork-id uint))
    (let
        (
            (artwork (unwrap! (map-get? artworks artwork-id) ERR-ARTWORK-NOT-FOUND))
        )
        (asserts! (is-eq tx-sender (get artist artwork)) ERR-NOT-AUTHORIZED)
        (asserts! (is-eq (get status artwork) u"for-sale") ERR-INVALID-STATUS)
        (ok (map-set artworks artwork-id (merge artwork { status: u"delisted" })))
    )
)
(define-read-only (get-artwork (artwork-id uint))
    (ok (map-get? artworks artwork-id))
)
(define-read-only (get-artist (artwork-id uint))
    (ok (get artist (unwrap! (map-get? artworks artwork-id) ERR-ARTWORK-NOT-FOUND)))
)