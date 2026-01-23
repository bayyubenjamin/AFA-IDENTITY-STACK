
import { Clarinet, Tx, Chain, Account, types } from "https://deno.land/x/clarinet/index.ts";

Clarinet.test({
 name: "Mint identity works",
 async fn(chain: Chain, accounts: Map<string, Account>) {
   let user = accounts.get("wallet_1")!;
   let block = chain.mineBlock([
     Tx.contractCall("afa-identity-nft","mintIdentity",[], user.address)
   ]);
   block.receipts[0].result.expectOk();
 }
});
