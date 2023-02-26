//
//  DetailsView.swift
//  SaniTech
//
//  Created by arian on 2/26/23.
//

import SwiftUI

struct DetailsView: View {
    
        var response : CovidStats
        
        var body: some View {
            
            
            VStack(alignment: .leading){
                
                Text("City Name :  " + response.name)
                    .font(.title)
                Text("CasesReported :  " + String(response.casesReported))

                    .font(.title2)
                
                
            }
        }
    }


//struct DetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailsView()
//    }
//}
