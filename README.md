# 使用haproxy中转Shadowsocks流量
>## 背景说明
>>Netflix作为一家优秀的视频提供商，为了版权方的利益，对视频内容进行了锁区。绝大部分的VPN和VPS的IP地址都被**Netflix**加入了黑名单，现在尚且只有搬瓦工等一些小众vps厂商IP段可以观看Netflix，但是没有cn2 优化更不用说gia 了，网速很慢(尤其是晚上)。

## 简单讲解一下
现在有三台设备为：
+ A,你的本地电脑;
+ B,Vultr日本服务器(IP在黑名单上);
+ C,Bandwagon美国服务器(拥有原生IP)

A当然可以直接连接C来访问Netflix，但是由于你本地网路国际带宽不足，实际上的速度很慢，播放Netflix视频加载很缓慢。

但是A直接连接B带宽充足，

B连接C机房服务器带宽充足

现在用A连接B，B连接C，通过B中转流量，如此一来，虽然成本有小幅上升，但是有明显的网络带宽情况的改善。

## 使用方法
首先在在一台设备上安装shadowsocks，并启动
然后在B上使用root用户登录，运行一下命令:

```sh
wget --no-check-certificate https://raw.githubusercontent.com/NathanDai/haproxy_install/master/haproxy.sh
chmod +x haproxy.sh
./haproxy.sh
```
安装的过程中，交互提示如下:
```sh
Please enter a port for haproxy and Shadowsocks server [1-65535]
(Default port: 8989):8989  //输入端口号

---------------------------
port = 8989
---------------------------

Please enter your Shadowsocks server's IPv4 address for haproxy
(IPv4 is):1.2.3.4   //输入C Shadowsocks服务器的公网IP

---------------------------
IP = 1.2.3.4
---------------------------

Press any key to start...or Press Ctrl+C to cancel
```
第一步输入需要 haproxy 代理的端口号，这里要跟 Shadowsocks 服务器开放的端口号一致。
第二步输入 Shadowsocks 公网 IPv4（注意：不是 haproxy 本机的 IP 地址）

## 使用命令：
+ 启动：service haproxy start

+ 停止：service haproxy stop

+ 重启：service haproxy restart

+ 状态：service haproxy status

## 配置文件路径：
+ /etc/haproxy/haproxy.cfg