# MarkUpDynamic

Markup generator for Swift that like a DSL.

## BASIC HTML

```swift
MarkUp()
    .html[MarkUp()
            .body[MarkUp()
                    .table[MarkUp()
                            .tr[MarkUp()
                                    .td[character: "one"]
                                    .td[character: "two"]
                            ]
                    ]
            ]
    ].generate()
```

```html
<html>

<body>
    <table>
        <tr>
            <td>one</td>
            <td>two</td>
        </tr>
    </table>
</body>

</html>
```

## BASIC XML

```swift
MarkUp(doctype: #"<?xml version="1.0" encoding="UTF-8"?>"#)
    .レシピ[MarkUp()
                .手順[character: "全ての材料を一緒にして混ぜます。"]
                .手順[character: "オーブンに入れて温度を180℃にして30分間焼きます。"]
    ]
    .generate()
```

```xml
<?xml version="1.0" encoding="UTF-8"?>
<レシピ>
    <手順>全ての材料を一緒にして混ぜます。</手順>
    <手順>オーブンに入れて温度を180℃にして30分間焼きます。</手順>
</レシピ>
```


## Attribute

```swift
MarkUp()
    .html[MarkUp()
            .body[MarkUp()
                    .table[attributes: ["border" : "1", "disable": nil]][MarkUp()
                                                                            .tr[MarkUp()
                                                                                    .td[character: "one"]
                                                                                    .td[character: "two"]
                                                                            ]
                    ]
            ]
    ]
    .generate()
```

Other way

```swift
MarkUp()
    .html[MarkUp()
            .body[MarkUp()
                    .table[MarkUp()
                            .tr[MarkUp()
                                    .td[character: "one"]
                                    .td[character: "two"]
                            ]
                    ][attributes: ["border" : "1", "disable": nil]]
            ]
    ]
    .generate()
```

```html
<html>

<body>
    <table border="1" disable>
        <tr>
            <td>one</td>
            <td>two</td>
        </tr>
    </table>
</body>

</html>
```

## Void element(No end tag)

```swift
MarkUp()
    .html[MarkUp()
            .body[MarkUp()
                    .br.doNotSpecifyEndTag()
                    .br.doNotSpecifyEndTag()
                    .br.doNotSpecifyEndTag()
            ]
    ]
    .generate()
```

```html
<html>

<body><br><br><br></body>

</html>
```

## vapor routes

```swift
import Vapor
import MarkUpDynamic

func routes(_ app: Application) throws {
    app.get { req in
        return View(data: ByteBuffer.init(string: MarkUp(doctype: #"<!DOCTYPE html>"#)
                                            .html[MarkUp()
                                                    .head[MarkUp()
                                                            .meta[attributes: ["charset" : "UTF-8"]].doNotSpecifyEndTag()
                                                            .title[character: "HTML"]
                                                    ]
                                                    .body[MarkUp()
                                                            .p[character: "Body"]
                                                    ]
                                            ][attributes: ["lang" : "ja"]]
                                            .generate())
        )
    }
    
    app.get("hello") { req -> String in
        return "Hello, world!"
    }
}
```

```
<!DOCTYPE html>
<html lang="ja">
<head>
  <meta charset="UTF-8">
  <title>HTML</title>
</head>
<body>
  <p>Body</p>
</body>
</html>
```
