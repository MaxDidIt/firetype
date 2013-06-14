# firetype

## Goals

firetype is an Open Source Actionscript 3 library that parses OpenType fonts, converts the contained vector glyphs into polygon shapes and renders them using Stage3D via the GPU.

One of the examples for a similar technology would be [Scaleform](http://gameware.autodesk.com/scaleform) which is used in many big-budget productions to render hardware accelerated text and UI elements.

firetype aims to make similar functionality available for Actionscript 3 developers using Stage3D.

## How To Use firetype

### Preliminaries

As with any Stage3D project, you will need to set up a couple of things first. This is a quick tutorial on what the following tutorials expect your project to look like.

You can get a quick overview of the basic project class by looking at [the code of the first firetype tutorial](https://github.com/MaxDidIt/firetype/blob/master/src/test/flash/de/maxdidit/hardware/font/FiretypeTutorial1.as).

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

We also add an event listener which reacts to the stage being resized. We will add the `handleResize` event handler later.

```ActionScript
public function FiretypeTutorial1() 
{
	// stage properties
	this.stage.frameRate = 60;
	
	// react to resizing the stage
	this.stage.addEventListener(Event.RESIZE, handleResize);
	
	// init stage3d
	var stage3d:Stage3D = this.stage.stage3Ds[0];
	stage3d.addEventListener(Event.CONTEXT3D_CREATE, handleContextCreated);
	stage3d.requestContext3D(Context3DRenderMode.AUTO);
}
```

**Step 3:** If the creation of the `Context3D` object was successful, the `handleContextCreated` event handler will be called. Here, we can access the `Context3D` object and assign it to a member variable.



```ActionScript
private var _context3d:Context3D;

private function handleContextCreated(e:Event):void 
{
	_context3d = (e.target as Stage3D).context3D;
	
	initializeView();
	
	// Set up the update loop.
	addEventListener(Event.ENTER_FRAME, update);
}
```