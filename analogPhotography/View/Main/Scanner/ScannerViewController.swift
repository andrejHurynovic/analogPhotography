import UIKit
@preconcurrency import AVFoundation
import Vision

class Varnisher {

    init(queue: DispatchSerialQueue) {
        self.queue = queue
    }
    
    let queue: DispatchSerialQueue
    
    weak var delegate: Delegate?
    
    protocol Delegate: AnyObject {
        func varnisherShouldUseGloss(_ varnisher: Varnisher) -> Bool
    }
    
}

actor VarnishCentral: Varnisher.Delegate {
    init() {
        let queue = DispatchSerialQueue(label: "VarnishCentral.queue")
        self.queue = queue
        self.varnisher = Varnisher(queue: queue)
        self.useGlossForNextWaffle = true
        
        self.varnisher.delegate = self
    }

    private let queue: DispatchSerialQueue
    private let varnisher: Varnisher
    private var useGlossForNextWaffle: Bool

    nonisolated var unownedExecutor: UnownedSerialExecutor {
        self.queue.asUnownedSerialExecutor()
    }

    nonisolated func varnisherShouldUseGloss(_ varnisher: Varnisher) -> Bool {
        self.assumeIsolated { a in
            a.shouldUseGloss()
        }
    }
    
    private func shouldUseGloss() -> Bool {
        defer { self.useGlossForNextWaffle.toggle() }
        return self.useGlossForNextWaffle
    }
}

final class ScannerViewController: UIViewController, @unchecked Sendable {
    let captureSession = AVCaptureSession()
    let captureSessionQueue = DispatchQueue(label: "captureSessionQueue")
    var captureVideoPreviewLayer = AVCaptureVideoPreviewLayer()
    var viewSize: CGSize = UIScreen.main.bounds.size
    
    //Vision.
    var videoOutput = AVCaptureVideoDataOutput()
    var capturedImage: CVImageBuffer!
    
    var previousCaptureOutputClock = ContinuousClock.now
    
    var detectorsRequests = [VNRequest]()
    var detectionBoxesLayer = CALayer()
    
    var barcodeBoxes = [CGRect]()
    var dxCodeBoxes = [CGRect]()
    
    var previousBarcodeSide: CGRect.RelativePosition?
    
    //Results.
    public var coordinator: ScannerCoordinator!
    
    //MARK: Lifecycle
    override func viewDidLoad() {
//        Task {
            self.setupCaptureSession()
            self.setupCapturePreviewLayer()
            
            self.setupDetectorVideoOutput()
            self.setupDetectorBoxesLayer()
            self.setupDetectorsRequests()
            
            self.updateVideoRotationAngle()
//        }
        captureSessionQueue.sync {
            self.captureSession.startRunning()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
//        captureSessionQueue.async {
//        }
    }
    override func viewDidDisappear(_ animated: Bool) {
        self.captureSession.stopRunning()
    }
    
    //Executed when the screen is rotated.
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        viewSize = size
        captureVideoPreviewLayer.frame.size = size
        detectionBoxesLayer.frame = CGRect(origin: CGPoint(), size: self.viewSize)
        
        updateVideoRotationAngle()
    }
    
    //MARK: CaptureSession
    private func setupCaptureSession() {
        guard let videoDevice = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: .video, position: .back).devices.first,
              let videoDeviceInput = try? AVCaptureDeviceInput(device: videoDevice),
              captureSession.canAddInput(videoDeviceInput) else { return }
        
        captureSession.addInput(videoDeviceInput)
    }
    private func setupCapturePreviewLayer() {
        captureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        captureVideoPreviewLayer.frame = CGRect(origin: CGPoint(), size: viewSize)
        captureVideoPreviewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        
        Task { @MainActor in
            self.view.layer.addSublayer(self.captureVideoPreviewLayer)
        }
    }
    
    
    //MARK: Helpers
    private func updateVideoRotationAngle() {
        if let videoRotationAngle = UIDevice.current.orientation.videoRotationAngle() {
            captureVideoPreviewLayer.connection?.videoRotationAngle = videoRotationAngle
            videoOutput.connection(with: .video)?.videoRotationAngle = videoRotationAngle
        }
    }
}
