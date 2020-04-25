#!/bin/bash

#
# deploy config files
#
function deploy_hexo_config {
    if [ -v ${HEXO_CONF_DIR} ]; then
        echo "HEXO CONFIG: None"
    else
        echo "HEXO CONFIG: ${HEXO_CONF_DIR}"
        BASE_DIR=$(pwd)
        cd ${HEXO_CONF_DIR}
        tar cvf - * | tar xvf - -C ${BASE_DIR}
        cd ${BASE_DIR}
    fi
}

#
# Build themes/tranquilpeak
#
function build_themes_tranquilpeak {
    BASE_DIR=$(pwd)
    cd themes/tranquilpeak/
    grunt build
    cd ${BASE_DIR}
}

#
# Build algolia index
#
function generate_algolia_index {
    # 環境変数で`USE_SEARCH_ALGOLIA`がtrueで無ければインデックス生成しない
    if [ -v ${USE_SEARCH_ALGOLIA} ]; then
        USE_SEARCH_ALGOLIA="false"
    fi
    if "${USE_SEARCH_ALGOLIA}"; then
        hexo algolia
    fi
}

#
# HEXO
#
deploy_hexo_config
build_themes_tranquilpeak

case $1 in
    regenerate)
        hexo clean
        hexo generate
        generate_algolia_index
        ;;
    generate)
        hexo generate
        generate_algolia_index
        ;;
    server)
        hexo generate
        hexo server
        ;;
    *)
        echo "entrypoint.sh"
        echo " CMD)"
        echo "    regenerate: hexo clean & hexo generate"
        echo "    generate: hexo generate"
        echo "    server: hexo server"
        ;;
esac
