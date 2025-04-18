# p2pool-docker

## Overview

`p2pool-docker` is a pre-built Docker image that compiles the latest [P2Pool](https://github.com/SChernykh/p2pool) source from GitHub.

P2Pool is a decentralized mining pool for Monero and other CryptoNote-based coins, providing better privacy, zero operator fees, and resistance against pool centralization.

This Docker image is designed for self-hosters and miners who prefer to always run the latest version directly from source.

---

## Docker Usage

### Simple `docker run` Example

```bash
docker run -d \
  --restart unless-stopped \
  --name p2pool \
  --privileged \
  -p 3333:3333 \
  -p 37888:37888 \
  -p 37889:37889 \
  -v /path/to/p2pool-data:/home/p2pool/.p2pool:rw \
  -v /dev/hugepages:/dev/hugepages:rw \
  p2pool:latest \
  --host monerod-hostname \
  --wallet YOUR_XMR_ADDRESS \
  --loglevel 3
