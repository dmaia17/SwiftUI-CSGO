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
        VStack(alignment: .leading) {
            Text("PARTIDAS")
                .foregroundColor(.white)
                .padding(24)

            List(viewModel.matches) { match in
                itemListView(match: match)
                    .listRowBackground(Color.CSGOPrimary)
                    .listRowSeparator(.hidden)
                    .overlay {
                        NavigationLink("", destination: CSGODetailView(match: match))
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
    }

    private var errorView: some View {
        Text("Ocorreu um erro!")
            .foregroundColor(.white)
            .font(.bold14)
    }

    private func itemListView(match: CSGOMatchModel) -> some View {
        VStack {
            VStack(spacing: 0) {
                itemListHeaderView(match: match)
                itemListOpponentView(match: match)
                itemListBottomView(match: match)
            }
            .padding(.bottom, 16)
            .background(Color.CSGODarkBlue)
            .cornerRadius(16)

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
    private func itemListHeaderView(match: CSGOMatchModel) -> some View {
        HStack {
            Spacer()

            if match.status == .running {
                Text("AGORA")
                    .font(.bold8)
                    .foregroundColor(.white)
                    .padding(8)
                    .background(Color.CSGORed)
                    .cornerRadius(16, corners: [.topRight, .bottomLeft])
            } else {
                Text(viewModel.getMatchDateStatus(match: match))
                    .font(.bold8)
                    .foregroundColor(.white)
                    .padding(8)
                    .background(Color.CSGOGray)
                    .cornerRadius(16, corners: [.topRight, .bottomLeft])
            }
        }
    }

    private func itemListOpponentView(match: CSGOMatchModel) -> some View {
        HStack(spacing: 16) {
            VStack {
                if let opponents = match.opponents, !opponents.isEmpty, opponents.count > 1 {
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
                if let opponents = match.opponents, !opponents.isEmpty, opponents.count > 1 {
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
        .padding(16)
    }

    private func itemListBottomView(match: CSGOMatchModel) -> some View {
        VStack{
            Divider()
                .background(Color.CSGOGray)
                .padding(.vertical, 8)

            HStack {
                AsyncImage(url: URL(string: match.league?.image_url ?? "")) { image in
                    image
                        .resizable()
                        .frame(width: 16, height: 16)
                } placeholder: {
                    PlaceholderImage(size: 16)
                }

                Text(match.league?.name ?? "")
                    .font(.regular8)
                    .foregroundColor(.CSGOGray)
            }
            .padding(.horizontal, 16)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
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

