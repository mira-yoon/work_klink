<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%@ 
taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %><%@ 
taglib prefix="spring" uri="http://www.springframework.org/tags" %><%@ 
taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%><%@ 
taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@ 
taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%@ 
taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" media="all" />
<script type="text/javascript">
	$(document).ready(function() {
		$("#allCheck").on("click", function() {
			if ($(this).is(":checked")) {
				$("input[name=memChk]").prop("checked", true);
			} else {
				$("input[name=memChk]").prop("checked", false);
			}
		});
		
		com.datepicker("sdate");
		com.datepicker("edate");
		
	});
	
	function fn_chkFnc(param){
		var chkLeng = $("input[name=memChk]:checked").length;
		if (chkLeng == 0) {
			alert("변경할 회원을 선택해주세요.");
			return;
		}else{
			if(!fn_chkList()) {
				return;
			}
			$("#updateType").val(param);
			if(param == 'C'){
				if(confirm("선택된 회원을 변경하시겠습니까?")){
					$("#authGroupId").val($("#memTypeSelect option:selected").val());
					var reqUrl = "/la/member/updateMemberList";
					$("#frmMember").attr("action", reqUrl);
					$("#frmMember").attr("target","_self");
					$("#frmMember").submit();
				}
			}else if(param == 'D'){
				if(confirm("선택된 회원을 삭제하시겠습니까?")){
					$("#deleteYn").val("Y");
					var reqUrl = "/la/member/updateMemberList";
					$("#frmMember").attr("action", reqUrl);
					$("#frmMember").attr("target","_self");
					$("#frmMember").submit();
				}
			}
		}
	}
	
	function fn_excel(){
		$("#authGroupId").val($("#memGubunSelect option:selected").val());
		var reqUrl = "/la/member/listMemberExcelDown";
		$("#frmMember").attr("action", reqUrl);
		$("#frmMember").attr("target", "_blank");
		$("#frmMember").submit();
	}
	
	/* 리스트 조회 */
	function fn_search( param1 ){
		$("#pageIndex").val( param1 );
		$("#pageSize").val($("#searchPageSize").val());
		var reqUrl = "/la/member/listMember";
		$("#frmMember").attr("action", reqUrl);
		$("#frmMember").attr("target","_self");
		$("#frmMember").submit();
	} 
	/* 상세 조회 */
	function fn_detail(param){
		document.frmMember.memSeq.value=param;
		var reqUrl = "/la/member/goDetailMember";
		$("#frmMember").attr("action", reqUrl);
		$("#frmMember").attr("target","_self");
		$("#frmMember").submit();
	}
	/* 작성 화면 */
	function fn_write(){
		var reqUrl = "/la/member/goInsertMember";
		$("#frmMember").attr("action", reqUrl);
		$("#frmMember").attr("target","_self");
		$("#frmMember").submit();
		
	}
	/* 수정화면 */
	function fn_update(param){
		document.frmMember.memSeq.value=param;
		var reqUrl = "/la/member/goUpdateMember";
		$("#frmMember").attr("action", reqUrl);
		$("#frmMember").attr("target","_self");
		$("#frmMember").submit();
	}
	/* 삭제 */
	function fn_delete(param){
		if(confirm("해당 회원을 삭제하시겠습니까?")){
			$("#deleteYn").val("Y");
			document.frmMember.memSeq.value=param;
			var reqUrl = "/la/member/updateMember";
			$("#frmMember").attr("action", reqUrl);
			$("#frmMember").attr("target","_self");
			$("#frmMember").submit();
		}
	}
	
	function fn_chkList(){
		var chk = document.getElementsByName("memChk");
		var len = chk.length;
		var checkRow = "";
		var checkCnt = 0;
		var checkLast = "";
		var rowId = "";
		var cnt = 0;
		
		for(var i=0;i<len;i++){
			if(chk[i].checked == true){
				checkCnt++;
				checkLast = i;
			}
		}
		for(var i=0;i<len;i++){
			if(chk[i].checked == true){
				checkRow = chk[i].value;
				
				if(checkCnt == 1){
					rowId += ""+checkRow+"";
				}else{
					if(i == checkLast){
						rowId += ""+checkRow+"";
					}else{
						rowId += ""+checkRow+",";
					}
				}
				cnt ++;
				checkRow = '';
			}
		}
		$("#checkList").val(rowId);
		if($("#checkList").val() != ''){
			return true;
		}else{
			return false;
		}
	}
	
	function fn_reset(seq, id){
		var msg = id+"님의 비밀번호를 등록된 이메일로 변경하시겠습니까?";
		if(confirm(msg)){
			$("#memSeq").val(seq);
			if($("#memSeq").val() != ''){
				var reqUrl = "/la/member/resetMemberPass";
				$("#frmMember").attr("action", reqUrl);
				$("#frmMember").attr("target","_self");
				$("#frmMember").submit();
			}else{
				alert("다시 시도해 주세요.!");
			}
		}else{
			$("#memSeq").val("");
		}
	}
	
	function fn_excelLog(){
		
		var sDate = com.replaceAll($("#sdate").val(),'-','');
		var eDate = com.replaceAll($("#edate").val(),'-','');

		if ( sDate > eDate ) {
			alert("시작일은 종료일보다 이전이어야 합니다.");
			$("#sdate").focus();
			return false;
		}else if(sDate == "" || eDate == ""){
			alert("로그 기간을 설정해 주세요.");
			$("#sdate").focus();
			return false;
		}
		
		var reqUrl = "/la/member/listLogExcelDown";
		$("#frmMember").attr("action", reqUrl);
		$("#frmMember").attr("target", "_blank");
		$("#frmMember").submit();
	}
	
