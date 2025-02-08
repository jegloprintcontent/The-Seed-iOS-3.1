//
//  SectionTileView.swift
//  TheSeed
//
//  Created by Iyanuoluwa Babatunde on 07/2/2025.
//

import SwiftUI
import Kingfisher

struct SectionTileView: View {
    
    let article: Article
    private let html = ParseHtml()
    private let parsedDate = FormatDate() //  Added for date formatting

    var body: some View {
        VStack(alignment: .leading) {
            KFImage(URL(string: article.image ?? ""))
                .resizable()
                .clipped()
                .scaledToFill()
                .cornerRadius(10)

            VStack(alignment: .leading, spacing: 4) {
                //  Title
                Text(html.parse(html: article.title.rendered) ?? "")
                    .font(.system(size: 20))
                    .fontWeight(.medium)
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)
                    .foregroundColor(Color(.label))

                //  Date (Newly Added)
                Text(parsedDate.convertDateFormat(inputDate: article.date))
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .padding(10)
        }
    }
}

struct SectionTileView_Previews: PreviewProvider {
    static var previews: some View {
        SectionTileView(article: .init(
            id: 7525,
            date: "2022-12-07T00:00:09", //  The date is now displayed
            guid: Article.Guid(rendered: "https://theseedjcli.ileewe.org/?p=7525"),
            slug: "lacking-nothing",
            link: "https://theseedjcli.ileewe.org/lacking-nothing/",
            title: Article.Title(rendered: "Lacking Nothing"),
            content: Article.Content(rendered: "<p>Sample Content</p>"),
            excerpt: Article.Excerpt(rendered: "<p>Excerpt preview...</p>"),
            author: 7,
            categories: [41],
            tags: [50,54],
            article_author: "Print &amp; Content, JEGLO",
            image: "https://theseedjcli.ileewe.org/wp-content/uploads/2022/12/3-copy.jpeg")
        )
        .padding()
    }
}
