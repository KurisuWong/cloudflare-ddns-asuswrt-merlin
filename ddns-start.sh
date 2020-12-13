#!/bin/bash

# Asuswrt-Merlin Custom DDNS bash script for Cloudflare DNS A record
# To use this script, follow the step:
# 1. Prepare a USB drive with format ext4 and plug it into the router
# 2. Enable "JFFS custom scripts and configs" under Administration -> System
# 2. run "amtm" to install Entware
# 3. run "opkg install jq"
# 4. edit "Configuration" section of this script
# 5. copy the contents of this script in /jffs/scripts/ddns-start
# 6. run "chmod +x /jffs/scripts/ddns-start"
# 7. enable the DDNS Client in WAN -> DDNS and use Custom as Server.

# Get the current IP address from router
ip=${1}

cloudflare_auth() {
	cloudflare_api_token=${1}
}

cloudflare_ddns_update() {
	zone=${1}
	dnsrecord=${2}

	# get the zone id for the requested zone
	zoneid=$(curl -s -X GET "https://api.cloudflare.com/client/v4/zones?name=$zone&status=active" \
	  -H "Authorization: Bearer $cloudflare_api_token" \
	  -H "Content-Type: application/json" | jq -r '{"result"}[] | .[0] | .id')
	
	# get the dns record id
	dnsrecordid=$(curl -s -X GET "https://api.cloudflare.com/client/v4/zones/$zoneid/dns_records?type=A&name=$dnsrecord" \
	  -H "Authorization: Bearer $cloudflare_api_token" \
	  -H "Content-Type: application/json" | jq -r '{"result"}[] | .[0] | .id')
	
	# update the record
	curl -s -X PUT "https://api.cloudflare.com/client/v4/zones/$zoneid/dns_records/$dnsrecordid" \
	  -H "Authorization: Bearer $cloudflare_api_token" \
	  -H "Content-Type: application/json" \
	  --data "{\"type\":\"A\",\"name\":\"$dnsrecord\",\"content\":\"$ip\",\"ttl\":1,\"proxied\":false}" | jq
}
###################
## Configuration ##
###################

# cloudflare zone is the zone which holds the record
# dnsrecord is the A record which will be updated

# cloudflare_auth "cloudflare_api_token"
# get one from here https://dash.cloudflare.com/profile/api-tokens
# Zone > DNS > Edit 
# Include > Specific zone > "Domain Name"
cloudflare_auth "<YOUR_API_TOKEN>"                          #edit this line

# cloudflare_ddns_update "zone" "dnsrecord"
cloudflare_ddns_update "<YOUR_ZONE>" "<YOUR_DNS_RECORD>"     #edit this line

###################

if [ $? -eq 0 ]; then
  /sbin/ddns_custom_updated 1
else
  /sbin/ddns_custom_updated 0
fi
