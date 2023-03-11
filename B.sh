#!/bin/bash
#此脚本插入运行在编译完成之后,文件上传之前。
#用于简单方便地进行一些shell操作,修改些工作。如复制一些文件或目录到上传目录
#本仓库的文件存放在工作目录下的apps里, 变量${GITHUB_WORKSPACE}/apps
#sdk下载目录为${SDK_NAME}
#此工作默认自动上传目录为${SDK_NAME}/bin/packages/${SDK_ARCH}
