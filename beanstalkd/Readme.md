#Beanstalk

> Beanstalk，一个高性能、轻量级的分布式内存队列系统.

> 官网 https://beanstalkd.github.io/

Beanstalk is a simple, fast work queue.

Its interface is generic, but was originally designed for reducing the latency of page views in high-volume web applications by running time-consuming tasks asynchronously.

最初设计的目的是想通过后台异步执行耗时的任务来降低高容量Web应用系统的页面访问延迟，
支持过有9.5 million用户的Facebook Causes应用。
现在有PostRank大规模部署和使用，每天处理百万级任务。
Beanstalkd是典型的类Memcached设计，协议和使用方式都是同样的风格，所以使用过memcached的用户会觉得Beanstalkd似曾相识。