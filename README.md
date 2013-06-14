# firetype

## Goals

*firetype* is an Open Source Actionscript 3 library that parses OpenType fonts, converts the contained vector glyphs into polygon shapes and renders them using Stage3D via the GPU.

One of the examples for a similar technology would be [Scaleform](http://gameware.autodesk.com/scaleform) which is used in many big-budget productions to render hardware accelerated text and UI elements.

firetype aims to make similar functionality available for Actionscript 3 developers using Stage3D.

## How To Use firetype

### Table of Contents

[Preliminaries](#preliminaries)

### Preliminaries

As with any Stage3D project, you will need to set up a couple of things first. Basically, *firetype* expects the following things in order to run:

1. A [`Context3D`](http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/display3D/Context3D.html) object.
1. A [`Matrix3D`](http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/geom/Matrix3D.html) object containing a projection matrix.

This is a quick tutorial on what the following tutorials expect your document class to look like, starting a project from scratch.

You can get a quick overview of the basic document class by looking at [the code of the first firetype tutorial](https://github.com/MaxDidIt/firetype/blob/master/src/test/flash/de/maxdidit/hardware/font/FiretypeTutorial1.as).

- - -

**Step 1:** Set up the document class.

```ActionScript
package de.maxdidit.hardware.font 
{
	import flash.display.Sprite;
	
	public class FiretypeTutorial extends Sprite 
	{
		public function FiretypeTutorial1() 
		{
		
		}
	}
}
```

**Step 2:** In the constructor, we set some basic stage properties. Most importantly, we request the [`Context3D`](http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/display3D/Context3D.html) object, which we will use to render the text.

```ActionScript
public function FiretypeTutorial1() 
{
	// stage properties
	this.stage.frameRate = 60;
	
	// init stage3d
	var stage3d:Stage3D = this.stage.stage3Ds[0];
	stage3d.addEventListener(Event.CONTEXT3D_CREATE, handleContextCreated);
	stage3d.requestContext3D(Context3DRenderMode.AUTO);
}
```

**Step 3:** If the creation of the `Context3D` object was successful, the `handleContextCreated` event handler will be called. Here, we can access the `Context3D` object and assign it to a member variable.

We also initialize the view and kick off the render loop.

```ActionScript
private var _context3d:Context3D;

private function handleContextCreated(e:Event):void 
{
	_context3d = (e.target as Stage3D).context3D;
	
	initializeView();
	
	// react to resizing the stage
	this.stage.addEventListener(Event.RESIZE, handleResize);
	
	// Set up the update loop.
	addEventListener(Event.ENTER_FRAME, update);
}
```

**Step 4:** Here we configure the back buffer with the width and height of the stage. For the tutorials, we deactivate the depth buffer, since we only render 2D text.

We also set up a basic orthogonal projection matrix. This matrix scales the rendered geometry according to the aspect ratio of the stage.

In the last step, we prepend a scale transformation to the matrix, effectively zooming out. *firetype* makes no assumptions about the proportions you want to render your text in. Because of this, it renders the characters from the font in their original measurements. Since characters in true type fonts are usually about 1000 units high, this means that we have to zoom out to see the entire text.

```ActionScript
private function initializeView():void 
{
	_context3d.configureBackBuffer(stage.stageWidth, stage.stageHeight, 8, false);
	
	// Create very basic, orthogonal projection matrix.
	var viewProjectionRawData:Vector.<Number> = new Vector.<Number>();
	viewProjectionRawData.push(	2 / stage.stageWidth, 0, 0, 0, //
								0, 2 / stage.stageHeight, 0, 0, //
								0, 0, -2, -1, //
								0, 0, 0, 1);
	
	var viewProjection:Matrix3D = new Matrix3D(viewProjectionRawData);
	
	// Zoom out
	viewProjection.prependScale(0.02, 0.02, 0.02);
}
```

We call `initializeView` not only from the `handleContextCreated` event handler, but from the `handleResize` event handler as well.

```ActionScript
private function handleResize(e:Event):void 
{
	// The view has been scaled, re-initialize the backbuffer and the projection matrix.
	initializeView();
}
```

**Step 5:** Finally, this is what the update looks like initially:

```ActionScript
private function update(e:Event):void 
{
	// Clear the backbuffer, render the text and then display it.
	_context3d.clear(1, 1, 1);
	
	_context3d.present();
}
```

### How To Display Text With *firetype*