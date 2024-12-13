![header](https://github.com/jihoonme/tuistui/assets/68891494/c1a2a5f4-0b11-40af-8590-3fd606d98c6f)

<p>
  <img src="https://img.shields.io/badge/Swift-5.9-f05318.svg" />
  <img src="https://img.shields.io/badge/tuist-plugin-blue.svg" />
  <img alt="GitHub" src="https://img.shields.io/github/license/jihoonme/tuistui">
</p>

TuistUI is Style Plugin for cooler use of Tuist.

## Installation

In order to tell Tuist you'd like to use TuistUI plugin in your project follow the instructions that are described in [Tuist documentation.](https://docs.tuist.io/plugins/using-plugins)

Add the plugin to `Config.swift`.

```swift
import ProjectDescription

let config = Config(
    plugins: [
        .git(url: "https://github.com/jihoonme/tuistui", tag: "vTAG")
    ]
)
```

## Documentation

The documentation for releases and `main` are available here:

- [`main`](https://jihoonme.github.io/tuistui/main/documentation/tuistui/)

## Using

Then import the `TuistUI` from thr location you want to use.

```swift
import TuistUI
```

#### Creating Project with TuistUI

```swift
struct BaseFeature: Module {
    var body: some Module {
        Project {
            /// Target Code
        }
        .organizationName("")
        .package {
            /// Package Code
        }
    }
}
```

additional operations

```swift
let project = BaseFeature().module()
```

#### Creating Workspace with TuistUI

```swift
struct TuistApp: Module {
    var body: some Module {
        Workspace {
            Path.relativeToRoot("Projects/App")
        }
        .scheme {
            /// Scheme Code
        }
    }
}
```

additional operations

```swift
let workspace = TuistApp().module()
```

### Constant management

`ModuleObject` can manage redundant parts of a project or workspace.

```swift
struct AppEnvironment: ModuleObject {
    static let organizationName: String = ""
    static let destinations: Destinations = .iOS
    static let deploymentTargets: DeploymentTargets = .iOS("15.0")
}
```

How to use within a module.

```swift
struct BaseProject: Module {
    @Constant var env = AppEnvironment()

    var body: Module {
        Project {
            // Target
        }
        .organizationName(env.organizationName)
    }
}
```

### Configuration management

Management configurations effectively using the `XCConfig` Protocol.

```swift
struct AppConfiguration: XCConfig {

    enum XCConfigTarget: String, XCConfigTargetType {
        case baseProject

        var path: Path {
            switch self {
            case .baseProject:
                return .relativeToRoot("XCConfig/baseProject")
            }
        }
    }

    var body: some XCConfigOf<Self> {
        Configure ({
            switch $0 {
            case .baseProject:
                return [
                    // Write Configuration Method
                ]
            }
        })
    }
}
```

Set the Deploy Target part of XCConfig.

```swift
enum XCConfigDeployTarget: String, XCConfigDeployTargetType {
    case dev = "DEV"
    case stage = "STAGE"
    case prod = "PROD"
} 
```

And use .debug(into:deploy:) method, .release(into:deploy:) method extended to ConfigurationName and make it easier to use

```swift
var body: some XCConfigOf<Self> {
    Configure ({
        switch $0 {
        case .A:
            return [
                .debug(into: $0, deploy: XCConfigDeployTarget.dev)
                .release(into: $0, deploy: XCConfigDeployTarget.prod)
            ]
        }
    })
}
```

How to use within a module.

```swift
struct BaseProject: Module {
    let config = AppConfiguration()

    var body: Module {
        Project {
            // Target
        }
        .settings(
            .settings(
                configurations: config.configure(into: .baseProject)
            )
        )
    }
}
```

## Templates
It is designed to accelerate project creation and workspace creation with templates.

```bash
$ tuist scaffold $(templateName) --path $(path) --name $(name)
```

<details>
  <summary> Template Name </summary>

- project
- workspace
</details>

#### Project Structure With TuistUI
Project File and Workplace File are gathered in one place to facilitate quick modifications.

Using `Project Template`
```
.
├── Projects
│   └── App
│     └── Project.swift //<- Project.swift file Generate
├── Tuist
│   ├── ProjectDescriptionHelpers
│     └── Projects
│       └── DemoProject.swift //<- DemoProject.swift file Generate
│   ├── Dependencies.swift
│   ├── Config.swift
│   └── Package.swift
└── README.md
```

Using `Workspace Template`
```
.
├── Projects
│   └── App
│     └── Workspace.swift //<- Workspace.swift file Generate
├── Tuist
│   ├── ProjectDescriptionHelpers
│     └── Workspace
│       └── DemoApp.swift //<- DemoApp.swift file Generate
│   ├── Dependencies.swift
│   ├── Config.swift
│   └── Package.swift
└── README.md
```

To modify the contents of a project and workspace, you only need to modify the ProjectDescription File, WorkspaceDescription File, which are clustered in the ProjectDescription Helper folder.

## License

**tuistui** is under MIT license. See the [LICENSE](https://github.com/jihoonme/tuistui/blob/main/LICENSE) file for more info.
