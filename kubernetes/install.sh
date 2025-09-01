# 1. docker(containerd) 설치
# 2. swap 비활성화
sudo nano /etc/fstab # 스왑항목 주석처리
sudo swapoff -a
# 3. kubelet, kubeadm, kubectl 등 설치
# 4. containerd systemdCgroup 설정
sudo bash -c 'containerd config default > /etc/containerd/config.toml'
sudo nano /etc/containerd/config.toml # SystemdCgroup = true
sudo systemctl restart containerd
sudo systemctl restart kubelet
# 5. init
kubeadm init --skip-phases=addon/kube-proxy
# 6. helm 설치
# 7. cilium 설치 (helm)
API_SERVER_IP=192.168.45.121
API_SERVER_PORT=6443
helm install cilium cilium/cilium \
  --version 1.18.1 \
  --namespace kube-system \
  --set kubeProxyReplacement=true \
  --set k8sServiceHost=${API_SERVER_IP} \
  --set k8sServicePort=${API_SERVER_PORT} \
  --set gatewayAPI.enabled=true
# 8. cilium CLI 설치