//
//  SearchBar.swift
//  Weatherly
//
//  Created by Noam Efergan on 04/05/2021.
//

import SwiftUI

// Connection the UI Search bar from UI kit and making it useable for swiftUI
struct SearchBar: UIViewRepresentable {

    @Binding var text: String

    func makeCoordinator() -> SearchBarCoordinator {
        return SearchBarCoordinator(text: $text)
    }

    func makeUIView(context: Context) -> UISearchBar {
        let searchBar = UISearchBar()
        searchBar.delegate = context.coordinator
        searchBar.searchTextField.leftView?.tintColor = UIColor.white
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: Constants.placeholder, attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        // A workaround used to set the background colour to actually be nil
        searchBar.backgroundImage = UIImage()
        return searchBar
    }

    func updateUIView(_ uiView: UISearchBar, context: Context) {
        //
    }
}

    // MARK: - Coordinator

// Coordinator class that's needed in order to use the search bar's functionality
final class SearchBarCoordinator: NSObject, UISearchBarDelegate {

    @Binding var text: String

    init(text: Binding<String>) {
        self._text = text
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let userText = searchBar.text else { return }
        searchBar.showsCancelButton = false
        searchBar.endEditing(true)
        text = userText
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.endEditing(true)
        searchBar.showsCancelButton = false
    }

}

