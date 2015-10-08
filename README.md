# Relative Path Converter

A simple CFC to translate an absolute path into a relative path for a given context.

## Installation
The easiest way to install is using CommandBox.  Simply type `box install relative-path-converter` to get going.

Alternatively, you can download a zip of the module and add it to your project.  Only the `RelativePathConverter.cfc` file is needed.

## Usage
There is a WireBox mapping out of the box.  Simply inject `RelativePathConverter` to use in your WireBox/ColdBox projects.

Create a new instance of the `RelativePathConverter`.  You can pass in an optional context.  (It defaults to the directory it is called in.)  You can change the context at any time by calling `setContext` passing in the new context.  The context you pass in will be ran through `ExpandPath`, so relative paths are okay here.

Convert an absolute path into a relative one by calling `convert` on the `RelativePathConverter` instance, passing in your absolute path.  If the absolute path doesn't exist, an exception will be thrown.  If a relative path is given, an exception will be thrown.