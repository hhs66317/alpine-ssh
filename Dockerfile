# 指定创建的基础镜像
FROM alpine

# 作者描述信息
MAINTAINER alpine_ssh

COPY entrypoint.sh /

# 替换阿里云的源
RUN echo "http://mirrors.aliyun.com/alpine/latest-stable/main/" > /etc/apk/repositories && \
    echo "http://mirrors.aliyun.com/alpine/latest-stable/community/" >> /etc/apk/repositories

# 更新源、安装openssh 并修改配置文件和生成key 并且同步时间
RUN apk update && \
    apk add --no-cache openssh-server tzdata tmux zsh vim htop && \
    cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    sed -i "s/#PermitRootLogin.*/PermitRootLogin yes/g" /etc/ssh/sshd_config && \
    ssh-keygen -t rsa -P "" -f /etc/ssh/ssh_host_rsa_key && \
    ssh-keygen -t ecdsa -P "" -f /etc/ssh/ssh_host_ecdsa_key && \
    ssh-keygen -t ed25519 -P "" -f /etc/ssh/ssh_host_ed25519_key && \
    mkdir /data && \
    chmod +x /entrypoint.sh && \
    echo "root:admin" | chpasswd

ADD root /root/

# 开放22端口
EXPOSE 22
 
# 执行ssh启动命令
CMD /entrypoint.sh && /usr/sbin/sshd -D

