# 🚩 Challenge #3: 🎟 Multisig Wallet

> ⚠️ **Important:** Please complete **Challenge #2** first if you haven't already, as it contains essential instructions related to all upcoming challenges.

🎛️ Multisig Wallet on Stylus 💼

🚀 Overview

This Rust-based smart contract is a blockchain-powered multi-signature wallet! It enables secure management of funds by requiring multiple confirmations for transactions. Built with the Stylus SDK, it ensures seamless integration with Rust.

✨ Features

- 🔒 Multi-Signature Security: Transactions require approval from a predefined number of wallet owners.

- 📝 Transaction Management: Submit, confirm, revoke, and execute transactions with transparency.

- 👥 Owner Roles: Assign multiple wallet owners with unique permissions.
- 📊 Activity Logs: Emit detailed events for every wallet operation for enhanced auditability.

🌟 Project Goals

1️⃣ Smart Contract: Build a secure multi-signature wallet for managing funds and transactions.


2️⃣ Frontend App: Create a user-friendly interface for submitting and managing transactions.

3️⃣ Deploy: Launch on the Local Nitro DEv Node.

🎉 Let's redefine secure fund management with multi-sig wallets! 🚀

## Checkpoint 0: 📦 Environment Setup 📚

Before you begin, you need to install the following tools:

