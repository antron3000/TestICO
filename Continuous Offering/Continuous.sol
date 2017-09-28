// This contract dispenses roughly 0.01% of the ICO supply for every 1 eth contributed. 
// Thus for every eth sent to the contract, the price of the token increases and the supply is never fully depleted. 

<<<<<<< HEAD
import "./StandardToken.sol";

library Math {

    function multiply (uint a, uint b, uint decimals) internal constant returns (uint) {
        return a*b/10**decimals;
    }
    
    function divide (uint a, uint b, uint decimals) internal constant returns (uint) {
        return a*10**decimals/b;
    }
    
}

contract ContinuousOffering is StandardToken {
=======
contract Bubble is StandardToken {
>>>>>>> 8071bea0a1406b9d7fa58e779dafa34c7b6e040f


    /* Public variables of the token */

    /*
    NOTE:
    The following variables are OPTIONAL vanities. One does not have to include them.
    They allow one to customise the token contract & in no way influences the core functionality.
    Some wallets/interfaces might not even bother to look at this information.
    */
    string public name;                   //fancy name: eg Simon Bucks
    uint8 public decimals;                //How many decimals to show. ie. There could 1000 base units with 3 decimals. Meaning 0.980 SBX = 980 base units. It's like comparing 1 wei to 1 ether.
    string public symbol;                 //An identifier: eg SBX
    string public version = 'H0.1';       //human 0.1 standard. Just an arbitrary versioning scheme.
    uint leftoverWei;                   //Wei left at current price
    uint WpT;                           //Wei per Bulbble
    uint public ICOSupply;              //Total ICO Supply

    function () payable {


       
    
    Dispense(msg.sender,msg.value);

  
        

        }

function DispenseToAddress(address _address) payable{
    
    Dispense(_address,msg.value);
}

function Dispense(address _address, uint _contribution) payable{
                    uint Reward = 0; //token reward

            uint TokenstoGive;

    //give reward, new price calculated for every 1 eth sent
        while (_contribution>leftoverWei) {
            _contribution -= leftoverWei; 
            TokenstoGive = Math.divide(leftoverWei,WpT,0);
            Reward += TokenstoGive;
            ICOSupply -= TokenstoGive;
            WpT = CalculateWpT();
            leftoverWei = 1000000000000000000;

        }

        //give out reward for remaining wei in contribution
            leftoverWei -= _contribution;
            TokenstoGive = Math.divide(_contribution,WpT,0);
            Reward += TokenstoGive;
            ICOSupply -= TokenstoGive;
            balances[_address] += Reward;

    
}

    function Tokens(
        ) {
        balances[msg.sender] = 3333333333333333;               // Give the creator all initial tokens
        totalSupply = 8888888888888888;                        // Update total supply
        name = "Tokens";                                   // Set the name for display purposes
        decimals = 8;                            // Amount of decimals for display purposes
        symbol = "CNT";                               // Set the symbol for display purposes
        ICOSupply = 5555555555555555;
        leftoverWei = 1000000000000000000;
             WpT = CalculateWpT();

    }

 
    //Calculate Wei per Token
    function CalculateWpT() returns (uint) {
        var TokensPerEth = Math.divide(ICOSupply,8888,0);
        
        return Math.divide(1000000000000000000,TokensPerEth,0);
    }

    /* Approves and then calls the receiving contract */
    function approveAndCall(address _spender, uint256 _value, bytes _extraData) returns (bool success) {
        allowed[msg.sender][_spender] = _value;
        Approval(msg.sender, _spender, _value);

        //call the receiveApproval function on the contract you want to be notified. This crafts the function signature manually so one doesn't have to include a contract in here just for this.
        //receiveApproval(address _from, uint256 _value, address _tokenContract, bytes _extraData)
        //it is assumed that when does this that the call *should* succeed, otherwise one would use vanilla approve instead.
        if(!_spender.call(bytes4(bytes32(sha3("receiveApproval(address,uint256,address,bytes)"))), msg.sender, _value, this, _extraData)) { throw; }
        return true;
    }
}

