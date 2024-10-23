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
        do {
            let pentaxSFX = Camera(name: "Pentax SFX")
            let zenitE = Camera(name: "Zenit-E", note: "Theodor's camera")
            let fed3 = Camera(name: "Fed 3", note: "Grandpa's camera")
            try tempContext.insert([pentaxSFX, zenitE, fed3])
            
            
            
            let filmProcesses = FilmProcess.defaults()
            let filmFormats = FilmFormat.defaults()
            let kodakGold200 = Film(name: "Kodak Gold 200", capacity: 36, speed: 200, exposureTolerance: .init(-1, 3), dxBarcodes: Set(["912503"]), format: filmFormats.randomElement()!, process: filmProcesses.randomElement()!)
            let relleiRetro80s = Film(name: "Rollei Retro 80s", capacity: 36, speed: 80, exposureTolerance: .init(-1, 3), dxBarcodes: Set(["851811"]), format: filmFormats.randomElement()!, process: filmProcesses.randomElement()!)
            
            try tempContext.insert(filmProcesses)
            try tempContext.insert(filmFormats)
            try tempContext.transaction {
                tempContext.insert(kodakGold200)
                tempContext.insert(relleiRetro80s)
            }
            
            try createFilmRollWithPhotos(with: kodakGold200, for: pentaxSFX, photosCountEqualsFilmCapacity: true, in: tempContext)
            try createFilmRollWithPhotos(with: relleiRetro80s, for: fed3, in: tempContext)
            
            
            try tempContext.save()
        } catch {
            Log.error(error.localizedDescription)
        }
    }
    
    static private func createFilmRollWithPhotos(with film: Film,
                                                 for camera: Camera,
                                                 photosCountEqualsFilmCapacity: Bool = false,
                                                 in context: ModelContext) throws {
        let filmRoll = FilmRoll(expired: Bool.random(), film: film, camera: camera)
        context.insert(filmRoll)
        
        let photoCount = photosCountEqualsFilmCapacity ? film.capacity ?? 36 : Int.random(in: 1...36)
        
        let photos = (1...photoCount).map { order in
            let photo = Photo(locationDescription: "A Big Place",
                              aperture: Constants.Photo.sampleAperture.randomElement()!,
                              shutterSpeed: Constants.Photo.shutterSpeeds.randomElement()!,
                              filmRoll: filmRoll)
            return photo
        }
        try context.insert(photos)
    }
}
