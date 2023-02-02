<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%@ 
taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %><%@ 
taglib prefix="spring" uri="http://www.springframework.org/tags" %><%@ 
taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%><%@ 
taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@ 
taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%@ 
taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" media="all" />
<script type="text/javascript">
	function fn_apply(){
		
		popOpenWindow( "", "applyList", 740, 560, 100, 100, ',scrollbars=yes' );
				
		var reqUrl = "/la/member/goApplyPop";
		$("#frmMember").attr("action", reqUrl);
		$("#frmMember").attr("target","applyList");
		$("#frmMember").submit();
	}
	function fn_update(){
		var reqUrl = "/la/member/goUpdateMember";
		$("#frmMember").attr("action", reqUrl);
		$("#frmMember").attr("target","_self");
		$("#frmMember").submit();
	}
	function fn_delete(param){
		if(confirm("해당 회원을 삭제하시겠습니까?")){
			$("#deleteYn").val("Y");
			var reqUrl = "/la/member/updateMember";
			$("#frmMember").attr("action", reqUrl);
			$("#frmMember").attr("target","_self");
			$("#frmMember").submit();
		}
	}
	/* 리스트 조회 */
	function fn_search(){
		var reqUrl = "/la/member/listMember";
		$("#frmMember").attr("action", reqUrl);
		$("#frmMember").attr("target","_self");
		$("#frmMember").submit();
	}
	function goUserList(code){
 
		var reqUrl = "/la/apply/listApplyUser";	
		$("#courseCd").val(code);
		$("#frmMember").attr("action", reqUrl);
		$("#frmMember").attr("target","_self");
		$("#frmMember").submit();
		
	}

</script>
<form id="frmMember" name="frmMember" method="post" enctype="multipart/form-data">
	<input type="hidden" id="memGubunSelect" name="memGubunSelect" value="${LoginVO.memGubunSelect }" />
	<input type="hidden" id="searchType3" name="searchType3" value="${LoginVO.searchType3 }" />
	<input type="hidden" id="menuId" name="menuId" value="<c:out value='${menuId}'/>" /> 
	<input type="hidden" id="memSeq" name="memSeq" value="${result.memSeq }" />
	<input type="hidden" id="memId" name="memId" value="${result.memId }" />
	<input type="hidden" id="deleteYn" name="deleteYn" value="${result.deleteYn}" />
	<input type="hidden" id="courseCd" name="courseCd" />
	<table border="0" cellpadding="0" cellspacing="0" class="view-2">
		<tbody>
			<tr>
				<th>회원구분</th>
				<td  colspan="3">
					 ${result.memTypeName}
				</td>
 
			</tr>
			<tr>
				<th>아이디</th>
				<td>${result.memIdStr }</td>
				<th>이름</th>
				<td>${result.memNameStr } ${result.memLastNameStr }</td>
			</tr>
			<tr>
				<th>국가</th>
				<td colspan="3">${result.natName}(${result.natNameKr})</td>
			</tr>
			<tr>
				<th>생년월일</th>
				<td  colspan="3">${result.memBirthStr }</td>
				 
			</tr>				
			<tr>
				<th>기관</th>
				<td>${result.orgName}</td>
				<th>기관구분</th>
				<td><c:out value="${result.orgGubunName }"/></td>
			</tr>
			<tr>
				<th>부서명</th>
				<td>${result.depName}</td>
				<th>직업</th>
				<td>${result.memJob}</td>
			</tr>
			<tr>
				<th>이메일</th>
				<td>${result.emailStr}(${result.receiveMailYn})</td>
				<th>추가이메일</th>
				<td>${result.emailSubStr}</td>
			</tr>
			<tr>
				<th>무선번호</th>
				<td>${result.hpNoStr}</td>
				<th>유선번호</th>
				<td>${result.telNoStr}</td>
			</tr>
			<tr>
				<th>최종방문일</th>
				<td>${result.lastLoginYmd}</td>
				<th>총방문수</th>
				<td><c:out value="${result.loginCnt}" default="0"/></td>
			</tr>
			<tr>
				<th>가입일자</th>
				<td>${result.insertDate}</td>
				<th>수정일자</th>
				<td>${result.updateDate}</td>
			</tr>
		</tbody>
	</table>
</form>

<div class="page-btn">
	<a href="#!" onclick="fn_apply();">지원정보</a>
	<a href="#!" onclick="fn_update();">수정</a>
	<a href="#!" onclick="fn_delete();">삭제</a>
	<a href="#!" onclick="fn_search();">목록</a>
</div>