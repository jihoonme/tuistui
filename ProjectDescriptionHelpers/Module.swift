import ProjectDescription
/// A Protocol that describes how to evolve the current Module
///
/// The snippet below shows an example module:
///
/// ```swift
/// struct ExampleModule: Module {
///     var body: some Module {
///         ...
///     }
/// }
/// ```
///
public protocol Module {
    /// A type representing the body of this Module.
    associatedtype Body: Module

    /// Responsible for retrieving the name of the module.
    var typeName: String { get }

    /// Create `Project` or `Workspace`, including struct name
    func module(_ name: String) -> AnyModule

    /// The content and behavior of a module.
    @ModuleBuilder
    var body: Self.Body { get }
}

extension Never: Module {
    public var body: Never {
        fatalError()
    }
}

extension Module where Body: Module {
    @discardableResult
    @inlinable
    public func module(_ name: String = "") -> AnyModule {
        return self.body.module(typeName)
    }
}

extension Module {
    public var typeName: String {
        return String(describing: type(of: self))
    }
}

extension Module {
    /// Calls `fatalError` with an explanation that a given `type` is a primitive `Module`
    public func neverModule(_ type: String) -> Never {
        fatalError("\(type) is a primitive `Module`, you're not supposed to access its `body`.")
    }
}
