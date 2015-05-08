#!/bin/bash

# 1. 清除旧有规则
iptables -F
iptables -X
iptables -Z

# 2. 设置默认策略
iptables -P INPUT DROP
iptables -P OUTPUT ACCEPT
iptables -P FORWARD ACCEPT

# 3. state模块
iptables -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT

# 4. 允许本机
iptables -A INPUT -i lo -j ACCEPT

# 5. 允许ping
iptables -A INPUT -p icmp -j ACCEPT


# 6. 开放22端口
iptables -A INPUT -p tcp -m state --state NEW -m tcp --dport 22 -j ACCEPT


# 7. 开放80端口
iptables -A INPUT -p tcp --dport 80 -j ACCEPT

# 8. 保存到配置文件
service iptables save