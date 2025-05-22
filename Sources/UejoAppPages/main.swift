import Foundation
import Publish
import Plot

// This type acts as the configuration for your website.
struct UejoAppPages: Website {
    enum SectionID: String, WebsiteSectionID {
        // Add the sections that you want your website to contain here:
        case posts
    }

    struct ItemMetadata: WebsiteItemMetadata {
        // Add any site-specific metadata that you want to use here.
    }

    // Update these properties to configure your website:
    var url = URL(string: "https://uejo.app")!
    var name = "UejoAppPages"
    var description = "A description of UejoAppPages"
    var language: Language { .japanese }
    var imagePath: Path? { nil }
}

// This will generate your website using the built-in Foundation theme:

// デフォルトのテーマはこちら
//try UejoAppPages().publish(withTheme: .foundation)

// オリジナルテーマはこちら
try UejoAppPages().publish(using: [
    .addMarkdownFiles(), // Markdown 記事を読み込む
    .copyResources(), // CSS などのリソースをコピーする
    .generateHTML(withTheme: .custom), // 🔥 カスタム HTMLFactory を使う
    .generateRSSFeed(including: [.posts]), // RSSフィードを作る（任意）
    .generateSiteMap() // サイトマップを作る（任意）
])
