pragma solidity ^0.4.20;

interface AbstractMultiSig {

  /*
   * This event should be dispatched whenever the contract receives
   * any contribution.
   */
  event ReceivedContribution(address indexed _contributor, uint valueInWei);
  
  /*
   * When this contract is initially created, it's in the state 
   * "Accepting contributions". No proposals can be sent, no withdraw
   * and no vote can be made while in this state. After this function
   * is called, the contract state changes to "Active" in which it will
   * not accept contributions anymore and will accept all other functions
   * (submit proposal, vote, withdraw)
   */
  function endContributionPeriod() external;

  /*
   * Sends a withdraw proposal to the contract. The beneficiary would
   * be "_beneficiary" and if approved, this address will be able to
   * withdraw "value" Ethers.
   *
   * This contract should be able to handle many proposals at once.
   */
  function submitProposal(uint _value) external;
  event ProposalSubmitted(address indexed _beneficiary, uint _value);

  /*
   * Returns a list of beneficiaries for the open proposals. Open
   * proposal is the one in which the majority of voters have not
   * voted yet.
   */
  function listOpenBeneficiariesProposals() external view returns (address[]);

  /*
   * Returns the value requested by the given beneficiary in his proposal.
   */
  function getBeneficiaryProposal(address _beneficiary) external view returns (uint);

  /*
   * List the addresses of the contributors, which are people that sent
   * Ether to this contract.
   */
  function listContributors() external view returns (address[]);

  /*
   * Returns the amount sent by the given contributor in Wei.
   */
  function getContributorAmount(address _contributor) external view returns (uint);

  /*
   * Approve the proposal for the given beneficiary
   */
  function approve(address _beneficiary) external;
  event ProposalApproved(address indexed _approver, address indexed _beneficiary, uint _value);

  /*
   * Reject the proposal of the given beneficiary
   */
  function reject(address _beneficiary) external;
  event ProposalRejected(address indexed _approver, address indexed _beneficiary, uint _value);

  /*
   * Withdraw the specified value in Wei from the wallet.
   * The beneficiary can withdraw any value less than or equal the value
   * he/she proposed. If he/she wants to withdraw more, a new proposal
   * should be sent.
   *
   */
  function withdraw(uint _value) external;
  event WithdrawPerformed(address indexed beneficiary, uint _value);

}
