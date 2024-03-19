### 李志资源

#### POSTMAN

##### API接口

```http
https://xiazai.lizhi334.com/api/storage/files
```



##### POST数据

```json
{
    "storageKey": "111",
    "path": "/★李志资源/★专辑版音频★",
    "password": "52nj",
    "orderBy": "name",
    "orderDirection": "asc"
}
```

##### 返回数据

```json
{
    "code": 0,
    "msg": "ok",
    "data": {
        "files": [
            {
                "name": "2005 被禁忌的游戏",
                "time": "2023-08-26 20:13",
                "size": 28386337,
                "type": "FOLDER",
                "path": "★李志资源/★专辑版音频★",
                "url": null
            },
            {
                "name": "2006 这个世界会好吗",
                "time": "2023-08-26 20:13",
                "size": 31879188,
                "type": "FOLDER",
                "path": "★李志资源/★专辑版音频★",
                "url": null
            },
            {
                "name": "2007 梵高先生",
                "time": "2023-08-26 20:13",
                "size": 25270196,
                "type": "FOLDER",
                "path": "★李志资源/★专辑版音频★",
                "url": null
            },
            {
                "name": "2009 我爱南京",
                "time": "2023-08-26 20:13",
                "size": 48245259,
                "type": "FOLDER",
                "path": "★李志资源/★专辑版音频★",
                "url": null
            },
            {
                "name": "2010 你好，郑州",
                "time": "2023-08-26 20:13",
                "size": 28862997,
                "type": "FOLDER",
                "path": "★李志资源/★专辑版音频★",
                "url": null
            },
            {
                "name": "2014 1701",
                "time": "2023-08-26 20:13",
                "size": 30295138,
                "type": "FOLDER",
                "path": "★李志资源/★专辑版音频★",
                "url": null
            },
            {
                "name": "2014 F",
                "time": "2023-08-26 20:13",
                "size": 30213125,
                "type": "FOLDER",
                "path": "★李志资源/★专辑版音频★",
                "url": null
            },
            {
                "name": "2014 IO跨年音乐会 专辑版",
                "time": "2023-08-26 20:13",
                "size": 61915212,
                "type": "FOLDER",
                "path": "★李志资源/★专辑版音频★",
                "url": null
            },
            {
                "name": "2016 8",
                "time": "2023-08-26 20:13",
                "size": 19819001,
                "type": "FOLDER",
                "path": "★李志资源/★专辑版音频★",
                "url": null
            },
            {
                "name": "2016 在每一条伤心的应天大街上",
                "time": "2023-08-26 20:13",
                "size": 28578980,
                "type": "FOLDER",
                "path": "★李志资源/★专辑版音频★",
                "url": null
            },
            {
                "name": "2018 爵士与不插电新编12首",
                "time": "2023-08-26 20:13",
                "size": 49484312,
                "type": "FOLDER",
                "path": "★李志资源/★专辑版音频★",
                "url": null
            }
        ],
        "passwordPattern": null
    },
    "dataCount": null,
    "traceId": "e712518a-b107-498b-9f6f-081d40a7ccc7"
}
```

#### ARIA2 RPC JSON

Assuming you started the RPC server with `aria2c --enable-rpc --rpc-listen-port=6800 --rpc-secret=ariatest` you can use

```bash
curl http://localhost:6800/jsonrpc -d "{\"jsonrcp\":\"2.0\",\"id\":\"someID\",\"method\":\"aria2.addUri\",\"params\":[\"token:ariatest\",[\"http://m.gettywallpapers.com/wp-content/uploads/2020/01/Wallpaper-Naruto-2.jpg\"],{\"out\":\"test.jpg\"}]}"
```

​    

if you're on Windows and

```bash
curl http://localhost:6800/jsonrpc -d '{"jsonrcp":"2.0","id":"someID","method":"aria2.addUri","params":["token:ariatest",["http://m.gettywallpapers.com/wp-content/uploads/2020/01/Wallpaper-Naruto-2.jpg"],{"out":"test.jpg"}]}'
```

​    

if you're on Linux or Mac.

It will download to the working directory of the RPC server. If you want to change it start the server with `--dir` option or set it for each file - instead of `{"out":"test.jpg"}` in the JSON you send use `{"out":"test.jpg","dir":"path_to_folder"}`.

#### RUBY 递归下载

```ruby
# encoding: utf-8

require "faraday"

require "json"

require "aria2"



initString = "/★李志资源/★专辑版音频★"

#initString = "★李志资源/★专辑版音频★/2014 1701"

xiazai = "https://xiazai.lizhi334.com/api/storage/files"

$aria2Client = Aria2::Client.new(host: "localhost", port: 6800)



=begin

postData = {

  "storageKey": "111",

  "path": initString,

  "password": "52nj",

  "orderBy": "name",

  "orderDirection": "asc",

}.to_json

=end

def gen_post_data(path)

  return { "storageKey": "111",

           "path": path,

           "password": "52nj",

           "orderBy": "name",

           "orderDirection": "asc" }.to_json

end



def get_response(resource, jsonData)

  conn = Faraday.new(url: resource) do |builder|

    builder.request :json

    builder.response :json

    builder.response :raise_error

    builder.response :logger

  end

  begin

    response = conn.post(resource, jsonData)

    return response

  rescue Faraday::Error => e

    puts e.response[:status]

    puts e.response[:body]

  end

end



p gen_post_data initString



re = get_response xiazai, gen_post_data(initString)

puts re.body

puts re.body.class

#puts JSON.parse(re.body)

puts re.body["code"], re.body["data"]["files"]



def get_music(resource, jsonData)

  re = get_response(resource, jsonData)

  if re.body["code"] == 0

    re.body["data"]["files"].each do |item|

      if item["type"] == "FOLDER"

        get_music(resource, gen_post_data(item["path"] + "/" + item["name"]))

      elsif item["type"] == "FILE"

        puts item["path"] + "/" + item["name"], item["url"]

        # https://github.com/aria2/aria2/issues/1856

        # curl http://localhost:6800/jsonrpc -d "{\"jsonrcp\":\"2.0\",\"id\":\"someID\",

        # \"method\":\"aria2.addUri\",\"params\":[\"token:ariatest\",[\"http://m.gettywallpapers.com/wp-content/uploads/2020/01/Wallpaper-Naruto-2.jpg\"],{\"out\":\"test.jpg\"}]}"

        # If you want to change it start the server with --dir option or set it for each file

        # - instead of {"out":"test.jpg"} in the JSON you send use {"out":"test.jpg","dir":"path_to_folder"}.

        #$aria2Client.addUri item["url"], item["path"] + "/" + item["name"]

        $aria2Client.addUri [item["url"]], { "dir": 'd:\\music\\' + item["path"] + "", "out": item["name"] }
      end

    end
  end
end

get_music(xiazai, gen_post_data(initString))
```

