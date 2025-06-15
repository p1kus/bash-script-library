#!bin/bash

if [[ $1 == "export" ]]; then
  read sid csrf <<<$(curl -sk -X POST https://pi.hole/api/auth \
    -d '{"password":"lsNFCtkCJGIfbSObp6fP/o8w/NhWiuapDfwpCWSY6ck="}' |
    jq -r '.session | "\(.sid) \(.csrf)"')

  curl -sk -X GET https://pi.hole/api/teleporter \
    -H "X-FTL-SID: $sid" \
    -H "X-FTL-CSRF: $csrf" \
    -o pihole-backup.zip
else
  sid=$(curl -sk -X POST "https://pi.hole/api/auth" --data '{"password":"lsNFCtkCJGIfbSObp6fP/o8w/NhWiuapDfwpCWSY6ck="}' | jq -r '.session.sid')
  summary=$(curl -sk -X GET "https://pi.hole/api/stats/summary?sid=$sid" | jq -r '{queries_total: .queries.total, percent_blocked: .queries.percent_blocked, queries_blocked: .queries.blocked, unique_domains: .queries.unique_domains, domains_being_blocked: .gravity.domains_being_blocked}')
  sessions=$(curl -sk -X GET "https://pi.hole/api/network/devices?max_addresses=1&sid=$sid" | jq -r '.devices[] | {id, ips, macVendor, hwaddr} | .ips[] as $ip | {id, hwaddr, macVendor, ip: $ip.ip}')

  echo "--------------Blocking--------------------"
  echo ""
  echo $summary
  echo ""
  echo "--------------Sessions-------------------"
  echo ""
  echo $sessions
  echo ""
  echo "-----------------------------------------"

  curl -sk -X DELETE "https://pi.hole/api/auth" --cookie "sid=$sid"
  echo "bye"
fi
# curl -k -X "https://pi.hole:443/api/stats/summary?sid=
