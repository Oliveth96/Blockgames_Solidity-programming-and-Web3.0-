//SPDX-License-Identifier: MIT
pragma solidity  ^0.8.6;

contract OllieTokenShib {
    string public name;
    string public symbol;
    uint256 public decimals;
    uint256 public totalSupply;

    mapping(address => uint256) public balanceOf; //This is to know the balance of token in every wallet hodling my OST
    mapping(address => mapping(address => uint256)) public allowance;


    //Below is how we log events and transactions on the eth chain
    event Transfer(address indexed from, address indexed to, uint256 value); //The address it's coming from, the address its going to and value.
    event Approval(address indexed owner, address indexed spender, uint256 value);

    constructor(string memory _name, string memory _symbol, uint _decimals, uint _totalSupply) {
        name = _name;
        symbol = _symbol;
        decimals = _decimals;
        totalSupply = _totalSupply;
        balanceOf[msg.sender] = totalSupply; //Take totalSupply and assign it to me: the contract deployer
    }

    function transfer(address _to, uint256 _value) external returns  (bool success) {
        require(balanceOf[msg.sender] >= _value);//Message sender is greater or equals to the value that's being passed in
        balanceOf[msg.sender] = balanceOf[msg.sender] - (_value); //This value that's passing withh be debit from msg i.e deployer's account
        balanceOf[_to] = balanceOf[_to] + (_value); //And we will credit it to the other person's account
        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    function transferFrom(address _from, address _to, uint256 _value) external returns (bool) { //This is used when a hodler of my OST sends it to another wallet or where an Exchange sells my OST on my behalf.
        require(_value <= balanceOf[_from]);
        require(_value <= allowance[_from][msg.sender]);
        allowance[_from][msg.sender] = allowance[_from][msg.sender] - (_value);
        emit Transfer(_from, _to, _value);
        return true;
    }

    function approve(address _spender, uint256 _value) external returns (bool) {
        require(_spender != address(0));
        allowance[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    function buyToken(address _receiver, uint256 _value) public payable returns(bool){
       require(msg.value >= 0, "You cannot mint GDF with zero ETH");
        uint256 amount = msg.value/10**17 * 1000;
        balanceOf[_receiver] += amount;
        totalSupply += amount;
        return true ;
    }

}