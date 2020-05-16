var mediaQuery = "(orientation: landscape)"
var scrollAmount = 0;
byId('rightbar').onscroll = function() {
	if(!window.matchMedia(mediaQuery).matches){
		if(!hasClass(byId('leftbar'),'animate')){
		    if (scrollAmount > 50) {
		        if(!hasClass(byId('leftbar'),'hid'))
		        	toggleBar();
		    } else {
		        if(hasClass(byId('leftbar'),'hid'))
		        	toggleBar();
		    }
		}
	}
	scrollAmount = byId('rightbar').scrollTop;
}
function moveCouch () {

	var mq = window.matchMedia(mediaQuery)
	if(location.search.indexOf("hid=1")>=0){
		if (mq.matches){
			var labels = document.getElementsByClassName('sidebarButtonLabel')
			for(var i = 0; i < labels.length; i++){
				addClass(labels[i],'hidden')
			}
		}else{
			byId('hideLabel').innerHTML="Show";
		}
		addClass(byId('leftbar'),'hid');
		addClass(byId('rightbar'),'hid');
		addClass(byId('arrow'),'hid');
		addClass(byId('title'),'hid');
		toggleHideLink();
	}
	document.getElementsByTagName("BODY")[0].style.visibility="visible";
}
function toggleBar() {
	var mq = window.matchMedia(mediaQuery)
	addClass(byId('leftbar'),'animate')
	addClass(byId('rightbar'),'animate')
	addClass(byId('arrow'), 'animate')
	addClass(byId('title'), 'animate')
	if(hasClass(byId('leftbar'),'hid')){
		byId('leftbar').style.animationDirection=byId('rightbar').style.animationDirection=byId('title').style.animationDirection=byId('arrow').style.animationDirection="reverse";
		removeClass(byId('leftbar'),'hid')
		removeClass(byId('rightbar'),'hid')
		removeClass(byId('arrow'),'hid')
		removeClass(byId('title'),'hid')
		byId('hideLabel').innerHTML="Hide"
	}else{
		byId('leftbar').style.animationDirection=byId('rightbar').style.animationDirection=byId('title').style.animationDirection=byId('arrow').style.animationDirection="normal";
		addClass(byId('leftbar'),'hid')
		addClass(byId('rightbar'),'hid')
		addClass(byId('arrow'),'hid')
		addClass(byId('title'),'hid')
		byId('hideLabel').innerHTML="Show"
	}
	var labels = document.getElementsByClassName('sidebarButtonLabel')
	for(var i = 0; i < labels.length; i++){
		addClass(labels[i],'hidden')
	}
	toggleHideLink();
}
function toggleInfo(){
	if(byId('sidebar').style.top=="230px"){
		byId('sidebar').style.top="100%";
		byId('sidebar').className="animate";
		byId('sidebar').style.animationDirection="reverse";
		toggleInfoLink();
	}else if(byId('leftbar').style.width!='48px'){
		byId('sidebar').style.top="230px";
		byId('sidebar').className="animate";
		toggleInfoLink();
	}
}
function showLabel(labelId){
	addClass(byId(labelId), 'animate')
	byId(labelId).style.animationDirection="normal";
	byId((labelId)).style.color = 'rgba(255,255,255,1)';
}
function hideLabel(labelId){
	addClass(byId(labelId), 'animate')
	byId(labelId).style.animationDirection="reverse";
	byId((labelId)).style.color = 'rgba(255,255,255,0)';
}
function leftbarAnimationEnd(){
    removeClass(this,'animate')
    this.style.animationDirection="normal";
		if(!hasClass(byId('leftbar'),'hid')){
			var labels = document.getElementsByClassName('sidebarButtonLabel')
			for(var i = 0; i < labels.length; i++){
				removeClass(labels[i],'hidden')
			}
		}
}
byId('leftbar').addEventListener('webkitAnimationEnd', leftbarAnimationEnd);
byId('leftbar').addEventListener('animationend', leftbarAnimationEnd);

function animationEnd(){
    removeClass(this,'animate')
    this.style.animationDirection="normal";
}
byId('rightbar').addEventListener('webkitAnimationEnd', animationEnd);
byId('rightbar').addEventListener('animationend', animationEnd);
byId('title').addEventListener('webkitAnimationEnd', animationEnd);
byId('title').addEventListener('animationend', animationEnd);
byId('arrow').addEventListener('webkitAnimationEnd', animationEnd);
byId('arrow').addEventListener('animationend', animationEnd);
byId('sidebar').addEventListener('webkitAnimationEnd', animationEnd);
byId('sidebar').addEventListener('animationend', animationEnd);
byId('hideLabel').addEventListener('webkitAnimationEnd', animationEnd);
byId('hideLabel').addEventListener('animationend', animationEnd);
byId('homeLabel').addEventListener('webkitAnimationEnd', animationEnd);
byId('homeLabel').addEventListener('animationend', animationEnd);
byId('rssLabel').addEventListener('webkitAnimationEnd', animationEnd);
byId('rssLabel').addEventListener('animationend', animationEnd);

function byId(id){
	return document.getElementById(id);
}
function toggleHideLink(){
	toggleLink("hid");
}
function toggleInfoLink(){
	toggleLink("info");
}
function toggleLink(label){
	var links = document.getElementsByTagName("A");
   	var thisSite="http://peterme.net/devlog/";
   	for(var i=0;i<links.length;i++){
   		var link = links[i].getAttribute("href");
   		if(link.slice(0,thisSite.length)==thisSite){
   			if(link.indexOf("?")>=0){
   				var index = link.indexOf(label+"=");
   				if(index>=0){
   					index+=label.length+1;
   					var newState = "0";
   					if(link.slice(index,index+1)=="0")
   						newState = "1";
   					var newLink = link.slice(0,index);
   					newLink+=newState;
   					newLink+=link.slice(index+1);
   					links[i].setAttribute("href",newLink);
   				}else
   					links[i].setAttribute("href",link+"&"+label+"=1");
   			}else{
   				links[i].setAttribute("href",link+"?"+label+"=1");
   			}
   		}
   	}
}

function hasClass (el, selector) {
    if(el.classList)
    	return el.classList.contains(selector)
    else
    	return el.className.split(/\s+/).indexOf('hid') >= 0
}

function addClass(el, className) {
  if (el.classList)
    el.classList.add(className)
  else if (!hasClass(el, className)) el.className += " " + className
}

function removeClass(el, className) {
  if (el.classList)
    el.classList.remove(className)
  else if (hasClass(el, className)) {
    var reg = new RegExp('(\\s|^)' + className + '(\\s|$)')
    el.className=el.className.replace(reg, ' ')
  }
}
