import ProjectDescription

/// A Protocol for management configurations in one place
public protocol XCConfigTargetType: Hashable, CaseIterable, RawRepresentable where RawValue == String {
    /// Specify the configuration path.
    func path(for config: ConfigurationName) -> Path
}
