package ui.component
{
import flash.display.DisplayObject;
import flash.display.Sprite;

public class ShowNums extends Sprite
{
    public function ShowNums(val:int = 0, sourceKey:String = null, prefix:String = "")
    {
        if (!sourceKey)
            sourceKey = "numf1";
        _sourceKey = sourceKey;
        _prefix = prefix;
        _lastNums = [];
        _showNegativeSymbol = true;
        value = val;
    }

    public function set offset(value:int):void
    {
        _offset = value;
    }

    private var _sourceKey:String;

    private var _lastNums:Array;

    private var _val:int;

    private var _prefix:String;

    /**
     * 数字显示的值
     * @return
     *
     */
    public function get value():int
    {
        return _val;
    }

    public function set value(val:int):void
    {
        _val = val;
        var valString:String = (_val > 0 ? _val : -_val).toString();
        var nums:Array = [];
        var charX:int = 0;
        var ilen:int = valString.length;

        for (var i:int = 0; i < ilen; i++)
        {
            var char:String = valString.charAt(i);
            var num:DisplayObject;
            var jlen:int = _lastNums.length;

            for (var j:int = 0; j < jlen; j++)
            {
                if (_lastNums[j].char == char)
                {
                    num = _lastNums[j];
                    _lastNums.splice(j, 1);
                    break;
                }
            }

            if (!num)
                num = new SingleShowNum(char, _sourceKey, _prefix);
            nums.push(num);
            num = null;
        }
        _lastNums = nums;

        while (this.numChildren)
        {
            this.removeChildAt(0);
        }

        if (_val > 0 && showPositiveSymbol)
        {
            var ps:SingleShowNum = new SingleShowNum("+", _sourceKey, _prefix);
            addChild(ps);
            charX = ps.width + offset;
        }
        else if (_val < 0 && showNegativeSymbol)
        {
            var ns:SingleShowNum = new SingleShowNum("-", _sourceKey, _prefix);
            addChild(ns);
            charX = ns.width + offset;
        }

        for each (var newNum:SingleShowNum in _lastNums)
        {
            newNum.x = charX;
            addChild(newNum);
            charX += newNum.width + offset;
        }
    }

    private var _offset:int;

    /**
     * 数字间距
     * @return
     *
     */
    public function get offset():int
    {
        return _offset;
    }

    private var _showPositiveSymbol:Boolean;

    /**
     * 当数字大于0的时候显示"+"号 (默认为false)
     * @return
     *
     */
    public function get showPositiveSymbol():Boolean
    {
        return _showPositiveSymbol;
    }

    public function set showPositiveSymbol(value:Boolean):void
    {
        _showPositiveSymbol = value;
    }

    private var _showNegativeSymbol:Boolean;

    /**
     * 当数字小于0的时候显示"-"号(默认为true)
     * @return
     *
     */
    public function get showNegativeSymbol():Boolean
    {
        return _showNegativeSymbol;
    }

    public function set showNegativeSymbol(value:Boolean):void
    {
        _showNegativeSymbol = value;
    }
}
}
