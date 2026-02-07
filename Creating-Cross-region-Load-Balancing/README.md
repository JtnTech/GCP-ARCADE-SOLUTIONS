#  Creating Cross-region Load Balancing


---
## 📁 Repository Structure:
```text
.
├── jtntech.sh   # main logic
├── run.sh       # user runs this
└── README.md
```

# First run this in cloudshell:
```text
export REGION1=
export REGION2=
export ZONE1=
export ZONE2=
```

---

## ⚡ One-Line Quick Start (**run.sh**)
```sh
curl -LO https://raw.githubusercontent.com/JtnTech/Creating-Cross-region-Load-Balancing/refs/heads/main/jtntech.sh
sudo chmod +x jtntech.sh
./jtntech.sh
```

## at last step run this:
```bash
gcloud compute addresses list
```
---

```bash
gcloud compute forwarding-rules create http-cr-rule \
    --address (your ip address) \
    --global \
    --target-http-proxy http-lb-proxy \
    --ports 80
```

---

## 📜 Bash Script: ( **jtntech.sh** )
```bash
#!/bin/bash
YELLOW='\033[0;33m'
NC='\033[0m' 
pattern=(
"**********************************************************"
"**                 S U B S C R I B E  TO                **"
"**                 Jatintrails                **"
"**                                                      **"
"**********************************************************"
)
for line in "${pattern[@]}"
do
    echo -e "${YELLOW}${line}${NC}"
done
gcloud auth list

gcloud config list project

gcloud compute instances create www-1 \
    --image-family debian-11 \
    --image-project debian-cloud \
    --machine-type e2-micro \
    --zone $ZONE1 \
    --tags http-tag \
    --metadata startup-script="#! /bin/bash
      apt-get update
      apt-get install apache2 -y
      service apache2 restart
      echo '<!doctype html><html><body><h1>www-1</h1></body></html>' | tee /var/www/html/index.html
"


gcloud compute instances create www-2 \
    --image-family debian-11 \
    --image-project debian-cloud \
    --machine-type e2-micro \
    --zone $ZONE1 \
    --tags http-tag \
    --metadata startup-script="#! /bin/bash
      apt-get update
      apt-get install apache2 -y
      service apache2 restart
      echo '<!doctype html><html><body><h1>www-2</h1></body></html>' | tee /var/www/html/index.html
"


gcloud compute instances create www-3 \
    --image-family debian-11 \
    --image-project debian-cloud \
    --machine-type e2-micro \
    --zone $ZONE2 \
    --tags http-tag \
    --metadata startup-script="#! /bin/bash
      apt-get update
      apt-get install apache2 -y
      service apache2 restart
      echo '<!doctype html><html><body><h1>www-3</h1></body></html>' | tee /var/www/html/index.html
"


gcloud compute instances create www-4 \
    --image-family debian-11 \
    --image-project debian-cloud \
    --machine-type e2-micro \
    --zone $ZONE2 \
    --tags http-tag \
    --metadata startup-script="#! /bin/bash
      apt-get update
      apt-get install apache2 -y
      service apache2 restart
      echo '<!doctype html><html><body><h1>www-4</h1></body></html>' | tee /var/www/html/index.html
"

gcloud compute firewall-rules create www-firewall \
    --target-tags http-tag --allow tcp:80

gcloud compute instances list


gcloud compute addresses create lb-ip-cr \
    --ip-version=IPV4 \
    --global


gcloud compute instance-groups unmanaged create $REGION1-resources-w --zone $ZONE1


gcloud compute instance-groups unmanaged create $REGION2-resources-w --zone $ZONE2


gcloud compute instance-groups unmanaged add-instances $REGION1-resources-w \
    --instances www-1,www-2 \
    --zone $ZONE1

gcloud compute instance-groups unmanaged add-instances $REGION2-resources-w \
    --instances www-3,www-4 \
    --zone $ZONE2

gcloud compute health-checks create http http-basic-check


gcloud compute instance-groups unmanaged set-named-ports $REGION1-resources-w \
    --named-ports http:80 \
    --zone $ZONE1


gcloud compute instance-groups unmanaged set-named-ports $REGION2-resources-w \
    --named-ports http:80 \
    --zone $ZONE2


gcloud compute backend-services create web-map-backend-service \
    --protocol HTTP \
    --health-checks http-basic-check \
    --global


gcloud compute backend-services add-backend web-map-backend-service \
    --balancing-mode UTILIZATION \
    --max-utilization 0.8 \
    --capacity-scaler 1 \
    --instance-group $REGION1-resources-w \
    --instance-group-zone $ZONE1 \
    --global


gcloud compute backend-services add-backend web-map-backend-service \
    --balancing-mode UTILIZATION \
    --max-utilization 0.8 \
    --capacity-scaler 1 \
    --instance-group $REGION2-resources-w \
    --instance-group-zone $ZONE2 \
    --global


gcloud compute url-maps create web-map \
    --default-service web-map-backend-service


gcloud compute target-http-proxies create http-lb-proxy \
    --url-map web-map


gcloud compute addresses list
pattern=(
"**********************************************************"
"**                 S U B S C R I B E  TO                **"
"**                 JatinTrails                **"
"**                                                      **"
"**********************************************************"
)
for line in "${pattern[@]}"
do
    echo -e "${YELLOW}${line}${NC}"
done

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
