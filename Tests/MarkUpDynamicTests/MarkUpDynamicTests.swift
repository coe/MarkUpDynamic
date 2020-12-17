import XCTest
@testable import MarkUpDynamic

final class MarkUpDynamicTests: XCTestCase {
    func testExample() {
        XCTAssertEqual(MarkUpDynamic()
                        .html[MarkUpDynamic()
                                .body[MarkUpDynamic()
                                        .table[MarkUpDynamic()
                                                .tr[MarkUpDynamic()
                                                        .td[character: "一行目"]
                                                        .td[character: "二行目"]
                                                ]
                                        ]
                                ]
                        ].generate(), "<html><body><table><tr><td>一行目</td><td>二行目</td></tr></table></body></html>")
    }
    
    func testAttributes() {
        XCTAssertEqual(MarkUpDynamic()
                        .html[MarkUpDynamic()
                                .body[MarkUpDynamic()
                                        .table[attributes: ["border" : "1"]][MarkUpDynamic()
                                                                                .tr[MarkUpDynamic()
                                                                                        .td[character: "一行目"]
                                                                                        .td[character: "二行目"]
                                                                                ]
                                        ]
                                ]
                        ]
                        .generate(), "<html><body><table border=\"1\"><tr><td>一行目</td><td>二行目</td></tr></table></body></html>")
    }
    
    func testAddEndTag() {
        XCTAssertEqual(MarkUpDynamic()
                        .html[ MarkUpDynamic()
                                .body[ MarkUpDynamic()
                                        .br[addEndTag: false]
                                        .br[addEndTag: false]
                                        .br[addEndTag: false]
                                ]
                        ]
                        .generate(), "<html><body><br><br><br></body></html>")
    }
    
    func testXml() {
        XCTAssertEqual(MarkUpDynamic(doctype: #"<?xml version="1.0" encoding="UTF-8"?>"#)
                        .レシピ[ MarkUpDynamic()
                                        .手順[character: "全ての材料を一緒にして混ぜます。"]
                                        .手順[character: "オーブンに入れて温度を180℃にして30分間焼きます。"]
                        ]
                        .generate(), #"<?xml version="1.0" encoding="UTF-8"?><レシピ><手順>全ての材料を一緒にして混ぜます。</手順><手順>オーブンに入れて温度を180℃にして30分間焼きます。</手順></レシピ>"#)
    }
    
    static var allTests = [
        ("testExample", testExample),
        ("testAttributes", testAttributes),
        ("testAddEndTag", testAddEndTag),
        ("testXml", testXml),
        
    ]
}
