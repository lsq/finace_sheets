require 'aria2'
require 'debug'

$aria2Client = Aria2::Client.new(host: "localhost", port: 6800)
binding.break
#re =  $aria2Client.tellStatus("f69d26a1c7b04824")
p $aria2Client.tellStatus "f69d26a1c7b04824"
p $aria2Client.addUri(["http://m.gettywallpapers.com/wp-content/uploads/2020/01/Wallpaper-Naruto-2.jpg"],{"out":"test.jpg", "dir": "d:\\tt"})
#p re
