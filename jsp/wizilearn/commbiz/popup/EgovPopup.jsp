<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<meta http-equiv="Cache-Control" content="no-cache"/>
<meta http-equiv="Expires" content="0"/>
<meta http-equiv="Pragma" content="no-cache"/>
<!-- <meta http-equiv="Content-Security-Policy" content="default-src https:; script-src https: 'unsafe-inline' 'unsafe-eval'; style-src https: 'unsafe-inline'; img-src * 'self' data: https:;" /> -->
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="keywords" content="K-LINK, 케이링크" />

<title>K-LINK</title>

<!-- 공통 css -->
<link rel="stylesheet" href="/css/import.css">

<script type="text/javascript" src="/js/jquery-3.1.1.min.js"></script>
<script type="text/javaScript" language="javascript">
<!--

/* ********************************************************
 * 쿠키설정
 ******************************************************** */
function fnSetCookiePopup( name, value, expiredays ) {
	  var todayDate = new Date();
	  todayDate.setDate( todayDate.getDate() + expiredays );
	  document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";"
}
/* ********************************************************
* 체크버튼 클릭시
******************************************************** */
function fnPopupCheck() {
	fnSetCookiePopup( "${comPopupVO.popupId}", "done" , 1);
	window.close();
}
//-->
</script>
</head>
<body>	
    <div id="mainPop">
      <div class="pop-contents">
        <p>${comPopupVO.popupContent}</p>
      </div>
      <div class="pop-bottom">
			<form name="pop">
		  	<c:if test="${comPopupVO.stopviewYn eq 'Y'}"> 
		        <div class="pop-no">
		          <input type="checkbox" id="noOpen" onClick="javascript:fnPopupCheck();" />
		          <label for="noOpen">Don't open today</label>
		        </div> 
		  	</c:if>
		  	</form>
        <button class="pop-close" onClick="self.close();">close</button>
      </div>
    </div>   
</body>
</html>
