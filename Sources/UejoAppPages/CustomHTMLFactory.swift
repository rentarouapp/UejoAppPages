import Publish
import Plot

extension Theme where Site == UejoAppPages {
    static var custom: Self {
        Theme(
            htmlFactory: CustomHTMLFactory(),
            resourcePaths: [] // 必要に応じて
        )
    }
}

struct CustomHTMLFactory<Site: Website>: HTMLFactory {
    
    func makeIndexHTML(for index: Index, context: PublishingContext<Site>) throws -> HTML {
        HTML(
            .head(for: index, on: context.site),
            .body(
                .h1("ようこそ \(context.site.name) へ！"),
                .p("これはカスタムトップページです 🚀"),
                .ul(
                    .forEach(context.allItems(sortedBy: \.date, order: .descending)) { item in
                            .li(
                                .a(
                                    .href(item.path),
                                    .text(item.title)
                                )
                            )
                    }
                )
            )
        )
    }
    
    func makeSectionHTML(for section: Section<Site>, context: PublishingContext<Site>) throws -> HTML {
        HTML(
            .head(for: section, on: context.site),
            .body(
                .h1("セクション: \(section.title)")
            )
        )
    }
    
    func makeItemHTML(for item: Item<Site>, context: PublishingContext<Site>) throws -> HTML {
        HTML(
            .head(for: item, on: context.site),
            .body(
                .h1(.text(item.title)),
                .article(.contentBody(item.body))
            )
        )
    }
    
    func makePageHTML(for page: Page, context: PublishingContext<Site>) throws -> HTML {
        HTML(
            .head(
                .title(page.title),
                .meta(.charset(.utf8)),
                .meta(.name("viewport"), .content("width=device-width, initial-scale=1")),
                .link(.rel(.stylesheet), .href("/styles.css")) // ← CSSの追加！
            ),
            .body(
                .h1(.text(page.title)),
                .div(.class("contentBody"), .contentBody(page.body))
            )
        )
    }
    
    func makeTagListHTML(for page: Publish.TagListPage, context: Publish.PublishingContext<Site>) throws -> HTML? {
        HTML(
            .head(for: page, on: context.site),
            .body(
                .h1("タグ一覧"),
                .ul(
                    .forEach(page.tags.sorted()) { tag in
                            .li(.a(.href(context.site.path(for: tag)), .text(tag.string)))
                    }
                )
            )
        )
    }
    
    func makeTagDetailsHTML(for page: Publish.TagDetailsPage, context: Publish.PublishingContext<Site>) throws -> HTML? {
        let items = context.items(taggedWith: page.tag)
        return HTML(
            .head(for: page, on: context.site),
            .body(
                .h1("タグ: \(page.tag.string)"),
                .forEach(items) { item in
                        .article(
                            .h2(.a(.href(item.path), .text(item.title)))
                        )
                }
            )
        )
    }
}
