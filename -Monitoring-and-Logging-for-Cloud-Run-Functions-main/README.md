
Welcome to **JtnTech GitHub** 👋  

## 📁 Repository Structure

```text
.
├── jtntech.sh   # Original deployment script
├── run.sh       # CLI wrapper / final execution script
└── README.md    # Project documentation

```

## ⚡ One-Line Quick Install & Run
**run.sh**
```bash
curl -LO https://raw.githubusercontent.com/JtnTech/-Monitoring-and-Logging-for-Cloud-Run-Functions/refs/heads/main/jtntech.sh
sudo chmod +x jtntech.sh
./jtntech.sh
```
## 📜 Original Full Deployment Script (**jtntech.sh**)
> 📋 **Tip:** Click the **Copy** button on the code block below and paste it directly into your Cloud Shell or terminal.
```bash
#!/bin/bash

# Enhanced Color Definitions
BLUE=$'\033[0;94m'
GREEN=$'\033[0;92m'
YELLOW=$'\033[0;93m'
RED=$'\033[0;91m'
MAGENTA=$'\033[0;95m'
CYAN=$'\033[0;96m'
WHITE=$'\033[0;97m'
BOLD=$'\033[1m'
UNDERLINE=$'\033[4m'
RESET=$'\033[0m'

# Header Section
echo "${BLUE}${BOLD}╔════════════════════════════════════════════════════════╗${RESET}"
echo "${BLUE}${BOLD}         WELCOME TO JtnTech      ${RESET}"
echo "${BLUE}${BOLD}╚════════════════════════════════════════════════════════╝${RESET}"
echo
echo "${MAGENTA}${BOLD}⚡ Initializing Cloud Run performance testing...${RESET}"
echo

# Step 1: Authentication Check
echo "${GREEN}${BOLD}▬▬▬▬▬▬▬▬▬ AUTHENTICATION ▬▬▬▬▬▬▬▬▬${RESET}"
echo "${YELLOW}Checking active GCP account...${RESET}"
gcloud auth list
echo

# Step 2: Region Configuration
echo "${GREEN}${BOLD}▬▬▬▬▬▬▬▬▬ REGION SETUP ▬▬▬▬▬▬▬▬▬${RESET}"
echo "${YELLOW}Setting default compute region...${RESET}"
export REGION=$(gcloud compute project-info describe --format="value(commonInstanceMetadata.items[google-compute-default-region])")
echo "${CYAN}Selected Region: ${WHITE}${BOLD}$REGION${RESET}"
echo


# Step 3: Vegeta Installation
echo "${GREEN}${BOLD}▬▬▬▬▬▬▬▬ VEGETA SETUP ▬▬▬▬▬▬▬▬${RESET}"
echo "${YELLOW}Downloading Vegeta load testing tool...${RESET}"
curl -LO 'https://github.com/tsenart/vegeta/releases/download/v12.12.0/vegeta_12.12.0_linux_386.tar.gz'
echo "${CYAN}Extracting Vegeta...${RESET}"
tar -xvzf vegeta_12.12.0_linux_386.tar.gz
echo "${GREEN}Vegeta installed successfully!${RESET}"
echo

# Step 4: Cloud Run URL Fetch
echo "${GREEN}${BOLD}▬▬▬▬▬▬▬ CLOUD RUN SETUP ▬▬▬▬▬▬▬${RESET}"
echo "${YELLOW}Fetching Cloud Run service URL...${RESET}"
CLOUD_RUN_URL=$(gcloud run services describe helloworld --region=$REGION --format='value(status.url)')
echo "${CYAN}Service URL: ${WHITE}${BOLD}$CLOUD_RUN_URL${RESET}"
echo

# Step 5: Load Testing
echo "${GREEN}${BOLD}▬▬▬▬▬▬▬ LOAD TESTING ▬▬▬▬▬▬▬${RESET}"
echo "${YELLOW}Starting 300-second load test at 200 requests/sec...${RESET}"
echo "GET $CLOUD_RUN_URL" | ./vegeta attack -duration=300s -rate=200 > results.bin
echo "${GREEN}Load test completed! Results saved to results.bin${RESET}"
echo

# Step 6: Logging Metric
echo "${GREEN}${BOLD}▬▬▬▬▬▬ LOGGING METRIC ▬▬▬▬▬▬${RESET}"
echo "${YELLOW}Creating Cloud Run latency logging metric...${RESET}"
gcloud logging metrics create nFunctionLatency-Logs \
  --project=$DEVSHELL_PROJECT_ID \
  --description="Cloud Run latency monitoring" \
  --log-filter='resource.type="cloud_run_revision" AND resource.labels.service_name="helloworld"'
echo "${GREEN}Logging metric created successfully!${RESET}"
echo

# Completion Message
echo "${GREEN}${BOLD}╔════════════════════════════════════════════════════════╗${RESET}"
echo "${GREEN}${BOLD}          LOAD TESTING COMPLETED SUCCESSFULLY!           ${RESET}"
echo "${GREEN}${BOLD}╚════════════════════════════════════════════════════════╝${RESET}"
echo
echo "${MAGENTA}${BOLD}For more cloud engineering content, visit:${RESET}"
echo "${BLUE}${UNDERLINE}https://www.youtube.com/@JatinTrails${RESET}"
echo
echo "${CYAN}${BOLD}Happy cloud computing!${RESET}"

```



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
