# ProposalNet: Decentralized Community Governance Platform

## Overview

ProposalNet is a blockchain-based governance platform that enables decentralized decision-making through transparent and secure proposal voting.

## Smart Contract Features

- Create proposals with descriptions
- Vote on active proposals
- Execute proposals with majority support
- Prevent double voting
- Track proposal lifecycle

## Contract Functions

### `create-proposal`
- Create a new governance proposal
- Specify proposal description and voting duration
- Returns unique proposal ID

### `vote`
- Cast a vote (for or against) on an active proposal
- Prevents multiple votes from the same address
- Tracks vote count

### `execute-proposal`
- Execute a proposal that has passed voting
- Requires majority support
- Prevents re-execution of proposals

### `get-proposal-details`
- Retrieve full details of a specific proposal

## Technical Details

- Blockchain: Stacks (Clarity smart contract)
- Language: Clarity
- Governance Model: Direct democracy
- Vote Requirement: Simple majority

## Setup and Deployment

1. Ensure you have a Stacks wallet
2. Deploy the smart contract to Stacks blockchain
3. Interact through compatible wallet or interface

## Security Considerations

- Proposals have a defined voting duration
- Double voting is prevented
- Only proposals with majority support can be executed

## Contributing

Contributions are welcome! Please submit pull requests or open issues on our GitHub repository.
