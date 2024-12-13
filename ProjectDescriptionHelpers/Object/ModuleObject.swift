import ProjectDescription

/// ModuleObject Type
/// Helps manage module variables that are used repeatedly by Tuist.
///
/// ```swift
/// struct Constants: ModuleObject {
///    static var version: String! = "x.y.z"
///    static let config = AppConfig()
///}
/// ```
///
public protocol ModuleObject {}
