package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.GameInputEvent;
	import flash.text.TextField;
	import flash.ui.GameInput;
	import flash.ui.GameInputControl;
	import flash.ui.GameInputDevice;
	
	/**
	 * ...
	 * @author Arya Antaputra
	 */
	public class Main extends Sprite 
	{
		public var input:GameInput;
		private var display:TextField;
		private var controllers:Vector.<GameInputDevice>;
		private var device:GameInputDevice;
		
		public function Main():void 
		{
			trace(this.width);
			input = new GameInput();
			controllers = new Vector.<GameInputDevice>();
			
			display = new TextField();
			display.width = 400;
			display.height = 300;
			display.backgroundColor = 0xffbbbb;
			display.text = "Display\n";
			trace("ready");
			
			this.addChild(display);
			
			input.addEventListener(GameInputEvent.DEVICE_ADDED, onDeviceAdded);
		}
		
		private function onDeviceAdded(e:GameInputEvent):void {
			trace(e.device.name);
			display.appendText(e.device.name + "\n");
			controllers.push(e.device);
			device = e.device;
			display.appendText(controllers.toString() + "\n");
			device.enabled = true;
			append_log(device.numControls.toString());
			
			for (var i:int = 0; i < device.numControls; i++) {
				append_log("set event listeners");
				append_log(i.toString());
				device.getControlAt(i).addEventListener(Event.CHANGE, onControllerChange);
			}
		}
		
		private function onDeviceRemoved(e:GameInputEvent):void {
			display.appendText(controllers.toString() + "\n");
		}
		
		private function onControllerChange(e:Event):void {
			var ctrl:GameInputControl = e.currentTarget as GameInputControl;
			display.appendText(ctrl.device.name + ": " + ctrl.id + " " + ctrl.value + "\n");
			display.scrollV = display.maxScrollV;
		}
		
		private function append_log(s:String):void {
			display.appendText(s + "\n");
		}
	}
	
}