# SML

## What is SML?

A way to write HTTP web content in swift and in a safe way. By using SML, applications written in swift can easily create and format HTTP webcontent with swift syntax. Since all SML are vaild swift code, it inherent the safeness of swift and can also integrate with normal swift code. Ultimately, generating dynamic web content in SML is as easy as generating string in swift.

### Syntax

Since in the end what SML generated is HTML string, therefore SML follows the tag-attribute-innerContent model of XML. Just like any XML and HTML file, everything is nested in tags. In SML, the general syntax of a tag with attributes and innerContent follows the syntax `tag(your_tag_name, attributes...) { "Inner content" }`, which innerContent can be either a String, another tag, or an array of tags. As you might noticed, since innerContent can be a String value, normal html text can mix with SML wihtout any Problem. An example of SML is:

```swift
let myPage = html {[
        head() {[
            tag("title") { "This is a SML demo" },
            script("alert('Welcome to SML Demo!!!')")
        ]},
        body() {[
            tag("h1", style("color:darkorange")) {
                "Introducing SML, write structual/dynamic web content in a type safe way"
            },
            tag("h2") {
                "What is SML?"
            },
            tag("p") {[
                "SML is a swift package, any SML web content is valid swift code, thus can be use on everywhere swift can be use. It is Ruby on Rails of Swift, the major difference between ruby-on-rails, php and SML is that both ruby-on-rails and php are \"putting code inside html\", while SML is about \"putting html content inline with code\".", "</br>",
                "As a result, since swift is a fast, super-type-safe, compile time language, it guarantees that all tags are closed safely, guarantees no code injection counld happen (Of cause no guarantee for unsafe SQL use) and maximize performance.", "</br>",
            ]},
            tag("h2") {
                "How it works"
            },
            tag("p") {[
                "SMLKit, which is the package of this \("repo".link(url: "https://github.com/michael-yuji/SML.git")), has mainly two components. First is CoreSML. Which can found under /Sources/CoreSML.swift, it defined a dozens of functions which all ultimately generate normal swift String. These functions are the form of the SML syntax. You might find it comfusing just by reading this paragraph, therefore I'm highly recommanded you to read this (index.swift) file in code and everything should make sense.", "</br>",
                "This second part is an actual runtime. As I mensioned, SML can run as package you can import to other projects as well as a standalone application. The runtime is powered by SXF97/spartanX. Which is another two projects I worked simultaneously. All these three projects are in early development stage, therefore they might not be perfect.", "</br>",
                ]},
            tag("h2") {
                "I want to use it with NginX"
            },
            tag("p") {[
                "The SML runtime can run on top of tcp/ip layer with a port number, as well as unix domain socket (much more safe and isolated from outside world). You can specify them in the main.swift file. Please keep in mind that all unix domain socket of SML applications will have a form of [spartanX-yourApplicationsName]", "</br>", "</br>",
                "Click Me to see some dynamic sample!!!".link(url: "/dynamic")
            ]},
        ]}
    ]}
```

### Usage

For demo, clone and cd into SML/ and use `make`, it should generate an exmaple temp.html

So far all SML application has to be compiled as executable or as a func in swift application. Since code is data in SML, and SML is basically just swift, so far there is no way to change the SML content without recompile the program/apps. It is suggested to run SML content as a separated process and pipe the SML output to parent application, or run SML as a standalone server.

### Future Development
The goal of SML is to become a replacement/alternative for php. In order to do that, SML content must be loadable. Consider the fact that swift can be use as a script language, this, hopefully, won't bee too hard.
