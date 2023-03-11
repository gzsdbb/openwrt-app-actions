#!/bin/bash
#此脚本插入运行在sdk下载之后 feeds处理之前
#用于简单方便地进行一些shell操作,修改此工作
#本仓库的文件存放在工作目录下的apps里, 变量${GITHUB_WORKSPACE}/apps
#sdk下载目录为${SDK_NAME}
#git clone https://github.com/1wrt/luci-app-ikoolproxy.git ${SDK_NAME}/package/luci-app-ikoolproxy
sed -i '$a src-git NueXini_Packages https://github.com/NueXini/NueXini_Packages.git' ${GITHUB_WORKSPACE}/apps/feeds.conf
