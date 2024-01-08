//
//  List.swift
//  Hedio
//
//  Created by lilivi on 2023/12/16.
//  Copyright © 2023 com.lilivi. All rights reserved.
//

import Foundation
import SwiftUI

struct List: View {
    
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(<#T##data: RandomAccessCollection##RandomAccessCollection#>) { item in
                    <#code#>
                }
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .navigationBarTitle(Text("代办事项"))
        .foregroundColor(.blue)
        .onAppear {
            
        }
    }
    
}
