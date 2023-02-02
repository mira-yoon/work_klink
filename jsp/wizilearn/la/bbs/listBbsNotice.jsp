<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%@ 
taglib prefix="spring" uri="http://www.springframework.org/tags" %><%@ 
taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%><%@ 
taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@ 
taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%@ 
taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" media="all" />
<script type="text/javascript">
	$(document).ready(function() {
		$("#allCheck").on("click", function() {
			if ($(this).is(":checked")) {
				$("input[name=bbsChk]").prop("checked", true);
			} else {
				$("input[name=bbsChk]").prop("checked", false);
			}
		});
	});
	
	function fn_chkFnc(){
		var chkLeng = $("input[name=bbsChk]:checked").length;
		if (chkLeng == 0) {
			alert("삭제할 글을 선택해주세요.");
			return;
		}else{
			if(!fn_chkList()) {
				return;
			}
			if(confirm("선택된 글을 삭제하시겠습니까?")){
				var bbsId = $("#bbsId").val();
				$("#deleteYn").val("Y");
				var reqUrl = "/la/bbs/"+bbsId+"/updateBbsNoticeList";
				$("#frmBbs").attr("action", reqUrl);
				$("#frmBbs").attr("target","_self");
				$("#frmBbs").submit();
			}
		}
	}
	
	/* 리스트 조회 */
	function fn_search( param1 ){
		var bbsId = $("#bbsId").val();
		$("#pageIndex").val( param1 );
		$("#pageSize").val($("#searchPageSize").val());
		var reqUrl = "/la/bbs/"+bbsId+"/listBbsNotice";
		$("#frmBbs").attr("action", reqUrl);
		$("#frmBbs").attr("target","_self");
		$("#frmBbs").submit();
	}
	/* 상세 조회 */
	function fn_detail(param){
		var bbsId = $("#bbsId").val();
		
		document.frmBbs.bbsNoticeId.value=param;
		
		var reqUrl = "/la/bbs/"+bbsId+"/goDetailBbsNotice";
		$("#frmBbs").attr("action", reqUrl);
		$("#frmBbs").attr("target","_self");
		$("#frmBbs").submit();
	}
	/* 작성 화면 */
	function fn_write(){
		var bbsId = $("#bbsId").val();
		var reqUrl = "/la/bbs/"+bbsId+"/goInsertBbsNotice";
		$("#frmBbs").attr("action", reqUrl);
		$("#frmBbs").attr("target","_self");
		$("#frmBbs").submit();
		
	}
	/* 수정화면 */
	function fn_update(param){
		var bbsId = $("#bbsId").val();
		
		document.frmBbs.bbsNoticeId.value=param;
		
		var reqUrl = "/la/bbs/"+bbsId+"/goUpdateBbsNotice";
		$("#frmBbs").attr("action", reqUrl);
		$("#frmBbs").attr("target","_self");
		$("#frmBbs").submit();
	}
	/* 삭제 */
	function fn_delete(param){
		if(confirm("해당 글을 삭제하시겠습니까?")){
		var bbsId = $("#bbsId").val();
		$("#deleteYn").val("Y");
		
		document.frmBbs.bbsNoticeId.value=param;
		
		var reqUrl = "/la/bbs/"+bbsId+"/updateBbsNotice";
		$("#frmBbs").attr("action", reqUrl);
		$("#frmBbs").attr("target","_self");
		$("#frmBbs").submit();
		}
	}
	
	function fn_chkList(){
		var chk = document.getElementsByName("bbsChk");
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
	function fn_courseList(yearStr){
		
		var reqUrl = "/la/course/selectboxCourseList";
		if(yearStr==null || yearStr==""){
			alert("년도를 선택하세요");
			return;
		}else{
			$.ajax({
				url:reqUrl,
				type:"post",
				data:{ searchYear:yearStr },
				dataType:"json",
				success:function(data){
					var result = data.msg;
					var resultLists = data.resultList;
					if(result == "success"){		
						$("#searchCourseCd option:first").remove();
						$("#searchCourseCd").html("<option value='' >선택</option> ");
						for(var i=0; resultLists.length>i ; i++){
							$("#searchCourseCd").append("<option value='"+resultLists[i].courseCd+"' >"+resultLists[i].title+"</option> ");
						}
					}else{
						alert("작업 진행중 오류가 발행하였습니다.");
					}
				},
				error:function(e){
					console.log("ERROR!!!!!!!!!!!");
				}
			});			
		}

	}
</script>
	<c:set var="now" value="<%=new java.util.Date()%>"/>
	<fmt:formatDate var="nowDate" value="${now}" pattern="yyyy"/>
    <fmt:formatNumber value="${nowDate}" type="number" pattern="0000" var="nowDateNumberType" />
<form id="frmBbs" name="frmBbs" method="post" enctype="multipart/form-data">
	<input type="hidden" id="menuId" name="menuId" value="<c:out value='${menuId}'/>"> 
	<input type="hidden" id="pageIndex" name="pageIndex" value="${pageIndex}" />
	<input type="hidden" id="pageSize" name="pageSize" value="${pageSize }" />
	<input type="hidden" id="bbsId" name="bbsId" value="<c:out value='${bbsInfo.bbsId }'/>">
	<input type="hidden" id="bbsType" name="bbsType" value="<c:out value='${bbsInfo.bbsType}'/>">
	<input type="hidden" id="commentYn" name="commentYn" value="<c:out value='${bbsInfo.commentYn }'/>">
	<input type="hidden" id="fileYn" name="fileYn" value="<c:out value='${bbsInfo.fileYn }'/>">
	<input type="hidden" id="bbsSecertYn" name="bbsSecertYn" value="<c:out value='${bbsInfo.bbsSecertYn }'/>">
	<input type="hidden" id="readCnt" name="readCnt"/>
	<input type="hidden" id="deleteYn" name="deleteYn" value="N"/>
	<input type="hidden" id="bbsNoticeId" name="bbsNoticeId" value=""/>
	<input type="hidden" id="checkList" name="checkList" value=""/>
	
	<div class="title-name-1">검색 조건</div>
	
	<ul class="search-list-1" style="margin-top:7px;">

		<li>
			<span>제목</span>
			<input type="text" name="searchTitle" id="searchTitle" value="${comBbsNoticeVO.searchTitle }" style="width:150px;" />
		</li>
		<c:if test="${bbsInfo.bbsId eq 'BBSMSTR_0000001' }">
			<li>
				<span>유형</span>
				<select id="searchBbsNoticeSort" name="searchBbsNoticeSort" style="width:80px; margin-right:10px;">
					<option value="">전체</option>
					<option value="1" <c:if test="${'1' == comBbsNoticeVO.searchBbsNoticeSort}"> selected </c:if>>상단</option>
					<option value="2" <c:if test="${'2' == comBbsNoticeVO.searchBbsNoticeSort}"> selected </c:if>>일반</option>
				</select>
			</li>	
		</c:if>
		<li>
			<span>사용여부</span>
			<select id="searchUseYn" name="searchUseYn"   style="width:90px;">
				<option value="">전체</option>
				<option value="Y" <c:if test="${'Y' == comBbsNoticeVO.searchUseYn}"> selected </c:if>>노출</option>
				<option value="N" <c:if test="${'N' == comBbsNoticeVO.searchUseYn}"> selected </c:if>>숨김</option>
			</select>
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
		<th width="4%">
			<input id="allCheck" type="checkbox" title="회원 전체선택"alt="회원선택"> 
			<label for="allCheck"></label>
		</th>
		<th width="5%">번호</th>
		<th>제목</th>
		<th width="7%">작성자</th>
		<th width="7%">작성일</th>
		<c:if test="${bbsInfo.bbsId eq 'BBSMSTR_0000004' }">
			<th width="7%">답변여부</th>
			<th width="7%">답변일</th>
		</c:if>
		<th width="7%">조회수</th>
		<th width="7%">글상태</th>
		<th width="10%">관리</th>
	</tr>
	</thead>
	<tbody>
	<c:forEach var="result" items="${resultList}" varStatus="status">
		<tr>
			<td><input type="checkbox" name="bbsChk" value="<c:out value="${result.bbsNoticeId}" />" /></td>
			<td>
				<c:choose>
					<c:when test="${bbsInfo.bbsId eq 'BBSMSTR_0000001' }">
						<c:if test="${'1' == result.bbsNoticeSort}">
							<img src="/images/wizilearn/adm/inc/board_type_001.png" alt="상단"/>
						</c:if>
						<c:if test="${'2' == result.bbsNoticeSort}">
							<c:out value="${totalCount - ((pageIndex-1) * pageSize + status.count)+1}"/>
						</c:if>
					</c:when>
					<c:otherwise>
						<c:out value="${totalCount - ((pageIndex-1) * pageSize + status.count)+1}"/>
					</c:otherwise>
				</c:choose>
			</td>
		
			<td>
				<c:choose>
					<c:when test="${bbsInfo.bbsId eq 'BBSMSTR_0000004' }">
						<a href="#" onclick="javascript:fn_update('${result.bbsNoticeId}');" >
							<c:out value="${result.title }"/>
						</a>
					</c:when>
					<c:otherwise>
						<a href="#" onclick="javascript:fn_detail('${result.bbsNoticeId}');" >
							<c:out value="${result.title }"/>
						</a>
					</c:otherwise>
				</c:choose>
			</td>
			<td><c:out value="${result.insertUser }"/></td>
			<td><c:out value="${result.insertDate }"/></td>
			<c:if test="${bbsInfo.bbsId eq 'BBSMSTR_0000004' }">
			
				<c:if test="${result.replyYn eq 'Y'}">
					<td><c:out value="${result.replyYn }"/></td>
					<td><c:out value="${result.replyDate }"/></td>
				</c:if>
				
				<c:if test="${result.replyYn eq 'N'}">
					<td><c:out value="${result.replyYn }"/> <a href="#@" onclick="fn_update('${result.bbsNoticeId}');" class="btn-1">답변하기</a></td>
					<td>-</td>
				</c:if>
				
			</c:if>
			<td><c:out value="${result.readCnt }"/></td>
			<td>
				<c:choose>
					<c:when test="${result.useYn == 'Y'}">
						노출
					</c:when>
					<c:otherwise>
						숨김
					</c:otherwise>
				</c:choose>
			</td>
			<td>
				<a href="#@" onclick="fn_update('${result.bbsNoticeId}');" class="btn-1">수정</a>
				<a href="#@" onclick="fn_delete('${result.bbsNoticeId}');" class="btn-2">삭제</a>
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
<c:if test="${bbsInfo.bbsId ne 'BBSMSTR_0000004' }">
<div class="page-btn">
	<a href="#" onclick="fn_write();">등록</a>
</div>
</c:if>
<div class="page-num">
	<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_search" /> 
</div><!-- E : page-num -->