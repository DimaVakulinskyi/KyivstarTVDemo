//
//  AssetDetailsView.swift
//  DemoApp
//
//  Created by Dmytro Vakulinskyi on 22.11.2024.
//

import SwiftUI
import Combine

struct AssetDetailsView: View {
    var asset: Asset
    
    @Environment(\.presentationMode) private var presentationMode
    @State private var similarAssets: [SimilarAsset] = []
    @State private var cancellable: AnyCancellable?
    private let apiClient = APIClient()
    
    var body: some View {
        VStack(spacing: 0) {
            AsyncImage(url: asset.image) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 211)
                        .clipped()
                case .failure:
                    Image(systemName: "photo")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 211)
                        .foregroundColor(.gray)
                        .clipped()
                @unknown default:
                    EmptyView()
                }
            }
            
            HStack {
                Button(action: {
                    print("Play button tapped")
                }) {
                    HStack(spacing: 8) {
                        Image(systemName: "play.fill")
                            .foregroundColor(.white)
                        Text("Play")
                            .foregroundColor(.white)
                            .font(.system(size: 16, weight: .bold))
                    }
                    .frame(width: 129, height: 40)
                    .background(Color.blue)
                    .cornerRadius(32)
                }
                
                Spacer()
                
                Button(action: {
                    print("Star button tapped")
                }) {
                    Image(systemName: "star.fill")
                        .foregroundColor(.white)
                        .frame(width: 66, height: 40)
                        .background(Color.gray)
                        .cornerRadius(32)
                }
            }
            .padding()
            .background(Color.white)
            
            Divider()
            
            ScrollView {
                Text(asset.name)
                    .font(.system(size: 22))
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                    ForEach(similarAssets, id: \.id) { similarAsset in
                        ZStack(alignment: .topLeading) {
                            AsyncImage(url: URL(string: similarAsset.image)) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                case .success(let image):
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 104, height: 156)
                                        .clipped()
                                case .failure:
                                    Rectangle()
                                        .fill(Color.gray.opacity(0.3))
                                        .frame(width: 104, height: 156)
                                @unknown default:
                                    EmptyView()
                                }
                            }
                            .background(Color.white)
                            .cornerRadius(10)
                            
                            if !similarAsset.purchased {
                                Image("lock")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24, height: 24)
                                    .padding(8)
                            }
                        }
                    }
                }
                .padding()
            }
            .background(Color.white)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color(UIColor.systemGroupedBackground))
        .onAppear {
            fetchSimilarAssets()
        }
        .navigationBarHidden(true)
        .gesture(DragGesture().onEnded { value in
            if value.translation.width > 100 {
                presentationMode.wrappedValue.dismiss()
            }
        })
    }
    
    private func fetchSimilarAssets() {
        cancellable = apiClient.fetchSimilarAssets()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }, receiveValue: { similarAssets in
                self.similarAssets = similarAssets
            })
    }
}
