<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%@ 
taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %><%@ 
taglib prefix="spring" uri="http://www.springframework.org/tags" %><%@ 
taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%><%@ 
taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@ 
taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%@ 
taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" media="all" />
<script type="text/javascript">
<!--
	$("input:text[numberonly]").on("keyup", function() {
		$(this).val($(this).val().replace(/[^0-9]/g,""));
	});
		
	$(document).ready(function() { 
		com.datepickerDateFormat('memBirth'); 
	
	});	
	function fn_save(){

		var memName = $("#memName").val();
		var memLastName = $("#memLastName").val();
		var orgName = $("#orgName").val();
		var depName = $("#depName").val();
		var memJob = $("#memJob").val();
		var telNo = $("#telNo").val();
		var hpNo = $("#hpNo").val();
		/*
		if(!emailFlag){
			alert("이메일 중복확인을 해야합니다.");
			return;
		}
		if(!emailSubFlag){
			alert("서브 이메일 중복확인을 해야합니다.");
			return;
		} 
		*/
		if(memName == ''){
			alert("First Name을 입력해주세요.");
			$("#memName").focus();
			return;
		}
		if(memLastName == ''){
			alert("Last Name을 입력해주세요.");
			$("#memLastName").focus();
			return;
		}
		if(orgName == ''){
			alert("기관명을 입력해주세요.");
			$("#orgName").focus();
			return;
		}
		if(depName == ''){
			alert("부서명을 입력해주세요.");
			$("#depName").focus();
			return;
		}
		if(memJob == ''){
			alert("직업을 입력해주세요.");
			$("#memJob").focus();
			return;
		}
		if(telNo == ''){
			alert("무선번호를 입력해주세요.");
			$("#telNo").focus();
			return;
		}
		if(hpNo == ''){
			alert("유선번호를 입력해주세요.");
			$("#hpNo").focus();
			return;
		}
		
		var reqUrl = "/la/member/updateMember";
		$("#frmMember").attr("action", reqUrl);
		$("#frmMember").attr("target","_self");
		$("#frmMember").submit();
	}
	/* 리스트 조회 */
	function fn_search(){
		var reqUrl = "/la/member/listMember";
		$("#authGroupId").val("");
		$("#frmMember").attr("action", reqUrl);
		$("#frmMember").attr("target","_self");
		$("#frmMember").submit();
	}
	
	var memIdFlag = true;
	
	/* 아이디 중복체크 */
	function fn_findOverlap(){
		var memId = $("#memId", "#frmMember").val();
		var memIdText = document.getElementById('memId');
		// 아이디체크
		var regex = /^[a-z0-9]{6,12}$/;
		if ( memId == '' ) {
			alert("아이디를 입력하십시오.");
			$("#memId", "#frmMember").focus();
			return;
		} else if ( isContainEmpty(memId) ) {
			alert("아이디에는 공백을 입력할 수 없습니다.");
			$("#memId", "#frmMember").focus();
			return;
		} else if ( !isRegexCheck(memId, regex) ) {
			alert("아이디는 영문 소문자, 숫자 6~12 자리입니다.");
			$("#memId", "#frmMember").focus();
			return;
		}
		
		if(memId != null && memId != ''){
			$.ajax({
				url:"/la/member/findOverlap.do",
				type:"post",
				data:{"memId" : memId},
				dataType:"json",
				success:function(data){
					var result = data.data;
					if(result > 0){
						alert("사용할 수 없는 아이디입니다.");
						$("#memId").val('');
					}else{
						memIdText.readOnly = true;
						memIdFlag = true;
						document.getElementById('resetId').style.display='inline';
						alert("사용 가능한 아이디입니다.");
					}
				},
				error:function(e){
					console.log("ERROR!!!!!!!!!!!");
				}
			})
		}else{
			alert("아이디를 입력해 주세요.");
			$("#memId").focus();
		}
	}
	
	var emailFlag = true;
	
	function fn_findOverlapEmail(){
		var email = $("#email", "#frmMember").val();
		var emailText = document.getElementById('email');
		
		if(email != null && email != ''){
			$.ajax({
				url:"/la/member/findOverlapEmail.do",
				type:"post",
				data:{"email" : email},
				dataType:"json",
				success:function(data){
					var result = data.data;
					if(result > 0){
						alert("사용할 수 없는 이메일 입니다.");
						$("#email").val('');
					}else{
						emailText.readOnly = true;
						emailFlag = true;
						document.getElementById('resetEmail').style.display='inline';
						alert("사용 가능한 이메일입니다.");
					}
				},
				error:function(e){
					console.log("ERROR!!!!!!!!!!!");
				}
			})
		}else{
			alert("이메일을 입력해 주세요.");
			$("#email").focus();
		}
	}
	
	var emailSubFlag = true;
	
	function fn_findOverlapEmailSub(){
		var email = $("#emailSub", "#frmMember").val();
		var emailText = document.getElementById('emailSub');
		
		if(email != null && email != ''){
			$.ajax({
				url:"/la/member/findOverlapEmail.do",
				type:"post",
				data:{"email" : email},
				dataType:"json",
				success:function(data){
					var result = data.data;
					if(result > 0){
						alert("사용할 수 없는 이메일 입니다.");
						$("#emailSub").val('');
					}else{
						emailText.readOnly = true;
						emailSubFlag = true;
						document.getElementById('resetEmailSub').style.display='inline';
						alert("사용 가능한 이메일입니다.");
					}
				},
				error:function(e){
					console.log("ERROR!!!!!!!!!!!");
				}
			})
		}else{
			alert("이메일을 입력해 주세요.");
			$("#emailSub").focus();
		}
	}
	
	function fn_reset(){
		var memIdText = document.getElementById('memId');
		$("#memId").val('');
		memIdText.readOnly = false;
		memIdFlag = false;
		document.getElementById('resetId').style.display='none';
	}
	
	function fn_resetEmail(){
		var emailText = document.getElementById('email');
		$("#email").val('');
		emailText.readOnly = false;
		emailFlag = false;
		document.getElementById('resetEmail').style.display='none';
	}
	
	function fn_resetEmailSub(){
		var emailText = document.getElementById('emailSub');
		$("#emailSub").val('');
		emailText.readOnly = false;
		emailSubFlag = false;
		document.getElementById('resetEmailSub').style.display='none';
	}
	
	/**
	 * 정규식 체크
	 */
	function isRegexCheck(value, regex) {
		var returnValue = false;
		returnValue = regex.test(value);
		return returnValue;
		 
	}
	
	/**
	 * 공백 포함여부 체크
	 * true : 포함
	 * false : 미포함
	 */
	function isContainEmpty(value) {
		var p = /[\s]/g;
		if ( p.test(value) )
			return true;
		return false;
	}
