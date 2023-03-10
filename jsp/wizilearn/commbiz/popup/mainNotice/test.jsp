<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<script type="text/javaScript" language="javascript">
/* ********************************************************
 * 쿠키설정
 ******************************************************** */
function fnSetCookiePopup( name, value, expiredays ) {
	  var todayDate = new Date();
	  todayDate.setDate( todayDate.getDate() + expiredays );
	  alert( name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";" );
	  document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";"
}
/* ********************************************************
* 체크버튼 클릭시
******************************************************** */
function fnPopupCheck() {
	fnSetCookiePopup( "${popupId}", "done" , 365);
	window.close();
}
</script>
<style type="text/css">
<!--
#contents {position:relative; display:block; height:170px; background:#ddf;}
#bottom {position:relative; display:block;font-size:9pt}

//-->
</style>

</head>
<body>
<noscript class="noScriptTitle">자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>
<div id="contents">
<%-- noscript 테그 --%>
팝업창테스트 TEST.jsp
</div>
<div id="bottom">
<c:if test="${stopVewAt eq 'Y'}">
다음부터 이 창을 열지 않음  <input type="checkbox" name="chkPopup" value="" onClick="fnPopupCheck()" title="다음부터창열지않기체크">
</c:if>
</div>

</body>
</html>
