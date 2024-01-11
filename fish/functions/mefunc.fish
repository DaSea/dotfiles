function md --description "make directory and enter it"
    mkdir -p "$argv"; cd "$argv"
end

function rd --description "rd directory"
    rm -r "$argv"
end

function gc1 --description "git clone --depth 1 <url>"
    git clone --depth 1 "$argv"
end

function cdl --description "auto ls for each cd"
  if [ -n $argv[1] ]
    builtin cd $argv[1]
    and ls -AF
  else
    echo "Unknown directory name!"
  end
end

function netproxy --description "set http or socket proxy"
    export all_proxy=socks://127.0.0.1:1089/
    export ALL_PROXY=socks://127.0.0.1:1089/
    export http_proxy=http://127.0.0.1:8889
    export HTTP_PROXY=http://127.0.0.1:8889
    export https_proxy=http://127.0.0.1:8889
    export HTTPS_PROXY=http://127.0.0.1:8889
end
