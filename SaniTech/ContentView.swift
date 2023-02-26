//
//  ContentView.swift
//  SaniTech
//
//  Created by arian on 2/25/23.
//

import SwiftUI

struct Response: Codable {
    
    var casesByState: [CovidStats]
}

struct CovidStats: Codable {
    
    var range: String
    var casesReported: Int
    var name: String
}

struct ContentView: View {
    @State private var results : [CovidStats] = []

    
    var body: some View {
        TabView {
            NavigationView {
                List(results, id: \.casesReported) { item in
                    NavigationLink(destination: DetailsView(response: item)){
                        
                        VStack(alignment: .leading) {
                            Spacer()
                            Text(item.name)
                                .font(.headline)
                            Text(item.range)
                        }
                        
                    }
                    
                    
                }.navigationBarTitle("My list")
                .task {
                    await loadData()
                }
            }.tabItem {
                         Image(systemName: "bubble.right")
                         Text("Tab 1")
                    }.tag(0)

                    NavigationView {
                         List {
                              ForEach((1...50), id: \.self) {
                                   Text("Row in Tab 2 Number: \($0)")
                              }
                         }
                         .navigationBarTitle("Tab 2")
                    }.tabItem {
                         Image(systemName: "bubble.left")
                         Text("Tab 2")
                    }.tag(1)
               }.edgesIgnoringSafeArea(.top)
    }
    
    func loadData() async {

        guard let url = URL(string: "https://api.apify.com/v2/key-value-stores/moxA3Q0aZh5LosewB/records/LATEST?disableRedirect=true") else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)

            // more code to come
            
            if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                results = decodedResponse.casesByState
            }
        } catch {
            print("Invalid data")
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
