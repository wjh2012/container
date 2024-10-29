$remoteport = bash.exe -c "ifconfig eth0 | grep 'inet '"
$found = $remoteport -match '\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}';

if ($found) {
    $remoteport = $matches[0];
} else {
    echo "The Script Exited, the IP address of WSL 2 cannot be found";
    exit;
}

# 기존 포트 리스트와 새 포트를 추가한 리스트
$tcp_ports=@(2222, 1004, 1006, 1008, 1010);
$addr='0.0.0.0';
$tcp_ports_a = $tcp_ports -join ",";

# 추가할 포트만을 위한 새로운 방화벽 예외 규칙 추가 (TCP)
iex "New-NetFireWallRule -DisplayName 'WSL 2 TCP Firewall Unlock 1010' -Direction Outbound -LocalPort 1010 -Action Allow -Protocol TCP";
iex "New-NetFireWallRule -DisplayName 'WSL 2 TCP Firewall Unlock 1010' -Direction Inbound -LocalPort 1010 -Action Allow -Protocol TCP";

# 새로운 TCP 포트 프록시 추가
foreach ($port in $tcp_ports) {
    iex "netsh interface portproxy delete v4tov4 listenport=$port listenaddress=$addr";
    iex "netsh interface portproxy add v4tov4 listenport=$port listenaddress=$addr connectport=$port connectaddress=$remoteport";
}

Invoke-Expression "netsh interface portproxy show v4tov4";
