#!/usr/bin/env bash

### docker-entrypoint.sh
### Sets up and installs Dokuwiki if needed.
###
### Author: Nathan Campos <nathan@innoveworkshop.com>

if [ ! -e index.php ]; then
	# Download and extract the latest stable version.
	curl -s -L https://download.dokuwiki.org/src/dokuwiki/dokuwiki-stable.tgz | \
		tar zxvf - -C . --strip-components=1

	# Install plugins.
	cd lib/plugins

	# Install Upgrade plugin.
	curl -L https://github.com/splitbrain/dokuwiki-plugin-upgrade/zipball/master -o upgrade.zip && \
		unzip upgrade.zip && \
		rm upgrade.zip && \
		mv splitbrain-dokuwiki-plugin-upgrade-* upgrade

	# Install copy2clipboard plugin.
	curl -L https://github.com/schplurtz/dokuwiki-plugin-copy2clipboard/zipball/master -o copy2clipboard.zip && \
		unzip copy2clipboard.zip && \
		rm copy2clipboard.zip && \
		mv schplurtz-dokuwiki-plugin-copy2clipboard-* copy2clipboard

	# Install sortablejs plugin.
	curl -L https://github.com/FyiurAmron/sortablejs/zipball/master -o sortablejs.zip && \
		unzip sortablejs.zip && \
		rm sortablejs.zip && \
		mv FyiurAmron-sortablejs-* sortablejs

	# Install color plugin.
	curl -L https://github.com/hanche/dokuwiki_color_plugin/zipball/master -o color.zip && \
		unzip color.zip && \
		rm color.zip && \
		mv hanche-dokuwiki_color_plugin-* color

	# Install barcodes plugin.
	curl -L https://gitlab.com/MatthiasLohr/dokuwiki-barcodes/-/releases/permalink/latest/downloads/dokuwiki-barcodes.zip -o barcodes.zip && \
		unzip barcodes.zip -d barcodes && \
		rm barcodes.zip

	# Installing templates.
	cd ../tpl

	# Install Default template.
	curl -L https://github.com/dokufreaks/template-default/zipball/master -o default.zip && \
		unzip default.zip && \
		rm default.zip && \
		mv dokufreaks-template-default-* default

	# Install Bootstrap 3 template.
	curl -L https://github.com/LotarProject/dokuwiki-template-bootstrap3/zipball/master -o bootstrap3.zip && \
		unzip bootstrap3.zip && \
		rm bootstrap3.zip && \
		mv giterlizzi-dokuwiki-template-bootstrap3-* bootstrap3

	# Install DokuBook template.
	curl -L https://github.com/samfisch/dokuwiki-template-dokubook/archive/master.zip -o dokubook.zip && \
		unzip dokubook.zip && \
		rm dokubook.zip && \
		mv dokuwiki-template-dokubook-* dokubook

	# Come back to the original root of the applcation.
	cd ../../

	# Ensure all of our permissions are set correctly.
	chown -R www-data:www-data .
fi

exec "$@"
