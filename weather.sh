#!/bin/bash
# Enter your own access key from https://weatherstack.com
access_key=71a61caa44d01e376b1731dcf093cf5d

# Do not modify past this point!

# Check if there is any argument provided, if not - ask interactively the user to enter those:

args="$@"
argsProvided=$(echo "$args" |xargs)



# Check if there is location argument provided and set it in a variable city
lastArgs="${@:2}"
city=$(echo "$lastArgs" |xargs)

# Check if there are any arguments provided, if not - ask interactively
if [ -z "$argsProvided" ]; then 
        echo "Please enter your query type: rain, shine"
        read querytype
        echo "Optional: Please enter your location, e.g. city, ZIP code, IP address or leave blank for fetching your current location"
        read city
fi

# If location is not provided, use the fetch:ip function in the API call to get requestee's IP address
if [ -z "$city" ]; then
	city="fetch:ip"
fi

# The API query
result=$(curl -s --request GET 'http://api.weatherstack.com/current?access_key='$access_key'&query='$city'')

# Creating 2 functions for query type "rain" and "shine"
rain() {
        chanceOfRain=$(echo $result|jq .current.precip)
        echo "The chance of rain today is $chanceOfRain %"
        if (( $(echo "$chanceOfRain > 5"|bc -l) )); then
                true
	fi
}

shine() {
        uvIndex=$(echo $result|jq .current.uv_index)
        echo "The UV index today is $uvIndex"
        if (( $(echo "$uvIndex > 3"|bc -l) )); then
                true
	fi
}

# Check the user's input and run the function requested 
if [ "$1" == "rain"  ] || [ "$querytype" == "rain" ]; then
	rain
elif [ "$1" == "shine" ] || [ "$querytype" == "shine" ]; then
	shine
fi
