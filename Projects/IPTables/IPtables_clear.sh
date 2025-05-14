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

  curl -k https://10.10.0.105:8443

  docker network ls
  423  docker inspect 0d7df158492b | grep -i network
  426  docker restart 0d7df158492b
  427  docker network create d0158673f4ebef4123197535ad35eb72b8504b5f54c9fb50cac4368a332bbc9e
  428  docker restart 0d7df158492b
  429  docker ps -a
  431  sudo docker rm -f $(sudo docker container ls -qa --filter="label=kasm.kasmid")
  434  sudo -E docker compose -f /opt/kasm/current/docker/docker-compose.yaml rm
  435  sudo docker network rm kasm_default_network
  436  plugin_name=$(sudo docker network inspect kasm_sidecar_network --format '{{.Driver}}')
  437  sudo docker network rm kasm_sidecar_network
  438  sudo docker plugin disable $plugin_name
  439  sudo docker plugin rm $plugin_name

   sudo /opt/kasm/current/bin/stop
  431  sudo docker rm -f $(sudo docker container ls -qa --filter="label=kasm.kasmid")
  432  export KASM_UID=$(id kasm -u)
  433  export KASM_GID=$(id kasm -g)
  434  sudo -E docker compose -f /opt/kasm/current/docker/docker-compose.yaml rm
  435  sudo docker network rm kasm_default_network
  436  plugin_name=$(sudo docker network inspect kasm_sidecar_network --format '{{.Driver}}')
  437  sudo docker network rm kasm_sidecar_network
  438  sudo docker plugin disable $plugin_name
  439  sudo docker plugin rm $plugin_name
  440  sudo rm -rf /var/log/kasm-sidecar
  441  sudo rm -rf /var/run/kasm-sidecar
  442  docker ps -a
  443  docker rm 56fb90705938 
  444  docker ps -a
  445  cd /tmp
  446  curl -O https://kasm-static-content.s3.amazonaws.com/kasm_release_1.16.1.98d6fa.tar.gz
  447  tar -xf kasm_release_1.16.1.98d6fa.tar.gz
  448  sudo bash kasm_release/install.sh -L 8443
  449  docker ps -a
  450  curl -k https://10.10.0.105:8443