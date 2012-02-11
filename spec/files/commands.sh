curl -u "$ROBOWHOIS_API_KEY:X" api.robowhois.com/account | jsonpretty > files/account/index/default.json
curl -u "$ROBOWHOIS_API_KEY:X" api.robowhois.com/account -i > files/account/index/default.dump

curl -u "$ROBOWHOIS_API_KEY:X" api.robowhois.com/whois/example.com > files/whois/index/record.txt
curl -u "$ROBOWHOIS_API_KEY:X" api.robowhois.com/whois/example.com -i > files/whois/index/record.dump

curl -u "$ROBOWHOIS_API_KEY:X" api.robowhois.com/whois/example.com/record | jsonpretty > files/whois/record/record.json
curl -u "$ROBOWHOIS_API_KEY:X" api.robowhois.com/whois/example.com/record -i > files/whois/record/record.dump

curl -u "$ROBOWHOIS_API_KEY:X" api.robowhois.com/whois/example.com/parts | jsonpretty > files/whois/parts/parts.json
curl -u "$ROBOWHOIS_API_KEY:X" api.robowhois.com/whois/example.com/parts -i > files/whois/parts/parts.dump

curl -u "$ROBOWHOIS_API_KEY:X" api.robowhois.com/whois/google.com/availability | jsonpretty > files/whois/availability/registered.json
curl -u "$ROBOWHOIS_API_KEY:X" api.robowhois.com/whois/google.com/availability -i > files/whois/availability/registered.dump
curl -u "$ROBOWHOIS_API_KEY:X" api.robowhois.com/whois/g111111111fle.com/availability | jsonpretty > files/whois/availability/available.json
curl -u "$ROBOWHOIS_API_KEY:X" api.robowhois.com/whois/g111111111fle.com/availability -i > files/whois/availability/available.dump

curl -u "$ROBOWHOIS_API_KEY:X" api.robowhois.com/whois/google.com/properties | jsonpretty > files/whois/properties/registered.json
curl -u "$ROBOWHOIS_API_KEY:X" api.robowhois.com/whois/google.com/properties -i > files/whois/properties/registered.dump
curl -u "$ROBOWHOIS_API_KEY:X" api.robowhois.com/whois/g111111111fle.com/properties | jsonpretty > files/whois/properties/available.json
curl -u "$ROBOWHOIS_API_KEY:X" api.robowhois.com/whois/g111111111fle.com/properties -i > files/whois/properties/available.dump
