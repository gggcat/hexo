FROM zzzcat/dispshell:node12

WORKDIR /hexo-work

#
# HEXO
#
# npm WARN optional SKIPPING OPTIONAL DEPENDENCY: ....
#  case1) npm install --no-optional 
#  case2) echo "optional=false" >> .npmrc
#  case3) npm -g config set optional false
RUN apt-get install -y python3 && \
    git config --global http.sslVerify false && \
    npm -g config set optional false && \
    npm config ls && \
    npm install -g hexo-cli && \
    hexo init && \
    echo "*** INSTALLED: hexo ***"

RUN npm install npm-check-updates -g --save && \
    npm install -g hexo --save && \
    npm install -g grunt-cli --save && \
    npm install hexo-generator-feed --save && \
    npm install hexo-generator-sitemap --save && \
    npm install hexo-generator-robotstxt --save && \
    npm install hexo-generator-seo-friendly-sitemap --save && \
    npm install hexo-generator-archive --save && \
    npm install hexo-generator-category --save && \
    npm install hexo-generator-index --save && \
    npm install hexo-generator-tag --save && \
    npm install hexo-generator-search --save && \
    npm install hexo-renderer-marked --save && \
    npm install hexo-toc --save && \
    npm install hexo-algoliasearch --save && \
    npm install hexo-tag-googlecharts --save && \
    npm install hexo-filter-mermaid-diagrams --save && \
    ncu -u && \
    npm install && \
    echo "*** INSTALLED: hexo modules ***"

#
# HEXO themes/tranquilpeak
#
RUN wget --no-check-certificate https://github.com/LouisBarranqueiro/hexo-theme-tranquilpeak/archive/master.zip && \
    mv master.zip themes/ && \
    cd themes && \
    unzip master.zip && \
    rm master.zip && \
    mv hexo-theme-tranquilpeak-master tranquilpeak && \
    #git clone https://github.com/LouisBarranqueiro/hexo-theme-tranquilpeak themes/tranquilpeak && \
    #cd themes/tranquilpeak && \
    cd tranquilpeak && \
    #ncu -u && \
    npm install && \
    npm run prod && \
    echo "*** INSTALLED: hexo themes/tranquilpeak ***"
#
# HEXO themes/icarus
#
RUN git clone https://github.com/ppoffice/hexo-theme-icarus.git themes/icarus && \
    cd themes/icarus && \
    ncu -u && \
    npm install && \
    echo "*** INSTALLED: hexo themes/icarus ***"

#
# RUN: need override
#
EXPOSE 4000
COPY entrypoint.sh .
ENTRYPOINT ["bash", "entrypoint.sh"]
CMD ["server"]