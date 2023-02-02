<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<script type="text/javaScript" language="javascript">
/* ********************************************************
 * 쿠키설정
 ******************************************************** */
function fnSetCookiePopup( name, value, expiredays ) {
	  var todayDate = new Date();
	  todayDate.setDate( todayDate.getDate() + expiredays );
	 // alert( name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";" );
	  document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";"
}
/* ********************************************************
* 체크버튼 클릭시
******************************************************** */
function fnPopupCheck() {
	fnSetCookiePopup( "${popupId}", "done" , 1);
	window.close();
}
</script>
<title>이러닝협회 소식</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" href="/css/popup_temp.css" type="text/css" />
</head>

<body>
<!-- 최적화 팝업창 가로 사이즈는 530픽셀 입니다.-->
<div id="temp-wrapper1">
	<div id="temp-wrapper2">
		<div id="temp-header">
			<div id="temp-logo"><!--img src="/images/wizilearn/std/popup/pop_logo.png" alt="이러닝협회" /--></div>
			<div id="temp-border">
				<ul></ul>
			</div>
		</div>

		<div id="temp-content">
			<div id="temp-content-area">
				<div id="temp-topimg"><!--img src="/images/wizilearn/std/popup/top_text.png" alt="안녕하세요. 이러닝협회 입니다." / --></div>
				<div id="temp-title">${popupManageVO.popupTitleNm }</div>
				<div id="temp-body">
					<div>${popupManageVO.popupContent}	</div>				
				</div>
			</div>
		</div>
		
		<div id="temp-footer">
			<div id="temp-bottom">
				<ul></ul>
			</div>
			<!-- 오늘하루 이창을 열지 않기 기능을 사용하려면 아래 줄이 들어가야 합니다.
			1. 체크박스는 항상 name="checkbox" 로 해주세요.
			2. 체크박스 온클릭 이벤트는 항상 onClick="javascript:notice_closeWin();"로 해주세요.-->
			<div id="temp-close">
			<form name="pop"><label for="pop-check">
			<c:if test="${stopVewAt eq 'Y'}">
			<input type="checkbox" name="checkbox" id="pop-check" value="checkbox" onClick="javascript:fnPopupCheck();" /> 오늘 하루 이창을 닫음</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			</c:if>
			</form></div>
		</div>
	</div>
</div>
</body>
</html>
 
