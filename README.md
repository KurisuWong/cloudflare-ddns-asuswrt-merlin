# Asuswrt-Merlin Custom DDNS for Cloudflare
This is a custom bash script for Asuswrt-Merlin router firmware to update Cloudflare DNS A record

# Feature
- Support updating multiple DNS A Record in multiple cloudflare account

# Prerequisite
- Entware
- jq (can be installed through `opkg instsall jq`

# Quick Start Guide
### Preparing the router
1. Prepare a USB drive with format ext4 and plug it into the router
2. Enable "JFFS custom scripts and configs" under Administration -> System
3. SSH to your router
4. run "amtm" to install Entware
5. run "opkg install jq"

### Preparing the Cloudflare
4. Add an A record in Cloudflare for the dns record that you are going to use in this script

### Editing the script
5. Download [ddns-start](ddns-start) script and modify the `Configuration ` session

API Token can be generated in User Profile > ['API Token'](https://dash.cloudflare.com/profile/api-tokens) Page with the following privilege
- Permissions: Zone > DNS > Edit*
- Zone Resources: Include > Specific Zone > \<your zone\>*

```
cloudflare_auth "<YOUR_API_TOKEN>"
cloudflare_ddns_update "<YOUR_ZONE>" "<YOUR_DNS_RECORD>"
```
Example #1: Single Account with Single DNS Record to be updated
```
cloudflare_auth "8M7wS6hCpXVc-DoRnPPY_UCWPgy8aea4Wy6kCe5T"
cloudflare_ddns_update "example.com" "ip.example.com"
```
Exmaple #2: Single Account with Multiple DNS Record to be updated
```
cloudflare_auth "8M7wS6hCpXVc-DoRnPPY_UCWPgy8aea4Wy6kCe5T"
cloudflare_ddns_update "examplea.com" "ip.examplea.com"
cloudflare_ddns_update "exampleb.com" "ip.exampleb.com"
```
Exmaple #3: Multiple Account with Multiple DNS Record to be updated
```
cloudflare_auth "8M7wS6hCpXVc-DoRnPPY_UCWPgy8aea4Wy6kCe5T" # API Token for account #1
cloudflare_ddns_update "examplea.com" "ip.examplea.com"
cloudflare_ddns_update "exampleb.com" "ip.exampleb.com"

cloudflare_auth "YQSn-xWAQiiEh9qM58wZNnyQS7FUdoqGIUAbrh7T" # API Token for account #2
cloudflare_ddns_update "examplec.com" "ip.examplec.com"
cloudflare_ddns_update "exampled.com" "ip.exampled.com"
```
### Uploading the script to router
6. SSH to your router
7. Run `vi /jffs/scripts/ddns-start`
8. Press 'i'
9. Copy and Paste the content of the edited script
10. Press `Esc` then key in `:wq`, and `Enter`
11. Run `chmod +x /jffs/scripts/ddns-start`
12. Enable the DDNS Client in `WAN` -> `DDNS` and use `Custom` as Server.
