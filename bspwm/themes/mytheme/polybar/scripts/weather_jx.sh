#!/bin/bash

# SETTINGS vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv

# API settings ________________________________________________________________

# APIKEY=`cat $HOME/.owm-key`
APIKEY='dc0f31ac6f37484f88e3e7d45b84e403'
# if you leave these empty location will be picked based on your ip-adres
CITY_NAME='jiangxia'
CITY_ID='101200105'
# Desired output language
COUNTRY_CODE='IT'
LANG="en"
# UNITS can be "metric", "imperial" or "kelvin". Set KNOTS to "yes" if you
# want the wind in knots:

#          | temperature | wind
# -----------------------------------
# metric   | Celsius     | km/h
# imperial | Fahrenheit  | miles/hour
# kelvin   | Kelvin      | km/h

UNITS="metric"

# Color Settings ______________________________________________________________

COLOR_CLOUD="#606060"
COLOR_THUNDER="#d3b987"
COLOR_LIGHT_RAIN="#73cef4"
COLOR_HEAVY_RAIN="#b3deef"
COLOR_SNOW="#FFFFFF"
COLOR_FOG="#606060"
COLOR_TORNADO="#d3b987"
COLOR_SUN="#ffc24b"
COLOR_MOON="#FFFFFF"
COLOR_ERR="#f43753"
COLOR_WIND="#73cef4"
COLOR_COLD="#b3deef"
COLOR_HOT="#f43753"
COLOR_NORMAL_TEMP="#FFFFFF"

# Leave "" if you want the default polybar color
COLOR_TEXT=""
# Polybar settings ____________________________________________________________

# Font for the weather icons
WEATHER_FONT_CODE=4

# Font for the thermometer icon
TEMP_FONT_CODE=2

# Wind settings _______________________________________________________________

# Display info about the wind or not. yes/no
DISPLAY_WIND="yes"

# Show beaufort level in windicon
BEAUFORTICON="yes"

# Display in knots. yes/no
KNOTS="yes"

# How many decimals after the floating point
DECIMALS=0

# Min. wind force required to display wind info (it depends on what
# measurement unit you have set: knots, m/s or mph). Set to 0 if you always
# want to display wind info. It's ignored if DISPLAY_WIND is false.

MIN_WIND=11

# Display the numeric wind force or not. If not, only the wind icon will
# appear. yes/no

DISPLAY_FORCE="yes"

# Display the wind unit if wind force is displayed. yes/no
DISPLAY_WIND_UNIT="yes"

# Thermometer settings ________________________________________________________

# When the thermometer icon turns red
HOT_TEMP=25

# When the thermometer icon turns blue
COLD_TEMP=0

# Other settings ______________________________________________________________

# Display the weather description. yes/no
DISPLAY_LABEL="yes"

# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

if [ "$COLOR_TEXT" != "" ]; then
    COLOR_TEXT_BEGIN="%{F$COLOR_TEXT}"
    COLOR_TEXT_END="%{F-}"
fi

