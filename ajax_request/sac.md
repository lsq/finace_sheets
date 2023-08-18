#### 保荐机构

- 请求方式：POST
- 请求地址：https://gs.sac.net.cn/publicity/getSponsorOrgList
```json
{"success": true, "code": 20000, "message": "成功", "data":{
"data": [{"id": 1, "orgName": "爱建证券有限责任公司", "orgAbbrName": "爱建证券", "aoiDate": null},…]
}
```
#### 保荐代表人名单

- 请求方式：POST
- 请求地址：https://gs.sac.net.cn/publicity/getSponsorAList
```json
{
    "success": true,
    "code": 20000,
    "message": "成功",
    "data": {
        "data": [
            {
                "uuid": "1613582845020009770",
                "name": "赵宏",
                "orgId": "1999106",
                "orgAbbrName": "平安证券",
                "prjCnt": 24,
                "badSinhonClassifCode": 7,
                "badSinhonClassifName": "无",
                "profLvlSituCode": 1,
                "profLvlSituDesc": "测试达到基本要求",
                "orderNo": 1
            },...]
            }
}
```
#### 保荐代表人基本信息

- 请求方式：POST
- 请求地址：https://gs.sac.net.cn/publicity/getSponsorDetail
- 请求类型: application/x-www-form-urlencoded
- 请求参数：uuid: 1613582845020009770

```json
{
    "success": true,
    "code": 20000,
    "message": "成功",
    "data": {
        "data": {
            "uuid": "1613582845020009770",
            "practnrNo": "012110",
            "staffNo": "012110",
            "name": "赵宏",
            "certifNo": "S1060712100040",
            "regDate": "2012-10-22",
            "orgId": "1999106",
            "orgAbbrName": "平安证券",
            "orgName": "平安证券股份有限公司",
            "pracCtegCode": "6",
            "pracCtegName": "保荐代表人",
            "edu": "硕士研究生",
            "gender": "女",
            "prjCnt": 24,
            "sinhonCnt": 0,
            "badSinhonClassifCode": 7,
            "badSinhonClassifName": "无",
            "profLvlSituCode": 1,
            "profLvlSituDesc": "测试达到基本要求",
            "exemptPrjCnt": "0",
            "photoPath": "L29sZHN5cy8yMDA4LTAxLTAyLzIwMDgwMTAyL3JlZ2lzdHJhdGlvblJwSW5mby8xMzYzODYyOTM0\nNzc3NzAyOTIuanBn",
            "trainYear": "-",
            "trainPreyear": "已完成",
            "regHistory": "[{\"certif_no\":\"S0020100010149\",\"status\":\"离职注销\",\"get_date\":\"2004-02-06\",\"leave_date\":\"2008-04-30\",\"org_name\":\"国元证券股份有限公司\",\"reg_type\":\"一般证券业务\" },{\"certif_no\":\"S1060108051310\",\"status\":\"离职注销\",\"get_date\":\"2008-05-13\",\"leave_date\":\"2012-10-18\",\"org_name\":\"平安证券股份有限公司\",\"reg_type\":\"一般证券业务\" },{\"certif_no\":\"S1060712100040\",\"status\":\"正常\",\"get_date\":\"2012-10-22\",\"leave_date\":\"\",\"org_name\":\"平安证券股份有限公司\",\"reg_type\":\"保荐代表人\" }]",
            "orderNo": 1
        }
    }
}
```

#### 保荐代表人保荐项目信息

- 请求方式：POST
- 请求地址：https://gs.sac.net.cn/publicity/getSponsorPrjList
- 请求类型: application/x-www-form-urlencoded
- 请求参数：practnrNo: 012110

```json
{
    "success": true,
    "code": 20000,
    "message": "成功",
    "data": {
        "data": [
            {
                "uuid": "1613582845020394625",
                "issuerName": "杭州热电集团股份有限公司",
                "projectType": "首发",
                "sector": "沪市主板",
                "tradPlace": "上海证券交易所",
                "finishDate": "2021-06-30",
                "orgName": "平安证券股份有限公司",
                "hasShinhonInfo": "否",
                "practnrNo": "012110",
                "isOnlyCntnuSteerPrj": "",
                "oldProjectNum": "BJS106110018"
            }, ...          
                    ]
    }
}

```
#### 保荐代表人执业声誉信息

- 请求方式：POST
- 请求地址：https://gs.sac.net.cn/publicity/getSponsorSinhonList
- 请求类型: application/x-www-form-urlencoded
- 请求参数：practnrNo: 012110

```json
{"success":true,"code":20000,"message":"成功","data":{"data":[]}}
```

#### 保荐代表人个人信息

- 请求方式：GET
- 请求地址：https://gs.sac.net.cn/publicity/filedownload?
- 请求参数: path: L29sZHN5cy8yMDA4LTAxLTAyLzIwMDgwMTAyL3JlZ2lzdHJhdGlvblJwSW5mby8xMzYzODYyOTM0Nzc3NzAyOTIuanBn

#### Ruby实现方式

```ruby
require 'ostruct'

json = {
  "application_id" => 45,
  "student_id" => 88887,
  "school_id" => 1,
  "course_id" => 1
}

helper = openstruct.new(json)
helper.application_id
# => 45
```

