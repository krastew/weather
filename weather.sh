#!/bin/bash

access_key=71a61caa44d01e376b1731dcf093cf5d
args="${@:2}"
city=$(echo "$args" |xargs)

if [ -z "$city" ]; then
	echo "City is empty"
	city=`curl -s showip.net`
fi

result=$(curl -s --request GET 'http://api.weatherstack.com/current?access_key='$access_key'&query='$city'')

rain() {
        chanceOfRain=$(echo $result|jq .current.precip)
        echo "The chance of rain today is $chanceOfRain %"
        if (( $(echo "$chanceOfRain > 5"|bc -l) )); then
                true
	fi
}

uv() {
        uvIndex=$(echo $result|jq .current.uv_index)
        echo "The UV index today is $uvIndex"
        if (( $(echo " uvIndex > 3 "|bc -l) )); then
                true
	fi
}

if [ "$1" == "rain" ]; then
	rain
elif [ "$1" == "shine" ]; then
	uv
fi
