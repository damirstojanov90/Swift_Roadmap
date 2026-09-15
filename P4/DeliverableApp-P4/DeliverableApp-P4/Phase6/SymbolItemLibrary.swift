//
//  SymbolItem.swift
//  DeliverableApp-P4
//
//  Created by Damir Stojanov on 14.09.2026..
//

import Foundation

struct SymbolItem {
    let symbolName: String
    let label: String
    let description: String
}

extension SymbolItem {
    // swiftlint:disable line_length
    static let library: [SymbolItem] = [
        SymbolItem(symbolName: "star.fill", label: "Star", description: "Mark a favorite or rated item"),
        SymbolItem(symbolName: "heart.fill", label: "Heart", description: "Show likes or favorites"),
        SymbolItem(symbolName: "bolt.fill", label: "Bolt", description: "Indicate power, speed, or charging"),
        SymbolItem(symbolName: "cloud.fill", label: "Cloud", description: "Represent weather or cloud storage"),
        SymbolItem(symbolName: "sun.max.fill", label: "Sun", description: "Show sunny weather or brightness"),
        SymbolItem(symbolName: "moon.stars.fill", label: "Moon and Stars", description: "Represent night mode or sleep"),
        SymbolItem(symbolName: "gamecontroller.fill", label: "Game Controller", description: "Link to games or game settings"),
        SymbolItem(symbolName: "house.fill", label: "House", description: "Navigate to a home screen"),
        SymbolItem(symbolName: "gear", label: "Gear", description: "Open settings"),
        SymbolItem(symbolName: "bell.fill", label: "Bell", description: "Show notifications or alerts"),
        SymbolItem(symbolName: "paperplane.fill", label: "Paper Plane", description: "Send a message"),
        SymbolItem(symbolName: "trash.fill", label: "Trash", description: "Delete an item"),
        SymbolItem(symbolName: "folder.fill", label: "Folder", description: "Organize files into folders"),
        SymbolItem(symbolName: "doc.fill", label: "Document", description: "Represent a file or document"),
        SymbolItem(symbolName: "camera.fill", label: "Camera", description: "Take a photo"),
        SymbolItem(symbolName: "mic.fill", label: "Microphone", description: "Record audio"),
        SymbolItem(symbolName: "wifi", label: "Wi-Fi", description: "Show network connectivity"),
        SymbolItem(symbolName: "battery.100", label: "Battery", description: "Display battery level"),
        SymbolItem(symbolName: "airplane", label: "Airplane", description: "Represent flight or airplane mode"),
        SymbolItem(symbolName: "car.fill", label: "Car", description: "Represent driving or car travel"),
        SymbolItem(symbolName: "bicycle", label: "Bicycle", description: "Represent cycling"),
        SymbolItem(symbolName: "tram.fill", label: "Tram", description: "Represent public transit"),
        SymbolItem(symbolName: "cart.fill", label: "Cart", description: "Go to a shopping cart"),
        SymbolItem(symbolName: "bag.fill", label: "Bag", description: "Represent shopping or purchases"),
        SymbolItem(symbolName: "gift.fill", label: "Gift", description: "Represent a gift or reward"),
        SymbolItem(symbolName: "flag.fill", label: "Flag", description: "Mark or report an item"),
        SymbolItem(symbolName: "mappin.and.ellipse", label: "Map Pin", description: "Mark a location on a map"),
        SymbolItem(symbolName: "map.fill", label: "Map", description: "Open a map view"),
        SymbolItem(symbolName: "globe", label: "Globe", description: "Represent the internet or language settings"),
        SymbolItem(symbolName: "lock.fill", label: "Lock", description: "Show a locked or secure state"),
        SymbolItem(symbolName: "key.fill", label: "Key", description: "Represent authentication or unlocking"),
        SymbolItem(symbolName: "eye.fill", label: "Eye", description: "Toggle visibility of content"),
        SymbolItem(symbolName: "hand.thumbsup.fill", label: "Thumbs Up", description: "Approve or like something"),
        SymbolItem(symbolName: "hand.thumbsdown.fill", label: "Thumbs Down", description: "Disapprove or dislike something"),
        SymbolItem(symbolName: "face.smiling", label: "Smiling Face", description: "Represent mood or reactions"),
        SymbolItem(symbolName: "person.fill", label: "Person", description: "Represent a user profile"),
        SymbolItem(symbolName: "person.2.fill", label: "Two People", description: "Represent contacts or groups"),
        SymbolItem(symbolName: "book.fill", label: "Book", description: "Open a reading list or library"),
        SymbolItem(symbolName: "bookmark.fill", label: "Bookmark", description: "Save an item for later"),
        SymbolItem(symbolName: "tag.fill", label: "Tag", description: "Represent a price or label"),
        SymbolItem(symbolName: "cube.fill", label: "Cube", description: "Represent a 3D object or package"),
        SymbolItem(symbolName: "puzzlepiece.fill", label: "Puzzle Piece", description: "Represent an add-on or extension"),
        SymbolItem(symbolName: "paintbrush.fill", label: "Paintbrush", description: "Represent drawing or theming tools"),
        SymbolItem(symbolName: "scissors", label: "Scissors", description: "Cut selected content"),
        SymbolItem(symbolName: "wrench.fill", label: "Wrench", description: "Open tools or maintenance settings"),
        SymbolItem(symbolName: "hammer.fill", label: "Hammer", description: "Represent building or repair actions"),
        SymbolItem(symbolName: "ruler.fill", label: "Ruler", description: "Measure or represent dimensions"),
        SymbolItem(symbolName: "magnifyingglass", label: "Magnifying Glass", description: "Search content"),
        SymbolItem(symbolName: "printer.fill", label: "Printer", description: "Print a document"),
        SymbolItem(symbolName: "tv.fill", label: "TV", description: "Represent a television or streaming device"),
        SymbolItem(symbolName: "headphones", label: "Headphones", description: "Represent audio playback devices"),
        SymbolItem(symbolName: "speaker.wave.2.fill", label: "Speaker", description: "Adjust volume or audio output"),
        SymbolItem(symbolName: "music.note", label: "Music Note", description: "Represent a song or music player"),
        SymbolItem(symbolName: "film.fill", label: "Film", description: "Represent a movie or video"),
        SymbolItem(symbolName: "photo.fill", label: "Photo", description: "Represent an image or gallery"),
        SymbolItem(symbolName: "video.fill", label: "Video", description: "Represent video recording or playback"),
        SymbolItem(symbolName: "calendar", label: "Calendar", description: "Show a date or schedule"),
        SymbolItem(symbolName: "clock.fill", label: "Clock", description: "Show the current time"),
        SymbolItem(symbolName: "alarm.fill", label: "Alarm", description: "Represent a scheduled alarm"),
        SymbolItem(symbolName: "stopwatch.fill", label: "Stopwatch", description: "Track elapsed time"),
        SymbolItem(symbolName: "timer", label: "Timer", description: "Set a countdown timer"),
        SymbolItem(symbolName: "thermometer", label: "Thermometer", description: "Show temperature readings"),
        SymbolItem(symbolName: "umbrella.fill", label: "Umbrella", description: "Represent rainy weather"),
        SymbolItem(symbolName: "snowflake", label: "Snowflake", description: "Represent cold or winter weather"),
        SymbolItem(symbolName: "flame.fill", label: "Flame", description: "Represent trending or hot items"),
        SymbolItem(symbolName: "drop.fill", label: "Drop", description: "Represent liquid or humidity"),
        SymbolItem(symbolName: "leaf.fill", label: "Leaf", description: "Represent nature or eco-friendly features"),
        SymbolItem(symbolName: "pawprint.fill", label: "Pawprint", description: "Represent pets or animals"),
        SymbolItem(symbolName: "ant.fill", label: "Ant", description: "Represent insects or bugs"),
        SymbolItem(symbolName: "fish.fill", label: "Fish", description: "Represent aquatic life"),
        SymbolItem(symbolName: "tortoise.fill", label: "Tortoise", description: "Represent slow mode or pacing"),
        SymbolItem(symbolName: "hare.fill", label: "Hare", description: "Represent fast mode or speed"),
        SymbolItem(symbolName: "bird.fill", label: "Bird", description: "Represent nature or freedom")
    ]
    // swiftlint:enable line_length
}
