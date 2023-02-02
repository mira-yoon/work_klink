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
				$("input[name=natChk]").prop("checked", true);
			} else {
				$("input[name=natChk]").prop("checked", false);
			}
		});
	});
	
	function fn_chkFnc(param){
		var chkLeng = $("input[name=natChk]:checked").length;
		if (chkLeng == 0) {
			alert("변경할 국가를 선택해주세요.");
			return;
		}else{
			if(!fn_chkList()) {
				return;
			}
			$("#updateType").val(param);
			if(param == 'C'){
				var useYnSelect  = $("#useYnSelect option:selected").val();
				if(useYnSelect != ''){
					if(confirm("선택된 국가를 변경하시겠습니까?")){
						$("#useYn").val(useYnSelect);
						var reqUrl = "/la/nation/updateNationList";
						$("#frmNation").attr("action", reqUrl);
						$("#frmNation").attr("target","_self");
						$("#frmNation").submit();
					}
				}else{
					alert("변경할 상태를 선택해주세요.");
				}
			}else if(param == 'D'){
				if(confirm("선택된 국가를 삭제하시겠습니까?")){
					$("#deleteYn").val("Y");
					var reqUrl = "/la/nation/updateNationList";
					$("#frmNation").attr("action", reqUrl);
					$("#frmNation").attr("target","_self");
					$("#frmNation").submit();
				}
			}
		}
	}
	
	/* 리스트 조회 */
	function fn_search( param1 ){
		$("#pageIndex").val( param1 );
		$("#pageSize").val($("#searchPageSize").val());
		var reqUrl = "/la/nation/listNation";
		$("#frmNation").attr("action", reqUrl);
		$("#frmNation").attr("target","_self");
		$("#frmNation").submit();
	}
	/* 상세 조회 */
	function fn_detail(param){
		document.frmNation.natCd.value=param;
		var reqUrl = "/la/nation/goDetailNation";
		$("#frmNation").attr("action", reqUrl);
		$("#frmNation").attr("target","_self");
		$("#frmNation").submit();
	}
	/* 작성 화면 */
	function fn_write(){
		var reqUrl = "/la/nation/goInsertNation";
		$("#frmNation").attr("action", reqUrl);
		$("#frmNation").attr("target","_self");
		$("#frmNation").submit();
	}
	/* 수정화면 */
	function fn_update(param){
		document.frmNation.natCd.value=param;
		var reqUrl = "/la/nation/goUpdateNation";
		$("#frmNation").attr("action", reqUrl);
		$("#frmNation").attr("target","_self");
		$("#frmNation").submit();
	}
	/* 삭제 */
	function fn_delete(param){
		if(confirm("해당 글을 삭제하시겠습니까?")){
			$("#deleteYn").val("Y");
			document.frmNation.natCd.value=param;
			var reqUrl = "/la/nation/updateNation";
			$("#frmNation").attr("action", reqUrl);
			$("#frmNation").attr("target","_self");
			$("#frmNation").submit();
		}
	}
	
	function fn_chkList(){
		var chk = document.getElementsByName("natChk");
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
	
</script>

<form id="frmNation" name="frmNation" method="post">
	<input type="hidden" id="menuId" name="menuId" value="<c:out value='${menuId}'/>"> 
	<input type="hidden" id="pageIndex" name="pageIndex" value="<c:out value='${pageIndex}'/>" />
	<input type="hidden" id="pageSize" name="pageSize" value="<c:out value='${pageSize }'/>" />
	<input type="hidden" id="deleteYn" name="deleteYn" value="N"/>
	<input type="hidden" id="natCd" name="natCd" value=""/>
	<input type="hidden" id="checkList" name="checkList" value=""/>
	<input type="hidden" id="useYn" name="useYn" value=""/>
	<input type="hidden" id="updateType" name="updateType" value=""/>
	
	<div class="title-name-1">검색 조건</div>
	
	<ul class="search-list-1" style="margin-top:7px;">
		<li>
			<span style="width: 5%;">대륙구분</span>
			<select id="searchPartCd" name="searchPartCd" style="width:180px; margin-right:30px;">
				<option value="">전체</option>
				<c:forEach var="partCdList" items="${partCdList}" varStatus="status">
					<option value="${partCdList.codeCode}" <c:if test="${partCdList.codeCode eq adminNationVO.searchPartCd}">selected</c:if>>${partCdList.codeName}</option>
				</c:forEach>
			</select>
			<span style="width: 5%;">국가구분</span>
			<select id="searchTypeCd" name="searchTypeCd" style="width:180px; margin-right:30px;">
				<option value="">전체</option>
				<c:forEach var="typeCdList" items="${typeCdList}" varStatus="status">
					<option value="${typeCdList.codeCode}" <c:if test="${typeCdList.codeCode eq adminNationVO.searchTypeCd}">selected</c:if>>${typeCdList.codeName}</option>
				</c:forEach>
			</select>
		</li>
		<li>
			<span style="width: 5%;">사용여부</span>
			<select id="searchUseYn" name="searchUseYn" style="width:180px; margin-right:30px;">
				<option value="">전체</option>
				<option value="Y" <c:if test="${'Y' == adminNationVO.searchUseYn}"> selected </c:if>>공개</option>
				<option value="N" <c:if test="${'N' == adminNationVO.searchUseYn}"> selected </c:if>>비공개</option>
			</select>
			<span style="width: 5%;">국가명 검색</span>
			<select id="searchNatName" name="searchNatName"   style="width:90px;">
				<option value="">전체</option>
				<option value="E" <c:if test="${'E' == adminNationVO.searchNatName}"> selected </c:if>>영문</option>
				<option value="K" <c:if test="${'K' == adminNationVO.searchNatName}"> selected </c:if>>국문</option>
			</select>
			<input type="text" name="searchKeyword" id="searchKeyword" value="${adminNationVO.searchKeyword}" style="width:200px;" />
		</li>	
	</ul>
	
	<div class="search-btn-area"><a href="#" onclick="javascript:fn_search(1);">조회</a></div>
	
	<ul class="board-info">
		<li class="info-area"><span>전체 : </span> <c:out value="${totalCount}" /> 건</li>
		<li class="btn-area">
			<select id="useYnSelect" name="useYnSelect">
				<option value="">선택</option>
				<option value="Y">공개</option>
				<option value="N">비공개</option>
			</select>
			<a href="javascript:fn_chkFnc('C');">상태변경</a> 
			<a href="javascript:fn_chkFnc('D');">선택삭제</a> 
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
		<th>대륙구분</th>
		<th width="17%">국가구분</th>
		<th width="17%">국가명</th>
		<th width="17%">국가명(KR)</th>
		
		<th width="10%">국가배점</th>
	
		<th width="10%">상태</th>
		<th width="10%">관리</th>
	</tr>  
	</thead>
	<tbody>
	<c:forEach var="result" items="${resultList}" varStatus="status">
		<tr>
			<td><input type="checkbox" name="natChk" value="<c:out value="${result.natCd}" />" /></td>
			<td>
				<c:out value="${totalCount - ((pageIndex-1) * pageSize + status.count)+1}"/>
			</td>	
			<td><c:out value="${result.partCdName }"/></td>
			<td><c:out value="${result.typeCdName}"/></td>
			<td>
				<a href="#" onclick="javascript:fn_detail('${result.natCd}');" >
					<c:out value="${result.natName }"/>
				</a>
			</td>
			<td>
				<a href="#" onclick="javascript:fn_detail('${result.natCd}');" >
					<c:out value="${result.natNameKr}"/>
				</a>
			</td>
			<td><c:out value="${result.natScore}"/></td>
			<td>
				<c:choose>
					<c:when test="${result.useYn == 'Y'}">
						공개
					</c:when>
					<c:otherwise>
						비공개
					</c:otherwise>
				</c:choose>
			</td>
			<td>
				<a href="#@" onclick="fn_update('${result.natCd}');" class="btn-1">수정</a>
				<a href="#@" onclick="fn_delete('${result.natCd}');" class="btn-2">삭제</a>
			</td>
		</tr>							
	</c:forEach>
	<c:if test="${fn:length(resultList) == 0}">
			<tr>
				<td colspan="9">
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