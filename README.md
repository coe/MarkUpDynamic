# MarkUpDynamic

Markup generator for Swift.

## BASIC HTML

```swift
MarkUpDynamic()
    .html[inside: MarkUpDynamic()
            .body[inside: MarkUpDynamic()
                    .table[inside: MarkUpDynamic()
                            .tr[inside: MarkUpDynamic()
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
MarkUpDynamic(doctype: #"<?xml version="1.0" encoding="UTF-8"?>"#)
    .レシピ[inside: MarkUpDynamic()
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
MarkUpDynamic()
    .html[inside: MarkUpDynamic()
            .body[inside: MarkUpDynamic()
                    .table[attributes: ["border" : "1", "disable": nil]][inside: MarkUpDynamic()
                                                                            .tr[inside: MarkUpDynamic()
                                                                                    .td[character: "一行目"]
                                                                                    .td[character: "二行目"]
                                                                            ]
                    ]
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
MarkUpDynamic()
    .html[inside: MarkUpDynamic()
            .body[inside: MarkUpDynamic()
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

