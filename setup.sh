#!/bin/sh

EMACS="emacs"

EMACS_REPOSITORY="sudo add-apt-repository ppa:cassou/emacs"
EMACS_UPDATE="sudo apt-get update"
EMACS_INSTALL="sudo apt-get install emacs24-nox"
EMACS_DIRECTORY="$HOME/.emacs.d"
EMACS_FILE="$HOME/.emacs"

AUTOCOMPLETE_FILE="auto-complete-1.3.1.tar.bz2"
AUTOCOMPLETE_URL="http://cx4a.org/pub/auto-complete/$AUTOCOMPLETE_FILE"
AUTOCOMPLETE_PATH="$EMACS_DIRECTORY/auto-complete"

YASNIPPET_FILE="master.zip"
YASNIPPET_URL="https://github.com/capitaomorte/yasnippet/archive/$YASNIPPET_FILE"
YASNIPPET_PATH="$EMACS_DIRECTORY/yasnippet"

PSVN_URL="http://www.xsteve.at/prg/emacs/psvn.el"

NAV_FILE="emacs-nav-49.tar.gz"
NAV_URL="http://emacs-nav.googlecode.com/files/$NAV_FILE"
NAV_PATH="$EMACS_DIRECTORY/nav"

PHP_MODE_URL="https://raw.github.com/ejmr/php-mode/master/php-mode.el"
PHP_MODE_PATH="$EMACS_DIRECTORY/php"

SCRIPT_TEMP="$EMACS_DIRECTORY/tmp"
SETUP_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

isInstalled () {
    type "$1" > /dev/null ;
}

installEmacs () {
	echo 'Installing....'
	$EMACS_REPOSITORY
	$EMACS_UPDATE 
	$EMACS_INSTALL
	echo 'Done'
}

installAutocomplete () {
	echo 'Installing autocomplete...'
	mkdir -p "$AUTOCOMPLETE_PATH"
	wget $AUTOCOMPLETE_URL -P $AUTOCOMPLETE_PATH
	tar xjvf "$AUTOCOMPLETE_PATH/$AUTOCOMPLETE_FILE" --strip 1 -C $AUTOCOMPLETE_PATH
	rm -rf "$AUTOCOMPLETE_PATH/$AUTOCOMPLETE_FILE"
	ln -s "$AUTOCOMPLETE_PATH/dict/javascript-mode" "$AUTOCOMPLETE_PATH/dict/js-mode"
	echo 'Done'
} 

installYasnippet () {
	echo 'Installing yasnippet...' 
        wget $YASNIPPET_URL -P $EMACS_DIRECTORY
	unzip -d  "$EMACS_DIRECTORY" "$EMACS_DIRECTORY/$YASNIPPET_FILE"
        rm -rf "$EMACS_DIRECTORY/$YASNIPPET_FILE"
	mkdir -p "$EMACS_DIRECTORY/yasnippet/"
	mv  "$EMACS_DIRECTORY/yasnippet-master"/* $EMACS_DIRECTORY'/yasnippet'
	rm -rf "$EMACS_DIRECTORY/yasnippet-master"
        echo 'Done'
}

installPsvn () {
	wget "$PSVN_URL" -P "$EMACS_DIRECTORY"
}

installNav () {
     	echo 'Installing emacs nav file browser...' 
     	mkdir -p "$NAV_PATH"
	wget "$NAV_URL" -P $NAV_PATH
        tar zxvf  "$NAV_PATH/$NAV_FILE" --strip 1 -C $NAV_PATH
	rm -rf "$NAV_PATH/$NAV_FILE"
        echo 'Done'

}

installPhpMode () {
	echo 'Installing php mode...'
	echo $PHP_MODE_PATH
        mkdir -p "$PHP_MODE_PATH"
        wget "$PHP_MODE_URL" -P $PHP_MODE_PATH
}

if isInstalled $EMACS ; then
	echo 'Emacs is installed...'
else
	echo 'Emacs is not installed'
	installEmacs
fi


if [ -d "$EMACS_DIRECTORY" ]; then
	rm -rf "$EMACS_DIRECTORY"
fi

mkdir -p "$SCRIPT_TEMP"

installAutocomplete
installYasnippet
installPsvn
installNav
installPhpMode

cp "$SETUP_DIR/init.el" "$EMACS_DIRECTORY/"

rm -rf "$SCRIPT_TEMP"
