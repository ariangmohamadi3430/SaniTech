//
//  GraphView.swift
//  SaniTech
//
//  Created by arian on 2/26/23.
//


import SwiftUI

struct GraphView: View {
    
    
    static let dateFormatter: DateFormatter = {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM"
        return formatter
        
    }()
    
    let steps: [Step]
    
    var totalSteps: Int {
        steps.map { $0.count }.reduce(0,+)
    }
    
    var body: some View {
        
        
        VStack {
            ScrollView(.horizontal){
                HStack(alignment: .lastTextBaseline) {
                
                ForEach(steps, id: \.id) { step in
                    
                    let Value = Swift.min(step.count/20, 800)
                    
                    VStack {
                        Text("\(step.count)")
                            .font(.caption)
                            .foregroundColor(Color.black)
                        Rectangle()
                            .fill(Color.orange)
                            .frame(width: 8, height: CGFloat(Value))
                        Text("\(step.date,formatter: Self.dateFormatter)")
                            .font(.caption2)
                            .foregroundColor(Color.black)
                            .rotationEffect(.degrees(45.0))
                        
                    }
                }
                
                }.padding(.bottom)
        }
         .environment(\.layoutDirection, .rightToLeft)
            Text("Total Steps: \(totalSteps)").padding(.top, 100)
                .foregroundColor(Color.gray)
                .opacity(0.5)
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white)
        .cornerRadius(40)
        .padding(10)
    }
}

struct GraphView_Previews: PreviewProvider {
    static var previews: some View {
        
        let steps = [
                   Step(count: 100, date: Date()),
                   Step(count: 123, date: Date()),
                   Step(count: 1223, date: Date()),
                   Step(count: 5223, date: Date()),
                   Step(count: 2023, date: Date())
               ]
        
        GraphView(steps: steps)
    }
}

