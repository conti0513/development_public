# ボリュームによるファイルの共有

## Ruby のコードをマウントして Bash を実行

```
docker run \
  -v $PWD:/opt/myapp \
  -w /opt/myapp \
  -it \
  my-ruby:dockerfile \
  bash
```

## Ruby のコードをマウントして Ruby を実行

```
docker run \
  -v $PWD:/opt/myapp \
  -w /opt/myapp \
  my-ruby:dockerfile \
  ruby hello.rb
```
