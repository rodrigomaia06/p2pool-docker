# p2pool-docker

## Overview

`p2pool-docker` is a pre-built Docker image that automatically compiles the latest [P2Pool](https://github.com/SChernykh/p2pool) source from GitHub.

P2Pool is a decentralized mining pool for Monero, providing better privacy, zero operator fees, and strong resistance against mining centralization.

This Docker image is designed for self-hosters and miners who want to always run the latest P2Pool version directly from source.

---

## Docker Usage

### Simple `docker run` Example

```bash
docker run -d \
  --restart unless-stopped \
  --name p2pool \
  --privileged \
  -p 3333:3333 \          # Port miners will connect to
  -p 37888:37888 \        # P2Pool Mini Network (P2P node port)
  -p 37889:37889 \        # P2Pool Main Network (P2P node port, only if using mainnet)
  -v /path/to/p2pool-data:/home/p2pool/.p2pool:rw \
  -v /dev/hugepages:/dev/hugepages:rw \
  p2pool:latest \
  --host monerod-hostname \    # IP or hostname of your Monero node
  --rpc-port 18081 \           # Port your Monero node uses (default: 18081)
  --wallet YOUR_XMR_ADDRESS \  # Replace with your actual Monero wallet address
  --mini                       # Enables Mini mode (if using P2Pool Mini Network)
