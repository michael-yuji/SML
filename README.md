# SML

## What is SML?

A way to write HTTP web content in swift and in a safe way. By using SML, applications written in swift can easily create and format HTTP webcontent with swift syntax. Since all SML are vaild swift code, it inherent the safeness of swift and can also integrate with normal swift code. Ultimately, generating dynamic web content in SML is as easy as generating string in swift.

### Syntax

Since in the end what SML generated is HTML string, therefore SML follows the tag-attribute-innerContent model of XML. Just like any XML and HTML file, everything is nested in tags. In SML, the general syntax of a tag with attributes and innerContent follows the syntax `tag(your_tag_name, attributes...) { "Inner content" }`, which innerContent can be either a String, another tag, or an array of tags. As you might noticed, since innerContent can be a String value, normal html text can mix with SML wihtout any Problem. For more detail, see Sources/main.swift.

### Usage

For demo, clone and cd into SML/ and use `make`, it should generate an exmaple temp.html

So far all SML application has to be compiled as executable or as a func in swift application. Since code is data in SML, and SML is basically just swift, so far there is no way to change the SML content without recompile the program/apps. It is suggested to run SML content as a separated process and pipe the SML output to parent application, or run SML as a standalone server.

### Future Development
The goal of SML is to become a replacement/alternative for php. In order to do that, SML content must be loadable. Consider the fact that swift can be use as a script language, this, hopefully, won't bee too hard.
