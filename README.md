# firetype

## Goals

*firetype* is an Open Source Actionscript 3 library that parses OpenType fonts, converts the contained vector glyphs into polygon shapes and renders them using Stage3D via the GPU.

One of the examples for a similar technology would be [Scaleform](http://gameware.autodesk.com/scaleform) which is used in many big-budget productions to render hardware accelerated text and UI elements.

*firetype* aims to make similar functionality available for Actionscript 3 developers using Stage3D.

## How To Use *firetype*

### Table of Contents

* [Preliminaries](#preliminaries)
* [How Do I Display Text With *firetype*?](#how-do-i-display-text-with-firetype)
* [How Do I Apply Formatting to Texts?](#how-do-i-apply-formatting-to-texts)

### Preliminaries

As with any Stage3D project, you will need to set up a couple of things first. Basically, *firetype* expects the following things in order to run:

1. A [`Context3D`](http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/display3D/Context3D.html) object.
1. A [`Matrix3D`](http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/geom/Matrix3D.html) object containing a view/projection matrix.

You can get a quick overview of a basic document class using *firetype* by looking at [the code of the first firetype tutorial](https://github.com/MaxDidIt/firetype/blob/master/src/test/flash/de/maxdidit/hardware/font/FiretypeTutorial1.as).

### How Do I Display Text With *firetype*?

These are the basic steps needed to display text using *firetype*. You can find an implementation of this tutorial at [FiretypeTutorial1.as](https://github.com/MaxDidIt/firetype/blob/master/src/test/flash/de/maxdidit/hardware/font/FiretypeTutorial1.as).

Create a `HardwareText` object and pass it the `Context3D` object in the constructor.

```ActionScript
_hardwareText = new HardwareText(_context3d);
```

- - -

You can assign a `String` via the `text` property.

```ActionScript
_hardwareText.text = "Hello World!\nThis text is being rendered using firetype!";
```

- - -

You can set the position of the `HardwareText` object via the `x` and `y` properties. You can set the scale of the `HardwareText` with the `scaleX` and `scaleY` properties.

```ActionScript
_hardwareText.scaleX = _hardwareText.scaleY = 0.02;
_hardwareText.x = -320;
```

**Note:** *firetype* makes no assumptions about the scale you want to render the text in. It renders the characters with their original measurements, as they are stored in the font file. Because of this, a character is usually 500-1500 units tall. You will probably need to either scale down the `HardwareText` via the `scaleX` and `scaleY` properties or zoom out via the view/projection matrix.

- - -

In order to be rendered properly, the `HardwareText` object needs a projection matrix.

```ActionScript
_hardwareText.calculateTransformations(viewProjection, true);
```

The second parameter needs to be `true` to signal the `HardwareText` that it needs to recalculate it's transformations based on the matrix passed to it.

This function needs to be called everytime the view or projection changes.

- - -

Finally, we can render the text via the `HardwareCharacterCache` object stored in the `HardwareText`.

```ActionScript
_hardwareText.cache.render();
```

Running this code should result in an image similar to this:

![The text rendered with firetype.](http://www.max-did-it.com/projects/firetype/tutorial1_result.png)

### How Do I Apply Formatting to Texts?

You can apply different colors, sizes or alignments to sections of text by using the `<format>` tag.

You can find an implementation of this tutorial at [FiretypeTutorial1.as](https://github.com/MaxDidIt/firetype/blob/master/src/test/flash/de/maxdidit/hardware/font/FiretypeTutorial2.as).