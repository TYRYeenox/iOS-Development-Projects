import UIKit

// Your task is to build a playlist manager Playground. Using a Song struct and Playlist class, the core of your app will be an array of playlists. The Playlist class should include a minimum of four properties name, author, songs, and currentlyPlaying, as well as the following functions:
//
// Init
// init()
//
// Core mutation
// func add(_ song: Song)
// func remove(at index: Int)
// func clear()
//
// Querying / reading
// var count: Int { get }
// func allSongs() -> [Song]
// func totalDuration() -> Int
// func currentSong() -> Song?
//
// Playback navigation
// func play(at index: Int) -> Song?
// func playNext() -> Song?
// func playPrevious() -> Song?
//
// Shuffle
// func shuffle()

struct Song: Equatable {
    var title: String
    var artist: String
    var duration: Int
}

class Playlist {
    var name: String
    var author: String
    var songs: [Song]
    var currentlyPlaying: Int?

    init(name: String, author: String, songs: [Song] = []) {
        self.name = name
        self.author = author
        self.songs = songs
        self.currentlyPlaying = songs.isEmpty ? nil : 0
    }

    // Core mutation
    func add(_ song: Song) {
        songs.append(song)
        if currentlyPlaying == nil {
            currentlyPlaying = 0
        }
    }

    // Remove
    func remove(at index: Int) {
        // index < songs.count
        guard songs.indices.contains(index) else { return }
        songs.remove(at: index)
        if let current = currentlyPlaying {
            if songs.isEmpty {
                currentlyPlaying = nil
            } else if index < current {
                currentlyPlaying = max(0, current - 1)
            } else if index == current {
                currentlyPlaying = min(current, songs.count - 1)
            }
        }
    }

    // Clear
    func clear() {
        songs.removeAll()
        currentlyPlaying = nil
    }

    // Querying / reading
    var count: Int { songs.count }
    func allSongs() -> [Song] { songs }

    // Total Duration
    func totalDuration() -> Int {
        var total = 0
        for song in songs { total += song.duration }
        return total
    }

    //Current Song
    func currentSong() -> Song? {
        if let index = currentlyPlaying, songs.indices.contains(index) {
            return songs[index]
        }
        return nil
    }

    // Playback navigation
    func play(at index: Int) -> Song? {
        guard songs.indices.contains(index) else { return nil }
        currentlyPlaying = index
        return songs[index]
    }

    //Play Next
    func playNext() -> Song? {
        guard !songs.isEmpty else { return nil }
        if let idx = currentlyPlaying {
            let next = idx + 1
            currentlyPlaying = songs.indices.contains(next) ? next : 0
        } else {
            currentlyPlaying = 0
        }
        return currentSong()
    }

    
    // Play Previous
    func playPrevious() -> Song? {
        guard !songs.isEmpty else { return nil }
        if let idx = currentlyPlaying {
            let prev = idx - 1
            currentlyPlaying = songs.indices.contains(prev) ? prev : songs.count - 1
        } else {
            currentlyPlaying = songs.count - 1
        }
        return currentSong()
    }

    // Shuffle
    func shuffle() {
        guard !songs.isEmpty else { return }
        let current = currentSong()
        songs.shuffle()
        if let current = current, let newIndex = songs.firstIndex(of: current) {
            currentlyPlaying = newIndex
        } else {
            currentlyPlaying = songs.isEmpty ? nil : 0
        }
    }
}

// Adding one song
let song1 = Song(title: "King for A Day", artist: "Pierce The Veil", duration: 236)

// Testing playlist
let playlist = Playlist(name: "Favorites", author: "Brandon")

playlist.add(song1)

// Testing song count
print("Song count:", playlist.count)

// Testing currently playing
print("Currently playing:", playlist.currentSong()?.title ?? "None")

// Testing play next/previous
playlist.playNext()
print("Next:", playlist.currentSong()?.title ?? "None")
playlist.playPrevious()
print("Previous:", playlist.currentSong()?.title ?? "None")

// Testing shuffle
playlist.shuffle()
print("After shuffle:")
for song in playlist.allSongs() {
    print(song.title)
}

// Testing removing
playlist.remove(at: 1)
print("After removal:", playlist.count)

// Testing clearing
playlist.clear()
print("After clear:", playlist.count)
