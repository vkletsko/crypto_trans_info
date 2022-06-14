// import http from "../http-common";
import api from "../api/transactions";
import ITransactionData from "../types/transaction.type"


class TransactionDataService {

  get(tx_hash: string) {
    return api.get<ITransactionData>(`/api/v1/tx/${tx_hash}`);
  }

}

export default new TransactionDataService();