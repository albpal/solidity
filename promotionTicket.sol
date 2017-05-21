pragma solidity ^0.4.11;

contract PromotionTicket {
    address issuer;

    mapping (address => uint) public tickets;

    event TicketOffered(address to);
    event TicketUsed(address ticket, address place);

    function PromotionTicket() { issuer = msg.sender; }
    function isTheTicketValidToBeOffered(address ticket) returns (bool){
      if (tickets[ticket] == 1 || tickets[ticket] == 2)
          return false;
      return true;
    }
    function isTheTicketValidToBeUsed(address ticket) returns (bool){
      if (tickets[ticket] != 1)
          return false;
      return true;
    }
    function markTicketAsOffered(address ticket){
      tickets[ticket] = 1;
      TicketOffered(ticket);
    }
    function markTicketAsUsed(address ticket){
      tickets[ticket] = 2;
      TicketUsed(ticket, msg.sender);
    }
    function offer(address ticket) returns (uint) {
        if (msg.sender != issuer) return 1;
        if (!isTheTicketValidToBeOffered(ticket))
            return 2;
        markTicketAsOffered(ticket);
        return 0;
    }
    function use(address ticket) returns (uint) {
        if (!isTheTicketValidToBeUsed(ticket))
            return 1;
        markTicketAsUsed(ticket);
    }
}
