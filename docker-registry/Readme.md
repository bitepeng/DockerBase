

###推送镜像到私有仓库

要推送镜像到私有仓库，需要先根据私有仓库地址来设定新标签

```
# 从官方仓库拉取一个镜像(可选)
docker pull alpine:3.6
 
# 根据私有仓库，设定标签（必须） 
# 为镜像 `alpine:3.6` 创建一个新标签 `127.0.0.1:5000/alpine:3.6`
docker tag alpine:3.6 127.0.0.1:5000/alpine:3.6
 
# 推送到私有仓库中
docker push 127.0.0.1:5000/alpine:3.6
```

###将仓库地址配置到不安全仓库列表中

```
# Error http: server gave HTTP response to HTTPS client
# 编辑 /etc/docker/daemon.json
vi /etc/docker/daemon.json

# 增加配置项
{
  ... # 其他配置项
  # 关键配置项，将仓库将入到不安全的仓库列表中
  "insecure-registries":[ 
    "127.0.0.1:5000"
  ]
}

# 重启Docker服务（CentOS 7.2）
systemctl restart docker
```

###验证是否提交到私有库
```
通过访问 http://127.0.0.1:5000/v2/alpine/tags/list 就能看到刚才提交的镜像了。
也可以通过 http://127.0.0.1:5000/v2/_catalog 来列出仓库中的镜像列表。
```

### 在需要拉取私有镜像的服务器修改docker镜像

```
# 编辑 /etc/docker/daemon.json
vi /etc/docker/daemon.json

# 增加配置项
{
  ... # 其他配置项
   # 增加私有库地址
  "registry-mirrors": [
        "http://1f637783.m.daocloud.io",
        "http://127.0.0.1:5000", 
    ],
  "storage-driver": "devicemapper"

}

# 重启Docker服务（CentOS 7.2）
systemctl restart docker
```