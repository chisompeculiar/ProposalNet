# ProposalNet: Decentralized Community Governance Platform

## Overview

ProposalNet is a blockchain-based governance platform that enables decentralized decision-making through transparent and secure proposal voting. Built on the Stacks blockchain using Clarity smart contracts, it provides a comprehensive suite of features for community governance.

## Smart Contract Features

- Create and manage community proposals with customizable voting periods
- Democratic voting system with one vote per address
- Proposal lifecycle management (creation, voting, execution, cancellation)
- Real-time proposal status tracking
- Proposal creator controls for duration updates and cancellation
- Built-in safeguards against common governance vulnerabilities

## Contract Functions

### Proposal Management

#### `create-proposal`
- Create a new governance proposal
- Parameters:
  - `description`: UTF-8 string (max 500 characters)
  - `voting-duration`: Duration in blocks
- Returns unique proposal ID

#### `update-voting-duration`
- Modify the voting period of an active proposal
- Only callable by proposal creator
- Cannot modify completed or cancelled proposals

#### `cancel-proposal`
- Cancel an active proposal
- Restricted to proposal creator
- Only possible during voting period

### Voting System

#### `vote`
- Cast a vote (for/against) on an active proposal
- One vote per address
- Automatically tracks vote tallies
- Prevents voting on expired proposals

#### `execute-proposal`
- Execute a completed proposal with majority support
- Automated vote counting validation
- Only executes proposals with more "for" than "against" votes
- Prevents multiple executions

### Query Functions

#### `get-proposal-details`
- Retrieve comprehensive proposal information including:
  - Creator address
  - Proposal description
  - Voting period (start/end)
  - Current vote counts
  - Execution/cancellation status

## Technical Specifications

### Core Components
- **Platform**: Stacks Blockchain
- **Smart Contract Language**: Clarity
- **Governance Model**: Direct democracy with majority voting
- **Testing Framework**: Vitest with mocked blockchain environment

### Data Structures
- Proposal mapping with comprehensive metadata
- Voter tracking system to prevent double voting
- Automated proposal ID counter

### Security Features
- Strict access controls for administrative functions
- Double-vote prevention mechanism
- Timelock controls for voting periods
- Input validation for all parameters
- Protection against proposal manipulation

## Development and Testing

### Test Coverage
The contract includes comprehensive tests for:
- Proposal creation validation
- Voting mechanics
- Execution conditions
- Access control
- Edge cases and error conditions

### Local Development
1. Install Clarinet for local Stacks development
2. Run test suite: `npm test` or `yarn test`
3. Deploy locally for testing: Follow Clarinet deployment guide

### Production Deployment
1. Ensure you have a Stacks wallet with sufficient STX
2. Deploy the smart contract to Stacks mainnet
3. Verify contract deployment and functionality
4. Share contract address with community

## Security Considerations

- **Voting Period**: All proposals have a defined, immutable voting window
- **Vote Integrity**: Double voting prevention through permanent record keeping
- **Access Control**: Function-level permission checking
- **Execution Safety**: Multiple validation checks before proposal execution
- **State Management**: Proper handling of proposal lifecycle states

## Contributing

We welcome contributions to ProposalNet! Please follow these steps:

1. Fork the repository
2. Create a feature branch
3. Add tests for new functionality
4. Submit a pull request

### Development Guidelines
- Follow Clarity best practices
- Maintain test coverage
- Document all changes
- Consider backwards compatibility

