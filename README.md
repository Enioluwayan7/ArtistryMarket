# ArtistryMarket: Decentralized Artwork Marketplace

ArtistryMarket is a decentralized platform built on Clarity that enables artists to list, showcase, and sell their artwork directly to collectors without intermediaries.

## Overview

ArtistryMarket creates a transparent marketplace where artists maintain full control over their work while connecting with art enthusiasts worldwide. The platform allows artists to list their creations with detailed information about medium, style, and pricing.

## Features

- List artwork with comprehensive details (title, description, medium, style)
- Set your own prices without platform fees
- Delist artwork when sold or no longer available
- Browse available artwork by medium, style, or artist
- Transparent artist verification and ownership tracking

## Contract Functions

### Public Functions

- `list-artwork`: Add a new artwork to the marketplace
- `delist-artwork`: Remove an artwork from active listings
- `get-artwork`: Retrieve details about a specific artwork
- `get-artist`: Get the creator of a specific artwork

### Constants

- Minimum price requirements
- Validation for art mediums and styles
- Error codes for various failure scenarios

## Data Structure

Each artwork listing contains:
- Artist information (principal)
- Artwork title (string)
- Description (string)
- Medium used (oil, acrylic, digital, etc.)
- Artistic style
- Availability status
- Price in microstacks

## Getting Started

To interact with the ArtistryMarket platform:

1. Deploy the contract to a Stacks blockchain node
2. Call the contract functions using a compatible wallet or Clarity development environment
3. List your artwork with appropriate details and pricing
4. Browse available artwork from other artists

## Future Development

- Implement direct purchase functionality
- Add commission system for galleries and curators
- Create artist verification and reputation system
- Support for limited edition digital artwork and NFTs
- Exhibition and showcase features