package net.an86.ui.menu
{
	public interface IMenu
	{
		function up():void;
		function down():void;
		function left():void;
		function right():void;
		
		function A():void;
		function B():void;
		
		function removePop():void;
		function pop():void;
	}
}