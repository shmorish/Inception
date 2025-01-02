#!/bin/bash

cd /var/www/html

workdir=/var/www/html

function main {
    # download_wp_cli
    if [ -f wp-cli.phar ]; then
        echo "wp-cli.phar already exists, skipping download"
    else
        curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
        chmod +x wp-cli.phar
    fi

    if ./wp-cli.phar core is-installed --allow-root --path=$workdir; then
        echo "WordPress is already installed, skipping install"
    else
        echo "Downloading WordPress"
        ./wp-cli.phar core download --allow-root --path=$workdir
    fi
    # config_create
    if ./wp-cli.phar config get --allow-root --path=$workdir; then
        echo "wp-config.php already exists, skipping config create"
    else
        echo "Creating wp-config.php"
        ./wp-cli.phar config create \
            --dbname=$DB_NAME \
            --dbuser=$DB_USER \
            --dbpass=$DB_PASSWORD \
            --dbhost=$DB_HOST \
            --allow-root \
            --path=$workdir
    fi
    # core_install
    if ./wp-cli.phar core is-installed --allow-root --path=$workdir; then
        echo "WordPress is already installed, skipping install"
    else
        echo "Installing WordPress"
        ./wp-cli.phar core install \
            --url=$WP_URL \
            --title=$WP_TITLE \
            --admin_user=$WP_ADMIN \
            --admin_password=$WP_ADMIN_PASS \
            --admin_email=$WP_ADMIN_EMAIL \
            --allow-root \
            --path=$workdir
    fi
    if ./wp-cli.phar user get $WP_EDITOR_USER --allow-root --path=$workdir; then
        echo "Editor user already exists, skipping create"
    else
        echo "Creating editor user"
        ./wp-cli.phar user create \
            $WP_EDITOR_USER $WP_EDITOR_EMAIL \
            --role=editor \
            --user_pass=$WP_EDITOR_PASS \
            --allow-root \
            --path=$workdir
    fi
    exec php-fpm8.2 -F
}

main
