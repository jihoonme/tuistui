import ProjectDescription

/// A project representation.
///
/// A project manifest needs to be defined in a `Project.swift` manifest file.
/// Manifests need to import the framework ProjectDescription and TuistUI which contains all
///
/// The snippet below shows an example project manifest:
///
/// ```swift
/// struct ExameplProject: Module {
///    var body: some Module {
///        Project {
///            // Target Type
///        }
///    }
/// }
/// ```
///
/// additional project operations
///
/// ```swift
/// let project = ExameplProject().module()
/// ```

public struct Project<Content>: Module where Content: TargetConvertable {
    /// Allows project modifier to be made to a given Project Type.
    public let projectModifier = ProjectModifier()

    public init(@TargetBuilder content: () -> [Content]) {
        projectModifier.targets = content().map { $0.build() }
    }

    public func module(_ name: String) -> Any {
        projectModifier.name = name
        return projectModifier.build()
    }
    
    public var body: Never {
        neverModule("Project")
    }
}

public extension Project {
    /// project organization name Setting
    @inlinable
    func organizationName(_ name: String) -> Self {
        projectModifier.organizationName = name
        return self
    }
    /// project package setting
    @inlinable
    func package(@PackageBuilder packages: () -> [Package]) -> Self {
        projectModifier.packages = packages()
        return self
    }
    /// project package setting
    @inlinable
    func package(_ packages: [Package]) -> Self {
        projectModifier.packages = packages
        return self
    }
    /// project option setting
    @inlinable
    func option(options: ProjectDescription.Project.Options) -> Self {
        projectModifier.options = options
        return self
    }
    /// project scheme setting
    @inlinable
    func scheme(@SchemeBuilder scheme: () -> [ProjectDescription.Scheme]) -> Self {
        projectModifier.schemes = scheme()
        return self
    }
    /// project scheme setting
    @inlinable
    func scheme(_ scheme: [ProjectDescription.Scheme]) -> Self {
        projectModifier.schemes = scheme
        return self
    }
    /// project setting related settings
    @inlinable
    func settings(_ setting: Settings?) -> Self {
        projectModifier.settings = setting
        return self
    }
    /// project fileHeaderTemplate setting
    @inlinable
    func fileHeaderTemplate(_ fileHeader: FileHeaderTemplate) -> Self {
        projectModifier.fileHeaderTemplate = fileHeader
        return self
    }
    /// project additionalFiles setting
    @inlinable
    func additionalFile(@FileElementBuilder additionalFile: () -> [FileElement]) -> Self {
        projectModifier.additionalFiles = additionalFile()
        return self
    }
    /// project additionalFiles setting
    @inlinable
    func additionalFile(_ additionalFile: [FileElement]) -> Self {
        projectModifier.additionalFiles = additionalFile
        return self
    }
    /// project resourceSynthesizers setting
    @inlinable
    func resourceSynthesizer(_ resourceSynthesizer: [ResourceSynthesizer]) -> Self {
        projectModifier.resourceSynthesizers = resourceSynthesizer
        return self
    }
}
