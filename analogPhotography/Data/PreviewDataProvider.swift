//
//  DataContainerPreviewData.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 7.07.24.
//
import SwiftData

@MainActor
final class PreviewDataProvider {
    static func insertPreviewData(in container: ModelContainer) {
        let tempContext = ModelContext(container)
        tempContext.autosaveEnabled = false
        
        let pentaxSFX = Camera(name: "Pentax SFX")
        let zenitE = Camera(name: "Zenit-E", note: "Theodor's camera")
        let fed3 = Camera(name: "Fed 3", note: "Grandpa's camera")
        tempContext.insert([pentaxSFX, zenitE, fed3])
        
        
        let filmProcesses = FilmProcess.defaults()
        let filmFormats = FilmFormat.defaults()
        let film = Film(name: "Kodak Gold 200", capacity: 36, speed: 200, exposureTolerance: .init(-1, 3), dxBarcodes: [912503], format: filmFormats.randomElement()!, process: filmProcesses.randomElement()!)
        tempContext.insert(filmProcesses)
        tempContext.insert(filmFormats)
        tempContext.insert(film)
        
        createFilmRollWithPhotos(with: film, for: pentaxSFX, in: tempContext)
        createFilmRollWithPhotos(with: film, for: zenitE, in: tempContext)
        createFilmRollWithPhotos(with: film, for: fed3, in: tempContext)
        
        do {
            try tempContext.save()
        } catch {
            Log.error(error.localizedDescription)
        }
    }
    
    static private func createFilmRollWithPhotos(with film: Film, for camera: Camera, in context: ModelContext) {
        let filmRoll = FilmRoll(expired: Bool.random(), film: film, camera: camera)
        context.insert(filmRoll)
        
        let photos = (1...Int.random(in: 1...36)).map { order in
            let photo = Photo(aperture: Constants.Photo.sampleAperture.randomElement()!,
                              shutterSpeed: Constants.Photo.shutterSpeeds.randomElement()!,
                              filmRoll: filmRoll)
            return photo
        }
        context.insert(photos)
    }
}
