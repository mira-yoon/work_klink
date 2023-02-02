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
				$("input[name=orgChk]").prop("checked", true);
			} else {
				$("input[name=orgChk]").prop("checked", false);
			}
		});
	});
	
	function fn_chkFnc(){
		var chkLeng = $("input[name=orgChk]:checked").length;
		if (chkLeng == 0) {
			alert("삭제할 기관을 선택해주세요.");
			return;
		}else{
			if(!fn_chkList()) {
				return;
			}
			if(confirm("선택한 기관을 삭제하시겠습니까?")){
				$("#deleteYn").val("Y");
				var reqUrl = "/la/organization/updateOrganizationList";
				$("#frmOrganization").attr("action", reqUrl);
				$("#frmOrganization").attr("target","_self");
				$("#frmOrganization").submit();
			}
		}
	}
	
	function fn_chkList(){
		var chk = document.getElementsByName("orgChk");
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
	
	/* 리스트 조회 */
	function fn_search( param1 ){
		$("#pageIndex").val( param1 );
		$("#pageSize").val($("#searchPageSize").val());
		var reqUrl = "/la/organization/listOrganization";
		$("#frmOrganization").attr("action", reqUrl);
		$("#frmOrganization").attr("target","_self");
		$("#frmOrganization").submit();
	}
	/* 상세 조회 */
	function fn_detail(param){
		document.frmOrganization.orgCd.value=param;
		var reqUrl = "/la/organization/goDetailOrganization";
		$("#frmOrganization").attr("action", reqUrl);
		$("#frmOrganization").attr("target","_self");
		$("#frmOrganization").submit();
	}
	/* 작성 화면 */
	function fn_write(){
		var reqUrl = "/la/organization/goInsertOrganization";
		$("#frmOrganization").attr("action", reqUrl);
		$("#frmOrganization").attr("target","_self");
		$("#frmOrganization").submit();
	}
	/* 수정화면 */
	function fn_update(param){
		document.frmOrganization.orgCd.value=param;
		var reqUrl = "/la/organization/goUpdateOrganization";
		$("#frmOrganization").attr("action", reqUrl);
		$("#frmOrganization").attr("target","_self");
		$("#frmOrganization").submit();
	}
	/* 삭제 */
	function fn_delete(param){
		if(confirm("해당 기관을 삭제하시겠습니까?")){
			$("#deleteYn").val("Y");
			document.frmOrganization.orgCd.value=param;
			var reqUrl = "/la/organization/updateOrganization";
			$("#frmOrganization").attr("action", reqUrl);
			$("#frmOrganization").attr("target","_self");
			$("#frmOrganization").submit();
		}
	}
</script>

<form id="frmOrganization" name="frmOrganization" method="post" enctype="multipart/form-data">
	<input type="hidden" id="menuId" name="menuId" value="<c:out value='${menuId}'/>"> 
	<input type="hidden" id="pageIndex" name="pageIndex" value="<c:out value='${pageIndex}'/>" />
	<input type="hidden" id="pageSize" name="pageSize" value="<c:out value='${pageSize }'/>" />
	<input type="hidden" id="deleteYn" name="deleteYn" value="N"/>
	<input type="hidden" id="orgCd" name="orgCd" value=""/>
	<input type="hidden" id="checkList" name="checkList" value=""/>
	
	<div class="title-name-1">검색 조건</div>
	
	<ul class="search-list-1" style="margin-top:7px;">
		<li>
			<span style="width: 5%;">사용여부</span>
			<select id="searchUseYn" name="searchUseYn" style="width:180px; margin-right:30px;">
				<option value="">전체</option>
				<option value="Y" <c:if test="${'Y' == adminOrganizationVO.searchUseYn}"> selected </c:if>>사용</option>
				<option value="N" <c:if test="${'N' == adminOrganizationVO.searchUseYn}"> selected </c:if>>비사용</option>
			</select>
			<span style="width: 5%;">기관명 검색</span>  
			<input type="text" name="searchKeyword" id="searchKeyword" value="${adminOrganizationVO.searchKeyword}" style="width:200px;" />
		</li>	
	</ul>
			
	<div class="search-btn-area"><a href="#" onclick="javascript:fn_search(1);">조회</a></div>
	
	<ul class="board-info">
		<li class="info-area">
			<span>전체 : </span> <c:out value="${totalCount}" /> 건
		</li>
		<li class="btn-area">
			<a href="javascript:fn_chkFnc();">선택삭제</a> 
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
		<th width="5%">번호</th>
		<th width="17%">기관명</th>
		<th>기관명(전체)</th>
		<th width="17%">기관 홈페이지</th>
		<th width="17%">사용여부</th>
		<th width="10%">관리</th>
	</tr>
	</thead>
	<tbody>
	<c:forEach var="result" items="${resultList}" varStatus="status">
		<tr>
			<td><input type="checkbox" name="orgChk" value="<c:out value="${result.orgCd}" />" /></td>
			<td>
				<c:out value="${totalCount - ((pageIndex-1) * pageSize + status.count)+1}"/>
			</td>	
			<td>
				<a href="#" onclick="javascript:fn_detail('${result.orgCd}');" >
					<c:out value="${result.orgName }"/>
				</a>
			</td>
			<td>
				<a href="#" onclick="javascript:fn_detail('${result.orgCd}');" >
					<c:out value="${result.orgNameFull}"/>
				</a>
			</td>
			<td><c:out value="${result.orgUrl }"/></td>
			<td>
				<c:choose>
					<c:when test="${result.useYn == 'Y'}">
						사용
					</c:when>
					<c:otherwise>
						미사용
					</c:otherwise>
				</c:choose>
			</td>
			<td>
				<a href="#@" onclick="fn_update('${result.orgCd}');" class="btn-1">수정</a>
				<a href="#@" onclick="fn_delete('${result.orgCd}');" class="btn-2">삭제</a>
			</td>
		</tr>							
	</c:forEach>
	<c:if test="${fn:length(resultList) == 0}">
			<tr>
				<td colspan="7">
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