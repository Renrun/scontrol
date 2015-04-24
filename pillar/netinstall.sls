netinstall:
  redis:
    source: http://download.redis.io/releases/redis-3.0.0.tar.gz
    source_hash: md5=cd8487159459d7575ba2664cb2a4819e
    package: redis-3.0.0.tar.gz
    version: 3.0.0
    extract_dir: redis-3.0.0
    extract_cmd: tar -zxf redis-3.0.0.tar.gz
    install_cmd: make && make install && cd utils
                        && ./install_redis.py 6379
                        && cd ..
