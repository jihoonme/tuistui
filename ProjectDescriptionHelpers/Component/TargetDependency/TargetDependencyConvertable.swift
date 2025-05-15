import ProjectDescription

/// Convert Target Dependency Type
public protocol TargetDependencyConvertable {
    func build() -> ProjectDescription.TargetDependency
}

extension ProjectDescription.TargetDependency: TargetDependencyConvertable {
    public func build() -> ProjectDescription.TargetDependency {
        self
    }
}
