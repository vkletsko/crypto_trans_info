export default interface ITransactionData {
        hash: string;
        from: string;
        to: string;
        status: string;
        block_number: number;
        block_confirmations: number;
        gas: number;
        gas_price: string;
        value: string;
}