FROM jlesage/baseimage-gui:debian-10

MAINTAINER Poseidon's 3 Rings

ENV APP_NAME="P3R Autodesk Eagle"
ENV KEEP_APP_RUNNING=1

RUN apt-get update && apt-get install -y locales && rm -rf /var/lib/apt/lists/* \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 \
	&& export LANGUAGE=en_US.UTF-8 \
	&& export LANG=en_US.UTF-8 \
	&& export LC_ALL=en_US.UTF-8
ENV LANG en_US.utf8

WORKDIR /usr/src/P3R

COPY startapp.sh /startapp.sh

RUN apt-get update \
	&& apt-get -y install \
	wget \
	packagekit-gtk3-module \
	libdbus-glib-1-2 \
	&& rm -rf /var/lib/apt/lists/* \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 \
	&& export LANGUAGE=en_US.UTF-8 \
	&& export LANG=en_US.UTF-8 \
	&& export LC_ALL=en_US.UTF-8 \
	&& wget -q https://trial2.autodesk.com/NET17SWDLD/2017/EGLPRM/ESD/Autodesk_EAGLE_9.6.1_English_Linux_64bit.tar.gz \
	&& tar xzf /usr/src/P3R/Autodesk_EAGLE_9.6.1_English_Linux_64bit.tar.gz \
	&& rm Autodesk_EAGLE_9.6.1_English_Linux_64bit.tar.gz  \
	&& apt-get -y purge wget \
	&& apt-get -y autoremove
	
RUN \
	APP_ICON_URL=https://raw.githubusercontent.com/P3R-CO/unraid/master/Eagle-P3R-256px.png && \
    APP_ICON_DESC='{"masterPicture":"/opt/novnc/images/icons/master_icon.png","iconsPath":"/images/icons/","design":{"ios":{"pictureAspect":"noChange","assets":{"ios6AndPriorIcons":false,"ios7AndLaterIcons":false,"precomposedIcons":false,"declareOnlyDefaultIcon":true}},"desktopBrowser":{"design":"raw"},"windows":{"pictureAspect":"noChange","backgroundColor":"#da532c","onConflict":"override","assets":{"windows80Ie10Tile":false,"windows10Ie11EdgeTiles":{"small":false,"medium":true,"big":false,"rectangle":false}}},"androidChrome":{"pictureAspect":"noChange","themeColor":"#ffffff","manifest":{"display":"standalone","orientation":"notSet","onConflict":"override","declared":true},"assets":{"legacyIcon":false,"lowResolutionIcons":false}},"safariPinnedTab":{"pictureAspect":"silhouette","themeColor":"#5bbad5"}},"settings":{"scalingAlgorithm":"Mitchell","errorOnImageTooSmall":false,"readmeFile":false,"htmlCodeFile":false,"usePathAsIs":false},"versioning":{"paramName":"v","paramValue":"ICON_VERSION"}}' && \
	install_app_icon.sh "$APP_ICON_URL" "$APP_ICON_DESC"