# AFA Identity Stack - API Reference

## Identity Module (`afa-identity-nft`)
- **mintIdentity**: Mencetak NFT identitas baru untuk pengirim.
- **ownerOf(id)**: Mengembalikan alamat pemilik dari ID tertentu.

## Subscription Module (`afa-subscription`)
- **isPremium(token-id)**: Memvalidasi apakah identitas memiliki status premium aktif.
- **getPremiumExpiration(token-id)**: Mengambil tinggi blok (block-height) waktu kedaluwarsa.
