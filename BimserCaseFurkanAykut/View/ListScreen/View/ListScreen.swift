//
//  ListScreen.swift
//  BimserCaseFurkanAykut
//
//  Created by Ebubekir Aykut on 24.12.2022.
//

import SwiftUI

struct ListScreen: View {

    //MARK: Properties
    @ObservedObject var listVM = ListScreenVM()
    @State var isTabbed: Bool = false
    private let categories = ["Movies", "Music", "Ebook", "Podcast"]

    var body: some View {
        NavigationView {
            VStack {
                segmentedPicker

                searchBar

                listWithPagination

            }//Vstack
            .padding()
                .generalBackgroundColor()
                .customAlertWithOneAction(message: listVM.errorMessage, isPresented: $listVM.errorHappenedGetList, actionDone: { })
        }//:NavigationView
    }//:body

    //MARK: SubViews

    private var segmentedPicker: some View {
        Picker("", selection: $listVM.selectedFilter) {
            ForEach(categories, id: \.self) {
                Text($0)
            }
        }//:picker
        .pickerStyle(.segmented)
            .onChange(of: listVM.selectedFilter, perform: { _ in
            listVM.searchTerm = ""
            removeItemsOfList()
        })
    }

    private var searchBar: some View {
        CustomSearchBar(text: $listVM.searchTerm, isTapped: $isTabbed)
            .frame(width: Dimension.shared.width * 0.93, height: Dimension.shared.width * 0.14)
            .innerShadow()
            .onChange(of: listVM.searchTerm) { newValue in
            if (newValue.count >= 3) {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    getList()
                }
            } else {
                removeItemsOfList()
            }
        }
    }

    private var listWithPagination: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], alignment: .leading, spacing: Dimension.shared.width * 0.03) {
                ForEach(listVM.results, id: \.self) { item in
                    NavigationLink(destination: ListDetailView(item: item)) {
                        ListRowCard(ImageUrl: item.artworkUrl100 ?? "", collectionName: item.collectionName ?? "", collectionPrice: item.collectionPrice ?? 0.0, releaseDate: item.releaseDate ?? "")
                            .padding(.top, Dimension.shared.width * 0.02)
                    }
                }

                if !listVM.results.isEmpty {
                    HStack {

                        ViewLoading()
                            .frame(width: Dimension.shared.width * 0.4)
                        Spacer()
                        ViewLoading()
                            .frame(width: Dimension.shared.width * 0.4)
                    }
                        .onAppear {
                        if !listVM.results.isEmpty {
                            getMoreItems()
                        }
                    }

                } else {
                    Text("Lütfen arama yapınız.")
                        .foregroundColor(Colors.shared.black)
                }
            }
        }
            .onTapGesture {
            hideKeyboard()
        }
    }

    //MARK: Functions

    func removeItemsOfList() {
        listVM.results = []
        listVM.page = 0
    }

    func getList() {
        listVM.getList()
    }

    func getMoreItems() {
        listVM.page += 1
        getList()
    }
}

struct ListScreen_Previews: PreviewProvider {
    static var previews: some View {
        ListScreen()
    }
}