if [ -z "$CITY_ID" ]; then
    CIDURL = $(curl -s https://geoapi.qweather.com/v2/city/lookup?location=$CITY_NAME&key=$APIKEY&number=1)
    CITY_ID=$(echo $CIDURL | jq -r ".location[0].id")
fi

RESPONSE=""
ERROR=0
ERR_MSG=""
# 获取一周的天气
## URL="https://devapi.qweather.com/v7/weather/7d?location=$CITY_ID&key=$APIKEY"
# 获取当前的天气
URL="https://devapi.qweather.com/v7/weather/now?location=$CITY_ID&key=$APIKEY"

function getData {
    ERROR=0
    # For logging purposes
    # echo " " >> "$HOME/.weather.log"
    # echo `date`" ################################" >> "$HOME/.weather.log"
    RESPONSE=`curl -s -L -X GET --compressed $URL`
    # RESPONSE=`cat weather.json`
    CODE="$?"
    echo $CODE
    if [ "$1" = "-d" ]; then
        # -d 调试
        # echo $RESPONSE
        echo $RESPONSE > "weather.json"
    fi
    RESPONSECODE=0
    if [ $CODE -eq 0 ]; then
        RESPONSECODE=`echo $RESPONSE | jq .code`
    fi

    RETLEN=$((${#RESPONSECODE}-2))
    RETCODE=${RESPONSECODE:1:RETLEN}
    if [ $CODE -ne 0 ] || [ ${RETCODE} -ne 200 ]; then
        if [ $CODE -ne 0 ]; then
            ERR_MSG="curl Error $CODE"
            # echo "curl Error $CODE" >> "$HOME/.weather.log"
        else
            ERR_MSG="Conn. Err. $RESPONSECODE"
            # echo "API Error $RESPONSECODE" >> "$HOME/.weather.log"
        fi
        ERROR=1
    # else
    #     echo "$RESPONSE" > "$HOME/.weather-last"
    #     echo `date +%s` >> "$HOME/.weather-last"
    fi
}

# 具体的code定义：https://dev.qweather.com/docs/resource/icons/
# 雷阵雨大雨等判断数组
tsarr=(300 301 302 303 304 308 317 399)
# 小雨等判断数组
lrainarr=(305 306)
# 大雨等判断数组
hrainarr=(307 309 310 311 312 313 316 350 351)
# 雨等判断数组k
rainarr=(309 314 315 399)
# 雪等数组
snowarr=(400 401 402 403 404 405 406 407 408 409 410 456 457 499)
# 雾数组
fogarr=(500 501 502 509 510 511 512 513 514 515)
# 风
windarr=(503 504 507 508 509)
# 晴天
clearskyarr=(100 150)
# 阴天
overcastarr=(104)
# 云
cloudarr=(101 102 103 151 152 153)

function is_exist() {
  local target=$1
  shift
  local arr=("$@")

  for item in "${arr[@]}"; do
    if [ "$item" == "$target" ]; then
      return 0
    fi
  done

  return 1
}
function setIcons {
    echo $WID
    ICONMODE=0

    is_exist ${WID} ${tsarr[@]}
    if [[ $? -eq 0 ]]; then
        ICONMODE=1
    fi
    is_exist $WID ${lrainarr[@]}
    if [[ $? -eq 0 ]]; then
        ICONMODE=2
    fi
    is_exist $WID ${hrainarr[@]}
    if [[ $? -eq 0 ]]; then
        ICONMODE=3
    fi
    is_exist $WID ${rainarr[@]}
    if [[ $? -eq 0 ]]; then
        ICONMODE=4
    fi
    is_exist $WID ${snowarr[@]}
    if [[ $? -eq 0 ]]; then
        ICONMODE=5
    fi
    is_exist $WID ${fogarr[@]}
    if [[ $? -eq 0 ]]; then
        ICONMODE=6
    fi
    is_exist $WID ${windarr[@]}
    if [[ $? -eq 0 ]]; then
        ICONMODE=7
    fi
    is_exist $WID ${clearskyarr[@]}
    if [[ $? -eq 0 ]]; then
        ICONMODE=8
    fi
    is_exist $WID ${overcastarr[@]}
    if [[ $? -eq 0 ]]; then
        ICONMODE=9
    fi
    is_exist $WID ${cloudarr[@]}
    if [[ $? -eq 0 ]]; then
        ICONMODE=10
    fi


    echo $DATE
    echo $SUNSET
    echo $SUNRISE
    if [[ ${ICONMODE} -eq 1 ]]; then
        #Thunderstorm
        ICON_COLOR=$COLOR_THUNDER
        if [ $DATE -ge $SUNRISE -a $DATE -le $SUNSET ]; then
            ICON=""
        else
            ICON=""
        fi
    elif [[ ${ICONMODE} -eq 2 ]]; then
        #Light drizzle
        ICON_COLOR=$COLOR_LIGHT_RAIN
        if [ $DATE -ge $SUNRISE -a $DATE -le $SUNSET ]; then
            ICON=""
        else
            ICON=""
        fi
    elif [[ ${ICONMODE} -eq 3 ]]; then
        #Heavy drizzle
        ICON_COLOR=$COLOR_HEAVY_RAIN
        if [ $DATE -ge $SUNRISE -a $DATE -le $SUNSET ]; then
            ICON=""
        else
            ICON=""
        fi
    elif [[ ${ICONMODE} -eq 4 ]]; then
        #Rain
        ICON_COLOR=$COLOR_HEAVY_RAIN
        if [ $DATE -ge $SUNRISE -a $DATE -le $SUNSET ]; then
            ICON=""
        else
            ICON=""
        fi
    elif [[ ${ICONMODE} -eq 5 ]]; then
        #Snow
        ICON_COLOR=$COLOR_SNOW
        ICON=""
    elif [[ ${ICONMODE} -eq 6 ]]; then
        #Fog
        ICON_COLOR=$COLOR_FOG
        ICON=""
    elif [[ ${ICONMODE} -eq 7 ]]; then
        #Tornado
        ICON_COLOR=$COLOR_TORNADO
        ICON=""
    elif [[ ${ICONMODE} -eq 8 ]]; then
        #Clear sky
        if [ $DATE -ge $SUNRISE -a $DATE -le $SUNSET ]; then
            ICON_COLOR=$COLOR_SUN
            ICON=""
        else
            ICON_COLOR=$COLOR_MOON
            ICON=""
        fi
    elif [[ ${ICONMODE} -eq 10 ]]; then
        # Few clouds
        if [ $DATE -ge $SUNRISE -a $DATE -le $SUNSET ]; then
            ICON_COLOR=$COLOR_SUN
            ICON=""
        else
            ICON_COLOR=$COLOR_MOON
            ICON=""
        fi
    elif [[ ${ICONMODE} -eq 9 ]]; then
        # Overcast
        ICON_COLOR=$COLOR_CLOUD
        ICON=""
    else
        ICON_COLOR=$COLOR_ERR
        ICON=""
    fi

    WIND=""
    WINDFORCEVAR=`echo "$RESPONSE" | jq .now.windSpeed`
    WINDLEN=$((${#WINDFORCEVAR}-2))
    WINDFORCE=${WINDFORCEVAR:1:WINDLEN}
    echo ${WINDFORCE}
    WINDICON=""
    if [ $BEAUFORTICON == "yes" ];then
        WINDFORCE2=${WINDFORCE}
        if [ $WINDFORCE2 -le 1 ]; then
            WINDICON=""
        elif [ $WINDFORCE2 -gt 1 ] && [ $WINDFORCE2 -le 5 ]; then
            WINDICON=""
        elif [ $WINDFORCE2 -gt 5 ] && [ $WINDFORCE2 -le 11 ]; then
            WINDICON=""
        elif [ $WINDFORCE2 -gt 11 ] && [ $WINDFORCE2 -le 19 ]; then
            WINDICON=""
        elif [ $WINDFORCE2 -gt 19 ] && [ $WINDFORCE2 -le 28 ]; then
            WINDICON=""
        elif [ $WINDFORCE2 -gt 28 ] && [ $WINDFORCE2 -le 38 ]; then
            WINDICON=""
        elif [ $WINDFORCE2 -gt 38 ] && [ $WINDFORCE2 -le 49 ]; then
            WINDICON=""
        elif [ $WINDFORCE2 -gt 49 ] && [ $WINDFORCE2 -le 61 ]; then
            WINDICON=""
        elif [ $WINDFORCE2 -gt 61 ] && [ $WINDFORCE2 -le 74 ]; then
            WINDICON=""
        elif [ $WINDFORCE2 -gt 74 ] && [ $WINDFORCE2 -le 88 ]; then
            WINDICON=""
        elif [ $WINDFORCE2 -gt 88 ] && [ $WINDFORCE2 -le 102 ]; then
            WINDICON=""
        elif [ $WINDFORCE2 -gt 102 ] && [ $WINDFORCE2 -le 117 ]; then
            WINDICON=""
        elif [ $WINDFORCE2 -gt 117 ]; then
            WINDICON=""
        fi
    fi
    if [ $KNOTS = "yes" ]; then
        case $UNITS in
            "imperial") 
                # The division by one is necessary because scale works only for divisions. bc is stupid.
                WINDFORCE=`echo "scale=$DECIMALS;$WINDFORCE * 0.8689762419 / 1" | bc`
                ;;
            *)
                WINDFORCE=`echo "scale=$DECIMALS;$WINDFORCE * 1.943844 / 1" | bc`
                ;;
        esac
    else
        if [ $UNITS != "imperial" ]; then
            # Conversion from m/s to km/h
            WINDFORCE=`echo "scale=$DECIMALS;$WINDFORCE * 3.6 / 1" | bc`
        else
            WINDFORCE=`echo "scale=$DECIMALS;$WINDFORCE / 1" | bc`
        fi
    fi
    if [ "$DISPLAY_WIND" = "yes" ] && [ `echo "$WINDFORCE >= $MIN_WIND" |bc -l` -eq 1 ]; then
        WIND="%{T$WEATHER_FONT_CODE}%{F$COLOR_WIND}$WINDICON%{F-}%{T-}"
        if [ $DISPLAY_FORCE = "yes" ]; then
            WIND="$WIND $COLOR_TEXT_BEGIN$WINDFORCE$COLOR_TEXT_END"
            if [ $DISPLAY_WIND_UNIT = "yes" ]; then
                if [ $KNOTS = "yes" ]; then
                    WIND="$WIND ${COLOR_TEXT_BEGIN}kn$COLOR_TEXT_END"
                elif [ $UNITS = "imperial" ]; then
                    WIND="$WIND ${COLOR_TEXT_BEGIN}mph$COLOR_TEXT_END"
                else
                    WIND="$WIND ${COLOR_TEXT_BEGIN}km/h$COLOR_TEXT_END"
                fi
            fi
        fi
        WIND="$WIND |"
    fi
    if [ "$UNITS" = "metric" ]; then
        TEMP_ICON="󰔄"
    elif [ "$UNITS" = "imperial" ]; then
        TEMP_ICON="󰔅"
    else
        TEMP_ICON="󰔆"
    fi
    
    TEMP="$TEMP$TEMP_ICON"
}

function outputCompact {
    # OUTPUT="$WIND %{T$WEATHER_FONT_CODE}%{F$ICON_COLOR}$ICON%{F-}%{T-} $ERR_MSG$COLOR_TEXT_BEGIN$DESCRIPTION$COLOR_TEXT_END| $TEMP"
    # echo "Output: $OUTPUT" >> "$HOME/.weather.log"
    OUTPUT="$ICON $DESCRIPTION $TEMP"
    echo "$OUTPUT"
}

getData $1
if [ $ERROR -eq 0 ]; then
    # MAIN=`echo $RESPONSE | jq .now.main`
    MAINID=`echo $RESPONSE | jq .now.icon`
    # SUNRISE=`echo $RESPONSE | jq .now.sunrise`
    # SUNSET=`echo $RESPONSE | jq .now.sunset`
    SUNRISE=7
    SUNSET=18
    # DATE=`date +%s`
    DATEVAR=`date +%H`
    DATESTR="$DATEVAR"
    if [ ${DATEVAR:0:1} -eq 0 ]; then 
        echo "first is zero"
        retlen=$((${#DATESTR}-1))
        DATASTR1=${DATESTR:1:retlen}
        echo $DATASTR1
        DATESTR=$DATASTR1
    fi
    DATE=$((DATESTR))
    echo $DATE
    # 描述
    DESC=`echo $RESPONSE | jq .now.text`
    DESCLEN=$((${#DESC}-2))
    DESCRIPTION=${DESC:1:DESCLEN}
    # 风速
    WIND=""
    MAINLEN=$((${#MAINID}-2))
    WID=${MAINID:1:MAINLEN}
    # 温度字符串转整数
    TEMPVAR=`echo $RESPONSE | jq .now.temp`
    TEMPLEN=$((${#TEMPVAR}-2))
    TEMP=${TEMPVAR:1:TEMPLEN}
    # 压强
    PRESSUREVAR=`echo $RESPONSE | jq .now.pressure`
    PRESSLEN=$((${#PRESSUREVAR}-2))
    PRESSURE=${PRESSUREVAR:1:PRESSLEN}
    # 湿度
    HUMIDITYVAR=`echo $RESPONSE | jq .now.humidity`
    HUMLEN=$((${#HUMIDITYVAR}-2))
    HUMIDITY=${HUMIDITYVAR:1:HUMLEN}
    setIcons
    outputCompact
else
    echo " "
fi
