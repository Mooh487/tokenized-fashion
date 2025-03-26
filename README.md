# Sustainable Fashion Tokenization Smart Contract

## Overview
This Clarity smart contract facilitates the tokenization of sustainable fashion assets on the Stacks blockchain. It enables the minting and trading of unique fashion assets, incorporates sustainability scoring, and includes a marketplace for asset transactions.

## Features
1. **Fungible Token (SUSTAINABLE-TOKEN):** A fungible token with an initial supply of 1,000,000,000.
2. **Non-Fungible Token (FashionAsset):** A non-fungible token representing unique fashion items.
3. **Fashion Registry:** A map storing asset details, including owner, metadata, and sustainability score.
4. **Marketplace:** A listing system for users to buy and sell fashion assets using SUSTAINABLE-TOKEN.
5. **Transfer and Ownership Management:** Secure transfer of assets between owners.
6. **Sustainability Score Updates:** Owners can update the sustainability score of their assets.

## Smart Contract Functions

### 1. Minting a Fashion Asset
```clarity
(define-public (mint-fashion-asset (id uint) (owner principal) (metadata (string-ascii 256)) (score uint))
```
- Mints a new fashion asset.
- Requires a unique `id`.
- Stores metadata and sustainability score.
- The asset is assigned to the specified owner.

### 2. Transferring a Fashion Asset
```clarity
(define-public (transfer-fashion-asset (id uint) (new-owner principal))
```
- Allows the owner to transfer their asset to another principal.
- Ensures only the owner can initiate the transfer.

### 3. Updating Sustainability Score
```clarity
(define-public (update-sustainability-score (id uint) (new-score uint))
```
- Allows the owner to update the sustainability score of their asset.
- Ensures only the asset owner can make this update.

### 4. Fetching Fashion Asset Data
```clarity
(define-read-only (get-fashion-asset (id uint))
```
- Retrieves the details of a given fashion asset.

### 5. Listing an Asset for Sale
```clarity
(define-public (list-fashion-asset (id uint) (price uint))
```
- Allows an asset owner to list their item for sale at a specified price.
- Ensures only the owner can list the asset.

### 6. Purchasing a Listed Asset
```clarity
(define-public (purchase-fashion-asset (id uint))
```
- Enables users to buy a listed asset by paying the required amount in SUSTAINABLE-TOKEN.
- Ensures the buyer has sufficient balance.
- Automatically transfers ownership of the asset upon successful payment.

### 7. Removing a Listing
```clarity
(define-public (remove-listing (id uint))
```
- Allows a seller to remove their listed asset from the marketplace.
- Ensures only the seller can remove the listing.

### 8. Fetching a Marketplace Listing
```clarity
(define-read-only (get-listing (id uint))
```
- Retrieves the details of a listed fashion asset.

## Deployment and Usage

### Prerequisites
- Stacks Blockchain environment
- Clarity smart contract deployment tools (e.g., Clarinet)
- SUSTAINABLE-TOKEN setup

### Deployment Steps
1. Compile and deploy the contract using Clarinet or Stacks CLI.
2. Mint fashion assets and interact with the registry.
3. List assets for sale and facilitate transactions using the marketplace functions.

## Security Considerations
- **Ownership Verification:** Ensures that only the asset owner can modify metadata, transfer ownership, or list items for sale.
- **Sufficient Token Balance:** Ensures the buyer has enough SUSTAINABLE-TOKEN before completing a purchase.
- **Preventing Duplicate Assets:** Ensures unique asset IDs to avoid duplication.

## Future Enhancements
- Implementing royalty mechanisms for designers.
- Integrating on-chain sustainability verification systems.
- Expanding asset metadata for richer details and provenance tracking.



