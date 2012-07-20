
function setHome() {
	if (document.all) {
		document.body.style.behavior='url(#default#homepage)';
		document.body.setHomePage("http://tea51.cn");
	} else if (window.sidebar) {
		if (window.netscape) {
			try {
				netscape.security.PrivilegeManager.enablePrivilege("UniversalXPConnect");
			} catch (e) {
				alert( "该操作被浏览器拒绝，如果想启用该功能，请在地址栏内输入 about:config,然后将项 signed.applets.codebase_principal_support 值设置为true" );
			}
		}
		var prefs = Components.classes['@mozilla.org/preferences-service;1'].getService(Components. interfaces.nsIPrefBranch);
		prefs.setCharPref('browser.startup.homepage',"http://tea51.cn");
	} else {
		alert("非常抱歉，你的浏览器目前还不支持此功能！请在浏览器的工具或者选项里面进行个人设置。");
	}
}

function addFav() {
	try {
		window.external.addFavorite("http://tea51.cn","《茶园物语》");
	} catch (e) {
		try {
			window.external.addToFavoritesBar("http://tea51.cn","《茶园物语》", "slice");
		} catch (e) {
			try {
				window.sidebar.addPanel("《茶园物语》","http://tea51.cn", "");
			} catch (e) {
				alert("非常抱歉，你的浏览器目前还不支持此功能！请在浏览器的收藏夹或者书签菜单里进行手动添加。");
			}
		}
	}
}