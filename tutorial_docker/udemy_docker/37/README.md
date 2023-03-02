# Dockerfile によるイメージの作成

## Dockerfile をもとにイメージをビルド

```
docker build -t my-ruby:dockerfile .
```

## 自作したイメージからコンテナを起動

```
docker run -it my-ruby:dockerfile bash
```
