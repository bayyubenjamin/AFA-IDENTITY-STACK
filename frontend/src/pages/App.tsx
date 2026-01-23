
import { showConnect } from '@stacks/connect';

export default function App(){
 return (
  <div>
    <h1>AFA Identity Protocol</h1>
    <button onClick={()=>showConnect({appDetails:{name:"AFA",icon:""},onFinish:()=>{}})}>
      Connect Wallet
    </button>
  </div>
 )
}
