import UIKit
@preconcurrency import AVFoundation
import Vision

final class ScannerViewController: UIViewController {
    let captureSession = AVCaptureSession()
    var captureSessionActor: ScannerCaptureSessionActor!
    var outputActor: ScannerOutputActor!
    
    var captureVideoPreviewLayer = AVCaptureVideoPreviewLayer()
    var viewSize: CGSize!
    
    var videoOutput = AVCaptureVideoDataOutput()
    
    var isSetupFinished: Bool = false
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.captureSessionActor = ScannerCaptureSessionActor(captureSession: captureSession)
        
        Task {
            await captureSessionActor.setupCaptureSession()
            await setupCapturePreviewLayer()
            await setupDetectorVideoOutput()
            
            updateVideoRotationAngle()
            await captureSessionActor.startCaptureSession()
            
            isSetupFinished = true
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isSetupFinished {
            Task {
                await captureSessionActor.startCaptureSession()
            }
        }
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        Task {
            await captureSessionActor.stopCaptureSession()
        }
    }
    
    //Executed when the screen is rotated.
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        viewSize = size
        captureVideoPreviewLayer.frame.size = size
        
        updateVideoRotationAngle()
    }
    
    //MARK: CaptureSession
    private func setupCaptureSession() {
        guard let videoDevice = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: .video, position: .back).devices.first,
              let videoDeviceInput = try? AVCaptureDeviceInput(device: videoDevice),
              captureSession.canAddInput(videoDeviceInput) else { return }
        
        captureSession.addInput(videoDeviceInput)
    }
    private func setupCapturePreviewLayer() async {
        captureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        captureVideoPreviewLayer.frame = CGRect(origin: CGPoint(), size: viewSize)
        captureVideoPreviewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        
        await MainActor.run {
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
