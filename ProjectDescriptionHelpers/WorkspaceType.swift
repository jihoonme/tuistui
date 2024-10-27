import ProjectDescription

/// A workspace representation.
///
/// By default, `tuist generate` generates an Xcode workspace that has the same name as the current project.
/// It includes the project and all its dependencies.
///
/// Tuist allows customizing this behaviour by defining a workspace manifest within a `Workspace.swift` file.
/// Workspace manifests allow specifying a list of projects to generate and include in an Xcode workspace.
///
/// The snippet below shows an example workspace manifest:
///
/// ```swift
/// struct TuistApp: Module {
///    var body: some Module {
///        Workspace {
///            // The Path to manifest Projects
///        }
///    }
/// }
/// ```
/// additional workspace operations
///
/// ```swift
/// let workspace = TuistApp().module()
/// ```


public struct Workspace<Content>: Module where Content: PathConvertable {
    /// Allows workspace modifier to be made to a given Workspace Type.
    public let workspaceModifier = WorkspaceModifier()
    
    public init(@PathBuilder content: () -> [Content]) {
        workspaceModifier.projects = content().map { $0.build() }
    }
    
    public func module(_ name: String) -> Any {
        workspaceModifier.name = name
        return workspaceModifier.build()
    }

    public var body: Never {
        neverModule("Workspace")
    }
}

public extension Workspace {
    /// workspace scheme setting
    @inlinable
    func scheme(@SchemeBuilder scheme: () -> [ProjectDescription.Scheme]) -> Self {
        workspaceModifier.schemes = scheme()
        return self
    }
    /// workspace scheme setting
    @inlinable
    func scheme(_ scheme: [ProjectDescription.Scheme]) -> Self {
        workspaceModifier.schemes = scheme
        return self
    }
    /// workspace file Header Template setting
    @inlinable
    func fileHeaderTemplate(_ fileHeader: FileHeaderTemplate) -> Self {
        workspaceModifier.fileHeaderTemplate = fileHeader
        return self
    }
    /// workspace additional Files setting
    @inlinable
    func additionalFile(@FileElementBuilder additionalFile: () -> [FileElement]) -> Self {
        workspaceModifier.additionalFiles = additionalFile()
        return self
    }
    /// workspace additional Files setting
    @inlinable
    func additionalFile(_ additionalFile: [FileElement]) -> Self {
        workspaceModifier.additionalFiles = additionalFile
        return self
    }
    /// workspace generationOption setting
    @inlinable
    func generationOption(_ option: ProjectDescription.Workspace.GenerationOptions) -> Self {
        workspaceModifier.generationOptions = option
        return self
    }
}
