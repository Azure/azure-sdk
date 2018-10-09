# Engineering System

## Requirements
- Dashboard
  - Tracking status of all SDKs in all languages
- Repositories
  - One per language, or one per SDK per language?
  - Public and private versions of all repos
    - New service features under embargo
- Publishing
  - Nightly / per-checkin builds to publicly-available pre-release package stores
  - Official builds to package stores on-demand
  - Fast and easy to publish a subset of packages (down to a single package)
- Testing
  - Unit, Functional, Scenario
  - Performance
  - Stress
  - All tests can be run without connecting to Azure (or in a private fork)
  - Distributed runner to decrease test time
  - Test multiple SDK versions agains latest version of service
  - Detect if service deployments break SDK
    - Run tests frequently against live services (prod, canary, deployment pipeline)
    - Automatically open ICM incidents
  - Support different cloud instances
    - Public
    - National
    - Stack
  - Service virtualization
    - Record and replay service responses, so tests can run much faster and without connecting to Azure
    - Fault injection (simulate service error cases)
  - Code coverage
  - Breaking change detection
    - Service breaks SDK within ApiVersion
    - Service upgrades ApiVersion
    - Client API breaking change
- Documentation
  - Build and publish
  - Changelog generation
- Issue Management
  - Report issues not getting traction
  - Route issues from client to service teams
- Dependency management
  - Between components we own
  - Third-party libraries (e.g. JSON.NET)
  - Notification when newer third-party library is available
  - Notification for issues and securiity vulnerabilities in third-party libraries
- Standardization
  - Test frameworks
  - Dependencies
  - Versioning

## Infrastructure
- Azure DevOps
- Travis

## Support Policy
> Microsoft Azure Cloud Services will support no fewer than the latest two SDK versions for deploying new Cloud Services. Microsoft will provide notification 12 months before retiring a SDK in order to smooth the transition to a supported version.

The Microsoft Azure SDK policy covers Microsoft Azure SDK authoring tools, REST APIs, client libraries, command-line utilities, compute & storage emulators, and Azure Tools for Microsoft Visual Studio.

https://support.microsoft.com/en-gb/help/18486/lifecycle-faq-azure
