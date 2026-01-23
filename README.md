# AFA WEB3TOOL (Airdrop For All)

![AFA WEB3TOOL Banner](public/gambar-frame-utamav2.png)

**AFA WEB3TOOL** adalah platform Web3 *all-in-one* yang dirancang untuk mempermudah komunitas kripto dalam mengelola airdrop, berinteraksi dengan smart contract, dan berpartisipasi dalam event komunitas. Aplikasi ini dibangun dengan arsitektur modern yang menggabungkan fleksibilitas Web2 dan keamanan Web3.

Platform ini mendukung akses multi-device melalui Web (PWA) dan Android (via Capacitor).

## 🚀 Fitur Utama

### 🛡️ Autentikasi Hybrid
* **Web3 Login:** Sign-in with Ethereum (SIWE) menggunakan **Wagmi** & **Web3Modal**.
* **Web2 Login:** Email & Password via Supabase Auth.
* **Telegram Integration:** Login dan verifikasi via Telegram Mini App data.
* **Identity System:** Integrasi AFA Identity (NFT/SBT) untuk profil pengguna.

### 💧 Airdrop & Task Management
* **Airdrop Aggregator:** Daftar airdrop terkini dengan status, kategori, dan panduan.
* **"Garapanku" (My Work):** Pelacakan status pengerjaan airdrop (Todo, Done, Claimed).
* **Daily Check-in & Quests:** Sistem poin dan gamifikasi untuk retensi pengguna.

### 💬 Komunitas & Utilitas
* **Forum Diskusi:** Ruang diskusi real-time untuk pengguna.
* **Warung Kripto:** Marketplace P2P atau layanan terkait kebutuhan kripto (Gas, e-wallet).
* **Event System:** Manajemen event, giveaway, dan klaim tiket on-chain.

### ⚙️ Panel Admin
* Dashboard komprehensif untuk mengelola user, airdrop, banner event, dan verifikasi data.

---

## 🛠️ Tech Stack

### Frontend
* **Framework:** [React.js](https://reactjs.org/) (Vite)
* **Styling:** [Tailwind CSS](https://tailwindcss.com/)
* **State Management:** React Hooks & Context API
* **Navigation:** React Router DOM
* **Icons:** FontAwesome

### Web3 Integration
* **Library:** [Wagmi](https://wagmi.sh/) & [Ethers.js v6](https://docs.ethers.org/)
* **Wallet Connect:** Web3Modal (Reown)
* **Contracts:** Solidity ABI integration (Diamond Proxy Pattern support).

### Backend & Infrastructure
* **BaaS:** [Supabase](https://supabase.com/) (PostgreSQL, Auth, Storage, Realtime).
* **Serverless:** Supabase Edge Functions (Deno/TypeScript) untuk logika sensitif (Verifikasi Signature Wallet, Telegram Auth).
* **Mobile:** [Capacitor](https://capacitorjs.com/) (Android Runtime).

---

## 📦 Prasyarat

Sebelum memulai, pastikan Anda telah menginstal:
* [Node.js](https://nodejs.org/) (v18+)
* [Supabase CLI](https://supabase.com/docs/guides/cli) (Untuk deploy Edge Functions)
* Android Studio (Jika ingin build versi mobile)

## 💻 Instalasi & Menjalankan Lokal

1.  **Clone Repository**
    ```bash
    git clone [https://github.com/username/afa-web3tool.git](https://github.com/username/afa-web3tool.git)
    cd afa-web3tool
    ```

2.  **Instal Dependencies**
    ```bash
    npm install
    ```

3.  **Konfigurasi Environment**
    Buat file `.env` di root folder dan isi dengan kredensial Anda:
    ```env
    VITE_SUPABASE_URL=your_supabase_url
    VITE_SUPABASE_ANON_KEY=your_supabase_anon_key
    VITE_WALLET_CONNECT_PROJECT_ID=your_reown_project_id
    ```

4.  **Jalankan Server Development**
    ```bash
    npm run dev
    ```
    Aplikasi akan berjalan di `http://localhost:5173`.

---

## ☁️ Backend (Supabase Edge Functions)

Proyek ini menggunakan Edge Functions untuk keamanan autentikasi wallet. Pastikan Anda telah men-deploy fungsi ini.

1.  **Login Supabase CLI**
    ```bash
    npx supabase login
    ```

2.  **Set Secret Variables (PENTING)**
    Untuk fungsi `login-with-wallet`, Anda wajib mengatur JWT Secret:
    ```bash
    npx supabase secrets set APP_JWT_SECRET=your_super_secret_jwt_string
    ```

3.  **Deploy Functions**
    ```bash
    npx supabase functions deploy login-with-wallet --no-verify-jwt
    npx supabase functions deploy telegram-auth --no-verify-jwt
    ```

---

## 📱 Build untuk Android

Aplikasi ini menggunakan Capacitor untuk membungkus aplikasi web menjadi native Android.

1.  **Build Project Web**
    ```bash
    npm run build
    ```

2.  **Sinkronisasi ke Android**
    ```bash
    npx cap sync
    ```

3.  **Buka di Android Studio**
    ```bash
    npx cap open android
    ```

---

## 🤝 Kontribusi

Kontribusi selalu diterima! Silakan ikuti langkah berikut:

1.  Fork repository ini.
2.  Buat branch fitur baru (`git checkout -b fitur-keren`).
3.  Commit perubahan Anda (`git commit -m 'Menambahkan fitur keren'`).
4.  Push ke branch (`git push origin fitur-keren`).
5.  Buat Pull Request.

## 📄 Lisensi

Proyek ini dilisensikan di bawah [MIT License](LICENSE).

---

<p align="center">
  Built with ❤️ by <b>AFA Team</b>
</p>
