#!/bin/env bash
# 目前看到的编码已经是UTF-8编码，是原来编码转为UTF-8编码显示的结果，
# 所以要想知道原来的编码，需要转换，原来的编码取决于写入程序的Encoding设置，
# windows 下一般为latin1，由于服务端采用gbk编码，原来的gbk编码传输过来后，
# 程序会以latin1的形式接收，在写入文件时，会把latin1编码转换为相应的目标编码；
# https://blog.csdn.net/weixin_50464560/article/details/119277677
# https://baijiahao.baidu.com/s?id=1713919887930449388&wfr=spider&for=pc
echo -n 'À´Ô´Á´½ÓÊÇ·ñÕýÈ·£¿'|iconv -f utf-8 -t latin1 |iconv -f gbk
