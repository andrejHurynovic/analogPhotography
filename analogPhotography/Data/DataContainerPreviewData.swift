//
//  DataContainerPreviewData.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 7.07.24.
//

import SwiftData

extension DataContainer {
    func insertPreviewData() {
        let tempContext = ModelContext(getContainer())
        tempContext.autosaveEnabled = false
        
        let pentax = Camera(name: "Pentax SFX", note: "", films: [])
        let zenit = Camera(name: "Zenit-E", note: "Theodor's camera", films: [])
        let fed3 = Camera(name: "Fed 3", note: "Grandpa's camera", films: [])
        tempContext.insert([pentax, zenit, fed3])
        
        let filmProcess = FilmProcess(name: "C-41")
        let filmFormat = FilmFormat(name: "135", length: 35, outdated: false)
        let filmType = FilmType(name: "Kodak Gold 200", capacity: 36, iso: 200, expired: false, format: filmFormat, process: filmProcess, films: [])
        let film = Film(camera: pentax, type: filmType, name: nil, note: "", finished: false, photos: [])
        tempContext.insert([filmProcess, filmFormat, filmType, film])
        
        let photos = (1...10).map { order in
            let photo = Photo(film: film,
                              order: order,
                              date: nil,
                              aperture: Constants.Photo.sampleAperture.randomElement()!,
                              shutterSpeed: Constants.Photo.shutterSpeeds.randomElement()!,
                              ruined: false, 
                              note: "")
            return photo
        }
        
        tempContext.insert(photos)
        
        do {
            try tempContext.save()
        } catch {
            Log.error(error.localizedDescription)
        }
    }
    
}