//-->
</script>
<form id="frmMember" name="frmMember" method="post"  enctype="multipart/form-data">
	<input type="hidden" id="memGubunSelect" name="memGubunSelect" value="${LoginVO.memGubunSelect }" />
	<input type="hidden" id="searchType3" name="searchType3" value="${LoginVO.searchType3 }" />
	<input type="hidden" id="menuId" name="menuId" value="<c:out value='${menuId}'/>"/> 
	<input type="hidden" id="memSeq" name="memSeq" value="<c:out value='${result.memSeq}'/>"/>
	<input type="hidden" id="deleteYn" name="deleteYn" value="${result.deleteYn }"/>
	
	<input type="hidden" id="memType" name="memType" value="P"/>
	
	<div class="title-name-1">회원수정</div>
	<table border="0" cellpadding="0" cellspacing="0" class="view-2">
		<tbody>
			<tr>
				<th>회원구분</th>
				<td  colspan="3">
					<select id="authGroupId" name="authGroupId">
			<c:forEach var="utlist" items="${utlist}" varStatus="status">
				<option value="${utlist.codeCode }" <c:if test="${result.authGroupId eq utlist.codeCode }">selected</c:if> >${utlist.codeName }</option>
			</c:forEach> 
					</select>
				</td>
			 
			</tr>
			<tr>
				<th>아이디</th>
				<td colspan="3">
					<input type="hidden" id="memId" name="memId" value="${result.memId }" readonly/>
					<c:out value="${result.memIdStr }"/>
				</td>
			</tr>
 
			<tr>
				<th>First Name</th>
				<td>
				<input type="text" id="memName" name="memNameStr" value="${result.memNameStr }"/>
				</td>
				<th>Last Name</th>
				<td>
				<input type="text" id="memLastName" name="memLastNameStr" value="${result.memLastNameStr }"/>
				</td>
			</tr>
			<tr>
				<th>국가</th>
				<td>
					<select id="memNation" name="memNation">
						<c:forEach var="nation" items="${nation}">
							<option value="${nation.natCd}" <c:if test="${result.memNation eq nation.natCd }">selected</c:if> >${nation.natName }(${nation.natNameKr })</option>
						</c:forEach>
					</select>
				</td>
				<th>기관</th>
				<td><input type="text" id="orgName" name="orgName" value="${result.orgName }"/></td>
			</tr>
			<tr>
				<th>생년월일</th>
				<td  colspan="3"><input type="text" id="memBirth" name="memBirthStr" value="${result.memBirthStr }"/></td>
 
			</tr>			
			<tr>
				<th>기관구분</th>
				<td  colspan="3">
			<c:forEach var="otlist" items="${otlist}" varStatus="status"> 
				<input type="radio" name="orgGubun" value="${otlist.codeCode }" <c:if test="${result.orgGubun eq otlist.codeCode }">checked</c:if> />${otlist.codeName }&nbsp;&nbsp;&nbsp;
			</c:forEach>				 
				</td>
			</tr>
			<tr>
				<th>부서명</th>
				<td><input type="text" id="depName" name="depName" value="${result.depName}"/></td>
				<th>직업</th>
				<td><input type="text" id="memJob" name="memJob" value="${result.memJob}"/></td>
			</tr>
			<tr>
				<th>이메일</th>
				<td>
					<input type="text" id="email" name="emailStr" value="${result.emailStr}" readonly/>
					<a href="#" onclick="javascript:fn_findOverlapEmail();" class="btn">Email Check</a>
					<a href="#" onclick="javascript:fn_resetEmail();" class="btn" id="resetEmail">Rewrite</a>
					<input type="checkbox" id="receiveMailYn" name="receiveMailYn" value="Y" <c:if test="${result.receiveMailYn eq 'Y' }">checked</c:if>/>Mailing
				</td>
				<th>추가이메일</th>
				<td>
					<input type="text" id="emailSub" name="emailSubStr" value="${result.emailSubStr}" readonly/>
					<a href="#" onclick="javascript:fn_findOverlapEmailSub();" class="btn">Sub Email Check</a>
					<a href="#" onclick="javascript:fn_resetEmailSub();" class="btn" id="resetEmailSub" >Rewrite</a>
				</td>
			</tr>
			<tr>
				<th>무선번호</th>
				<td  colspan="3"><input type="text" id="hpNo" name="hpNoStr" value="${result.hpNoStr }"/>(Country - City code - Number)</td>
			</tr>
			<tr>
				<th>유선번호</th>
				<td  colspan="3"><input type="text" id="telNo" name="telNoStr" value="${result.telNoStr }"/>(Country - City code - Number)</td>
			</tr>
		</tbody>
	</table>
</form>

<div class="page-btn">
	<a href="#!" onclick="fn_save();">저장</a>
	<a href="#!" onclick="fn_search();">목록</a>
</div>