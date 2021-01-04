# MarkUpDynamic

Markup generator for Swift that like a DSL.

## BASIC HTML

```swift
MarkUp()
    .html[MarkUp()
            .body[MarkUp()
                    .table[MarkUp()
                            .tr[MarkUp()
                                    .td[character: "一行目"]
                                    .td[character: "二行目"]
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
            <td>一行目</td>
            <td>二行目</td>
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
                                                                                    .td[character: "一行目"]
                                                                                    .td[character: "二行目"]
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
                                    .td[character: "一行目"]
                                    .td[character: "二行目"]
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
            <td>一行目</td>
            <td>二行目</td>
        </tr>
    </table>
</body>

</html>
```

## Void element

```swift
MarkUp()
    .html[MarkUp()
            .body[MarkUp()
                    .br[addEndTag: false]
                    .br[addEndTag: false]
                    .br[addEndTag: false]
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
                                                            .meta[attributes: ["charset" : "UTF-8"]][addEndTag: false]
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
