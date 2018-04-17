# cd $HOME/.conky/feed/
rm -fr feed_*
echo '正在获取天气信息....' > feed_ls
sleep 13
a=111 ; b=113 ; c=122 ; d=155 ; e=117 ; f=118
# wget -q https://tianqi.moji.com/ -O tqym
wget -q https://tianqi.moji.com/weather/china/hubei/jiangxia-district -O tqym
pd=`head -108 tqym | tail -1 | grep li`
if test "$pd" != ''
then	
	a=121 ; b=123 ; c=132 ; d=165 ; e=127 ; f=128
	pd=`head -118 tqym | tail -1 | grep li`
	if test "$pd" != ''
	then
	a=131 ; b=133 ; c=142 ; d=175 ; e=137 ; f=138
	fi

fi
wd=`head -$a tqym | tail -1 | awk -F'>' '{print $2}' | awk -F'<' '{print $1}'`
tq=`head -$b tqym | tail -1 | awk -F'>' '{print $2}' | awk -F'<' '{print $1}' `
by=`head -$c tqym | tail -1 | awk -F'>' '{print $2}' | awk -F'<' '{print $1}'`
wc=`head -$d tqym | tail -1 | awk -F'>' '{print $2}' | awk -F'<' '{print $1}' `
dq=`head -72 tqym | tail -1 | awk -F'>' '{print $2}' | awk -F'<' '{print $1}'`
kqzl=` head -105 tqym | tail -1 | awk -F'>' '{print $2}' | awk -F'<' '{print $1}' | awk '{print $1 $2}'`
sd=` head -$e tqym | tail -1 | awk -F'>' '{print $2}' | awk -F'<' '{print $1}' | awk '{print $1 $2}'`
fl=`head -$f tqym | tail -1 | awk -F'>' '{print $2}' | awk -F'<' '{print $1}'`

rm -fr tqym
echo "$wd°" > feed_wd 
echo "  $tq     $wc" > feed_ls
echo "空气质量：$kqzl    $fl     $sd" > feed_xls
echo "$by" >> feed_xls
cw=`cat feed_wd` 2>/dev/null
cl=`cat feed_ls` 2> /dev/null
cx=`cat feed_xls` 2>/dev/null
if [ "$cw" = '' ] || [ "$cl" = '' ] || [ "$cx" = '' ]
then
	sz=`cat sz`
	if test $sz -lt '9'
	then
		sleep 1
		sz=`expr $sz + 1`
		echo $sz > sz
		sh $0
	else
		exit 0
	fi
fi
echo 1 > sz
