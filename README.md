# cloudflare-ddns-asuswrt-merlin
Asuswrt-Merlin Custom DDNS bash script for Cloudflare DNS A record

## To use this script, follow the step:
1. Prepare a USB drive with format ext4 and plug it into the router
2. Enable "JFFS custom scripts and configs" under Administration -> System
2. run "amtm" to install Entware
3. run "opkg install jq"
4. edit "Configuration" section of this script
5. copy the contents of this script in /jffs/scripts/ddns-start
6. run "chmod +x /jffs/scripts/ddns-start"
7. enable the DDNS Client in WAN -> DDNS and use Custom as Server.
