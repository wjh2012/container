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
$tcp_ports=@(2222, 1004, 1006, 1008);

#[고정 IP]
# 특정 IP 주소에 대해 포트 포워딩을 할 수 있습니다.
$addr='0.0.0.0';
$tcp_ports_a = $tcp_ports -join ",";

# 기존 방화벽 예외 규칙 제거
iex "Remove-NetFireWallRule -DisplayName 'WSL 2 TCP Firewall Unlock' ";

# 새로운 방화벽 예외 규칙 추가 (TCP)
iex "New-NetFireWallRule -DisplayName 'WSL 2 TCP Firewall Unlock' -Direction Outbound -LocalPort $tcp_ports_a -Action Allow -Protocol TCP";
iex "New-NetFireWallRule -DisplayName 'WSL 2 TCP Firewall Unlock' -Direction Inbound -LocalPort $tcp_ports_a -Action Allow -Protocol TCP";

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

Invoke-Expression "netsh interface portproxy show v4tov4";
