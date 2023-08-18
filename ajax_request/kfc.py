# 爬取想要爬取城市的肯德基餐厅信息
# http://www.taodudu.cc/news/show-3402050.html?action=onClick
import requests
if __name__ == '__main__':
    # 指定url
    url = 'http://www.kfc.com.cn/kfccda/ashx/GetStoreList.ashx?op=keyword'
    # 动态输入查找的城市
    city = input('请输入您想要查找的城市：')
    # 参数处理
    param = {'cname': '','pid': '','keyword': city,        # 城市名称
             'pageIndex': '1',       
             # 页面
             'pageSize': '10',       
             # 一页显示多少数据
             }
    # 进行UA伪装
    header = {'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.105 Safari/537.36'}
    # 获取相应数据
    response = requests.post(url=url,data=param,headers=header)
    # 这个页面是一个text，不是json
    page_text = response.text
    print(page_text)
    print('数据爬取成功！')
    #输出结果：
#{"Table":[{"rowcount":65}],"Table1":[{"rownum":1,"storeName":"育慧里","addressDetail":"小营东路3号北京凯基伦购物中心一层西侧","pro":"24小时,Wi-Fi,店内参观,礼品卡","provinceName":"北京市","cityName":"北京市"},{"rownum":2,"storeName":"京通新城","addressDetail":"朝阳路杨闸环岛西北京通苑30号楼一层南侧","pro":"Wi-Fi,店内参观,礼品卡,生日餐会","provinceName":"北京市","cityName":"北京市"},{"rownum":3,"storeName":"黄寺大街","addressDetail":"黄寺大街15号北京城乡黄寺商厦","pro":"Wi-Fi,点唱机,店内参观,礼品卡,生日餐会","provinceName":"北京市","cityName":"北京市"},{"rownum":4,"storeName":"四季青桥","addressDetail":"西四环北路117号北京欧尚超市F1、B1","pro":"Wi-Fi,礼品卡,生日餐会","provinceName":"北京市","cityName":"北京市"},{"rownum":5,"storeName":"亦庄","addressDetail":"北京经济开发区西环北路18号F1＋F2","pro":"24小时,Wi-Fi,礼品卡,生日餐会","provinceName":"北京市","cityName":"北京市"},{"rownum":6,"storeName":"石园南大街","addressDetail":"通顺路石园西区南侧北京顺义西单商场石园分店一层、二层部分","pro":"24小时,Wi-Fi,店内参观,礼品卡,生日餐会","provinceName":"北京市","cityName":"北京市"},{"rownum":7,"storeName":"北京南站","addressDetail":"北京南站候车大厅B岛201号","pro":"Wi-Fi,礼品卡","provinceName":"北京市","cityName":"北京市"},{"rownum":8,"storeName":"北清路","addressDetail":"北京北清路1号146区","pro":"24小时,Wi-Fi,店内参观,礼品卡","provinceName":"北京市","cityName":"北京市"},{"rownum":9,"storeName":"大红门新世纪肯德基餐厅","addressDetail":"海户屯北京新世纪服装商贸城一层南侧","pro":"Wi-Fi,点唱机,礼品卡","provinceName":"北京市","cityName":"北京市"},{"rownum":10,"storeName":"巴沟","addressDetail":"巴沟路2号北京华联万柳购物中心一层","pro":"Wi-Fi,礼品卡,生日餐会","provinceName":"北京市","cityName":"北京市"}]}
