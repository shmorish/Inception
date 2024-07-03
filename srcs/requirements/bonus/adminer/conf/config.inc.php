<?php
function adminer_object() {
    // データベースへの接続設定
    $host = 'mariadb'; // docker-compose.yml で指定した MariaDB のサービス名
    $username = 'root';
    $password = getenv('MYSQL_ROOT_PASSWORD'); // .env ファイルからパスワードを取得
    $database = 'wordpress';

    class AdminerSoftware extends Adminer {
        function name() {
            // サイドバーの表示名を変更
            return 'Inception Adminer';
        }

        function permanentLogin() {
            // セキュリティのため、恒久ログインは無効化
            return false;
        }
    }
    return new AdminerSoftware(compact('host', 'username', 'password', 'database'));
}

// その他の Adminer 設定 (必要に応じて)
// 例: デフォルトの接続先データベース
// $_GET["db"] = "wordpress";