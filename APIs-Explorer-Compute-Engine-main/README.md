# APIs-Explorer-Compute-Engine

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
curl -LO https://raw.githubusercontent.com/JtnTech/APIs-Explorer-Compute-Engine/refs/heads/main/jtntech.sh
sudo chmod +x jtntech.sh
./jtntech.sh
```

---

## 📜 Bash Script: ( **jtntech.sh** )

```bash
#!/bin/bash
clear

# -------------------- Color Definitions --------------------
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

# -------------------- Start --------------------
echo "${RANDOM_BG_COLOR}${RANDOM_TEXT_COLOR}${BOLD}Starting Execution${RESET}"

# Step 1: Set Compute Zone
echo "${BOLD}${BLUE}Setting Compute Zone${RESET}"
export ZONE=$(gcloud compute project-info describe \
--format="value(commonInstanceMetadata.items[google-compute-default-zone])")

# Step 2: Enable Compute Engine API
echo "${BOLD}${GREEN}Enabling Compute Engine API${RESET}"
gcloud services enable compute.googleapis.com
sleep 15

# Step 3: Create VM Instance
echo "${BOLD}${CYAN}Creating VM Instance 'instance-1'${RESET}"
curl -X POST "https://compute.googleapis.com/compute/v1/projects/$DEVSHELL_PROJECT_ID/zones/$ZONE/instances" \
-H "Authorization: Bearer $(gcloud auth application-default print-access-token)" \
-H "Content-Type: application/json" \
-d "{
  \"name\": \"instance-1\",
  \"machineType\": \"zones/$ZONE/machineTypes/n1-standard-1\",
  \"networkInterfaces\": [{}],
  \"disks\": [{
    \"type\": \"PERSISTENT\",
    \"boot\": true,
    \"initializeParams\": {
      \"sourceImage\": \"projects/debian-cloud/global/images/family/debian-11\"
    }
  }]
}"

# -------------------- Progress Check --------------------
check_progress() {
  while true; do
    echo
    read -p "${BOLD}${YELLOW}Have you checked your progress for Task 2? (Y/N): ${RESET}" input
    case "$input" in
      Y|y) echo "${GREEN}Proceeding...${RESET}"; break ;;
      N|n) echo "${RED}Please complete Task 2 first.${RESET}" ;;
      *) echo "${MAGENTA}Invalid input. Enter Y or N.${RESET}" ;;
    esac
  done
}

check_progress

# Step 4: Delete VM
echo "${BOLD}${YELLOW}Deleting VM Instance 'instance-1'${RESET}"
curl -X DELETE \
-H "Authorization: Bearer $(gcloud auth application-default print-access-token)" \
"https://compute.googleapis.com/compute/v1/projects/$DEVSHELL_PROJECT_ID/zones/$ZONE/instances/instance-1"

# -------------------- Completion --------------------
echo "${BOLD}${GREEN}🎉 Congratulations For Completing The Lab!! 🎉${RESET}"

# -------------------- Cleanup --------------------
cd
for file in gsp* arc* shell*; do
  [[ -f "$file" ]] && rm "$file"
done
}

remove_files
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

