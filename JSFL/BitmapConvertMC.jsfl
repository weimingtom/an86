fl.getDocumentDOM().selectAll();//选中场景中所有的位图
if(fl.getDocumentDOM().selection.length>0)
{
fl.getDocumentDOM().deleteSelection();//删除所有位图
}
var lib=fl.getDocumentDOM().library;//取得库
var libLength=lib.items.length;//库元素的长度
var bitmapArr=new Array();//库里面没有处理的位图
for(var i=0;i<libLength;i++)
{
//没有在目录中的位图则表示没有处理
if((lib.items[i].itemType=="bitmap")&&((lib.items[i].name).indexOf("/")==-1))
{
   bitmapArr.push(lib.items[i].name);
}
}
if(bitmapArr.length>0)
{
//创建目录
for(var i=0;i<bitmapArr.length;i++)
{
   var name=bitmapArr[i];//位图的完整名称
   if(bitmapArr[i].indexOf('_') != -1){
	   var nameArr=bitmapArr[i].split("_");//位图名称的拆分数组
   }else{
	   var nameArr = bitmapArr[i];
   }
   var folder=nameArr[0];//目录名称
   var iconName=nameArr[1];//图标名称
   if(nameArr != null){
	   var code=nameArr[2].split(".")[0];//图标编码
   }else{
	   var code = nameArr;
   }
   lib.newFolder(folder);
   lib.selectItem(name);//选中位图
   lib.addItemToDocument({x:0, y:0});//添加到场景
   fl.getDocumentDOM().selectAll();
   var mcName=iconName+"_"+code;
   //转换为mc
   fl.getDocumentDOM().convertToSymbol("movie clip",mcName,"top left") ;
   if (lib.getItemProperty('linkageImportForRS') == true) {
   lib.setItemProperty('linkageImportForRS', false);
   }
   lib.setItemProperty('linkageExportForAS', true);
   lib.setItemProperty('linkageExportForRS', false);
   lib.setItemProperty('linkageExportInFirstFrame', true);
   lib.setItemProperty('linkageClassName', code);
   lib.setItemProperty('scalingGrid', false);
   fl.getDocumentDOM().selectAll();//选中场景中所有的位图
   fl.getDocumentDOM().deleteSelection();//删除所有位图
   var bitmapFolder=folder+"/图素";
   var mcFolder=folder+"/导出类"
   lib.newFolder(bitmapFolder);
   lib.newFolder(mcFolder);
   lib.moveToFolder(mcFolder, mcName);
   lib.moveToFolder(bitmapFolder, name);
}
}
else
{
alert("没有需要处理的位图!");
}

 
