//
//  CSGODetailView.swift
//  SwiftUI-CSGO
//
//  Created by Daniel Maia dos Passos on 02/08/23.
//

import SwiftUI

struct CSGODetailView: View {
    @ObservedObject var viewModel: CSGODetailViewModel

    init(match: CSGOMatchModel) {
        self.viewModel = CSGODetailViewModel(match: match, service: CSGOServiceProvider())
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
    }

    var body: some View {
        GeometryReader { geo in
            VStack {
                switch viewModel.state {
                case .loading:
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: Color.white))
                case .loaded:
                    detailView
                case .error:
                    errorView
                }
            }
            .frame(minWidth: geo.size.width, minHeight: geo.size.height)
            .background(Color.CSGOPrimary)
            .onAppear {
                viewModel.loadData()
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: NavigationBackButton())
            .navigationTitle(viewModel.match.league?.name ?? "")
            .preferredColorScheme(.dark)
        }
    }

    private var detailView: some View {
        VStack {
            headerView

            Text(viewModel.timeStatus)
                .font(.bold12)
                .foregroundColor(.white)
                .padding(.bottom, 20)

            playersView()

            Spacer()
        }
    }

    private var headerView: some View {
        HStack(spacing: 16) {
            VStack {
                if let opponents = viewModel.match.opponents, opponents.count > 1 {
                    AsyncImage(url: URL(string: opponents[0].opponent?.image_url ?? "")) { image in
                        image
                            .resizable()
                            .frame(width: 60, height: 60)
                    } placeholder: {
                        PlaceholderImage(size: 60)
                    }

                    Text(opponents[0].opponent?.name ?? "")
                        .font(.regular10)
                        .foregroundColor(.white)
                } else {
                    PlaceholderImage(size: 60)
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity)

            Text("vs")
                .font(.regular12)
                .foregroundColor(.white)

            VStack {
                if let opponents = viewModel.match.opponents, opponents.count > 1 {
                    AsyncImage(url: URL(string: opponents[1].opponent?.image_url ?? "")) { image in
                        image
                            .resizable()
                            .frame(width: 60, height: 60)
                    } placeholder: {
                        PlaceholderImage(size: 60)
                    }

                    Text(opponents[1].opponent?.name ?? "")
                        .font(.regular10)
                        .foregroundColor(.white)
                } else {
                    PlaceholderImage(size: 60)
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity)
        }
        .padding(20)
    }

    private func playersView() -> some View {
        ScrollView(.vertical) {
            HStack(spacing: 12) {
                VStack {
                    ForEach(Array(viewModel.firstPlayerList.enumerated()), id: \.offset) { index, player in
                        HStack {
                            VStack {
                                Text(player.slug)
                                    .font(.bold14)
                                    .lineLimit(1)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                
                                Text(player.name)
                                    .font(.bold12)
                                    .lineLimit(1)
                                    .foregroundColor(.CSGOGray)
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                            }
                            
                            AsyncImage(url: URL(string: player.image_url)) { image in
                                image
                                    .resizable()
                                    .frame(width: 60, height: 60)
                                    .cornerRadius(8)
                            } placeholder: {
                                PlaceholderImage(size: 60, cornerRadius: 8)
                            }
                        }
                        .padding(.trailing, 8)
                        .padding(.bottom, 8)
                        .background(Color.CSGODarkBlue)
                        .cornerRadius(8, corners: [.topRight, .bottomRight])
                    }
                    
                    Spacer()
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                
                VStack {
                    ForEach(Array(viewModel.secondPlayerList.enumerated()), id: \.offset) { index, player in
                        HStack {
                            AsyncImage(url: URL(string: player.image_url)) { image in
                                image
                                    .resizable()
                                    .frame(width: 60, height: 60)
                                    .cornerRadius(8)
                            } placeholder: {
                                PlaceholderImage(size: 60, cornerRadius: 8)
                            }
                            
                            VStack {
                                Text(player.slug)
                                    .font(.bold14)
                                    .lineLimit(1)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                Text(player.name)
                                    .font(.bold12)
                                    .lineLimit(1)
                                    .foregroundColor(.CSGOGray)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                        .padding(.leading, 8)
                        .padding(.bottom, 8)
                        .background(Color.CSGODarkBlue)
                        .cornerRadius(8, corners: [.topLeft, .bottomLeft])
                    }
                    
                    Spacer()
                }
                .frame(minWidth: 0, maxWidth: .infinity)
            }
        }
    }

    private var errorView: some View {
        Text("Ocorreu um erro!")
            .foregroundColor(.white)
    }
}

struct CSGODetailView_Previews: PreviewProvider {
    static var previews: some View {
        CSGODetailView(match: CSGOMatchModel())
    }
}
