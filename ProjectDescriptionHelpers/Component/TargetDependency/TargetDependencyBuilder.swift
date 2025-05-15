import ProjectDescription

@resultBuilder
public struct TargetDependencyBuilder {
    @inlinable
    public static func buildBlock() -> [ProjectDescription.TargetDependency] {
        []
    }
    @inlinable
    public static func buildBlock(_ targets: TargetDependencyConvertable...) -> [ProjectDescription.TargetDependency] {
        targets.map { $0.build() }
    }
    @inlinable
    public static func buildBlock(_ targets: [TargetDependencyConvertable]) -> [ProjectDescription.TargetDependency] {
        targets.map { $0.build() }
    }
    @inlinable
    public static func buildOptional(_ wrapped: [TargetDependencyConvertable]?) -> [ProjectDescription.TargetDependency]? {
        wrapped?.map { $0.build() }
    }
}
