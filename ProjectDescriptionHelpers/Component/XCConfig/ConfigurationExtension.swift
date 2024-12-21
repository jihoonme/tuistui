import ProjectDescription

extension ProjectDescription.Configuration {

    /// Returns a debug configuration.
    ///
    /// - Parameters:
    ///   - target: The target of the configuration to use
    ///   - name: The name of the configuration to use
    ///   - settings: The base build settings to apply
    /// - Returns: A debug `CustomConfiguration`
    public static func debug(
        into target: some XCConfigTargetType,
        name configurationName: ConfigurationName,
        settings: SettingsDictionary = [:]
    ) -> ProjectDescription.Configuration {
        let xcconfigPath = Path.path("\(target.path.pathString)/\(configurationName.rawValue).xcconfig")
        return .debug(
            name: configurationName,
            settings: settings,
            xcconfig: xcconfigPath
        )
    }

    /// Returns a release configuration.
    ///
    /// - Parameters:
    ///   - target: The target of the configuration to use
    ///   - name: The name of the configuration to use
    ///   - settings: The base build settings to apply
    /// - Returns: A debug `CustomConfiguration`
    public static func release(
        into target: some XCConfigTargetType,
        name configurationName: ConfigurationName,
        settings: SettingsDictionary = [:]
    ) -> ProjectDescription.Configuration {
        let xcconfigPath = Path.path("\(target.path.pathString)/\(configurationName.rawValue).xcconfig")
        return .release(
            name: configurationName,
            settings: settings,
            xcconfig: xcconfigPath
        )
    }
}
