#!/bin/bash
if test "$1" = 'network'
then
	read -p '请输入你的网卡名字：' net
	cat $HOME/.conkyrc | sed -i "/下载速度/d" $HOME/.conkyrc 
	cat $HOME/.conkyrc | sed -i "/上传速度/d" $HOME/.conkyrc
	cat $HOME/.conkyrc | sed -i "/downspeedgraph/d" $HOME/.conkyrc
	echo "下载速度:\$alignr\${downspeed $net} k/s" >> $HOME/.conkyrc
	echo "上传速度:\$alignr\${upspeed $net} k/s" >> $HOME/.conkyrc
	echo "\${downspeedgraph $net 324D23 77B753}" >> $HOME/.conkyrc
	exit 0
fi
killall conky
cat $HOME/.profile | sed -i '/conky/d' $HOME/.profile
cat $HOME/.profile | sed -i '/feed.sh/d' $HOME/.profile

rm -fr $HOME/.conkyrc $HOME/.feed
cp -rf conkyrc  $HOME/.conkyrc  
cp -rf feed $HOME/.feed 
echo 'conky &' >> $HOME/.profile
echo "sh $HOME/.feed/feed.sh &" >> $HOME/.profile

echo ''
echo "如果你的网络监控不工作，请在终端进入本工具解压的目录后执行　　 sh setup.sh network "
conky 2>/dev/null &
echo ''
echo '正在初始化天气模块，请等待。。。。'
echo '若30秒内无响应请退出后重新执行　谢谢'
sh $HOME/.feed/feed.sh
