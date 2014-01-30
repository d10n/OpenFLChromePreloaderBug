package;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.media.Sound;
import flash.media.SoundChannel;
import flash.events.Event;
#if(openfl)
import openfl.Assets;
#else
@:bitmap("assets/logo.png") class BitmapLogo extends BitmapData{}
@:sound("assets/bgm.mp3") class SoundBGM extends Sound{}
#end

class Main extends flash.display.Sprite {

    private var logo:Bitmap;
    private var channel:SoundChannel;

    public function new() {
        super();
        addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
    }

    private function onAddedToStage(event:Event):Void {
        removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
        setup();
    }

    private function setup() {
        flash.Lib.current.stage.align = untyped "";  // center stage align
        flash.Lib.current.stage.scaleMode = flash.display.StageScaleMode.SHOW_ALL;
        addLogo();
        addBgmLoop();
    }

    private function addLogo() {
        logo = new Bitmap();
#if(openfl)
        logo.bitmapData = Assets.getBitmapData("assets/logo.png");
#else
        logo.bitmapData = new BitmapLogo(0, 0);
#end
        logo.x = flash.Lib.current.stage.stageWidth / 2 - logo.width / 2;
        logo.y = flash.Lib.current.stage.stageHeight / 2 - logo.height / 2;
        addChild(logo);
    }

    private function addBgmLoop() {
#if(openfl)
        var sound:Sound = Assets.getSound("assets/bgm.mp3");
#else
        var sound:Sound = new SoundBGM();
#end
        channel = sound.play(0, 99);
    }

    static function main() {
        var mainFrame = new Main();
        flash.Lib.current.addChild(mainFrame);
    }
}
