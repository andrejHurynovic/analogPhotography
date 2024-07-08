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
        
        let pentax = Camera(name: "Pentax SFX")
        let zenitE = Camera(name: "Zenit-E", note: "Theodor's camera")
        let fed3 = Camera(name: "Fed 3", note: "Grandpa's camera")
        tempContext.insert([pentax, zenitE, fed3])
        
        let filmProcess = FilmProcess(name: "C-41")
        let filmFormat = FilmFormat(name: "135", length: 35, outdated: false)
        let film = Film(name: "Kodak Gold 200", capacity: 36, iso: 200, expired: false, format: filmFormat, process: filmProcess)
        tempContext.insert([filmProcess, filmFormat, film])
        
        let filmRoll = FilmRoll(type: film, camera: pentax)
        tempContext.insert(filmRoll)
        
        let photos = (1...10).map { order in
            let photo = Photo(aperture: Constants.Photo.sampleAperture.randomElement()!,
                              shutterSpeed: Constants.Photo.shutterSpeeds.randomElement()!,
                              filmRoll: filmRoll)
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
