$remoteport = bash.exe -c "ifconfig eth0 | grep 'inet '"
$found = $remoteport -match '\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}';

if ($found) {
    $remoteport = $matches[0];
} else {
    echo "The Script Exited, the IP address of WSL 2 cannot be found";
    exit;
}

#[Ports]
# All the ports you want to forward separated by comma
$ports=@(50022, 59092, 59093, 59094);

#[Static IP]
# You can change the addr to your IP config to listen to a specific address
$addr='0.0.0.0';
$ports_a = $ports -join ",";

# Remove Firewall Exception Rules
iex "Remove-NetFireWallRule -DisplayName 'WSL 2 Firewall Unlock' ";

# Adding Exception Rules for inbound and outbound Rules
iex "New-NetFireWallRule -DisplayName 'WSL 2 Firewall Unlock' -Direction Outbound -LocalPort $ports_a -Action Allow -Protocol TCP";
iex "New-NetFireWallRule -DisplayName 'WSL 2 Firewall Unlock' -Direction Inbound -LocalPort $ports_a -Action Allow -Protocol TCP";

# Remove all existing port proxies
$existingProxies = netsh interface portproxy show v4tov4 | Select-String -Pattern "(\d+\.\d+\.\d+\.\d+)\s+(\d+)\s+(\d+\.\d+\.\d+\.\d+)\s+(\d+)"

foreach ($proxy in $existingProxies) {
    if ($proxy -match "(\d+\.\d+\.\d+\.\d+)\s+(\d+)\s+(\d+\.\d+\.\d+\.\d+)\s+(\d+)") {
        $listenAddress = $matches[1]
        $listenPort = $matches[2]
        iex "netsh interface portproxy delete v4tov4 listenport=$listenPort listenaddress=$listenAddress"
    }
}

# Add new port proxies
foreach ($port in $ports) {
    iex "netsh interface portproxy delete v4tov4 listenport=$port listenaddress=$addr";
    iex "netsh interface portproxy add v4tov4 listenport=$port listenaddress=$addr connectport=$port connectaddress=$remoteport";
}

Invoke-Expression "netsh interface portproxy show v4tov4";
