# ![firetype](http://www.max-did-it.com/wp-content/uploads/2013/06/logo.png)

Please help me to maintain *firetype*. If you found *firetype* useful or used it in one of your products, consider making a donation:
[![Donate](https://www.paypalobjects.com/en_US/i/btn/btn_donate_LG.gif)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=3JXFXD3YAVN42)

## Table of Contents

* [License](#license)
* [Where Do I Get *firetype*?](#where-do-i-get-firetype)
* [What Does *firetype* Do?](#what-does-firetype-do)
* [Advantages](#advantages)
* [Drawbacks](#drawbacks)
* [How Do I Use *firetype*?](#how-do-i-use-firetype)
* [Where Can I Find the *firetype* API Documentation?](#where-can-i-find-the-firetype-api-documentation)

## License

*firetype* is free software: you can redistribute it and/or modify 
it under the terms of the GNU Lesser General Public License as published by 
the Free Software Foundation, either version 3 of the License, or 
(at your option) any later version. 
  
*firetype* is distributed in the hope that it will be useful, 
but WITHOUT ANY WARRANTY; without even the implied warranty of 
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the 
GNU Lesser General Public License for more details. 
 
You can find a copy of the GNU Lesser General Public License 
along with *firetype* in the LICENSE.md file or at [http://www.gnu.org/licenses/](http://www.gnu.org/licenses/). 

## Where Do I Get *firetype*?

[Download firetype-1.6.0.swc](http://bit.ly/1e7Zq7C)
- [Closed #5](https://github.com/MaxDidIt/firetype/issues/5): You can now set the `HardwareCharacterCache` used by `FiretypeStarlingTextField`. Either pass a `cache` as a parameter to the constructor or set the respective `cache` property.
- [Closed #6](https://github.com/MaxDidIt/firetype/issues/6): `HardwareCharacterCache` can now explictly cache characters from a String. This can be used to pre-cache characters during the initialization of the application. Use either the `cacheHardwareCharacters` or `cacheHardwareCharactersByTextFormat` functions to let a `HardwareCharacterCache` explicitly cache characters.
- [Fixed #7](https://github.com/MaxDidIt/firetype/issues/7): Fixed a bug in `HardwareCharacterCache` where adding new characters after invalidating the cache would overwrite old characters. This caused render glitches when changing the text of a `HardwareText` object unless the `HardwareCharacterCache` was cleared each time. This is not necessary anymore.
- [Fixed #8](https://github.com/MaxDidIt/firetype/issues/8): The `width` and `height` properties of `FiretypeStarlingTextField` are now updated correctly.
- [Closed #9](https://github.com/MaxDidIt/firetype/issues/9): Implemented layouting without caching for faster text dimensions measurement. The `update` method of `HardwareText` and `FiretypeStarlingTextField` now accept a Boolean parameter indicating whether glyphs should be cached or only layouting should be performed.
- `HardwareText` and `FiretypeStarlingTextField` now exposes the textWidth and textHeight properties which store the measured dimensions of the contained, layouted text.

*****

[Download firetype-1.5.1.swc](http://bit.ly/1dFbhd4)
- Added basic Starling Framework integration. See [How Do I Use *firetype* With Starling?](#how-do-i-use-firetype-with-starling).

*****

[Download firetype-1.4.0.swc](http://bit.ly/1adyG99)
- Texts can now be rendered with outlines. (As of this version, this feature still has minor issues. See [How Do I Render Texts With Outlines?](#how-do-i-render-texts-with-outlines)).

*****

[Download firetype-1.3.0.swc](http://bit.ly/10xoZfa)
- API change: SingleGlyphRenderer, BatchedGlyphRenderer, SingleGlyphRendererFactory and BatchedGlyphRendererFactory don't require an ITriangulator parameter anymore.

*****

[Download firetype-1.2.5.swc](http://www.max-did-it.de/projects/firetype/firetype-1.2.5.swc)

## What Does *firetype* Do?

*firetype* is an Open Source Actionscript 3 library that parses OpenType fonts, converts the contained vector glyphs into polygon shapes and renders them using Stage3D via the GPU.

![The text rendered with firetype.](http://www.max-did-it.com/projects/firetype/steps.png)

One example for a similar technology would be [Scaleform](http://gameware.autodesk.com/scaleform) which is used in many big-budget productions to render hardware accelerated text and UI elements.

*firetype* aims to make similar functionality available for Actionscript 3 developers using Stage3D.

Check out the [**live demo**](http://www.max-did-it.com/projects/firetype/) showing firetype in action.
	
## Advantages

### Resolution Independence

One major advantage of using firetype is that it makes it easier to handle the resolutions of different versions of your Flash or AIR application.

You can arbitrarily scale the texts without worrying about texture resolutions or the performance impact of software rendering on mobile devices.

### Rendering Does Not Have Any Impact On CPU Performance</h3>

Each character handled by firetype is rendered entirely on the graphics hardware. This makes it several magnitudes faster than classic software rendered text objects in Flash.

This can be especially interesting for mobile devices, where rendering via the CPU can noticeably slow down performance.

### Only Renders Pixels Actually Occupied By Characters</h3>

When rendering texts with the help of textures, there are usually significant amounts of transparent space between lines and characters which still cause calls to the pixel shader and texture lookups for each pixel.

This is not an issue with firetype. Since characters are polygon objects, only pixels actually covered by the triangles are rendered.

## Drawbacks

### Moving Texts Still Impacts CPU Performance

While rendering does not cause any calculations on the processor, moving any text in firetype requires the transformation matrices of each character to be recalculated.

In my experience, this still takes up only a fraction of your CPU budget in a frame. However, due to this firetype is basically on par with software rendered texts which have been cached as bitmaps.

firetype still wins if you scale or rotate said texts.

### Noticable Lag When Initializing the First Text

firetype caches the polygon data of any character that has been already used.

The first text that you render with a certain font and level of detail will cause firetype to cache each character it encounters for the first time.

This can cause a short lag, which should be below a second in duration, but is still noticeable.

Every subsequent text using the same font and level of detail should cause no lag at all.

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
* [How Do I Render Texts With Outlines?](#how-do-i-render-texts-with-outlines)
* [How Do I Use *firetype* With Starling?](#how-do-i-use-firetype-with-starling)

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

One way is to set a property globally via the `standardFormat` property of the `HardwareText`.

If you change any property of the `standardFormat` object after `text` has been set, you will need to call the `flagForUpdate` method of the `HardwareText` object to apply the changes. The only property you don't have to do this for is the `color` property.

```ActionScript
_hardwareText.standardFormat.color = 0x333333;
```

The other way you can change the appearance of sections of your text by using the `<format>` tag. 
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

By default, the cache of a `HardwareText` object uses `SingleGlyphRenderer` objects to render its contents. This type of renderer will use one draw call per character.

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
var cache:HardwareCharacterCache = new HardwareCharacterCache(new BatchedGlyphRendererFactory(_context3d));
_hardwareText = new HardwareText(null, cache);
```

The `HardwareCharacterCache` constructor receives a `BatchedGlyphRendererFactory` object as parameter. The factory object requires a valid `Context3D` object.

The cache object is passed as a parameter to the `HardwareText` constructor. If you explictly pass a `HardwareCharacterCache` object to `HardwareText`, then the first parameter can be null.

### How Should I Handle Multiple Texts?

You can save considerable amounts of memory and even rendering time by using the same `HardwareCharacterCache` object for several texts, especially if the texts share fonts and vertex distance values. You can find an implementation of this tutorial at [FiretypeTutorial7.as](https://github.com/MaxDidIt/firetype/blob/master/src/test/flash/de/maxdidit/hardware/font/FiretypeTutorial7.as).

By assigning the same cache object to several objects you can prevent that the same characters are converted to polygon objects and stored in memory several times.

```ActionScript
_cache = new HardwareCharacterCache(new BatchedGlyphRendererFactory(_context3d));
_hardwareText1 = new HardwareText(null, _cache);
_hardwareText2 = new HardwareText(null, _cache);
```

### How Do I Render Texts With Outlines?

You can find an implementation of this tutorial at [FiretypeTutorial6.as](https://github.com/MaxDidIt/firetype/blob/master/src/test/flash/de/maxdidit/hardware/font/FiretypeTutorial8.as).

You can render texts with outlines by passing an `OutlinedGlyphBuilder` object to the `HardwareCharacterCache` object used by the text. The constructor of `OutlinedGlyphBuilder` expects a second parameter in addition to the triangulator indicating the thickness of the outline.

In order to render the text outline in a different color than the text itself, you should use the `SingleTwoColorGlyphRenderer`. In the example above, we create an instance of the respective factory class which we pass to the cache object.

**Note:** As of version 1.4.0, firetype renders outlines only in black. The ability to use the text formatting features of firetype to set several different color values will be implemented in the next versions.

```ActionScript
var rendererFactory:IHardwareTextRendererFactory = new SingleTwoColorGlyphRendererFactory(_context3d);
var glyphBuilder:IGlyphBuilder = new OutlinedGlyphBuilder(new EarClippingTriangulator(), 120)
var hardwareCache:HardwareCharacterCache = new HardwareCharacterCache(rendererFactory, glyphBuilder);

_hardwareText = new HardwareText(_context3d, hardwareCache);
_hardwareText.standardFormat.color = 0xFFFF0000;
_hardwareText.text = "Hello World!\nThis text is being rendered\nwith an outline using firetype!"; 
```

If you don't pass an object implementing `IGlyphBuilder` to the `HardwareCharacterCache` constructor, it will use the `SimpleGlyphBuilder` by default. `SimpleGlyphBuilder` simply converts the vertex paths into polygon objects without adding any extra geometry.

**Note:** Rendering texts with outlines has the following known issues as of version 1.4.0:
* Occasionally, certain characters will have minor glitches in their outlines. (Example: The lower case 'g' in the default font)
* Certain characters might cause the library to freeze. (Example: The '@' sign will send the triangulator into an endless loop due to it's implementation.)

These issues will be fixed in the upcoming versions.

![The text rendered with firetype.](http://www.max-did-it.com/projects/firetype/tutorial8.png)
	
### How Do I Use *firetype* With Starling?

As of version 1.5.0, *firetype* offers a basic integration with the [Starling Framework](http://gamua.com/starling/). The *firetype* library offers a class named `FiretypeStarlingTextField` that wraps firetype's `HardwareText` object in a Starling `DisplayObjectContainer` and integrates it into the render process of Starling.

You can find an implementation of this tutorial at [FiretypeStarlingTutorial.as](https://github.com/MaxDidIt/firetype/blob/master/src/test/flash/de/maxdidit/hardware/font/FiretypeStarlingTutorial.as) and [FiretypeStarlingGame.as](https://github.com/MaxDidIt/firetype/blob/master/src/test/flash/de/maxdidit/hardware/font/FiretypeStarlingGame.as).
	
If you use `FiretypeStarlingTextField`, you initialize your `Starling` object just like you would in any other Starling project. However, it is recommended that you set the `antiAliasing` property to something greater than 0 for better text rendering quality.

```ActionScript
_starling = new Starling(FiretypeStarlingGame, stage);
_starling.antiAliasing = 8;
_starling.start();
```

In your game class, or any other Starling `DisplayObject` class, you simply instantiate a `FiretypeStarlingTextField` object, set it's properties and add it to the display list.

```ActionScript
var text:FiretypeStarlingTextField = new FiretypeStarlingTextField();
text.text = "This text has been rendered in <format color='0xFFFF0000'>Starling</format> via <format color='0xFFFF6611'>firetype</format>.";
text.x = 100;
text.y = 100;
text.width = 300;
text.color = 0xFF666666;
addChild(text);
```

The result might look something like this:

![The text rendered with Starling and firetype.](http://www.max-did-it.com/projects/firetype/tutorialFiretype.png)

You can use the following properties of the `FiretypeStarlingTextField` object to set it's standard text format properties.

* `color`: Sets the text's color
* `textAlign`: Aligns the displayed text. Should be set to either TextAlign.LEFT, TextAlign.CENTER or TextAlign.RIGHT. 
* `textScale`: Uniformly scales the text's characters.
* `textSkewX`: Applies a shearing effect to each of the text's characters along the X axis.
* `textSkewY`: Applies a shearing effect to each of the text's characters along the Y axis.
* `font`: Sets the `HardwareFont` oject that should be used by the text. See [How Can I Set The Font of a Text](#how-can-i-set-the-font-of-a-text) on how to load a TrueType font in *firetype*.
* `vertexDistance`: Applies a value which indicates the level of detail in which the characters should be rendered. See [How Do I Control the Level of Detail of Characters](#how-do-i-control-the-level-of-detail-of-characters).

You can use all methods shown in [How Do I Apply Formatting to Texts](#how-do-i-apply-formatting-to-texts) to apply further formatting to your texts. This way, you can apply `format` tags and font format objects to your text.

## Where Can I Find the *firetype* API Documentation?

This is the link to the *firetype* ASDoc API documentation:
	
[www.maxdid.it/projects/firetype/docs](http://www.maxdid.it/projects/firetype/docs)