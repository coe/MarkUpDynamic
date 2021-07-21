# MarkUpDynamic

Markup generator for Swift that like a DSL.

## BASIC HTML

```swift
let m = MarkUp()

let htmlString = m.html.children {
    m.head.children {
        m.meta(charset: "UTF-8").doNotSpecifyEndTag()
        m.meta(name: "description",
               content: "Free Web tutorials").doNotSpecifyEndTag()
        m.meta(name: "keywords",
               content: "HTML, CSS, JavaScript").doNotSpecifyEndTag()
        m.meta(name: "author",
               content: "John Doe").doNotSpecifyEndTag()
    }
    m.body.children {
        m.p.children {
            "All meta information goes inside the head section."
        }
    }
}
.toString()
```

```html
<html>
<head>
  <meta charset="UTF-8">
  <meta name="description" content="Free Web tutorials">
  <meta name="keywords" content="HTML, CSS, JavaScript">
  <meta name="author" content="John Doe">
</head>
<body>
  <p>All meta information goes inside the head section.</p>
</body>
</html>
```

## DOCTYPE HTML

```swift
let m = MarkUp()
let htmlString = m.children {
    m[dynamicMember: "!DOCTYPE"](html: nil).doNotSpecifyEndTag()
    m.html.children {
        m.head.children {
            m.meta(charset: "UTF-8").doNotSpecifyEndTag()
            m.meta(name: "description",
                   content: "Free Web tutorials").doNotSpecifyEndTag()
            m.meta(name: "keywords",
                   content: "HTML, CSS, JavaScript").doNotSpecifyEndTag()
            m.meta(name: "author",
                   content: "John Doe").doNotSpecifyEndTag()
        }
        m.body.children {
            m.p.children {
                "All meta information goes inside the head section."
            }
        }
    }
}
.toString()
```

```html
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="description" content="Free Web tutorials">
  <meta name="keywords" content="HTML, CSS, JavaScript">
  <meta name="author" content="John Doe">
</head>
<body>
  <p>All meta information goes inside the head section.</p>
</body>
</html>
```

## BASIC XML

```swift
let m = MarkUp()

let htmlString = m.書籍目録.children {
    m.書名.children {
        "XML入門"
    }
    m.著者.children {
        "筒井"
    }
    m.書名.children {
        "続・XML入門"
    }
    m.著者.children {
        "小松"
    }
}
.toString()
```

```xml
<書籍目録>
  <書名>XML入門</書名>
  <著者>筒井</著者>
  <書名>続・XML入門</書名>
  <著者>小松</著者>
</書籍目録>
```

## XML declaration

```swift
let m = MarkUp()

let htmlString = m.children {
    m[dynamicMember: "?xml"](version: "1.0",
                             encoding: "UTF-8").doNotSpecifyEndTag(instead: "?")
    m.書籍(出版日: "2007-10-31").children {
        "これは書籍です.... "
    }
}
.toString()
```

```xml
<?xml version="1.0" encoding="UTF-8"?>
<書籍 出版日="2007-10-31">これは書籍です.... </書籍>
```


## Hyphened-Attribute
Use dynamicallyCall.

```swift
let m = MarkUp()

let htmlString = m.form.dynamicallyCall(withKeywordArguments: ["accept-charset": "UTF-8"]).toString()
```

```html
<form accept-charset="UTF-8"></form>
```
