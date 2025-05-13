sudo netstat -tuln | grep 9090
  973  curl http://localhost:9090
  974  curl https://localhost:9090
  975  curl -k https://localhost:9090
  976  curl -g -k -6 https://localhost:9090
  977  sudo iptables -I INPUT -i lo -p tcp --dport 9090 -j ACCEPT
  978  curl -k https://localhost:9090
  979  exit
  980  sudo iptables -L INPUT --line-numbers -n -v
  981  sudo iptables -D INPUT 1
  982  sudo service iptables save
  983  sudo service iptables reload
  984  sudo alternatives --display iptables
  985  sudo iptables-save > /etc/iptables/rules.v4
  986  sudo iptables -L -n -v
  987  sudo iptables -L INPUT --line-numbers -n
  988  sudo iptables -D INPUT 3
  989  sudo iptables -L INPUT --line-numbers -n
  990  sudo iptables -L INPUT --line-numbers -n
  991  history
  992  curl -k https://localhost:9090