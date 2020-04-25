# hexo

## About

This is HEXO container.

## Usage

generate contents.

``` bash
docker-compose run generate
```

generate contents and preview.

``` bash
docker-compose up
```

## 環境変数

| ENV                | VALUE                              |
| ------------------ | ---------------------------------- |
| HEXO_CONF_DIR      | Folder path for Hexo configuration |
| USE_SEARCH_ALGOLIA | true or false                      |

## docker-compose.yml

``` yml
  stage:
    image: zzzcat/hexo:latest
    command: server
    tty: true
    volumes:
      - ./source:/hexo-work/source:ro
      - ./public:/hexo-work/public:rw
    ports:
      - "4000:4000"
    environment:
      HEXO_CONF_DIR: ./source/.hexo_config/
      USE_SEARCH_ALGOLIA: "true"
```
