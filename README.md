# firetype

## Table of Contents

* [Goals](#goals)
* [What Does *firetype* Do?](#what-does-firetype-do)
* [How Do I Use *firetype*?](#how-do-i-use-firetype)

## Goals

*firetype* is an Open Source Actionscript 3 library that parses OpenType fonts, converts the contained vector glyphs into polygon shapes and renders them using Stage3D via the GPU.

One of the examples for a similar technology would be [Scaleform](http://gameware.autodesk.com/scaleform) which is used in many big-budget productions to render hardware accelerated text and UI elements.

*firetype* aims to make similar functionality available for Actionscript 3 developers using Stage3D.

## What Does *firetype* Do?

*firetype*

## How Do I Use *firetype*?

### Table of Contents

* [Preliminaries](#preliminaries)
* [How Do I Display Text With *firetype*?](#how-do-i-display-text-with-firetype)
* [How Do I Apply Formatting to Texts?](#how-do-i-apply-formatting-to-texts)
* [How Can I Define a Text Format And Use It Several Times?](#how-can-i-define-a-text-format-and-use-it-several-times)
* [How Can I Set The Font of a Text?](#how-can-i-set-the-font-of-a-text)
* [How Can I Embed a Font?](#how-can-i-embed-a-font)
* [How Do I Control the Level of Detail of Characters?](#how-do-i-control-the-level-of-detail-of-characters)
* [How Should I Handle Longer Texts?](#how-should-i-handle-longer-texts)
* [How Should I Handle Multiple Texts?](#how-should-i-handle-multiple-texts)

### Preliminaries

As with any Stage3D project, you will need to set up a couple of things first. Basically, *firetype* expects the following things in order to run:

1. A [`Context3D`](http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/display3D/Context3D.html) object.
1. A [`Matrix3D`](http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/geom/Matrix3D.html) object containing a view/projection matrix.

You can get a quick overview of a basic document class setting up Stage3D and using *firetype* by looking at [the code of the first firetype tutorial](https://github.com/MaxDidIt/firetype/blob/master/src/test/flash/de/maxdidit/hardware/font/FiretypeTutorial1.as).

### How Do I Display Text With *firetype*?

These are the basic steps needed to display text using *firetype*. You can find an implementation of this tutorial at [FiretypeTutorial1.as](https://github.com/MaxDidIt/firetype/blob/master/src/test/flash/de/maxdidit/hardware/font/FiretypeTutorial1.as).

Create a `HardwareText` object and pass it the `Context3D` object in the constructor.

```ActionScript
_hardwareText = new HardwareText(_context3d);
```

You can assign a `String` via the `text` property.

```ActionScript
_hardwareText.text = "Hello World!\nThis text is being rendered using firetype!";
```

You can set the position of the `HardwareText` object via the `x` and `y` properties. You can set the scale of the `HardwareText` with the `scaleX` and `scaleY` properties.

```ActionScript
_hardwareText.scaleX = _hardwareText.scaleY = 0.02;
_hardwareText.x = -320;
```

**Note:** *firetype* makes no assumptions about the scale you want to render the text in. It renders the characters with their original measurements, as they are stored in the font file. Because of this, a character is usually 500-1500 units tall. You will probably need to either scale down the `HardwareText` via the `scaleX` and `scaleY` properties or zoom out via the view/projection matrix.

In order to be rendered properly, the `HardwareText` object needs a projection matrix.

```ActionScript
_hardwareText.calculateTransformations(viewProjection, true);
```

The second parameter needs to be `true` to signal the `HardwareText` that it needs to recalculate it's transformations based on the matrix passed to it.

This function needs to be called everytime the view or projection changes.

Finally, we can render the text via the `HardwareCharacterCache` object stored in the `HardwareText`.

```ActionScript
_hardwareText.cache.render();
```

Running this code should result in an image similar to this:

![The text rendered with firetype.](http://www.max-did-it.com/projects/firetype/tutorial1_result.png)

### How Do I Apply Formatting to Texts?

You can apply different colors, sizes or alignments to your text in two ways.
You can set a property globally via the `standardFormat` property of the `HardwareText`:
If you change any property of the `standardFormat` object after `text` has been set, you will need to call the `flagForUpdate` method of the `HardwareText` object to apply the changes. The only property you don't have to do this for is the `color` property.

```ActionScript
_hardwareText.standardFormat.color = 0x333333;
```

Or you can change the appeareance of sections of your text by using the `<format>` tag. 
```Actionscript
_hardwareText.text = "Just <format color='0x666666'>like</format> this.";
```
The `<format>` tag can be nested into other `<format>` tags. The attributes used in the tag will override the respective values of the `standardFormat` or of the enclosing `<format>` tag. The values of attributes have to be put either into single or double quotation marks.

The basic format attributes are
* `color`
* `scale`
* `shearX`
* `shearY`
* `textAlign`

You can find an implementation of this tutorial at [FiretypeTutorial2.as](https://github.com/MaxDidIt/firetype/blob/master/src/test/flash/de/maxdidit/hardware/font/FiretypeTutorial2.as).

You can change the text color with the **color** attribute. The value is either passed as an RGB or ARGB hexadecimal number.
```ActionScript
_hardwareText.text = "You can <format color='0xFF6611'>change the text color</format> with the " + 
					"<format color='0xFF0000'>color</format> attribute.";
```
![The text rendered with firetype.](http://www.max-did-it.com/projects/firetype/tutorial2_result2.png)

You can scale sections of a text with the **scale** attribute. The value is expected to be a floating point number.
```ActionScript
_hardwareText.text = "You can <format scale='0.66'>scale sections of a text</format> with the " + 
					"<format color='0xFF0000'>scale</format> attribute.";
```
![The text rendered with firetype.](http://www.max-did-it.com/projects/firetype/tutorial2_result1.png)

You can slant a portion of text with the **shearX** attribute. You can slant individual characters along the Y axis with the **shearY** attributes. Both attributes expect floating point numbers as values.
```ActionScript
_hardwareText.text = "You can <format shearX='0.3'>slant a portion of a text</format> with the " + 
					"<format color='0xFF0000'>shearX</format> attribute.";
```
![The text rendered with firetype.](http://www.max-did-it.com/projects/firetype/tutorial2_result3.png)

```ActionScript
_hardwareText.text = "<format textAlign='" + TextAlign.RIGHT + "'>You can set the text alignment " +
					"with the <format color='0xFF0000'>textAlign</format> attribute. You should use " + 
					"the constants of the TextAlign class as values for the attribute.\n</format>";
```
![The text rendered with firetype.](http://www.max-did-it.com/projects/firetype/tutorial2_result5.png)

### How Can I Define a Text Format And Use It Several Times?

Instead of duplicating the same format attributes over and over again, you can define a `HardwareTextFormat` object once and set the properties there. You can find an implementation of this tutorial at [FiretypeTutorial3.as](https://github.com/MaxDidIt/firetype/blob/master/src/test/flash/de/maxdidit/hardware/font/FiretypeTutorial3.as).

```ActionScript
var textFormatEmphasis:HardwareTextFormat = new HardwareTextFormat();
textFormatEmphasis.color = 0xFF0000;
textFormatEmphasis.shearX = 0.3;
textFormatEmphasis.scale = 1.1;
textFormatEmphasis.id = "emphasis";
```

The most important property here is `id`. This value must be set in order to use the text format in the `format` tag.

In order to use this text format, we need to register it with the cache of the `HardwareText`.

```ActionScript
_hardwareText.cache.textFormatMap.addTextFormat(textFormatEmphasis);
```

We can now reference the text format in any `format` tag by using the `id` attribute.

```ActionScript
_hardwareText.text = "Lorem ipsum dolor sit amet, <format id='emphasis'>consectetur</format> adipiscing " + 
					"elit. Sed facilisis <format id='emphasis'>lacus nec sollicitudin</format> fermentum. " + 
					"Vivamus urna mi, fringilla eu diam ac, lobortis bibendum mi. " + 
					"<format id='emphasis'>Vestibulum laoreet</format> augue id ligula ullamcorper, " + 
					"sit amet malesuada diam tincidunt.";
```

![The text rendered with firetype.](http://www.max-did-it.com/projects/firetype/tutorial3.png)
					
You can also use the usual attributes in a `format` tag referencing an `id`. The attributes will override the respective properties of the referenced `HardwareTextFormat`.

If you change any property of the `HardwareText` object after `text` has been set, you will need to call the `flagForUpdate` method of the `HardwareText` object to apply the changes. The only property you don't have to do this for is the `color` property.

### How Can I Set The Font of a Text?

Before you can use a different font than the default, you will have to load and parse an OpenType font file. In *firetype*, you will use the `OpenTypeParser` class for this. You can find an implementation of this tutorial at [FiretypeTutorial4.as](https://github.com/MaxDidIt/firetype/blob/master/src/test/flash/de/maxdidit/hardware/font/FiretypeTutorial4.as).

```ActionScript
var openTypeParser:OpenTypeParser = new OpenTypeParser();
openTypeParser.loadFont("newscycle-bold.ttf").addEventListener(FontEvent.FONT_PARSED, handleFontParsed);
```

`OpenTypeParser` will consecutively load and parse font files passed to it. You can add the event listener reacting to a completed font at two points:
* To the `IEventDispatcher` object returned by the `loadFont` function. The event handler will only be called when this specific font is completed.
* To the `OpenTypeParser` object itself. In this case, the event handler will be called for each font that the parser completes.

In the event handler, we can assign the loaded font to the `standardFormat` property to apply it to the entire text.

```ActionScript
private function handleFontParsed(e:FontEvent):void 
{
	_hardwareText.standardFormat.font = e.font;
	_hardwareText.flagForUpdate();
}
```

![The text rendered with firetype.](http://www.max-did-it.com/projects/firetype/tutorial4.png)

If the the `text` property of the `HardwareText` object had been set before this, you will need to call the `flagForUpdate` method to apply the changes in the `standardFormat` property.

You can also change the font in certain sections of text. To do that, you will have to register the font with the cache used by the `HardwareText` object first.

```ActionScript
_hardwareText.cache.fontMap.addFont(e.font);
```

Then, you can set the `font` attribute in the `format` tag to reference the loaded font file. The value of the `format` attribute has to be the same as the `uniqueIdentifier` property of the referenced font. The easiest way to do this is to directly include the `uniqueIdentifier` value in the string.

```ActionScript
_hardwareText.text = "Lorem ipsum dolor sit amet, <format font='" + e.font.uniqueIdentifier + "'>consectetur " + 
					"adipiscing elit</format>. Sed facilisis lacus nec sollicitudin fermentum. Vivamus urna mi, " + 
					"fringilla eu diam ac, lobortis bibendum mi. <format font='" + e.font.uniqueIdentifier + "'>" +
					"Vestibulum laoreet augue</format> id ligula ullamcorper, sit amet " + 
					"<format font='" + e.font.uniqueIdentifier + "'> malesuada diam</format> tincidunt.";
```

![The text rendered with firetype.](http://www.max-did-it.com/projects/firetype/tutorial4a.png)

### How Can I Embed a Font?

You can embed font files as byte arrays and directly parse them with `OpenTypeParser` instead of loading them from a remote location. You can find an implementation of this tutorial at [FiretypeTutorial5.as](https://github.com/MaxDidIt/firetype/blob/master/src/test/flash/de/maxdidit/hardware/font/FiretypeTutorial5.as).

When embedding the font file, make sure that you set the `mimeType` to *"application/octet-stream"*;

```ActionScript
[Embed(source="../../../../../resources/fonts/newscycle/newscycle-bold.ttf", mimeType="application/octet-stream")]
private static const fontNewsCycleBoldData : Class;
```

You can then instantiate the embedded data as a byte array and pass it to the `parseFont` function of an `OpenTypeParser` object.

```ActionScript
var openTypeParser:OpenTypeParser = new OpenTypeParser();
var font:HardwareFont = openTypeParser.parseFont(new fontNewsCycleBoldData() as ByteArray);
```

Then, you can simply pass the font to the `standardFormat` property or use it in a `format` tag as described in [How Can I Set The Font of a Text?](#how-can-i-set-the-font-of-a-text).

### How Do I Control the Level of Detail of Characters?

*firetype* converts the vector data of characters in a font to polygons. The `vertexDistance` attribute controls the amount of polygons that are generated to display the character. Higher values for `vertexDistance` will cause the vertices of the triangulated character to be further away from each other, resulting in fewer polgons. Lower values will result in more polygons and smoother edges.

![The text rendered with firetype.](http://www.max-did-it.com/projects/firetype/precision400.png)
![The text rendered with firetype.](http://www.max-did-it.com/projects/firetype/precision200.png)
![The text rendered with firetype.](http://www.max-did-it.com/projects/firetype/precision100.png)
![The text rendered with firetype.](http://www.max-did-it.com/projects/firetype/precision50.png)

**Note:** Try to use as few different `vertexDistance` values as possible. Using many different values for larger text sections each will result in higher memory and graphics card memory requirements.

You can use the `vertexDistance` attribute with `HardwareTextFormat` objects or with the `format` tag.

```ActionScript
_hardwareText.text = "You can make characters appear\n<format scale='1.5' vertexDistance='3000'>edged</format> " + 
					"(vertexDistance='3000') or\n<format scale='1.5' vertexDistance='50'>smooth</format> " +
					"(vertexDistance='50') with the <format color='0xFF0000'>vertexDistance</format> attribute. " + 
					"Lower vertexDistance values will have an impact on performance.";
```
![The text rendered with firetype.](http://www.max-did-it.com/projects/firetype/tutorial2_result4.png)

### How Should I Handle Longer Texts?

You can find an implementation of this tutorial at [FiretypeTutorial6.as](https://github.com/MaxDidIt/firetype/blob/master/src/test/flash/de/maxdidit/hardware/font/FiretypeTutorial6.as).

*firetype* renders the characters of a text via it's `HardwareCharacterCache`, which is accessible via the `cache` property.

By default, the cache of a `HardwareText` object uses `SingleGlyphRenderer` objects to render it's contents. This type of renderer will use one draw call per character.

Characters rendered after one draw call:
![The text rendered with firetype.](http://www.max-did-it.com/projects/firetype/tutorial6a_1.png)
Characters rendered after two draw calls:
![The text rendered with firetype.](http://www.max-did-it.com/projects/firetype/tutorial6a_2.png)
Characters rendered after three draw calls:
![The text rendered with firetype.](http://www.max-did-it.com/projects/firetype/tutorial6a_3.png)

It's advisable for longer texts with many characters in them to use a `BatchedGlyphRenderer`. This type of renderer will try to collect as many characters of the same type into one draw call.

Characters rendered after one draw call:
![The text rendered with firetype.](http://www.max-did-it.com/projects/firetype/tutorial6b.png)

This speeds up the render process considerably. However, the trade-off of this renderer is that it needs a several times the memory the `SingleGlyphRenderer` requires. Try to use this type of renderer only as often as you really need.

To use the `BatchedGlyphRenderer`, you will have to initialize the `HardwareCharacterCache` yourself and pass it to the `HardwareText` object.

```ActionScript
var cache:HardwareCharacterCache = new HardwareCharacterCache(new BatchedGlyphRendererFactory(_context3d, new EarClippingTriangulator()));
_hardwareText = new HardwareText(null, cache);
```

The `HardwareCharacterCache` constructor receives a `BatchedGlyphRendererFactory` object as parameter. The factory object requires a valid `Context3D` object and an ITriangulator object. *firetype* comes with the EarClippingTriangulator class, which implements the ITriangulator interface.

The cache object is passed as a parameter to the `HardwareText` constructor. If you explictly pass a `HardwareCharacterCache` object to `HardwareText`, then the first parameter can be null.

### How Should I Handle Multiple Texts?

You can save considerable amounts of memory and even rendering time by using the same `HardwareCharacterCache` object for several texts, especially if the texts share fonts and vertex distance values. You can find an implementation of this tutorial at [FiretypeTutorial7.as](https://github.com/MaxDidIt/firetype/blob/master/src/test/flash/de/maxdidit/hardware/font/FiretypeTutorial7.as).

By assigning the same cache object to several objects you can prevent that the same characters are converted to polygon objects and stored in memory several times.

```ActionScript
_cache = new HardwareCharacterCache(new BatchedGlyphRendererFactory(_context3d, new EarClippingTriangulator()));
_hardwareText1 = new HardwareText(null, _cache);
_hardwareText2 = new HardwareText(null, _cache);
```