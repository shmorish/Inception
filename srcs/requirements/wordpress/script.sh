#!/bin/bash

set -e

cd /var/www/html

workdir=/var/www/html

# function download_wp_cli {
#     if [ -f wp-cli.phar ]; then
#         echo "wp-cli.phar already exists, skipping download"
#         return
#     fi
#     curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
#     chmod +x wp-cli.phar
# }

# function core_download {
#     if ./wp-cli.phar core is-installed --allow-root --path=$workdir; then
#         echo "WordPress is already installed, skipping install"
#         return
#     fi
#     ./wp-cli.phar core download --allow-root \
#         --path=$workdir
# }

# function config_create {
#     if ./wp-cli.phar config get --allow-root --path=$workdir; then
#         echo "wp-config.php already exists, skipping config create"
#         return
#     fi
#     ./wp-cli.phar config create \
#         --dbname=$DB_NAME \
#         --dbuser=$DB_USER \
#         --dbpass=$DB_PASSWORD \
#         --dbhost=$DB_HOST \
#         --allow-root \
#         --path=$workdir
# }

# function core_install {
#     if ./wp-cli.phar core is-installed --allow-root --path=$workdir; then
#         echo "WordPress is already installed, skipping install"
#         return
#     fi
#     ./wp-cli.phar core install \
#         --url=$WP_URL \
#         --title=$WP_TITLE \
#         --admin_user=$WP_ADMIN \
#         --admin_password=$WP_ADMIN_PASS \
#         --admin_email=$WP_ADMIN_EMAIL \
#         --allow-root \
#         --path=$workdir
# }

# function install_wordpress {
#     if [ -f wp-config.php ]; then
#         echo "wp-config.php already exists, skipping install"
#         return
#     fi
#     core_download
#     config_create
#     core_install
# }

# function create_database {
#     if ./wp-cli.phar db check --allow-root --path=$workdir; then
#         echo "Database already exists, skipping create"
#         return
#     fi
#     ./wp-cli.phar db create \
#         --dbuser=$DB_USER \
#         --dbpass=$DB_PASSWORD \
#         --allow-root \
#         --path=$workdir
# }

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
        ./wp-cli.phar core download --allow-root --path=$workdir || echo "Failed to download WordPress!!!!!!!!!"
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

# usage: wp user create <user-login> <user-email> [--role=<role>] [--user_pass=<password>] [--user_registered=<yyyy-mm-dd-hh-ii-ss>] [--display_name=<name>] [--user_nicename=<nice_name>] [--user_url=<url>] [--nickname=<nickname>] [--first_name=<first_name>] [--last_name=<last_name>] [--description=<description>] [--rich_editing=<rich_editing>] [--send-email] [--porcelain]

    # create_database
    # if ./wp-cli.phar db check --allow-root --path=$workdir; then
    #     echo "Database already exists, skipping create"
    # else
    #     echo "Creating database"
    #     ./wp-cli.phar db create \
    #         --dbuser=$DB_USER \
    #         --dbpass=$DB_PASSWORD \
    #         --allow-root \
    #         --path=$workdir
    # fi
    php-fpm8.2 -F
}

main

# cd /var/www/html
# curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
# chmod +x wp-cli.phar
# ./wp-cli.phar core download --allow-root
# ./wp-cli.phar config create --dbname=wordpress --dbuser=wpuser --dbpass=password --dbhost=mariadb --allow-root
# ./wp-cli.phar core install --url=localhost --title=inception --admin_user=admin --admin_password=admin --admin_email=admin@admin.com --allow-root
# php-fpm8.2 -F
