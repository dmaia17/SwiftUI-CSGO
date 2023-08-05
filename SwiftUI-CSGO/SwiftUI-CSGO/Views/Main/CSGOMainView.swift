//
//  CSGOMainView.swift
//  SwiftUI-CSGO
//
//  Created by Daniel Maia dos Passos on 02/08/23.
//

import SwiftUI

struct CSGOMainView: View {
    @ObservedObject var viewModel = CSGOMainViewModel(service: CSGOServiceProvider())

    var body: some View {
        NavigationView {
            GeometryReader { geo in
                VStack {
                    switch viewModel.state {
                    case .loading:
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: Color.white))
                    case .loaded:
                        listView
                    case .error:
                        errorView
                    }
                }
                .frame(minWidth: geo.size.width, minHeight: geo.size.height)
                .background(Color.CSGOPrimary)
            }
        }
    }

    private var listView: some View {
        List(viewModel.matches) { match in
            itemListView(match: match)
                .listRowBackground(Color.CSGOPrimary)
                .listRowSeparator(.hidden)
                .overlay {
                    NavigationLink("", destination: CSGODetailView(matchId: match.id))
                        .opacity(0)
                }
        }
        .listStyle(.inset)
        .refreshable {
            viewModel.refreshMatches()
        }
        .onAppear {
            UIRefreshControl.appearance().tintColor = .white
        }
        .scrollContentBackground(.hidden)

    }

    private var errorView: some View {
        Text("Ocorreu um erro!")
    }

    private func itemListView(match: CSGOMatchModel) -> some View {
        VStack {
            VStack(spacing: 0) {
                HStack {
                    Spacer()

                    Text("AGORA")
                        .foregroundColor(.white)
                        .padding(8)
                        .background(Color.CSGORed)
                        .cornerRadius(6, corners: [.topRight, .bottomLeft])
                }

                HStack(spacing: 16) {
                    VStack {
                        if let opponents = match.opponents, !opponents.isEmpty, opponents.count > 1 {
                            AsyncImage(url: URL(string: opponents[0].opponent?.image_url ?? "")) { image in
                                image
                                    .resizable()
                                    .frame(width: 60, height: 60)
                            } placeholder: {
                                placeholderImage()
                            }
                        } else {
                            placeholderImage()
                        }
                    }

                    Text("vs")
                        .foregroundColor(.CSGOGray)

                    VStack {
                        if let opponents = match.opponents, !opponents.isEmpty, opponents.count > 1 {
                            AsyncImage(url: URL(string: opponents[1].opponent?.image_url ?? "")) { image in
                                image
                                    .resizable()
                                    .frame(width: 60, height: 60)
                            } placeholder: {
                                placeholderImage()
                            }
                        } else {
                            placeholderImage()
                        }
                    }
                }
                .padding(16)

                Divider()
                    .background(Color.CSGOGray)
                    .padding(.vertical, 16)

                HStack {
                    AsyncImage(url: URL(string: match.league?.image_url ?? "")) { image in
                        image
                            .resizable()
                            .frame(width: 16, height: 16)
                    } placeholder: {
                        placeholderImage(size: 16)
                    }

                    Text(match.league?.name ?? "")
                        .foregroundColor(.CSGOGray)
                }
                .padding(.horizontal, 16)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.bottom, 16)
            .background(Color.CSGODarkBlue)
            .cornerRadius(8)

            if match == viewModel.matches.last && viewModel.hasMorePages {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: Color.white))
            }
        }
        .onAppear {
            if match == viewModel.matches.last {
                viewModel.currentPage = viewModel.currentPage + 1
                viewModel.fetchMatches()
            }
        }

    }

    private func placeholderImage(size: CGFloat = 60) -> some View {
        Color.CSGOGray
            .frame(width: size, height: size)
            .cornerRadius(size / 2)
    }

    private func customRadius() -> CGFloat {
        let topLeft: CGFloat = 0
        let topRight: CGFloat = 8
        let bottomLeft: CGFloat = 8
        let bottomRight: CGFloat = 0
        return 10 * (topLeft + topRight + bottomLeft + bottomRight)
    }
}

struct CSGOMainView_Previews: PreviewProvider {
    static var previews: some View {
        CSGOMainView()
    }
}

