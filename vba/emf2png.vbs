WScript.Echo("Hello����Һã�����Ѧ���̵ķ�����")
Set img = CreateObject("ImageMagickObject.MagickImage")
printSize = img.Identify("-format", "%[printsize.x]x%[printsize.y]", "image68.emf")
wscript.echo(printSize)
geometry = img.Identify("-format", "%[fx:w/resolution.x*" & 600 & "]x%[fx:h/resolution.y*" & 600 & "]", "image68.emf")
WScript.Echo(geometry)
msgs = img.Convert("-units", "PixelsPerinch", "-density", 600, "-size", geometry, "image68.emf", "img68.png")