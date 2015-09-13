import Foundation

class SimulatorUtility
{
    class var isRunningSimulator: Bool
        {
        get
    {
        return TARGET_IPHONE_SIMULATOR != 0
        }
    }
}