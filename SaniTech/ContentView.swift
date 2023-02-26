//
//  ContentView.swift
//  SaniTech
//
//  Created by arian on 2/25/23.
//

import SwiftUI
import HealthKit



struct ContentView: View {
    @State private var results : [CovidStats] = []
    @State private var steps: [Step] = [Step]()

    private var healthStore: HealthStore?
    
    init() {
        healthStore = HealthStore()
    }
    
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
                         
                        GraphView(steps: steps)

                         .navigationBarTitle("My Steps")
                    }.onAppear{
                        if let healthStore = healthStore {
                            healthStore.requestAuthorization { success in
                                if success {
                                    healthStore.calculateSteps { statisticsCollection in
                                        if let statisticsCollection = statisticsCollection {
                                            // update the UI
                                            updateUIFromStatistics(statisticsCollection)
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .tabItem {
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
    private func updateUIFromStatistics(_ statisticsCollection: HKStatisticsCollection) {
        
        let startDate = Calendar.current.date(byAdding: .day, value: -29, to: Date())!
        let endDate = Date()
        
        statisticsCollection.enumerateStatistics(from: startDate, to: endDate) { (statistics, stop) in
            
            let count = statistics.sumQuantity()?.doubleValue(for: .count())
            
            let step = Step(count: Int(count ?? 0), date: statistics.startDate)
            steps.append(step)
        }
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



