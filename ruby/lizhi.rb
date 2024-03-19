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
