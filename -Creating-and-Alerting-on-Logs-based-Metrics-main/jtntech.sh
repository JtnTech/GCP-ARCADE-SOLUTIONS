## 📜 Full Deployment Script (`jtntech.sh`)

> 📋 **Tip:** Click the **Copy** button on the code block below and paste it directly into your Cloud Shell or terminal.

#!/bin/bash

# ==============================
# 🎨 Color & Formatting Setup
# ==============================

BLACK=`tput setaf 0`
RED=`tput setaf 1`
GREEN=`tput setaf 2`
YELLOW=`tput setaf 3`
BLUE=`tput setaf 4`
MAGENTA=`tput setaf 5`
CYAN=`tput setaf 6`
WHITE=`tput setaf 7`

BG_BLACK=`tput setab 0`
BG_RED=`tput setab 1`
BG_GREEN=`tput setab 2`
BG_YELLOW=`tput setab 3`
BG_BLUE=`tput setab 4`
BG_MAGENTA=`tput setab 5`
BG_CYAN=`tput setab 6`
BG_WHITE=`tput setab 7`

BOLD=`tput bold`
RESET=`tput sgr0`

TEXT_COLORS=($RED $GREEN $YELLOW $BLUE $MAGENTA $CYAN)
BG_COLORS=($BG_RED $BG_GREEN $BG_YELLOW $BG_BLUE $BG_MAGENTA $BG_CYAN)

RANDOM_TEXT_COLOR=${TEXT_COLORS[$RANDOM % ${#TEXT_COLORS[@]}]}
RANDOM_BG_COLOR=${BG_COLORS[$RANDOM % ${#BG_COLORS[@]}]}

# ==============================
# 🚀 Script Execution Start
# ==============================

echo "${RANDOM_BG_COLOR}${RANDOM_TEXT_COLOR}${BOLD}Welcome to JtnTech Cloud Tutorials${RESET}"
echo "${BOLD}${CYAN}Starting Lab Execution...${RESET}"

# Step 1: Set Project ID, Zone & Region
echo "${BOLD}${GREEN}Setting Project ID, Compute Zone & Region${RESET}"
export PROJECT_ID=$(gcloud info --format='value(config.project)')
export ZONE=$(gcloud compute project-info describe \
--format="value(commonInstanceMetadata.items[google-compute-default-zone])")
export REGION=$(gcloud compute project-info describe \
--format="value(commonInstanceMetadata.items[google-compute-default-region])")

gcloud config set compute/zone $ZONE

# Step 2: Create Kubernetes Cluster
echo "${BOLD}${CYAN}Creating Kubernetes Cluster${RESET}"
gcloud container clusters create gmp-cluster --num-nodes=1 --zone $ZONE

# Step 3: Create Log-based Metric for Stopped VMs
echo "${BOLD}${RED}Creating log-based metric for stopped VMs${RESET}"
gcloud logging metrics create stopped-vm \
  --description="Metric for stopped VMs" \
  --log-filter='resource.type="gce_instance" protoPayload.methodName="v1.compute.instances.stop"'

# Step 4: Create Pub/Sub Notification Channel
echo "${BOLD}${GREEN}Creating Pub/Sub notification channel${RESET}"
cat > pubsub-channel.json <<EOF
{
  "type": "pubsub",
  "displayName": "jtntech-alerts",
  "description": "Alerts powered by JtnTech",
  "labels": {
    "topic": "projects/$DEVSHELL_PROJECT_ID/topics/notificationTopic"
  }
}
EOF

gcloud beta monitoring channels create --channel-content-from-file=pubsub-channel.json

# Step 5: Completion
echo "${BOLD}${GREEN}Lab execution completed successfully!${RESET}"
echo "${BOLD}${CYAN}Thank you for using JtnTech Cloud Tutorials 🚀${RESET}"
