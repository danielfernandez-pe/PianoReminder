import Swinject

public enum Scope {
    case transient
    case graph
    case container
    case weak

    var swinjectScope: ObjectScope {
        switch self {
        case .transient:
            return .transient
        case .graph:
            return .graph
        case .container:
            return .container
        case .weak:
            return .weak
        }
    }
}

public protocol DICRegistering {
    func registerService<Service>(type: Service.Type, scope: Scope, factory: @escaping () -> Service)
    func registerService<Service, Arg1>(type: Service.Type, scope: Scope, factory: @escaping (Arg1) -> Service)
}

public protocol DICResolvering {
    func resolveService<Service>(_ type: Service.Type) -> Service
    func resolveService<Service, Arg1>(_ type: Service.Type, arg1: Arg1) -> Service
}

public protocol DICProtocol: DICRegistering, DICResolvering {}

// swiftlint:disable force_cast
public final class DIContainer: DICProtocol {
    public static let shared = DIContainer()

    private let container = Container()

    private init() {}

    public func registerService<Service>(type: Service.Type, scope: Scope, factory: @escaping () -> Service) {
        container.registerService(type: type, scope: scope, factory: factory)
    }
    
    public func registerService<Service, Arg1>(type: Service.Type, scope: Scope, factory: @escaping (Arg1) -> Service) {
        container.registerService(type: type, scope: scope, factory: factory)
    }

    public func resolveService<Service>(_ type: Service.Type) -> Service {
        container.resolveService(type)
    }

    public func resolveService<Service, Arg1>(_ type: Service.Type, arg1: Arg1) -> Service {
        container.resolveService(type, arg1: arg1)
    }
}

extension Container: DICProtocol {
    public func registerService<Service>(type: Service.Type, scope: Scope, factory: @escaping () -> Service) {
        self.register(type) { resolver in
            return factory()
        }
        .inObjectScope(scope.swinjectScope)
    }

    public func registerService<Service, Arg1>(type: Service.Type, scope: Scope, factory: @escaping (Arg1) -> Service) {
        self.register(type) { resolver, arg1 in
            return factory(arg1)
        }
        .inObjectScope(scope.swinjectScope)
    }
}

extension Resolver where Self: DICResolvering {
    public func resolveService<Service>(_ type: Service.Type) -> Service {
        self.resolve(type)!
    }

    public func resolveService<Service, Arg1>(_ type: Service.Type, arg1: Arg1) -> Service {
        self.resolve(type, argument: arg1)!
    }
}
// swiftlint:enable force_cast
