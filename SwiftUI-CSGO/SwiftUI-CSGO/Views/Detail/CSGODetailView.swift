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
        }
    }

    private var detailView: some View {
        VStack {
            headerView

            Text("Hoje 21:00")
                .foregroundColor(.white)

            playersView()

            Spacer()
        }
    }

    private var headerView: some View {
        HStack(spacing: 16) {
            VStack {
                if let opponents = viewModel.match.opponents, !opponents.isEmpty, opponents.count > 1 {
                    AsyncImage(url: URL(string: opponents[0].opponent?.image_url ?? "")) { image in
                        image
                            .resizable()
                            .frame(width: 60, height: 60)
                    } placeholder: {
                        PlaceholderImage(size: 60)
                    }

                    Text(opponents[0].opponent?.name ?? "")
                        .foregroundColor(.white)
                } else {
                    PlaceholderImage(size: 60)
                }
            }

            Text("vs")
                .foregroundColor(.CSGOGray)

            VStack {
                if let opponents = viewModel.match.opponents, !opponents.isEmpty, opponents.count > 1 {
                    AsyncImage(url: URL(string: opponents[1].opponent?.image_url ?? "")) { image in
                        image
                            .resizable()
                            .frame(width: 60, height: 60)
                    } placeholder: {
                        PlaceholderImage(size: 60)
                    }

                    Text(opponents[1].opponent?.name ?? "")
                        .foregroundColor(.white)
                } else {
                    PlaceholderImage(size: 60)
                }
            }
        }
        .padding(16)
    }

    private func playersView() -> some View {
        HStack {
            VStack {
                ForEach(Array(viewModel.firstPlayerList.enumerated()), id: \.offset) { index, player in
                    HStack {
                        VStack {
                            Text("Nick")
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity, alignment: .trailing)

                            Text("Nome")
                                .foregroundColor(.CSGOGray)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        }

                        AsyncImage(url: URL(string: "https://picsum.photos/200/300")) { image in
                            image
                                .resizable()
                                .frame(width: 60, height: 60)
                                .cornerRadius(8)
                        } placeholder: {
                            PlaceholderImage(size: 60, cornerRadius: 8)
                        }
                    }
                    .background(Color.CSGODarkBlue)
                }

                Spacer()
            }

            VStack {
                ForEach(Array(viewModel.secondPlayerList.enumerated()), id: \.offset) { index, player in
                    HStack {
                        AsyncImage(url: URL(string: "https://picsum.photos/200/300")) { image in
                            image
                                .resizable()
                                .frame(width: 60, height: 60)
                                .cornerRadius(8)
                        } placeholder: {
                            PlaceholderImage(size: 60, cornerRadius: 8)
                        }

                        VStack {
                            Text("Nick")
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity, alignment: .leading)

                            Text("Nome")
                                .foregroundColor(.CSGOGray)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    .background(Color.CSGODarkBlue)
                }

                Spacer()
            }
        }
    }

    private var errorView: some View {
        Text("Ocorreu um erro!")
    }
}

struct CSGODetailView_Previews: PreviewProvider {
    static var previews: some View {
        //CSGODetailView(match: CSGOMatchModel())
        PlayersView()
            .background(Color.CSGOPrimary)
            .frame(width: .infinity)
    }
}

struct PlayersView: View {
    var body: some View {
        HStack {
            VStack {
                ForEach(0..<5) { index in
                    HStack {
                        VStack {
                            Text("Nick")
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                            Text("Nome")
                                .foregroundColor(.CSGOGray)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        }

                        AsyncImage(url: URL(string: "https://picsum.photos/200/300")) { image in
                            image
                                .resizable()
                                .frame(width: 60, height: 60)
                                .cornerRadius(8)
                        } placeholder: {
                            Text("loading..")
                        }
                    }
                    .background(Color.CSGODarkBlue)
                }

                Spacer()
            }

            VStack {
                ForEach(0..<2) { index in
                    HStack {
                        AsyncImage(url: URL(string: "https://picsum.photos/200/300")) { image in
                            image
                                .resizable()
                                .frame(width: 60, height: 60)
                                .cornerRadius(8)
                        } placeholder: {
                            Text("loading...")
                        }

                        VStack {
                            Text("Nick")
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text("Nome")
                                .foregroundColor(.CSGOGray)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    .background(Color.CSGODarkBlue)
                }

                Spacer()
            }
        }
    }
}
