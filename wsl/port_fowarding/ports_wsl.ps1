$remoteport = bash.exe -c "ifconfig eth0 | grep 'inet '"
$found = $remoteport -match '\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}';

if ($found) {
    $remoteport = $matches[0];
} else {
    echo "The Script Exited, the IP address of WSL 2 cannot be found";
    exit;
}

#[TCP 포트]
# 포워딩할 TCP 포트를 콤마로 구분하여 나열합니다.
$tcp_ports=@(1008, 2377, 7946, 4789);

#[UDP 포트]
# 포워딩할 UDP 포트를 콤마로 구분하여 나열합니다.
$udp_ports=@(4789);

#[고정 IP]
# 특정 IP 주소에 대해 포트 포워딩을 할 수 있습니다.
$addr='0.0.0.0';
$tcp_ports_a = $tcp_ports -join ",";
$udp_ports_a = $udp_ports -join ",";

# 기존 방화벽 예외 규칙 제거
iex "Remove-NetFireWallRule -DisplayName 'WSL 2 TCP Firewall Unlock' ";
iex "Remove-NetFireWallRule -DisplayName 'WSL 2 UDP Firewall Unlock' ";

# 새로운 방화벽 예외 규칙 추가 (TCP 및 UDP 각각)
iex "New-NetFireWallRule -DisplayName 'WSL 2 TCP Firewall Unlock' -Direction Outbound -LocalPort $tcp_ports_a -Action Allow -Protocol TCP";
iex "New-NetFireWallRule -DisplayName 'WSL 2 TCP Firewall Unlock' -Direction Inbound -LocalPort $tcp_ports_a -Action Allow -Protocol TCP";
iex "New-NetFireWallRule -DisplayName 'WSL 2 UDP Firewall Unlock' -Direction Outbound -LocalPort $udp_ports_a -Action Allow -Protocol UDP";
iex "New-NetFireWallRule -DisplayName 'WSL 2 UDP Firewall Unlock' -Direction Inbound -LocalPort $udp_ports_a -Action Allow -Protocol UDP";

# 기존 포트 프록시 삭제
$existingProxies = netsh interface portproxy show v4tov4 | Select-String -Pattern "(\d+\.\d+\.\d+\.\d+)\s+(\d+)\s+(\d+\.\d+\.\d+\.\d+)\s+(\d+)"

foreach ($proxy in $existingProxies) {
    if ($proxy -match "(\d+\.\d+\.\d+\.\d+)\s+(\d+)\s+(\d+\.\d+\.\d+\.\d+)\s+(\d+)") {
        $listenAddress = $matches[1]
        $listenPort = $matches[2]
        iex "netsh interface portproxy delete v4tov4 listenport=$listenPort listenaddress=$listenAddress"
    }
}

# 새로운 TCP 포트 프록시 추가
foreach ($port in $tcp_ports) {
    iex "netsh interface portproxy delete v4tov4 listenport=$port listenaddress=$addr";
    iex "netsh interface portproxy add v4tov4 listenport=$port listenaddress=$addr connectport=$port connectaddress=$remoteport";
}

# UDP 포트 프록시 처리 (netsh는 UDP 지원하지 않으므로 다른 방식 필요)
foreach ($port in $udp_ports) {
    # UDP 포트를 처리할 방법을 추가해야 합니다.
    Write-Host "UDP 포트 $port 처리는 netsh로 할 수 없습니다. 별도의 처리가 필요합니다.";
}

Invoke-Expression "netsh interface portproxy show v4tov4";