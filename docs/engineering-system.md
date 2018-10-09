# Engineering System

## Requirements
1. Dashboard
    1. Tracking status of all SDKs in all languages
1. Repositories
    1. One per language, or one per SDK per language?
    1. Public and private versions of all repos
        1. New service features under embargo
1. Publishing
    1. Nightly / per-checkin builds to publicly-available pre-release package stores
    1. Official builds to package stores on-demand
    1. Fast and easy to publish a subset of packages (down to a single package)
1. Testing
    1. Unit, Functional, Scenario
    1. Performance
    1. Stress
    1. All tests can be run without connecting to Azure (or in a private fork)
    1. Distributed runner to decrease test time
    1. Test multiple SDK versions agains latest version of service
    1. Detect if service deployments break SDK
        1. Run tests frequently against live services (prod, canary, deployment pipeline)
        1. Automatically open ICM incidents
    1. Support different cloud instances
        1. Public
        1. National
        1. Stack
    1. Service virtualization
        1. Record and replay service responses, so tests can run much faster and without connecting to Azure
        1. Fault injection (simulate service error cases)
    1. Code coverage
    1. Breaking change detection
        1. Service breaks SDK within ApiVersion
        1. Service upgrades ApiVersion
        1. Client API breaking change
1. Documentation
    1. Build and publish
    1. Changelog generation
1. Issue Management
    1. Report issues not getting traction
    1. Route issues from client to service teams
1. Dependency management
    1. Between components we own
    1. Third-party libraries (e.g. JSON.NET)
    1. Notification when newer third-party library is available
    1. Notification for issues and securiity vulnerabilities in third-party libraries
1. Standardization
    1. Test frameworks
    1. Dependencies
    1. Versioning
