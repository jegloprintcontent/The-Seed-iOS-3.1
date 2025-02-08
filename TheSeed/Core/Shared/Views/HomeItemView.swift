//
//  HomeItemView.swift
//  TheSeed
//
//  Created by Lawrence Adeyemi on 06/12/2022.
//

import SwiftUI
import Kingfisher
import SDWebImageSwiftUI

struct HomeItemView: View {
    
    let article: Article
    private let html = ParseHtml()
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            VStack(alignment: .leading, spacing: 8.0) {
                KFImage(URL(string: article.image ?? ""))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 160)
                    .frame(maxWidth: .infinity)
                    .cornerRadius(10)
            }
            .frame(width: 250)
            .cornerRadius(10)
            
            VStack(alignment: .leading) {
                
                HStack {
                    Spacer()
                }
                
                //Text(article.title.rendered)
                Text(html.parse(html: article.title.rendered) ?? "")
                    .font(.system(size: 20))
                    .fontWeight(.medium)
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)
                    .foregroundColor(Color(.label))
            }
            .frame(maxWidth: 250)
            .padding(.vertical, 10)
            .multilineTextAlignment(.leading)
            
        }
        
    }
}

struct HomeItemView_Previews: PreviewProvider {
    static var previews: some View {
        
        ZStack {
            
            LinearGradient(gradient: Gradient(colors: [.blue, .red]), startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea()
            
            HomeItemView(article: .init(
                id: 7525,
                date: "2022-12-07T00:00:09",
                guid: Article.Guid(rendered: "https://theseedjcli.ileewe.org/?p=7525"),
                slug: "lacking-nothing",
                link: "https://theseedjcli.ileewe.org/lacking-nothing/",
                title: Article.Title(rendered: "Lacking Nothing"),
                content: Article.Content(rendered: "<p><em><strong>THE,l SEED</strong></em><br />\n“&#8230;knowing that the testing of your faith produces patience. But let patience have its perfect work, that you may be perfect and complete, lacking nothing.” James 1:3-4, NKJV</p>\n<p>\nGod maintains that you should perfect and complete, living in His overflow and lacking nothing on this planet. That might appear to be a stretch from where you are today. It might appear to be far not exactly right; however, in a moment, things can turn around. God has set up a system of blessing for you, and it starts with His Word. The Bible says that God has given each of us a measure of faith. We all have faith, and it’s up to us to develop it. Romans 10:17 says that faith grows as we read and study His Word. Faith, in turn, produces patience, and when we allow patience to have its perfect work in us, we will lack no good thing. Today, no matter where you are in the process, the key is to keep moving forward by reading and hearing His Word. His Word is alive. His Word will heal your heart and restore your soul. His Word will produce patience in your life so that you can move forward, being complete and lacking nothing all the<br />\ndays of your life!</p>\n<p>\n<strong>PRAYER</strong><br />\nFather God, thank You for Your Word which lights my path and directs my way. I choose to put You first place. I choose to meditate on Your Word, knowing that You are leading me in Your paths of life in Jesus’ name. Amen!</p>\n<p>\n<strong>BIBLE READINGS: James 1</strong></p>\n<p><strong>KI A MA SE ALAINI OHUNKOHUN</strong></p>\n<p>\n<em><strong>IRUGBIN NAA</strong></em><br />\n“Ki e si mo pe, idanwo igbagbo nyin nsise suru; sugbon e je ki suru ki o se ise asepe, ki enyin ki o le je pipe ati ailabuku, ki o ma ku ohun kan fun enikeni.” Jakobu 1:3-4</p>\n<p>\nOlorun so wipe ki a je pipe, ki a maa gbe ni inu akunwo sile re, ki a ma si se alaini ohunkohun laye yii. Eyi le yato si ohun ti o n sele si o loni. O le dabi wipe ko dara to, sugbon laarin igba die, ohun gbogbo le yipada. Olorun ti pese ibukun sile fun o, yio si bere pelu oro re. Iwe Mimo wipe, Olorun ti fun olukuluku wa ni osuwon igbagbo. Gbogbo wa ni a ni igbagbo, o si ku si wa lowo lati mu ki igbagbo naa dagba. Romu 10:17 so wipe igbagbo a maa dagba bi a baa<br />\nn ka ti a sin se asaro ninu oro re. igbagbo a maa sise suuru, nigba ti a basi je ki suuru ki o se ise asepe ninu wa, a ki yio se alaini ohun rere. Loni, ipele ti o wu ki o le wa, kokoro re ni wipe ki o maa tesiwaju, ki o maa ka, ki o si maa gbo oro re. oro re, iye ni. Oro re yio wo okan re san, yio si mu okan re pada bo sipo. Oro re yio sise suuru ninu aye re ki o baa le te siwaju, ki o le pe, ki o ma si se alaini ohunkohun ni ojo aye re gbogbo.</p>\n<p>\n<strong>ADURA</strong><br />\nOlorun, o seun fun oro re ti n tan imole si ona mi, to si n to mi sona. Mo pinnu lati fi o saaju, lati se asaro ninu oro re, ni bi mo ti mo wipe O n to mi si ona iye re ni oruko Jesu. Amin </p>\n<p>\n<strong>BIBELI KIKA: Jakobu 1</strong></p>\n"),
                excerpt: Article.Excerpt(rendered: "<p>THE SEED “&#8230;knowing that the testing of your faith produces patience. But let patience have its perfect work, that you may be perfect and complete, lacking nothing.” James 1:3-4, NKJV God maintains that you should perfect and complete, living in His overflow and lacking nothing on this planet. That might appear to be a stretch&hellip; <a class=\"more-link\" href=\"https://theseedjcli.ileewe.org/lacking-nothing/\">Continue reading <span class=\"screen-reader-text\">Lacking Nothing</span></a></p>\n"),
                author: 7,
                categories: [41],
                tags: [50,54],
                article_author: "Print &amp; Content, JEGLO",
                image: "https://theseedjcli.ileewe.org/wp-content/uploads/2022/12/3-copy.jpeg")
            )
        }
        
        
    }
}
