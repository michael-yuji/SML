import PackageDescription

let package = Package(
    name: "SMLKit",
    dependencies: [.Package(url: "https://github.com/michael-yuji/SXF97.git", versions: Version(0,0,0)..<Version(1,0,1))]
)
