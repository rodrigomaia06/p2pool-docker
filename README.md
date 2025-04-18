# P2Pool Docker Deployment

This repository helps you deploy P2Pool (a decentralized Monero mining pool) along with its optional statistics web interface using Docker.

## Overview

- `p2pool`: runs the latest P2Pool node, automatically connecting to Monero and participating in the P2Pool network.
- `p2pool-statistics`: optional web interface to visualize P2Pool performance and local statistics.

---

## 💻 Docker Compose Example

```yaml
services:

  # P2Pool Service
  p2pool:
    image: ghcr.io/rodrigomaia06/p2pool-docker:latest  # Latest P2Pool image
    container_name: p2pool  # Container name
    privileged: true  # Required for access to system features like hugepages
    restart: unless-stopped  # Auto-restart unless manually stopped
    depends_on:
      - monerod  # Ensure Monero node is running first
    ports:
      - "18333:18333"  # P2Pool worker connection port
      - "37888:37888"  # P2Pool Mini Network P2P port
    volumes:
      - ./p2pool/:/home/p2pool/.p2pool:rw  # Persist data
      - /dev/hugepages:/dev/hugepages:rw  # Optimized memory (hugepages)
    command: >  # Start P2Pool with custom options
      --host monerod  # Monero node address
      --local-api  # Enable local API
      --data-api /home/p2pool/.p2pool  # Data storage path
      --rpc-port 18081  # Monero RPC port
      --wallet YOUR_XMR_ADDRESS  # Replace with your Monero wallet address
      --p2p 0.0.0.0:37888  # P2P port
      --stratum 0.0.0.0:18333  # Stratum port
      --mini  # Enable Mini mode

  # P2Pool Statistics Service
  p2pool-statistics:
    image: ghcr.io/rodrigomaia06/p2pool-docker-statistics:latest  # Latest statistics image
    container_name: p2pool-statistics  # Container name
    restart: unless-stopped  # Auto-restart unless manually stopped
    depends_on:
      - p2pool  # Wait for P2Pool to be ready
    volumes:
      - ./p2pool:/data:ro  # Mount P2Pool data as read-only for stats

```

---

## ⚡️ Quick Steps

1️⃣ Replace `YOUR_XMR_ADDRESS` in the `p2pool` container with your own Monero wallet address.

2️⃣ Ensure your `monerod` instance is fully synced and reachable (typically via `localhost:18081` or a LAN IP).

3️⃣ Launch the setup:

```bash
docker compose up -d
```

4️⃣ (Optional) To access the web statistics:

Open your browser and navigate to:

```
http://<YOUR-HOST-IP>:80
```

(Replace `<YOUR-HOST-IP>` with your Docker host's address)

---

## 🧾 Notes

- **Mini Network Mode** is enabled (`--mini`) in the example — this mode has lower difficulty and better accessibility for smaller miners. You can remove `--mini` if you want to connect to the main P2Pool network instead.

- `p2pool-statistics` reads the `/home/p2pool/.p2pool` folder mounted by the P2Pool node. Make sure the path matches in both services.

---

## 💡 References

- Official P2Pool repo: https://github.com/SChernykh/p2pool
- Monero: https://www.getmonero.org

---

Happy Mining! ⛏️✨

