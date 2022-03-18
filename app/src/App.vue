<template>
    <img alt="Vue logo" src="./assets/logo.png" />
    <div>
        <div>
            <h1>Hello Web3</h1>
        </div>
        <div>
            <button v-if="!address" @click="connectWallet">Connect Wallet</button>
        </div>
        <div v-if="address">
            Logged as
            <strong>{{ address.substring(0, 5) + "..." + address.substring(address.length - 5) }}</strong>
        </div>

        <div v-if="address">
            <h2>✋🏻 {{ count }}</h2>
            <button @click="addCount">Say Hi</button>
            <button @click="getCount">getCount</button>
        </div>
    </div>
</template>

<script>
/* eslint-disable */
import { ethers } from 'ethers'

const provider = new ethers.providers.Web3Provider(
    ethereum,
);

// const contractAddress = "0x5FbDB2315678afecb367f032d93F642f64180aa3"
// const contractABI = require("../../artifacts/contracts/Counter.sol/Counter").abi

// Goerli 测试网
const contractAddress = "0xdd8B45a7d1897437941B02182f85be0420cf84B5"
const contractABI = [
    {
        "inputs": [],
        "name": "addcounter",
        "outputs": [],
        "stateMutability": "nonpayable",
        "type": "function"
    },
    {
        "inputs": [],
        "name": "getcounter",
        "outputs": [
            {
                "internalType": "uint256",
                "name": "",
                "type": "uint256"
            }
        ],
        "stateMutability": "view",
        "type": "function"
    }
]

export default {
    name: 'App',
    data() {
        return {
            address: "",
            count: 0
        }
    },
    created() {
        this.getCount()
    },
    methods: {
        async connectWallet() {
            const { ethereum } = window
            ethereum === undefined ?
                alert("请安装小狐狸钱包")
                : [this.address] = await provider.send("eth_requestAccounts", []);
        },
        getCntract() {
            const provider = new ethers.providers.Web3Provider(
                window.ethereum,
            );
            const signer = provider.getSigner()
            const ContractCounter = new ethers.Contract(contractAddress, contractABI, signer)
            return ContractCounter
        },
        async addCount() {
            const ContractCounter = this.getCntract()
            const tx = await ContractCounter.addcounter()
            await tx.wait()
            await this.getCount()
        },
        async getCount() {
            const ContractCounter = this.getCntract()
            const result = await ContractCounter.getcounter()
            this.count = result.toNumber()
        }
    },
}
</script>

<style>
#app {
    font-family: Avenir, Helvetica, Arial, sans-serif;
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
    text-align: center;
    color: #2c3e50;
    margin-top: 60px;
}
</style>
