//
//  AboutView.swift
//  Bulsseye
//
//  Created by Juan Brusco on 19/02/2020.
//  Copyright © 2020 Juan Brusco. All rights reserved.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        VStack{
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
    .navigationBarTitle("Bullseye About")
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
       // Values for Landscape mode of an iPhone XR (points).
        AboutView().previewLayout(.fixed(width: 896, height: 414))
    }
}
