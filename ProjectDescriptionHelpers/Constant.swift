import ProjectDescription

/// Constant value Property wrapper
///
/// Used for Constant Management.
/// ```swift
///  @Constant var env = Constants()
/// ```
@propertyWrapper public struct Constant<ObjectType> where ObjectType: ModuleObject {
    private var value: ObjectType

    public init(wrappedValue: ObjectType) {
        self.value = wrappedValue
    }

    public var wrappedValue: ObjectType { value }

    public var projectedValue: Constant<ObjectType> {
        get { return self }
    }
}