</script>

<form id="frmMember" name="frmMember" method="post">
	<input type="hidden" id="menuId" name="menuId" value="<c:out value='${menuId}'/>"> 
	<input type="hidden" id="pageIndex" name="pageIndex" value="${pageIndex}" />
	<input type="hidden" id="pageSize" name="pageSize" value="${pageSize }" />
	<input type="hidden" id="deleteYn" name="deleteYn" value="N"/>
	<input type="hidden" id="memSeq"  name="memSeq" value=""/>
	<input type="hidden" id="checkList" name="checkList" value=""/>
	<input type="hidden" id="memType" name="memType" value=""/>
	<input type="hidden" id="authGroupId" name="authGroupId" value=""/>
	<input type="hidden" id="updateType" name="updateType" value=""/>
	
	<div class="title-name-1">검색 조건</div>
	
	<ul class="search-list-1" style="margin-top:7px;">
		<li>
			<span style="width: 10%;"> ID 검색</span>
			<input type="text" name="searchKeyword" id="searchKeyword" value="${LoginVO.searchKeyword }" style="width:150px;" />
		</li>
		<li>
			<span style="width: 10%;"> 이름 검색</span>
			<input type="text" name="searchName" id="searchName" value="${LoginVO.searchNameStr }" style="width:150px;" />
		</li>
		<li>			
			<span style="width: 10%;">국적 검색</span>
			<input type="text" name="searchNatCd" id="searchNatCd" value="${LoginVO.searchNatCd }" style="width:150px;" />
			※한글 영문 모두 검색됨
		</li>
		<li>
			<span style="width: 10%;">회원구분 검색</span>
			<select id="memGubunSelect" name="memGubunSelect" onchange="javascript:fn_search(1)">
				<option value="">전체회원</option>
			<c:forEach var="utlist" items="${utlist}" varStatus="status">
				<option value="${utlist.codeCode }" <c:if test="${utlist.codeCode eq LoginVO.memGubunSelect }">selected</c:if>>${utlist.codeName }</option>
			</c:forEach>
			</select>
		</li>
		
		<li>
			<span style="width: 10%;">로그기간</span>
			<input type="text" name="searchStartDate" id="sdate" maxlength="10" value="" readonly="readonly"/> ~
			<input type="text" name="searchEndDate" id="edate" maxlength="10" value="" readonly="readonly"/>
		</li>
		
	</ul>
			
	<div class="search-btn-area">
		<a href="javascript:fn_excelLog();" class="btn">로그다운로드</a>&nbsp;&nbsp;&nbsp;&nbsp;
		<a href="javascript:fn_excel();" class="btn">엑셀다운</a>&nbsp;&nbsp;&nbsp;
		<a href="#" onclick="javascript:fn_search(1);">조회</a>
	</div>
	
	<ul class="board-info">
		<li class="info-area">
			<span>전체 : </span> <c:out value="${totalCount}" /> 건<br/>
			<span style="margin-left: 0px;">선택한 회원을 : 
			<select id="memTypeSelect" name="memTypeSelect">
				<option value="">전체회원</option>
			<c:forEach var="utlist" items="${utlist}" varStatus="status">
				<option value="${utlist.codeCode }">${utlist.codeName }</option>
			</c:forEach>
			</select>
			(으)로 
			<a href="javascript:fn_chkFnc('C');" class="btn-blue">변경</a>
			<a href="javascript:fn_chkFnc('D');">탈퇴</a></span>
		</li>				
		<li class="btn-area">			
			정렬:
			<select name="searchType3" id="searchType3" onchange="javascript:fn_search(1)" >
				<option value="">-선택-</option>
				<option value="LAST_LOGIN_YMD" <c:if test="${LoginVO.searchType3 eq 'LAST_LOGIN_YMD' }">selected</c:if>>최종방문일</option>
				<option value="INSERT_DATE" <c:if test="${LoginVO.searchType3 eq 'INSERT_DATE' }">selected</c:if>>가입일순</option>
				<option value="LOGIN_CNT" <c:if test="${LoginVO.searchType3 eq 'LOGIN_CNT'}">selected</c:if>>방문수</option>
			</select> 
			
			<select name="searchPageSize" id="searchPageSize" title="목록 갯수 설정하기" onchange="javascript:fn_search(1)">
				<option value="10" <c:if test="${pageSize=='10' }" > selected</c:if> >10 개</option>
				<option value="20" <c:if test="${pageSize=='20' }" > selected</c:if> >20 개</option>
				<option value="30" <c:if test="${pageSize=='30' }" > selected</c:if> >30 개</option>
				<option value="50" <c:if test="${pageSize=='50' }" > selected</c:if> >50 개</option>
			</select>
		</li>
	</ul>
