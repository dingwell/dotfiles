#!/bin/bash

SSB_USER_DIR=$HOME/.webapps/.facebook/midori

# Set up run dir if missing:
if [[ ! -d "$SSB_USER_DIR" ]]; then
  mkdir -p "$SSB_USER_DIR"
  cat << EOF > "$SSB_USER_DIR"/config
[settings]
default-encoding=ISO-8859-1
enable-developer-extras=true
enable-site-specific-quirks=true
enable-javascript=true
default-charset=ISO-8859-1
last-window-width=803
last-window-height=451
last-panel-position=231
last-panel-page=1
search-width=23
last-window-state=MIDORI_WINDOW_MAXIMIZED
location-entry-search=https://duckduckgo.com/?q=%s
show-menubar=true
toolbar-items =Back,Forward
homepage=https://www.facebook.com/
tabhome=about:dial
download-folder=
user-agent=Mozilla/5.0 (X11; Linux) AppleWebKit/538.15 (KHTML, like Gecko) Chrome/46.0.2490.86 Safari/538.15 Midori/0.5
EOF
  fi

# Launch application:
midori -c "$SSB_USER_DIR"
