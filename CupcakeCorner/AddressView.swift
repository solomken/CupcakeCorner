//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Anastasiia Solomka on 13.07.2023.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var order: Order
    
    var body: some View {
        Form {
            Section {
                TextField("Name:", text: $order.name)
                TextField("Street address:", text: $order.streetAddress)
                TextField("City:", text: $order.city)
                TextField("Zip:", text: $order.zip)
            }
            
            Section {
                NavigationLink {
                    CheckoutView(order: order)
                } label: {
                    Text("Check out")
                }
            }
            .disabled(order.hasValidAddress == false)
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView { //just for a preview to show nav title
            AddressView(order: Order())
        }
    }
}
