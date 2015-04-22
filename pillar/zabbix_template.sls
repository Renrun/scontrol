zabbix_template:
  Mysql:
    items:
      Mysql Version:
        key: "mysql.version"
        type: 0
        valuetype: 4
      Mysql Ping:
        key: "mysql.status[ping]"
        type: 0
        triggers:
          Mysql Ping trigger:
            expression: 'last(0)'
            condition: '#1'
            priority: 4
      Mysql Aborted_clients:
        key: "mysql.status[Aborted_clients]"
        type: 1
      Mysql Aborted_connects:
        key: "mysql.status[Aborted_connects]"
        type: 1
      Mysql Binlog_cache_disk_use:
        key: "mysql.status[Binlog_cache_disk_use]"
        type: 0
      Mysql Binlog_cache_use:
        key: "mysql.status[Binlog_cache_use]"
        type: 0
      Mysql Binlog_stmt_cache_disk_use:
        key: "mysql.status[Binlog_stmt_cache_disk_use]"
        type: 0
      Mysql Binlog_stmt_cache_use:
        key: "mysql.status[Binlog_stmt_cache_use]"
        type: 0
      Mysql Bytes_received:
        key: "mysql.status[Bytes_received]"
        type: 1
        triggers:
          Mysql Bytes_received trigger:
            expression: 'avg(60)'
            condition: '>10000000'
            priority: 4
      Mysql Bytes_sent:
        key: "mysql.status[Bytes_sent]"
        type: 1
        triggers:
          Mysql Bytes_sent trigger:
            expression: 'avg(60)'
            condition: '>20000000'
            priority: 4
      Mysql Connections_per_sec:
        key: "mysql.status[Connections]"
        type: 1
      Mysql Created_tmp_disk_tables:
        key: "mysql.status[Created_tmp_disk_tables]"
        type: 1
      Mysql Created_tmp_files:
        key: "mysql.status[Created_tmp_files]"
        type: 1
      Mysql Created_tmp_tables:
        key: "mysql.status[Created_tmp_tables]"
        type: 1
      Mysql Delayed_errors:
        key: "mysql.status[Delayed_errors]"
        type: 1
      Mysql Delayed_insert_threads:
        key: "mysql.status[Delayed_insert_threads]"
        type: 1
      Mysql Delayed_writes:
        key: "mysql.status[Delayed_writes]"
        type: 1
      Mysql Innodb_buffer_pool_pages_data:
        key: "mysql.status[Innodb_buffer_pool_pages_data]"
        type: 0
      Mysql Innodb_buffer_pool_pages_dirty:
        key: "mysql.status[Innodb_buffer_pool_pages_dirty]"
        type: 0
      Mysql Innodb_buffer_pool_pages_free:
        key: "mysql.status[Innodb_buffer_pool_pages_free]"
        type: 0
      Mysql Innodb_buffer_pool_pages_misc:
        key: "mysql.status[Innodb_buffer_pool_pages_misc]"
        type: 0
      Mysql Innodb_buffer_pool_pages_total:
        key: "mysql.status[Innodb_buffer_pool_pages_total]"
        type: 0
      Mysql Open_files:
        key: "mysql.status[Open_files]"
        type: 0
      Mysql Open_tables:
        key: "mysql.status[Open_tables]"
        type: 0
      Mysql Slow_queries:
        key: "mysql.status[Slow_queries]"
        type: 1
        triggers:
          Mysql Slow_queries trigger:
            expression: 'avg(60)'
            condition: '>0.5'
            priority: 4
      Mysql Threads_cached:
        key: "mysql.status[Threads_cached]"
        type: 1
      Mysql Threads_connected:
        key: "mysql.status[Threads_connected]"
        type: 1
      Mysql Threads_created:
        key: "mysql.status[Threads_created]"
        type: 1
      Mysql Threads_running:
        key: "mysql.status[Threads_running]"
        type: 0
      Mysql Uptime:
        key: "mysql.status[Uptime]"
        type: 0
    graphs:
      Mysql Abort Connection:
        width: 900
        heigh: 200
        keys:
          - Mysql Aborted_clients
          - Mysql Aborted_connects
      Mysql Binlog Cache:
        width: 900
        heigh: 200
        keys:
          - Mysql Binlog_cache_disk_use
          - Mysql Binlog_cache_use
          - Mysql Binlog_stmt_cache_disk_use
          - Mysql Binlog_stmt_cache_use
      Mysql Traffic:
        width: 900
        heigh: 200
        keys:
          - Mysql Bytes_received
          - Mysql Bytes_sent
      Mysql Connection:
        width: 900
        heigh: 200
        keys:
          - Mysql Connections_per_sec
      Mysql Temp files:
        width: 900
        heigh: 200
        keys:
          - Mysql Created_tmp_disk_tables
          - Mysql Created_tmp_files
          - Mysql Created_tmp_tables
      Mysql Delayed:
        width: 900
        heigh: 200
        keys:
          - Mysql Delayed_errors
          - Mysql Delayed_insert_threads
          - Mysql Delayed_writes
      Mysql Innodb:
        width: 900
        heigh: 200
        keys:
          - Mysql Innodb_buffer_pool_pages_data
          - Mysql Innodb_buffer_pool_pages_dirty
          - Mysql Innodb_buffer_pool_pages_free
          - Mysql Innodb_buffer_pool_pages_misc
          - Mysql Innodb_buffer_pool_pages_total
      Mysql Open files:
        width: 900
        heigh: 200
        keys:
          - Mysql Open_files
          - Mysql Open_tables
      Mysql Slow queries:
        width: 900
        heigh: 200
        keys:
          - Mysql Slow_queries
      Mysql Threads:
        width: 900
        heigh: 200
        keys:
          - Mysql Threads_cached
          - Mysql Threads_connected
          - Mysql Threads_created
          - Mysql Threads_running
      Mysql Uptimes:
        width: 900
        heigh: 200
        keys:
          - Mysql Uptime
  Mysql Slave:
    items:
      Mysql Slave_delay:
        key: "mysql.status[Slave_delay]"
        type: 0
        triggers:
          Mysql Slave_delay trigger:
            expression: 'avg(60)'
            condition: '>5'
            priority: 4
    graphs:
      Mysql Slave delay:
        width: 900
        heigh: 200
        keys:
          - Mysql Slave_delay
  Socket:
    items:
      Socket total_sockets:
        key: "socket.total_sockets"
        type: 0
      Socket tcp_inuse:
        key: "socket.tcp_inuse"
        type: 0
      Socket tcp_orphan:
        key: "socket.tcp_orphan"
        type: 0
      Socket tcp_timewait:
        key: "socket.tcp_timewait"
        type: 0
      Socket tcp_alloc:
        key: "socket.tcp_alloc"
        type: 0
      Socket tcp_mem:
        key: "socket.tcp_mem"
        type: 0
      Socket tcp_estab:
        key: "socket.tcp_estab"
        type: 0
      Socket tcp_synrecv:
        key: "socket.tcp_synrecv"
        type: 0
      Socket udp_inuse:
        key: "socket.udp_inuse"
        type: 0
      Socket udp_mem:
        key: "socket.udp_mem"
        type: 0
    graphs:
      Socket graph:
        width: 900
        heigh: 200
        keys:
          - Socket total_sockets
          - Socket tcp_inuse
          - Socket tcp_orphan
          - Socket tcp_timewait
          - Socket tcp_alloc
          - Socket tcp_mem
          - Socket tcp_estab
          - Socket tcp_synrecv
          - Socket udp_inuse
          - Socket udp_mem
