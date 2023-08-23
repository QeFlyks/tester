<?php
if (!file_exists(dirname(__FILE__) . '/system.php')) {
    echo '<pre>';
    echo 'Ошибка! Файл system.php не найден!';
    echo '</pre>';
    die;
}

define('TKM', true);
require_once dirname(__FILE__) . '/system.php';

if (!$config['main']['installed']) {
    header('Location: install.php');
    die;
}

if (isset($_GET['pstatus'])) {
    switch ($_GET['pstatus']) {
        case 'success':
            MessageSend(3, 'Оплата успешно завершена, спасибо за покупку!', 'index.php');
            break;

        case 'waiting':
            MessageSend(2, 'Оплата не завершена, ожидание платежа...', 'index.php');
            break;

        case 'fail':
            MessageSend(1, 'Платёж отменён.', 'index.php');
            break;
    }
}

$pageData = [
    // Admin button link in navigation menu
    'adminButton' => isset($_SESSION['authsession']) ? '<li><a href="cpanel.php">Админ-панель</a></li>' : '',

    // Modules blocks
    'lastBuyers' => false,
    'hideLastBuyers' => false,
    'advert' => false,
    'hideAdvert' => false,
    'content' => false,

    // Links on page (header|footer)
    'links' => [
        'footer' => false,
        'header' => false,
    ],
];

// Fill links
foreach ($config['links'] as $links) {
    if ($links['footer'] === true) {
        $pageData['links']['footer'] .= loadTpl('/links/footer.html', $links);
    } else {
        $pageData['links']['header'] .= loadTpl('/links/header.html', $links);
    }
}

// Setting advert block (if isset)
if (!empty($config['advert']['text']) && $advertData = $config['advert']) {
    $advertData['button'] = false;
    if (!empty($advertData['button_name'])) {
        $advertData['button'] = loadTpl('/advert_button.html', $advertData);
    }

    $pageData['advert'] = loadTpl('/advert.html', $advertData);
}

$page = 'main';
if (!empty($_GET['mod']) && $mod = $_GET['mod']) {
    $modFile = LD_ROOT_DIR . '/pages/' . $mod . '.php';
    if (file_exists($modFile)) {
        $page = $mod;
    }
}

ob_start();
include(LD_ROOT_DIR . '/pages/' . $page . '.php');
$pageData['content'] = ob_get_clean();

if (@$config['main']['last_buyers'] === true && $pageData['hideLastBuyers'] === false) {
    $lastBuyerList = false;
    $buyersQuery = $link->query("SELECT `username`, `data`, `time` FROM `AD_PAYMENTS` WHERE `status` = '1' ORDER BY `time` DESC LIMIT 6");

    while ($buyer = $buyersQuery->fetch()) {
        $goods_name = json_decode($buyer['data'], true)['goods_name'];
        $lastBuyerList .= loadTpl("/last_buyers/buyer.html", [
            'buyer' => $buyer,
            'name' => $goods_name,
        ]);
    }

    if (empty($lastBuyerList)) {
        $data = loadTpl("/last_buyers/none.html");
    } else {
        $data = $lastBuyerList;
    }
    $pageData['lastBuyers'] = loadTpl("/last_buyers/parent.html", $data);
}

echo loadTpl('/index.html', $pageData);