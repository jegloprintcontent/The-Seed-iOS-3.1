//
//  MinistryListView.swift
//  TheSeed
//
//  Created by Lawrence Adeyemi on 10/12/2022.
//

import SwiftUI
import Kingfisher

struct MinistryListView: View {
    
    @ObservedObject var vmml: MinistryListViewModel
    let category: String
    let id: Int
    //new addition
    private let html = ParseHtml()
    @Environment(\.presentationMode) private var presentationMode
    
    init(category: String, id: Int) {
        
        print("Loaded the ministries view and making a request for \(category) - \(id)")
        self.category = category
        self.id = id
        self.vmml = .init(category: category, id: id)
    }
    var body: some View {
        
            ScrollView {
                
                LazyVStack(spacing: 24) {
                    ForEach(vmml.ministrylist) { ministry in
                        
                        NavigationLink {
                            DetailsView(article: ministry)
                            //DetailView(article: ministry)
                        } label: {
                            
                            //Text("The Ministry Title")
                            
                           VStack(alignment: .leading) {
                                
                                VStack(alignment: .leading, spacing: 8) {
                                    //Image(sermon.image)
                                    KFImage(URL(string: ministry.image ?? ""))
                                        .resizable()
                                        .scaledToFill()
                                        //.frame(height: 240)
                                        .frame(maxWidth: .infinity)
                                        .cornerRadius(10)
                                }
                                .frame(maxWidth: .infinity)
                                .cornerRadius(10)
                                
                                
                                VStack(alignment: .leading) {
                                    Text(ministry.title.rendered)
                                        .font(.system(size: 20))
                                        .fontWeight(.medium)
                                        .lineLimit(2)
                                        .fixedSize(horizontal: false, vertical: true)
                                        
                                }
                                //.frame(width: 250)
                                .padding(.vertical, 10)
                                
                            }
                        }
                        .foregroundColor(Color(.label))

                    }
                }
                .padding(.horizontal, 10)
                //new additions
                .navigationBarBackButtonHidden(true)
                .navigationBarTitle(String(html.parse(html: category) ?? ""), displayMode: .inline)
                .navigationBarItems(
                    leading:
                        Button(action: {
                            dismiss()
                        }, label: {
                            //Text("Back")
                            VStack {
                                Image(systemName: "chevron.backward")
                            }
                        })
                )
                
        }
    }
    
    //new additions
    func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
}

struct MinistryListView_Previews: PreviewProvider {
    static var previews: some View {
        MinistryListView(category: "Charity, Welfare & Visitation", id: 44)
    }
}
