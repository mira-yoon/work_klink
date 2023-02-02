<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%@ 
taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core"%><%@ 
page import="java.util.Enumeration" %><%@ 
page import="kr.co.wizi.wizilearn.commbiz.util.BizUtil" %><%@ 
page import="kr.co.wizi.wizilearn.comm.vo.LoginInfo" %><%@ 
page import="kr.co.wizi.wizilearn.comm.service.Globals" %><%@ 
page import="kr.co.wizi.wizilearn.comm.vo.LoginVO" %><script type="text/javascript" src="/js/jquery-3.1.1.min.js"></script>
<script type="text/javascript" src="/js/jquery-common.js"></script>
<script type="text/javascript">

	// includeJs.jsp에서 파일들을 정상 로드 하지 못하는 경우(urlrewrite되는 경우).
	function isBlank(obj){
		return (!obj || /^\s*$/.test(obj) || 'null' == obj );
	}
	var CONTEXT_ROOT = "<%= request.getContextPath() %>";
	
	var targetURL = CONTEXT_ROOT;
	targetURL = targetURL + "/la/bbs/BBSMSTR_0000001/listBbsNotice";

 	window.location = targetURL;
	
	//Controller에서  전달된 메시지를 출력한다. ( gridUtil.setRetMsg 값 )
	$(document).ready(function(){
		if(""!="${retMsg}"){
			alert("${retMsg}");
		}
	});
	

</script>
 