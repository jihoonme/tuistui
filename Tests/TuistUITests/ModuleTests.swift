import XCTest
import ProjectDescription
@testable import TuistUI

final class ModuleTests: XCTestCase {
    struct MyAppModule: Module {
            var body: some Module {
                Project {
                    Target(name: "MyApp", destinations: .iOS, product: .app, bundleId: "io.jihoon.myapp")
                }
                .organizationName("jihoonme")
            }
        }

        func testTypeName() {
            let module = MyAppModule()
            XCTAssertEqual(module.typeName, "MyAppModule")
        }

        func testProjectModuleGeneration() {
            let module = MyAppModule()
            let anyModule = module.module()
            
            switch anyModule.module {
            case let .project(project):
                XCTAssertEqual(anyModule.typeName, "MyAppModule")
                XCTAssertEqual(project.organizationName, "jihoonme")
                XCTAssertEqual(project.targets.first?.name, "MyApp") // Target 이름 검증
            default:
                XCTFail("Expected a Project module")
            }
        }
        
        struct MyWorkspaceModule: Module {
            var body: some Module {
                Workspace {
                    ProjectDescription.Path.relativeToRoot("Projects/MyApp")
                }
                .generationOption(.options(enableAutomaticXcodeSchemes: true))
            }
        }

        func testWorkspaceModuleGeneration() {
            let module = MyWorkspaceModule()
            let anyModule = module.module()
            
            switch anyModule.module {
            case let .workspace(workspace):
                XCTAssertEqual(workspace.generationOptions, .options(enableAutomaticXcodeSchemes: true))
                XCTAssertEqual(workspace.projects.first, .relativeToRoot("Projects/MyApp"))
            default:
                XCTFail("Expected a Workspace module")
            }
        }
}
