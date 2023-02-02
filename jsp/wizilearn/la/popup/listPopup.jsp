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
				$("input[name=popChk]").prop("checked", true);
			} else {
				$("input[name=popChk]").prop("checked", false);
			}
		});
	});
	
	function fn_chkFnc(){
		var chkLeng = $("input[name=popChk]:checked").length;
		if (chkLeng == 0) {
			alert("변경할 팝업을 선택해주세요.");
			return;
		}else{
			if(!fn_chkList()) {
				return;
			}
			if(confirm("해당 팝업을 삭제하시겠습니까?")){
				$("#deleteYn").val("Y");
				var reqUrl = "/la/popup/updatePopupList";
				$("#frmComPopup").attr("action", reqUrl);
				$("#frmComPopup").attr("target","_self");
				$("#frmComPopup").submit();
			}
		}
	}
	
	/* 리스트 조회 */
	function fn_search( param1 ){
		$("#pageIndex").val( param1 );
		$("#pageSize").val($("#searchPageSize").val());
		var reqUrl = "/la/popup/listPopup";
		$("#frmComPopup").attr("action", reqUrl);
		$("#frmComPopup").attr("target","_self");
		$("#frmComPopup").submit();
	}
	/* 상세 조회 */
	function fn_detail(param){
		document.frmComPopup.popupId.value=param;
		var reqUrl = "/la/popup/goDetailPopup";
		$("#frmComPopup").attr("action", reqUrl);
		$("#frmComPopup").attr("target","_self");
		$("#frmComPopup").submit();
	}
	/* 작성 화면 */
	function fn_write(){
		var reqUrl = "/la/popup/goInsertPopup";
		$("#frmComPopup").attr("action", reqUrl);
		$("#frmComPopup").attr("target","_self");
		$("#frmComPopup").submit();
	}
	/* 수정화면 */
	function fn_update(param){
		document.frmComPopup.popupId.value=param;
		var reqUrl = "/la/popup/goUpdatePopup";
		$("#frmComPopup").attr("action", reqUrl);
		$("#frmComPopup").attr("target","_self");
		$("#frmComPopup").submit();
	}
	/* 삭제 */
	function fn_delete(param){
		if(confirm("해당 팝업을 삭제하시겠습니까?")){
			$("#deleteYn").val("Y");
			document.frmComPopup.popupId.value=param;
			var reqUrl = "/la/popup/updatePopup";
			$("#frmComPopup").attr("action", reqUrl);
			$("#frmComPopup").attr("target","_self");
			$("#frmComPopup").submit();
		}
	}
	
	function fn_chkList(){
		var chk = document.getElementsByName("popChk");
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
	/* ********************************************************
	* 팝업창 미리보기
	******************************************************** */
	function fn_egov_view_PopupManage(){
	    var chk = false;
		var FLength = document.getElementsByName("popChk").length; 
	 
		if( FLength == 1){
			if(document.getElementById("checkList0").checked){
				fn_egov_ajaxPopupInfo_PopupManage( document.getElementById("checkList0").value );
			}else{
				alert("미리보기할 팝업을 선택하세요.");
			}
		}else if(FLength>1){
			for(var i=0; i < FLength; i++)
			{
				if(document.getElementsByName("checkList")[i].checked == true){
					fn_egov_ajaxPopupInfo_PopupManage( document.getElementsByName("checkList")[i].value );
					chk=true;
				}
			}
			
			if(!chk){
				alert("미리보기할 팝업을 선택하세요..");
			}
		} 
		return;

	}
	/* ********************************************************
	* 팝업창 정보 Ajax통신으로 정보 획득
	******************************************************** */
	function fn_egov_ajaxPopupInfo_PopupManage(popupIds){
	 var test1 = "popupId="+popupIds;
		$.ajax({      
	        type:"GET",  
	        url:"<c:url value='/la/popup/ajaxPopupManageInfo.do' />",      
	        data:test1,
	        success:function(args){   
	        	var returnValueArr = args.split("||");

		    	   	fn_egov_popupOpen_PopupManage(popupIds,
		        	    	returnValueArr[1],
		        	    	returnValueArr[2],
		        	    	returnValueArr[3],
		        	    	returnValueArr[4],
		        	    	returnValueArr[5] );

	        },
	        error:function(e){  
	            alert(e.responseText);  
	        }  
	    });  
	}
	/* ********************************************************
	* 팝업창  오픈
	******************************************************** */
	function fn_egov_popupOpen_PopupManage(popupId,width,height,top,left,stopviewYn){

		var url = "<c:url value='/la/popup/openPopupManage.do' />?";
		url = url + "stopviewYn=" + stopviewYn;
		url = url + "&popupId=" + popupId;
		var name = popupId;

		var openWindows = window.open(url,name,"width="+width+",height="+height+",top="+top+",left="+left+",toolbar=no,status=no,location=no,scrollbars=yes,menubar=no,resizable=yes");

		if (window.focus) {openWindows.focus()}
	}

</script>

<form id="frmComPopup" name="frmComPopup" method="post">
	<input type="hidden" id="menuId" name="menuId" value="<c:out value='${menuId}'/>"> 
	<input type="hidden" id="pageIndex" name="pageIndex" value="<c:out value='${pageIndex}'/>" />
	<input type="hidden" id="pageSize" name="pageSize" value="<c:out value='${pageSize }'/>" />
	<input type="hidden" id="deleteYn" name="deleteYn" value="N"/>
	<input type="hidden" id="popupId" name="popupId" value=""/>
	<input type="hidden" id="checkList" name="checkList" value=""/>
	
	<div class="title-name-1">검색 조건</div>
	
	<ul class="search-list-1" style="margin-top:7px;">
		<li>
			<span style="width: 5%;">사용여부</span>
			<select id="searchUseYn" name="searchUseYn" style="width:180px; margin-right:30px;">
				<option value="">전체</option>
				<option value="Y" <c:if test="${'Y' == comPopupVO.searchUseYn}"> selected </c:if>>공개</option>
				<option value="N" <c:if test="${'N' == comPopupVO.searchUseYn}"> selected </c:if>>비공개</option>
			</select>
			<span style="width: 5%;">팝업제목 검색</span>
			<input type="text" name="searchKeyword" id="searchKeyword" value="${comPopupVO.searchKeyword}" style="width:200px;" />
		</li>
	</ul>
	
	<div class="search-btn-area"><a href="#" onclick="javascript:fn_search(1);">조회</a></div>
	
	<ul class="board-info">
		<li class="info-area"><span>전체 : </span> <c:out value="${totalCount}" /> 건</li>
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
		<th>팝업제목</th>
		<th width="17%">공지기간</th>
		<th width="17%">공개여부</th>
		<th width="10%">관리</th>
	</tr>
	</thead>
	<tbody>
	<c:forEach var="result" items="${resultList}" varStatus="status">
		<tr>
			<td><input type="checkbox" name="popChk" id="checkList${status.index }"  value="<c:out value="${result.popupId}" />" /></td>
			<td>
				<c:out value="${totalCount - ((pageIndex-1) * pageSize + status.count)+1}"/>
			</td>	
			<td>
				<a href="#" onclick="javascript:fn_detail('${result.popupId}');" >
					<c:out value="${result.popupTitle}"/>
				</a>
			</td>
			<td><c:out value="${result.ntceBgnde}"/> ~ <c:out value="${result.ntceEndde}"/></td>
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
				<a href="#@" onclick="fn_update('${result.popupId}');" class="btn-1">수정</a>
				<a href="#@" onclick="fn_delete('${result.popupId}');" class="btn-2">삭제</a>
			</td>
		</tr>							
	</c:forEach>
	<c:if test="${fn:length(resultList) == 0}">
			<tr>
				<td colspan="6">
					조회된 데이터가 없습니다.
				</td>
			</tr>
	</c:if>
	</tbody>
</table>

<div class="page-btn">
	<a href="#@" class="btn-lg btn-blue" onclick="javascript:fn_egov_view_PopupManage();">미리보기</a>
	<a href="#" onclick="fn_write();">등록</a>
</div>

<div class="page-num">
	<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_search" /> 
</div><!-- E : page-num -->