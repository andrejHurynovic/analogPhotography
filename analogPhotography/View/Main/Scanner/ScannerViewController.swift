import UIKit
import AVFoundation
import Vision

final class ScannerViewController: UIViewController {
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
        captureSessionQueue.async {
            self.setupCaptureSession()
            self.setupCapturePreviewLayer()
            
            self.setupDetectorVideoOutput()
            self.setupDetectorBoxesLayer()
            self.setupDetectorsRequests()
            
            self.updateVideoRotationAngle()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        captureSessionQueue.async {
            self.captureSession.startRunning()
        }
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
