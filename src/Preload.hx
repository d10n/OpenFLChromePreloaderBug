package;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.IOErrorEvent;

class Preload extends Sprite {
    private var bytesTotal:UInt;

    public function new() {
        super();
        addEventListener(Event.ADDED_TO_STAGE, setup);
    }

    private function setup(event:Event):Void {
        removeEventListener(Event.ADDED_TO_STAGE, setup);

        bytesTotal = flash.Lib.current.loaderInfo.bytesTotal;
        if(bytesTotal == 0) {
            bytesTotal = 3000000;
        }

        addEventListener(Event.ENTER_FRAME, onEnterFrame);
        this.loaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
        this.loaderInfo.addEventListener(IOErrorEvent.NETWORK_ERROR, onIOError);
    }

    private function onIOError(event:IOErrorEvent):Void {
        // Do nothing
    }

    private function onEnterFrame(event:Event):Void {
        var bytesLoaded = flash.Lib.current.loaderInfo.bytesLoaded;
        if(bytesLoaded > bytesTotal) {
            bytesTotal = bytesLoaded;  // Chrome workaround
        }
        var percentLoaded = bytesLoaded / bytesTotal;
        trace('$bytesLoaded / $bytesTotal: $percentLoaded');
        if (percentLoaded >= 1) {
            var cls = Type.resolveClass("Main");
            //trace(cls);
            if(cls == null) {  // Chrome workaround
                return;
            }
            var app = Type.createInstance(cls, []);
            removeEventListener(Event.ENTER_FRAME, onEnterFrame);
            this.loaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onIOError);
            this.loaderInfo.removeEventListener(IOErrorEvent.NETWORK_ERROR, onIOError);
            //trace(cls);
            flash.Lib.current.removeChild(this);
            flash.Lib.current.addChild(app);
        }
    }

    public static function main() {
        flash.Lib.current.addChild(new Preload());
    }
}
