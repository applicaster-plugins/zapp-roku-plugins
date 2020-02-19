# zapp-roku-plugins
Repo for Applicaster Roku plugins

## About

This repo contains public plugins which can be integrated, at build time into your roku apps built on applicaster's platform.

# Getting started

Our platform for third party development is currently in closed beta. Please contact our support team to gain early access to the tools and other sources required to develop your own plugins on roku.

# Application source structure.

## Overall project structure
As is the norm with scenegraph apps, there are two root sub-folders, `components` and `source`.

All plugin code is separated by the plugin id (i.e. zappifest identifier). This is for 2 reasons:

  1. Makes it easy for the developer to understand which code goes where

  2. Allows the app to only compile the required sources

## Tests

Plugin specific tests are found in `source/[PLUGIN_ID]/tests` folder. All plugin related test files should be self-contained in the plugin tests folder. Note, the tests will _not_ be deployed with the plugin, outside of a test build.

# Plugin processing

The application uses the plugin manifest (zappifest) and the source code when building the app, to ascertain when and how to instantiate your plugin.

There are a few key manifest fields which are used when ascertaining the role of your plugin:

| field | usage |
|---|---|
|identifiter|Becomes id, at runtime, and is used to locate your plugin sources. All your sources must be under `source/[PLUGIN_ID]` and  `components/[PLUGIN_ID]`|
|ui_builder_support|if true, indicates that the code creates a visual component which can be added to screen|
|api.class_name|This is the name of the component/ _brighterscript_ class to instantiate when creating your plugin at runtime. The name must match exactly.|
|api.interfaces|a string array of interface names see [below](#plugin-interfaces) indicating your plugins capabilities|

|api.require_startup_execution| if true, this indicates that the plugin will display a screen at startup time, the api.class_name, must be the name of the screen you will display see [below](#startup-plugins) for more info|

## creating visual components

You can create 2 types of visual components:

  - Screens
  - Components

To create a custom screen:

  1. Create a folder named `components/[ID_OF_YOUR_PLUGIN]` and create a new xml file that extends `ZUIBScreen` and implement your view.

  2. Create a VM class that extends `ZUIBScreenVM` and implement your desired functionality.

  3. Either wire your VM to the view using _maestro_ bindings (more info [here](https://github.com/georgejecook/maestro/blob/master/docs/index.md#XML-bindings) ), or using observers/callbacks


To create a custom component:

  1. Create a folder named `components/[ID_OF_YOUR_PLUGIN]` and create a new xml file that extends `ZUIBContent` and implement your view.

  2. Create a VM class that extends `ZUIBContentVM` and implement your desired functionality.

  3. Either wire your VM to the view using _maestro_ bindings (more info [here](https://github.com/georgejecook/maestro/blob/master/docs/index.md#XML-bindings) ), or using observers/callbacks

### Dynamic styling with power cell.

More info coming soon

### Component lifecycle and documentation

More info coming soon


## plugin interfaces

For non visual controls, you can mark your plugin with an interface, so as to register it with the relevant managers. In all cases, you must extend the relevant base classes/base components

The following interfaces are currently supported:

## startup plugins

You may wish to show a dialog screen, terms, a video preview, or login screen at app startup. To do this, set the following fields in your manifest:

| field| usage |
|---|---|
|api.require_startup_execution|set to true to indicate that the screen will be shown at startup|
|api.is_always_shown|if true, then the screen is always shown|
|custom_configuration_fields.registry_key|if your plugin contains a registry key such custom field, then this will be used to store the state of the screens's dismissal, and the screen will not be shown once the key is set. When the registry_key field is present, this process is automatically handled for you.|