</form>

<table  border="0" cellpadding="0" cellspacing="0" class="list-1">
	<thead>
	<tr>
		<th width="30px;">
			<input id="allCheck" type="checkbox" title="회원 전체선택"alt="회원선택"> 
			<label for="allCheck"></label>
		</th>
		<th width="40px">번호</th>
		<th width="100px">회원구분</th>
		<!--th width="70px">회원상태</th -->
		<th>국적</th>
		<th>ID</th>
		<th>이름</th>
		<th width="100px">최종방문일</th>
		<th width="80px">방문횟수</th>
		<th width="140px">관리</th>     
	</tr>
	</thead> 
	<tbody>
	<c:forEach var="result" items="${resultList}" varStatus="status">
		<tr>
			<td><input type="checkbox" name="memChk" value="<c:out value="${result.memSeq}" />" /></td>
			<td>
				<c:out value="${totalCount - ((pageIndex-1) * pageSize + status.count)+1}"/>
			</td>	
			<td>
				${result.memTypeName } 				
			</td>
			<%--
			<td>
				 <c:if test="${result.memType eq 'A' }">대기(신청)</c:if>
				 <c:if test="${result.memType eq 'P' }">승인</c:if>
				 <c:if test="${result.memType eq 'R' }">반려</c:if>				 
			</td --%> 
			<td>${result.natNameKr}</td>
			<td>
				<a href="javascript:fn_detail('${result.memSeq }')">
					<c:out value="${result.memId }"/>
				</a>
			</td>
			<td><c:out value="${result.memNameStr }"/></td>
			<td><c:out value="${result.lastLoginYmd }"/></td>
			<td><c:out value="${result.loginCnt }"/></td>
			<td>
				<a href="#@" onclick="fn_update('${result.memSeq}');" class="btn-1">수정</a>
				<a href="#@" onclick="fn_reset('${result.memSeq}','${result.memId}');" class="btn-1">비밀번호 초기화</a>
				<!--a href="#@" onclick="fn_delete('${result.memSeq}');" class="btn-2">삭제</a-->
			</td>
		</tr>							
	</c:forEach>
	<c:if test="${fn:length(resultList) == 0}">
			<tr>
				<td colspan="10">
					조회된 데이터가 없습니다.
				</td>
			</tr>
	</c:if>
	</tbody>
</table>

<div class="page-btn">
	<a href="#" onclick="fn_write();">등록</a>
</div>

<div class="page-num">
	<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_search" /> 
</div><!-- E : page-num -->