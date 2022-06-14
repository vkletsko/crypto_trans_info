import React from 'react'
import "./TransactionItem.css"

interface Props {
    tx_hash: string;
    from: string;
    to: string;
    status: string;
    block_number: number;
    block_confirmations: number;
    value: string;
    gas_price: string;
    gas: number;
}

export const TransactionItem = (props: Props) => {
    return (
        <div className="data_item">
            <ul>
                <li>Transaction hash: <span>{props.tx_hash}</span></li>
                <li>Satus: <span className={ props.status === 'success' ? 'badge_success' : 'badge_fail'}>{props.status}</span></li>
                <li>Block: <span>{props.block_number}</span></li>
                <li>Block: <span>{props.block_confirmations}</span></li>
                <li>From: <span>{props.from}</span></li>
                <li>To: <span>{props.to}</span></li>
                <li>Value: <span>{props.value} Ether</span></li>
                <li>Gas Limit: <span>{props.gas}</span></li>
                <li>Gas Price: <span>{props.gas_price} </span></li>
            </ul> 
        </div>
    );
}