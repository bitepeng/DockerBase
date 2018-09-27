#Aerospike

> 可靠、高性能、分布式优化的KV数据库

> 官网 https://www.aerospike.com/


###应用场景
在很多业务场景比如反欺诈、广告定向推荐、数字身份验证等，这些场景都有一些共同的特点：

- 读多于写
- 随机读
- 延迟低
- 数据量不大时，有很多优秀的框架可以使用，比如单机的redis、Cassandra等，它们不但满足上述需求而且还有着易于运维、管理方便的优点，但随着业务规模扩大，不可预测的大流量、查询延时低效都成为了比较难解决的痛点。
Aerospike在2012年作为分布式KV数据库出现后，以稳定性和延迟低的特点让不少公司开始试水，到如今4.0版本发布，6年时间里Aerospike已经积累了不少在不同行业的成功案例。

###数据模型
我理解在Aerospike的Data model其实和Hbase中的namespace/table/row/column family非常类似。

####namespace
namespace是最高层级的一个容器概念，决定了这个容器中的数据的存储方式，有着如下的配置
如何存储，可以选择全部存储到DRAM或者SSD上
replica复制因子，决定了这个namespace的高可用性
expire TTL
####sets
sets是可选项，数据存储时可以指定set也可以不指定，在set中可以设置基于set的二级索引
####records
record就是一行记录了，包括:
- key
- metadata(版本号(version), ttl, last-update-time(lut))
- bins
####bins
包括name和value（类似列名和值）

###查询索引
Aerospike中的查询索引分为两种，一级索引和二级索引，两种索引的用途各不相同。

####一级索引（Primary-Index）
Primary-Index是Aerospike默认存在的，作用是加速查询和防止数据倾斜，具体原理是取每一个key做hash后，前12bit作为partitionID，所以partition的个数是固定的，4096个。
####二级索引（Secondary-Index）
Secondary-Index和关系型数据库中的索引类似，基于bin而存在，但其索引后的值是当前节点的partitionId列表，也就是说，即使命中了二级索引，还是要scan相应partition list中的每一行记录，效率并不高。需要注意的是，在生成Secondary-Index的过程，Aerospike需要扫描所有的数据，所以要在low load的时候做这样的操作。

###一致性和高可用分析
我们假设在单namespace的情况下，当前Aerospike集群为4个节点，每个节点有1024个partition，replica复制因子为1，探讨常见的以下几种场景：

1. 在一个节点宕机的情况下，其replica的节点从replica变成了master，并开始寻找新的replica节点，数据不会发生丢失。
2. 在两个节点宕机的情况下，如果两个节点正好是partition的replica和master，数据丢失，可靠性无法保证。
3. 在一个节点宕机后重启时，由于在内存中的index丢失，需要重新scan整个SSD来重建索引（非常耗时），整个集群开始重新rebalance，相应partition的数据从其他节点复制到新节点中，直到新节点ready之后再加入集群，数据不会丢失。

###选型建议
KV数据库有很多，但大多数都是在Speed和Scale上来做取舍，根据别人的一些选型经验，总结出了其他几个存储和Aerospike对比的一些劣势。

- MongoDB、Redis这种需要内存的代价过高，无法做到低成本地快速Scale，且无法应对高峰流量。
- Couchbase性能很好，但是不支持udf。
- Cassandra在大数据量下无法保证低延迟。

###不足之处
虽然Aerospike有稳定性好、延迟低、性价比高的特点，但是也有一些不足的地方需要注意的：

- Aerospike Rolling Start时间过长（scan整个SSD重建索引）
- 无法支持复杂的数据类型，例如hyperloglog
- 每个record不能超过1MB
- 在做rebalance过程中，响应会有所抖动

