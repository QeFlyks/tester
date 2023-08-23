<?php
function formatMOTD($motd){
	$search  = array('§0', '§1', '§2', '§3', '§4', '§5', '§6', '§7', '§8', '§9', '§a', '§b', '§c', '§d', '§e', '§f', '§l', '§m', '§n', '§o', '§k', '§r');
	$replace = array('<font color="#000000">', '<font color="#0000AA">', '<font color="#00AA00">', '<font color="#00AAAA">', '<font color="#aa00aa">', '<font color="#ffaa00">', '<font color="#aaaaaa">', '<font color="#555555">', '<font color="#5555ff">', '<font color="#55ff55">', '<font color="#55ffff">', '<font color="#ff5555">', '<font color="#ff55ff">', '<font color="#ffff55">', '<font color="#ffffff">', '<font color="#000000">', '<b>', '<u>', '<i>', '<font color="#000000">', '<font color="#000000">');
	$motd  = str_replace($search, $replace, $motd);
	
	return $motd;
}
function QueryMinecraft($ip, $port = 25565) {
//made by Fabian

	@$socket = fsockopen("tcp://" . $ip, $port, $errno, $errstr, 3);
	if (!$socket) { return array('status' => 0); }
	socket_set_timeout($socket, 5);
	fwrite($socket, "\xFE\x01"); //Send the server list ping request (two bytes)
	@$data = fread($socket, 1024); //Get the info and store it in $data
	
	if ($data != false && substr($data, 0, 1) == "\xFF") //Ensure we're getting a kick message as expected
	{
		$data = substr($data, 9); //Remove packet, length and starting characters
		$data = explode("\x00\x00", $data); //0000 separated info
		$protocolVersion = $data[0]; //Get it all into separate variables
		@$serverVersion = mb_convert_encoding($data[1], 'UTF-8', 'UCS-2');;
		@$motd = $data[2];
		$motd = mb_convert_encoding($motd, 'UTF-8', 'UCS-2');
		@$players = mb_convert_encoding($data[3], 'UTF-8', 'UCS-2');
		@$max_players = mb_convert_encoding($data[4], 'UTF-8', 'UCS-2');
		
		sleep(0.2);
		return array('status' => 1,'HostName' => formatMOTD($motd), 'Players' => $players, 'MaxPlayers' => $max_players, 'serverVersion' => $serverVersion);
	} else { return array('status' => 0); }
}
$data = QueryMinecraft($_GET['ip_port']);
if(file_exists('cashe/'.md5($_GET['ip_port']))){
	$online = file_get_contents('cashe/'.md5($_GET['ip_port']));
	if($data['Players'] > $online){
		file_put_contents('cashe/'.md5($_GET['ip_port']), $data['Players']);
		$online = $data['Players'];
	}
}else{
	file_put_contents('cashe/'.md5($_GET['ip_port']), $data['Players']);
	$online = $data['Players'];
}
echo $data['Players'].'/'.$data['MaxPlayers'].'/'.$online;
?>