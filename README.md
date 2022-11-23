# Weather script

Description
This bash script is used to query https://www.apixu.com/api.aspx API service and get information regarding expected rain (precipitation) or UV index for the current day.

Command-line usage:
/bin/bash weather.sh <query type> [location]

	- <query type> could be either "rain" or "uv"
	- [location] is optional. Accepted locations are not only cities, but also the following entities:
		Location Name, e.g New York
		UK/Canada/US ZIP Code, e.g. 99501
		Coordinates (Lat/Lon), e.g 40.7831,-73.9712	
		IP Address, e.g. 153.65.8.20
		If location is not provided, it will automatically fetch the IP address of the requestor and will provide local weather information. 		
		Be aware that if you are on a VPN, the IP address will not reflect your current location but rather the one of the remote VPN connection!

Examples:

/bin/bash weather.sh rain San Francisco

/bin/bash weather.sh uv 195.34.101.1

/bin/bash weather.sh rain

Docker usage:
sudo docker build -t weather .
sudo docker run -it weather
