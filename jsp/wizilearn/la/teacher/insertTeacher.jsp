<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%@ 
taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %><%@ 
taglib prefix="spring" uri="http://www.springframework.org/tags" %><%@ 
taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%><%@ 
taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@ 
taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%@ 
taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" media="all" />
<script type="text/javascript">
	function fn_save(){	
		if($("input[name=name]").val()==''){
			alert('강사명을 입력해주세요');
			$("input[name=name]").focus();
			return false;
		}
		if($("input[name=tel]").val()==''){
			alert('연락처를 입력해 주세요.');
			$("input[name=tel]").focus();
			return false;
		}
		if($("input[name=email]").val()==''){
			alert('이메일을 입력해 주세요.');
			$("input[name=email]").focus();
			return false;
		}
		if($("input[name=history]").val()==''){
			alert('약력을 입력해 주세요.');
			$("input[name=history]").focus();
			return false;
		}
		var msg='등록하시겠습니까?';
		if(confirm(msg)){
			var reqUrl = "/la/teacher/insertTeacher";
			$("#frmTeacher").attr("action", reqUrl);
			$("#frmTeacher").attr("target","_self");
			$("#frmTeacher").submit();	
		}
	}
	
	/* 리스트 조회 */
	function fn_list(){
		var reqUrl = "/la/member/listTeacher";
		$("#frmTeacher").attr("action", reqUrl);
		$("#frmTeacher").attr("target","_self");
		$("#frmTeacher").submit();
	}
</script>
<form id="frmTeacher" name="frmTeacher" method="post">
	<input type="hidden" id="menuId" name="menuId" value="<c:out value='${menuId}'/>"> 
	<div class="title-name-1">강사이력등록</div>
	<table border="0" cellpadding="0" cellspacing="0" class="view-2">
		<tbody>
			<tr>
				<th>이름</th>
				<td colspan="3">
					<input type="text" id="name" name="name" value=""/>
				</td>
			</tr>
			<tr>
				<th>연락처</th>
				<td colspan="3">
					<input type="text" id="tel" name="tel" value=""/>
				</td>
			</tr>
			<tr>
				<th>이메일</th>
				<td colspan="3">
					<input type="text" id="email" name="email" value=""/>
				</td>
			</tr>
			<tr>
				<th>약력</th>
				<td colspan="3">
					<textarea id="history" name="history"></textarea>
				</td>
			</tr>
		</tbody>
	</table>
</form>

<div class="page-btn">
	<a href="#!" onclick="fn_save();">저장</a>
	<a href="#!" onclick="fn_list();">목록</a>
</div>