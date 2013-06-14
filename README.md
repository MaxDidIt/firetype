# firetype

## Goals

*firetype* is an Open Source Actionscript 3 library that parses OpenType fonts, converts the contained vector glyphs into polygon shapes and renders them using Stage3D via the GPU.

One of the examples for a similar technology would be [Scaleform](http://gameware.autodesk.com/scaleform) which is used in many big-budget productions to render hardware accelerated text and UI elements.

*firetype* aims to make similar functionality available for Actionscript 3 developers using Stage3D.

## How To Use *firetype*

### Table of Contents

[Preliminaries](#preliminaries)
[How Do I Display Text With *firetype*?](#how-do-i-display-text-with-firetype)

### Preliminaries

As with any Stage3D project, you will need to set up a couple of things first. Basically, *firetype* expects the following things in order to run:

1. A [`Context3D`](http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/display3D/Context3D.html) object.
1. A [`Matrix3D`](http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/geom/Matrix3D.html) object containing a view/projection matrix.

You can get a quick overview of a basic document class using *firetype* by looking at [the code of the first firetype tutorial](https://github.com/MaxDidIt/firetype/blob/master/src/test/flash/de/maxdidit/hardware/font/FiretypeTutorial1.as).

### How Do I Display Text With *firetype*?

These are the basic steps needed to display text using *firetype*. You can find a document class implementing this tutorial at [FiretypeTutorial1.as](https://github.com/MaxDidIt/firetype/blob/master/src/test/flash/de/maxdidit/hardware/font/FiretypeTutorial1.as).

Create a `HardwareText` object and pass it the `Context3D` object in the constructor.

```ActionScript
_hardwareText = new HardwareText(_context3d);
```

You can assign a `String` via the `text` property.

```ActionScript
_hardwareText.text = "Hello World!\nThis text is being rendered using firetype!";
```

You can set the position of the `HardwareText` object via the `x` and `y` properties.

```ActionScript
_hardwareText.x = -16000;
```

In order to be rendered properly, the `HardwareText` object needs a projection matrix. The second parameter needs to be `true` to signal the `HardwareText` that it needs to recalculate it's transformations based on the matrix passed to it.

```ActionScript
_hardwareText.calculateTransformations(viewProjection, true);
```

This function needs to be called everytime the view or projection changes.

**Note:** *firetype* makes no assumptions about the scale you need to render the text in. It renders the characters with their original measurements, as they are stored in the font file. This means that a character is usually 500-1500 units tall. Because of this, you will probably to either scale down the `HardwareText` via the `scaleX` and `scaleY` properties or zoom out via the view/projection matrix.

Finally, we can render the text via the `HardwareCharacterCache` object stored in the `HardwareText`.

```ActionScript
_hardwareText.cache.render();
```