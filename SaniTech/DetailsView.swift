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
            
    //       let salam =  myValue[0].casesByState
            
            VStack(alignment: .leading){
                
                Text(response.name + "TTTT")
                    .font(.title)
                
                
            }
        }
    }


//struct DetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailsView()
//    }
//}
