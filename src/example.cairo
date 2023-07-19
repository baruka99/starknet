#[contract]
mod Example {
    use starknet::get_caller_address;
    use starknet::ContractAddress;

    struct Storage {
        names: LegacyMap::<ContractAddress, felt252>, 
    }

    #[event]
    fn StoredName(caller: ContractAddress, name: felt252) {}

    #[constructor]
    fn constructor(_name: felt252, _address: ContractAddress) {
        names::write(_address, _name);
    }

    #[external]
    fn store_name(_name: felt252) {
        let caller = get_caller_address();
        names::write(caller, _name);
        StoredName(caller, _name);
    }

    #[view]
    fn get_name(_address: ContractAddress) -> felt252 {
        let name = names::read(_address);
        return name;
    }
}
