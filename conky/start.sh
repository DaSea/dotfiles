#!/bin/bash
killall conky
apiKey=
cityId=
unit=metric
lang=
# curl -s "api.openweathermap.org/data/2.5/forecast?id=${cityId}&cnt=5&units=${unit}&appid=${apiKey}&lang=${lang}" -o ~/.conky/harmattan-conky/forecast.json
# curl -s "api.openweathermap.org/data/2.5/weather?id=${cityId}&cnt=5&units=${unit}&appid=${apiKey}&lang=${lang}" -o ~/.conky/harmattan-conky/weather.json
sleep 2
conky 2>/dev/null &
