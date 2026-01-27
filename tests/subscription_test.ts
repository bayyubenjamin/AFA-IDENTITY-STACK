import { Clarinet, Tx, Chain, Account, types } from "https://deno.land/x/clarinet/index.ts"\;

Clarinet.test({
  name: "Alur upgrade langganan premium berhasil",
  async fn(chain: Chain, accounts: Map<string, Account>) {
    let user = accounts.get("wallet_1")!;
    let block = chain.mineBlock([
      Tx.contractCall("afa-subscription", "upgradeToPremium", [types.uint(1), types.uint(2)], user.address)
    ]);
    block.receipts[0].result.expectOk();
  }
});
