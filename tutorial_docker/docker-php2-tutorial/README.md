# docker-php2-tutorial
## 構成

docker-php2-tutorial
├── docker-compose.yml
├── Dockerfile
├── nginx.conf
├── php.ini
├── php_sample
│   ├── code1
│   └── code2...
└── mysql
    └── data


# 8回　PHPの環境構築／docker-composeで複数コンテナを一括で起動
https://harusite.net/20230305-docker-2/


docker-compose up -d

docker-compose ps

docker stop $(docker ps -aq) 


