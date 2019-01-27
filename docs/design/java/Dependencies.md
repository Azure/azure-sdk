# External Dependencies

Each dependency we add to an SDK component increases its weight, and so it should be done with caution and careful consideration. Also, for every dependency we add, we increase the risk of having classpath collisions and dependency versioning issues.

A parent POM lists a large number of dependencies, specified as a combination of a single Maven `groupId`, `artifactId`, and `version`. When individual SDK projects depend on this parent POM, they no longer have to specify the version number for their dependencies, as these will instead be inferred from the parent POM. This means that all projects that depend on this parent POM, assuming they specify no versions in their own POM files, will be consistently using the same version. In doing so, we can avoid many of the pitfalls of dependency management, affectionately referred to in Java parlance as 'classpath hell'.

It is important to note that the parent POM does have many more dependencies listed in it than any one SDK component may require to build and run. This is OK - it is designed to be the superset of all dependencies for all children project. Therefore, it does not mean that all dependencies are added to the project. A parent POM should be thought of as simply a map of (Maven `groupId` + Maven `artifactId`) to Maven `version` number, and nothing more.

We do not intend to 'lead the pack' and always update to the latest version of all dependencies. We will instead be fast followers by observing community preferences, keeping ourselves informed of where the wider Java community stands on versioning and keeping in step with that.

Every dependency we have must be listed in the table below. The only exception is for dependencies that are extensions of the dependencies list below (for example, okhttp-urlconnection).

## Adding or Updating a Dependency

Sometimes a new library, or an update to an existing library, is released, which may be beneficial to one or more of our SDK components. Because dependency versions must be centralized through the parent POM, all new depenendencies must be handled in a consistent manner. Developers must submit new dependencies, or updates to existing dependency versions, into the parent POM by way of a pull request. It will be swiftly reviewed by the relevant people, discussed, and a decision will then be made.

## Runtime Dependencies

| Name              | Role               | Version | License | Internal / External | Status |
|-------------------|--------------------|---------|---------|---------------------|--------|
| Project Reactor   | Reactive library   | 3.2.3   | Apache  | External            | Awaiting review |
| Slf4j             | Logging Framework  | 1.7.25  | MIT     | Internal            | Investigating - what wrapped impl will we use? |
| Netty             | HTTP client        | 4.1.32  | Apache  | Internal            |        |
| Jackson           | REST client        | 2.9.7   | Apache  | Internal            | Need to understand schedule for Jackson 3 release (baselined on JDK 8) |

## Compile-time Dependencies, Testing, and Tools

| Name       | Role                                | Version | License                   | Internal / External | Status |
|------------|-------------------------------------|---------|---------------------------|---------------------|--------|
| JUnit      | Unit test framework                 | 5       | Eclipse Public License    | Internal            |        |
| CheckStyle | Code style reporting framework      | 8.15    | LGPL                      | Internal            |        |
| SpotBugs   | Code issues reporting framework     | 3.1.8   | LGPL                      | Internal            |        |
| Jacoco     | Test coverage reporting framework   | 0.8.2   | GPL + Classpath exception | Internal            |        |

## Libraries to try and remove

Listed below are dependencies that we should consider removing over time:

- Google Guava
- Jodatime / ThreeTen date / time library
- RxJava
- Apache commons-lang
- Apache commons-codec
- OkHttp / Okio
- Retrofit