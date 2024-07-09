//
//  ContentView.swift
//  Locator
//
//  Created by savio sailas
//

import SwiftUI

struct LocatorView: View {
    
    @ObservedObject var viewModel: LocatorViewModel
    
    var body: some View {
        ScrollView {
            infoTitle("Street", imageName: "road.lanes.curved.left", $viewModel.street)
            infoTitle("City", imageName: "building.2", $viewModel.city)
            infoTitle("State", imageName: "building.columns", $viewModel.state)
            infoTitle("Postal code", imageName: "enelop.open.fill", $viewModel.postalCode)
            infoTitle("Country", imageName: "globe", $viewModel.country)
            infoTitle("ISO Country code", imageName: "mappin.and.ellipse.circle", $viewModel.isoCountryCode)
            
            Button {
                viewModel.calcCoordinates()
            } label: {
                HStack {
                    Spacer()
                    Text("Get coordinates")
                        .font(.title2)
                        .foregroundColor(.white)
                    Image(systemName: "circle.dashed")
                        .foregroundColor(viewModel.isLoading ? .white : .black)
                    Spacer()
                }
                .padding()
                .background(viewModel.isLoading ? Color.gray : Color.black)
            }
            .disabled(viewModel.isLoading)
            .padding(.horizontal)
            
            infoTitle("Latitude", imageName: "location", $viewModel.lat)
            infoTitle("Longitude", imageName: "loaction", $viewModel.long)
            
            Text(viewModel.errorMsg)
                .font(.caption)
                .foregroundColor(.red)
        }
    }
    
    private func infoTitle(_ text: String, imageName: String, _ value: Binding<String>,
                           _ placeholder: String = "") -> some View {
        Label {
            Text(text)
            TextField(placeholder, text: value)
                .padding(10.0)
                .overlay(
                    Rectangle()
                        .stroke(Color.gray, lineWidth: 1.0)
                )
            Button {
                value.wrappedValue = ""
            } label: {
                Image(systemName: "delete.left")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20.0)
                    .foregroundColor(.gray)
            }
        } icon: {
            Image(systemName: imageName)
        }
        .padding()
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LocatorView(viewModel: LocatorViewModel())
    }
}
