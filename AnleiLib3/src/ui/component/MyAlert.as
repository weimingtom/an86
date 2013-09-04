package ui.component
{
	import ui.abs.AlertForm;

	public class MyAlert
	{
		public static const YES:uint = 0x0001;
		
		public static const NO:uint = 0x0002;
		
		public static const OK:uint = 0x0004;
		
		public static const CANCEL:uint= 0x0008;
		
		private static var oldYesLab:String = 'Yes';
		private static var oldNoLab:String = 'No';
		private static var oldOkLab:String = 'Ok';
		private static var oldCancelLab:String = 'Cancel';
		
		public static var yesLabel:String = '';
		public static var noLabel:String = '';
		public static var okLabel:String = '';
		public static var cancelLabel:String = '';
		
		
		public function MyAlert(){}
		
		public static function show(text:String = "", title:String = "",
									flags:uint = 0x4 /* Alert.OK */,
									isBG:Boolean = true,
									closeHandler:Function = null, 
									customerAlert:AlertForm = null):AlertForm{
			
			var _alert:AlertForm;
			if(customerAlert == null){
				_alert = new AlertForm(title, 340, 190);
			}else{
				_alert = customerAlert;
			}
			_alert.pop();
				
				_alert.setText(text);
				_alert.title = title;
				_alert.isAtuoClose = true;
				_alert.closeFunction = closeHandler;
				_alert.isMask = isBG;
				
				
				if(yesLabel == '')		yesLabel = oldYesLab;
				if(noLabel == '')		noLabel = oldNoLab;
				if(okLabel == '')		okLabel = oldOkLab;
				if(cancelLabel == '')	cancelLabel = oldCancelLab;
				
				_alert.yes_btn.label	= yesLabel;
				_alert.no_btn.label		= noLabel;
				_alert.ok_btn.label		= okLabel;
				_alert.cancel_btn.label	= cancelLabel;
				
				yesLabel = '';
				noLabel = '';
				okLabel = '';
				cancelLabel = '';
				
				
				if(flags & YES){
					_alert.hbox.addChild(_alert.yes_btn);
				}
				
				if(flags & OK){
					_alert.hbox.addChild(_alert.ok_btn);
				}
				
				if(flags & NO){
					_alert.hbox.addChild(_alert.no_btn);
				}
				
				if(flags & CANCEL){
					_alert.hbox.addChild(_alert.cancel_btn);
				}
				
				
			return _alert;
		}
		
	}
}
