import XCTest
import MarkUpDynamic

final class MarkUpDynamicTests: XCTestCase {
    func testExample() {
        XCTAssertEqual(MarkUp()
                        .html[MarkUp()
                                .body[MarkUp()
                                        .table[MarkUp()
                                                .tr[MarkUp()
                                                        .td[character: "一行目"]
                                                        .td[character: "二行目"]
                                                ]
                                        ]
                                ]
                        ].generate(), "<html><body><table><tr><td>一行目</td><td>二行目</td></tr></table></body></html>")
    }
    
    func testTagName() {
        XCTAssertEqual(MarkUp()
                        .tagName("html")[MarkUp()
                                .tagName("body")[MarkUp()
                                        .tagName("table")[MarkUp()
                                                .tagName("tr")[MarkUp()
                                                                .tagName("td")[character: "一行目"]
                                                        .td[character: "二行目"]
                                                ]
                                        ]
                                ]
                        ].generate(), "<html><body><table><tr><td>一行目</td><td>二行目</td></tr></table></body></html>")
    }
    
    func testAttributes() {
        XCTAssertEqual(MarkUp()
                        .html[MarkUp()
                                .body[MarkUp()
                                        .table[MarkUp()
                                                .tr[MarkUp()
                                                        .td[character: "一行目"]
                                                        .td[character: "二行目"]
                                                ]
                                        ][attributes: ["border" : "1"]]
                                ]
                        ]
                        .generate(), "<html><body><table border=\"1\"><tr><td>一行目</td><td>二行目</td></tr></table></body></html>")
    }
    
    func testAddEndTag() {
        XCTAssertEqual(MarkUp()
                        .html[MarkUp()
                                .body[MarkUp()
                                        .br.doNotSpecifyEndTag()
                                        .br.doNotSpecifyEndTag()
                                        .br.doNotSpecifyEndTag()
                                ]
                        ]
                        .generate(), "<html><body><br><br><br></body></html>")
    }
    
    func testXml() {
        XCTAssertEqual(MarkUp(doctype: #"<?xml version="1.0" encoding="UTF-8"?>"#)
                        .レシピ[MarkUp()
                                    .手順[character: "全ての材料を一緒にして混ぜます。"]
                                    .手順[character: "オーブンに入れて温度を180℃にして30分間焼きます。"]
                        ]
                        .generate(), #"<?xml version="1.0" encoding="UTF-8"?><レシピ><手順>全ての材料を一緒にして混ぜます。</手順><手順>オーブンに入れて温度を180℃にして30分間焼きます。</手順></レシピ>"#)
    }
    
    func testHtml() {
        XCTAssertEqual(MarkUp(doctype: #"<!DOCTYPE html>"#)
                        .html[MarkUp()
                                .head[MarkUp()
                                        .meta.doNotSpecifyEndTag()[attributes: ["charset" : "UTF-8"]]
                                        .title[character: "HTML5サンプル"]
                                ]
                                .body[MarkUp()
                                        .p[character: "HTML5で作成しました！"]
                                ]
                        ][attributes: ["lang":"ja"]]
                        .generate(), #"<!DOCTYPE html><html lang="ja"><head><meta charset="UTF-8"><title>HTML5サンプル</title></head><body><p>HTML5で作成しました！</p></body></html>"#)
    }
    
    static var allTests = [
        ("testExample", testExample),
        ("testAttributes", testAttributes),
        ("testAddEndTag", testAddEndTag),
        ("testXml", testXml),
    ]
}
