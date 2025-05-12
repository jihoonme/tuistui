import ProjectDescription

/// A module that does Any Type.
public struct AnyModule: Sendable {
    
    public enum ModuleType: Sendable {
        case project(ProjectDescription.Project)
        case workspace(ProjectDescription.Workspace)
    }
    
    public let typeName: String
    public let module: ModuleType

    /// Initializes a module that does nothing.
    @inlinable
    public init(name: String, module: ModuleType) {
        self.typeName = name
        self.module = module
    }
}
