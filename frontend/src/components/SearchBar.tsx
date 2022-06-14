import React, {Component, useEffect, useState } from 'react'
import axios from 'axios';
import "./SearchBar.css"
import ITransactionData from "../types/transaction.type"
import TransactionDataService from "../services/transaction.service";
import { TransactionItem } from "./TransactionItem"
import { Notification } from './Notification';
import { Axios, AxiosError } from 'axios';

interface Props {
}

type State = {
  currentTransaction: ITransactionData | null;
  currentTxHash: string | null
  notification: string | null
}

export default class SearchBar extends Component<Props, State> {
  constructor(props: Props) {
    super(props);

    this.getTransaction = this.getTransaction.bind(this);
    this.handleOnSubmit = this.handleOnSubmit.bind(this);
    this.onChangeTxHash = this.onChangeTxHash.bind(this);

    this.state = { 
      currentTransaction: null,
      // currentTransaction: {
      //   hash: "0x7a3a1a72d8edbf8d25edde759d1142369397f8e1e69751f48f9dadfc0423993d",
      //   from: "0x49566edb6bcca216f5e539cfb032a3205a91f8ba",
      //   to: "0x49566edb6bcca216f5e539cfb032a3205a91f8ba",
      //   status: "fail",
      //   block_number: 14938261,
      //   block_confirmations: 616,
      //   value: "0.1469",
      //   gas_price: "0.000000032934654174",
      //   gas: 21000
      // },
      currentTxHash: null,
      notification: null
    };
  }


  onChangeTxHash(e: React.FormEvent<HTMLInputElement>){
    this.setState({currentTxHash: e.currentTarget.value });
  }


  getTransaction(tx_hash: string) {
    TransactionDataService.get(tx_hash)
      .then((response: any) => {
        if (response.data.code === 0){
          this.setState({
            currentTransaction: response.data.data,
            notification: null
          });
        } else {
          this.setState({
            currentTransaction: null,
            notification: response.data.error.message
          });
          console.log(response.data);
        }
      })
      .catch((err: Error | AxiosError) => {
        this.setState({
          currentTransaction: null,
          notification: "unknown server error"
        });
      });
  }


  handleOnSubmit(e: React.FormEvent<HTMLFormElement>) {
    e.preventDefault();

    const currentTxHash = this.state.currentTxHash;
    
    if (!currentTxHash) return;

    this.getTransaction(currentTxHash);

  }

  render() {
    const { currentTransaction, notification } = this.state;

    return(
      <div className="search_form">
        <form className="input_form" onSubmit={this.handleOnSubmit}>
          <input 
            className="input_field" 
            name="txhash" 
            type="text" 
            size={68}
            value={this.state.currentTxHash as string} 
            placeholder="Search by Tx Hash"
            onChange={this.onChangeTxHash}
            />
          <button className="search_btn" type="submit">Find</button>

        </form>

        {notification != null && (<Notification message={notification}/>)}

        {currentTransaction != null && (
            <TransactionItem 
              tx_hash={currentTransaction.hash} 
              from={currentTransaction.from}
              to={currentTransaction.to}
              status={currentTransaction.status} 
              block_number={currentTransaction.block_number}
              block_confirmations={currentTransaction.block_confirmations}
              gas={currentTransaction.gas}
              gas_price={currentTransaction.gas_price}
              value={currentTransaction.value} />
        )}
      </div>
    );
  }

}