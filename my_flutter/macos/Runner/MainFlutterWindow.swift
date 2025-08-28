import Cocoa
import FlutterMacOS

class MainFlutterWindow: NSWindow {
  override func awakeFromNib() {
    let flutterViewController = FlutterViewController.init()
    let windowFrame = self.frame
    
    // 设置最小窗口大小，避免内容显示异常
    self.minSize = NSSize(width: 900, height: 700)
    
    // 设置初始窗口大小
    let initialSize = NSSize(width: 1200, height: 900)
    let screenFrame = NSScreen.main?.frame ?? NSRect.zero
    let centerX = (screenFrame.width - initialSize.width) / 2
    let centerY = (screenFrame.height - initialSize.height) / 2
    let initialFrame = NSRect(x: centerX, y: centerY, width: initialSize.width, height: initialSize.height)
    
    self.setFrame(initialFrame, display: true)
    self.contentViewController = flutterViewController

    RegisterGeneratedPlugins(registry: flutterViewController)

    super.awakeFromNib()
  }
}
