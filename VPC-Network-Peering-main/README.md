# VPC-Network-Peering

---
## 📁 Repository Structure:
```text
.
├── jtntech.sh   # main logic
├── run.sh       # user runs this
└── README.md
```

## ⚡ One-Line Quick Start (**run.sh**)
```sh
curl -LO https://raw.githubusercontent.com/JtnTech/-VPC-Network-Peering/refs/heads/main/jtntech.sh
sudo chmod +x jtntech.sh
./jtntech.sh
```

---

## 📜 Bash Script: ( **jtntech.sh** )
```bash
#!/bin/bash

# ==============================================
#  VPC Network Peering Setup
#  Created by JtnTech 
#  YouTube: https://www.youtube.com/@JatinTrails
# ==============================================

# Text styles and colors
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)
BLUE=$(tput setaf 4)
MAGENTA=$(tput setaf 5)
BOLD=$(tput bold)
RESET=$(tput sgr0)

# Welcome Banner
echo
echo "${BLUE}${BOLD}╔══════════════════════════════════════════╗${RESET}"
echo "${BLUE}${BOLD}║   VPC NETWORK PEERING SETUP               ║${RESET}"
echo "${BLUE}${BOLD}║        by JtnTech                         ║${RESET}"
echo "${BLUE}${BOLD}╚══════════════════════════════════════════╝${RESET}"
echo
echo "${MAGENTA}Thank you for using our VPC peering setup script!${RESET}"
echo "${YELLOW}Subscribe on YouTube:${RESET}"
echo "${BLUE}https://www.youtube.com/@JatinTrails/videos${RESET}"
echo

# User Inputs
echo "${YELLOW}Please enter the following configuration details:${RESET}"
read -p "Enter the Second Project ID: " SECOND_PROJECT_ID
read -p "Enter Zone 1 (e.g. us-central1-a): " ZONE_1
read -p "Enter Zone 2 (e.g. us-east1-b): " ZONE_2

# Variables
export FIRST_PROJECT_ID=$DEVSHELL_PROJECT_ID
export REGION_1="${ZONE_1%-*}"
export REGION_2="${ZONE_2%-*}"

# First Project
gcloud config set project $FIRST_PROJECT_ID
gcloud compute networks create network-a --subnet-mode custom
gcloud compute networks subnets create network-a-subnet \
  --network network-a --range 10.0.0.0/16 --region $REGION_1

gcloud compute instances create vm-a \
  --zone $ZONE_1 --network network-a --subnet network-a-subnet \
  --machine-type e2-small

gcloud compute firewall-rules create network-a-fw \
  --network network-a --allow tcp:22,icmp

# Second Project
gcloud config set project $SECOND_PROJECT_ID
gcloud compute networks create network-b --subnet-mode custom
gcloud compute networks subnets create network-b-subnet \
  --network network-b --range 10.8.0.0/16 --region $REGION_2

gcloud compute instances create vm-b \
  --zone $ZONE_2 --network network-b --subnet network-b-subnet \
  --machine-type e2-small

gcloud compute firewall-rules create network-b-fw \
  --network network-b --allow tcp:22,icmp

# VPC Peering
gcloud config set project $FIRST_PROJECT_ID
gcloud compute networks peerings create peer-ab \
  --network network-a \
  --peer-project $SECOND_PROJECT_ID \
  --peer-network network-b

gcloud config set project $SECOND_PROJECT_ID
gcloud compute networks peerings create peer-ba \
  --network network-b \
  --peer-project $FIRST_PROJECT_ID \
  --peer-network network-a

echo "${GREEN}${BOLD}VPC Peering Setup Completed Successfully!${RESET}"
```


---


<div align="center">

### 🚀 Follow & Support **JtnTech**

<div align="center">
  <a href="https://github.com/JtnTech">
    <img src="https://cdn.jsdelivr.net/npm/simple-icons@v9/icons/github.svg" width="28"/>
  </a>&nbsp;&nbsp;&nbsp;
  <a href="https://www.youtube.com/@JatinTrails">
    <img src="https://cdn.jsdelivr.net/npm/simple-icons@v9/icons/youtube.svg" width="28"/>
  </a>&nbsp;&nbsp;&nbsp;
  <a href="https://www.instagram.com/firstcodejatin">
    <img src="https://cdn.jsdelivr.net/npm/simple-icons@v9/icons/instagram.svg" width="28"/>
  </a>
</div>

<br><br>

⭐ **Star this repo** if it helped you  
📺 **Subscribe on YouTube**  
💡 **Learn • Build • Deploy with JtnTech**

</div>

---

