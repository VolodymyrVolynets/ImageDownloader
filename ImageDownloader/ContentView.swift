//
//  ContentView.swift
//  PhotoLibrary
//
//  Created by Vova on 15/09/2022.
//

import SwiftUI

struct ContentView: View {
    
    private struct constants {
        static let gridSpacing: CGFloat = 3
        static let gridSize: CGFloat = 100
    }
    
    @StateObject private var vm: ViewModel = ViewModel()
    let columns = [
        GridItem(.adaptive(minimum: constants.gridSize - constants.gridSpacing), spacing: constants.gridSpacing)
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                
                HStack {
                    TextField("Enter Photo URL:", text: $vm.text)
                    Button {
                        vm.downloadImage(url: vm.text)
                    } label: {
                        Text("Download")
                            .foregroundColor(.white)
                            .padding(7)
                            .padding(.horizontal, 5)
                            .background(Color.blue)
                            .cornerRadius(15)
                    }
                }
                .padding(10)
                
                LazyVGrid(columns: columns, spacing: constants.gridSpacing) {
                    ForEach(vm.photos, id: \.self) { photo in
                        Image(uiImage: photo)
                            .resizable()
                            .frame(width: getImageSize(), height: getImageSize())
                            .scaledToFill()
                            .clipShape(Rectangle())
                    }
                }

            }
        }
        .alert("\(vm.error)", isPresented: $vm.isShowAlert) {
            Button("OK", role: .cancel) {  }
        }
    }
    
    func getImageSize() -> CGFloat{
        let screenWidth = UIScreen.main.bounds.size.width
        let temp = CGFloat(Int(screenWidth / constants.gridSize))
        return (screenWidth - (temp - 1) * constants.gridSpacing) / temp
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