- [Node (>= v18.17)](https://nodejs.org/en/download/)
- Yarn ([v1](https://classic.yarnpkg.com/en/docs/install/) or [v2+](https://yarnpkg.com/getting-started/install))
- [Git](https://git-scm.com/downloads)

Then download the challenge to your computer and install dependencies by running:

> ⚠️ IMPORTANT: Please make sure to run the below commands through WSL only. In PowerShell, you'll get an error because some files are not supported on Windows.

```sh
git clone -b multi-sig https://github.com/abhi152003/speedrun_stylus.git
cd speedrun_stylus
yarn install
```

> In the same terminal, after all the dependencies have installed, run the below commands to start the local devnode in Docker. You'll need to spin up the Stylus nitro devnode by running the script through commands. This script will deploy the contract and generate the ABI so you can interact with the contracts written in RUST:

Contracts will be deployed through the cargo stylus command using the pre-funded account's private key so users can perform any transaction through the frontend while interacting with the contract.

```sh
cd speedrun_stylus # if not done
cd packages
cd cargo-stylus
cd multi-sig
```

> Now open your Docker desktop and then return to your IDE and run bash run-dev-node.sh. This will spin up the nitro devnode in Docker. You can check it out in your Docker desktop. This will take some time to deploy the RUST contract, and then the script will automatically generate the ABI. You can view all these transactions in your terminal and Docker desktop. The Docker node is running at localhost:8547,
but before running this command make sure about below thing

## 🚨 Fixing Line Endings and Running Shell Scripts in WSL on a CRLF-Based Windows System

> ⚠️ This guide provides step-by-step instructions to resolve the Command not found error caused by CRLF line endings in shell scripts when running in a WSL environment.

---

## 🛠️ Steps to Fix the Issue

###  Convert Line Endings to LF
Shell scripts created in Windows often have `CRLF` line endings, which cause issues in Unix-like environments such as WSL. To fix this:

#### Using `dos2unix`
1. Install `dos2unix` (if not already installed):
   ```bash
   sudo apt install dos2unix
   ```

2. Convert the script's line endings:
    ```bash
   dos2unix run-dev-node.sh
   ```

3. Make the Script Executable:
    ```bash
    chmod +x run-dev-node.sh
    ```

4. Run the Script in WSL
    ```bash
    bash run-dev-node.sh
    ```

> In the same WSL terminal window or at the Docker Desktop terminal, you can easily view the details of your contract deployment, including the deployment transaction hash, which can be later used to verify the contract.

![image](https://github.com/user-attachments/assets/30bb3557-c04e-450a-925f-78043672e7ec)

![image](https://github.com/user-attachments/assets/4d99d35a-4adc-418e-b6c7-4d03490f693d)

> Then in a second WSL terminal window, you can run below commands to start your 📱 frontend:

```sh
cd speedrun_stylus ( if not done )
cd packages ( if not done )
cd nextjs
yarn run dev OR yarn dev
```

📱 Open [http://localhost:3000](http://localhost:3000) to see the app.

---

## 💫 Checkpoint 1:  Frontend Magic

After completing Checkpoint 0, you'll be able to start interacting with your contract. To begin, click on "Debug Contracts" from the Navbar or the Debug Contracts Div on the screen.

---

## Features

The interface allows you to:
### Step 1: Initialize the Contract
- **Set up the owners**: Provide a list of owner addresses.
- **Define confirmation requirements**: Specify the number of confirmations required for a transaction to be executed.

**Why this step?**
This establishes the foundational security setup for the contract.

---

### Step 2: Deposit ETH
- **Allow users to deposit ETH** into the contract securely.


**Why this step?**
Funds must be available in the contract for transactions to proceed.

---

### Step 3: Submit a Transaction
- **Fill in transaction details**:
  - Recipient address (`to`).
  - Amount in ETH (`value`).
  - Optional data in hexadecimal (`data`).
- **Submit the transaction**: Add it to the list of pending transactions.

**Why this step?**
It initiates the transaction process and makes it available for confirmation.

---

### Step 4: Confirm a Transaction

- **Confirm the transaction**: Allow owners to approve the transaction using its index (`txIndex`).

**Why this step?**
It ensures that only approved transactions can be executed, maintaining the multi-signature requirement.

---

### Step 5: Execute a Transaction
- **Check transaction status**: Verify if the required number of confirmations is met.
- **Execute the transaction**: Transfer the specified amount to the recipient.

**Why this step?**
This is the culmination of the process where funds are securely transferred.

---

### Step 6: Revoke Confirmation (Optional)
- **Allow owners to revoke their confirmation** for a pending transaction if needed.

**Why this step?**
It adds flexibility, allowing owners to change their decisions before execution.

---

### Step 7: Check Contract Details
- **View owner status**: Verify if an address is an owner.
- **Display contract stats**:
  - Total transactions.
  - Confirmations required.

**Why this step?**
This provides transparency and easy access to critical contract details.

---

### Step 8: Track Transactions
- **Integrate a blockchain explorer link** for users to track all transaction activity directly on-chain.

**Why this step?**
It enhances trust and transparency by allowing users to independently verify contract activity.

---

## Summary of User Flow

    1. Initialize the contract.
    2. Deposit ETH.
    3. Submit a transaction.
    4. Confirm the transaction.
    5. Execute the transaction (after required confirmations).
    6. Revoke confirmation (if necessary).
    7. Check contract details.
    8. Track transactions.



### Below are the examples of above all interactions that can be done with the Multisig smart contract written in the RUST

### 1. Initialize the contract.
![Initialize the contract.](https://github.com/user-attachments/assets/93ca9c7d-99e4-4a4b-85a2-9f9ca6cb2dae)

### 2. Deposit ETH.
![Deposit ETH.](https://github.com/user-attachments/assets/d9d9c2d7-938e-4a71-92c3-b6915559a97a)

### 3. Submit a transaction.
![Submit a transaction.](https://github.com/user-attachments/assets/44ff5c11-dc7f-4d43-8e4b-13cba9bb1567)

### 4. Confirm the transaction. 
![Confirm the transaction.](https://github.com/user-attachments/assets/73429114-6184-4013-a887-98310494d580)

### 5. Execute the transaction (after required confirmations).
![Execute the transaction (after required confirmations).](https://github.com/user-attachments/assets/187d7c17-a4ed-4082-ae10-aa81fe2382d0)

### 6. Revoke confirmation (if necessary).
![Revoke confirmation (if necessary).](https://github.com/user-attachments/assets/981c13a3-9d5e-4caf-b147-dfe58a6f57bb)

### 7. Check contract details.
![Check Owner Status.](https://github.com/user-attachments/assets/8b06b343-f8fe-484d-b465-647cfbe5acba)

![Contract Stats.](https://github.com/user-attachments/assets/a176a6f1-2a33-47b6-96eb-bcc71b239d47)

### 8. Track transactions.
> After that, you can easily view all of your transactions from the Block Explorer Tab

![Track Transactions.](https://github.com/user-attachments/assets/4cac7ce8-5cd2-4906-b3c7-cd5f531dfd5d)


💼 Take a quick look at your deploy script `run-dev-node.sh` in `speedrun_stylus/packages/cargo-stylus/multi-sig/run-dev-node.sh`.

📝 If you want to edit the frontend, navigate to `speedrun_stylus/packages/nextjs/app` and open the specific page you want to modify. For instance: `/debug/page.tsx`. For guidance on [routing](https://nextjs.org/docs/app/building-your-application/routing/defining-routes) and configuring [pages/layouts](https://nextjs.org/docs/app/building-your-application/routing/pages-and-layouts) checkout the Next.js documentation.

---

## Checkpoint 2: 💾 Deploy your contract! 🛰

🛰  You don't need to provide any specifications to deploy your contract because contracts are automatically deployed from the `run-dev-node.sh`

> You can check that below :

![image](https://github.com/user-attachments/assets/d84c4d6a-be20-426b-9c68-2c021caefb29)

The above command will automatically deploy the contract functions written inside `speedrun_stylus/packages/cargo-stylus/multi-sig/src/lib.rs`

> This local account will deploy your contracts, allowing you to avoid entering a personal private key because the deployment happens using the pre-funded account's private key.

## Checkpoint 3: 🚢 Ship your frontend! 🚁

> We are deploying all the RUST contracts at the `localhost:8547` endpoint where the nitro devnode is spinning up in Docker. You can check the network where your contract has been deployed in the frontend (http://localhost:3000):

![image](https://github.com/user-attachments/assets/bb82e696-97b9-453e-a7c7-19ebb7bd607f)

🚀 Deploy your NextJS App

```shell
vercel
```

> Follow the steps to deploy to Vercel. Once you log in (email, github, etc), the default options should work. It'll give you a public URL.

> If you want to redeploy to the same production URL you can run `yarn vercel --prod`. If you omit the `--prod` flag it will deploy it to a preview/test URL.

---

## Checkpoint 4: 📜 Contract Verification

You can verify your smart contract by running:

```bash
cargo stylus verify -e http://127.0.0.1:8547 --deployment-tx "$deployment_tx"
# here deployment_tx can be received through the docker desktop's terminal when you have depoloyed your contract using the below command:

```
If you want to deploy again after verification then you can do with the below command:
```
cargo stylus deploy -e http://127.0.0.1:8547 --private-key "$your_private_key"
# here you can use pre-funded account's private-key as well
```


> It is okay if it says your contract is already verified. 


---

## 🏁 Next Steps

Explore more challenges or contribute to this project!

> 🏃 Head to your next challenge [here](https://speedrun-stylus.vercel.app/challenge/uniswap-v2-stylus).
