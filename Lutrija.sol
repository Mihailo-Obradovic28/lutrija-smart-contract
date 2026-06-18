// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Lutrija {
    address public vlasnik;
    address[] public igraci;
    uint public cenaUlaznice;

    constructor(uint _cenaUlaznice) {
        vlasnik = msg.sender;
        cenaUlaznice = _cenaUlaznice;
    }
    modifier samoVlasnik(){
        require(msg.sender==vlasnik,"Samo vlasnik moze ovo");
        _;
    }
    function ucestvuj() public payable {
        require(msg.value==cenaUlaznice,"Pogresna suma ETH");
        require(msg.sender!=vlasnik,"Vlasnik ne moze ucestvovati");

        for(uint i=0;i<igraci.length;i++){
            require(igraci[i]!=msg.sender,"Vec si prijavljen");
        }
        igraci.push(msg.sender);
    }
    function brojIgraca()public view returns(uint){
        return igraci.length;
    }

    function izaberiPobednika() public samoVlasnik{
        require(igraci.length>=2,"Potrebno najmanje 2 igraca");
        uint index = uint(keccak256(abi.encodePacked(
            block.timestamp,
            block.prevrandao,
            igraci.length
        )))%igraci.length;
        address pobednik = igraci[index];

        (bool uspeh,)=pobednik.call{value:address(this).balance}("");
        require(uspeh,"Transfer nije uspeo");

        igraci = new address[](0);
    }

    function getStanje() public view returns(uint){
        return address(this).balance;
    }
}