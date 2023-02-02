<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%@ 
taglib prefix="spring" uri="http://www.springframework.org/tags" %><%@ 
taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%><%@ 
taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@ 
taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%@ 
taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" media="all" />
<script type="text/javascript">
<!--
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
				$("#deleteYn").val("Y");
				var reqUrl = "/la/community/updateCommunityList";
				$("#frmBbs").attr("action", reqUrl);
				$("#frmBbs").attr("target","_self");
				$("#frmBbs").submit();
			}
		}
	}
	
	/* 리스트 조회 */
	function fn_search( param1 ){ 
		$("#pageIndex").val( param1 );
		$("#pageSize").val($("#searchPageSize").val());
		var reqUrl = "/la/community/listCommunity";
		$("#frmBbs").attr("action", reqUrl);
		$("#frmBbs").attr("target","_self");
		$("#frmBbs").submit();
	}
	/* 상세 조회 */
	function fn_detail(param,year){ 
		
		$("#bbsNoticeId").val(param);
		$("#searchYear").val(year);
		
		var reqUrl = "/la/community/goDetailCommunity";
		$("#frmBbs").attr("action", reqUrl);
		$("#frmBbs").attr("target","_self");
		$("#frmBbs").submit();
	}
	/* 작성 화면 */
	function fn_write(){ 
		var reqUrl = "/la/community/goInsertCommunity";
		$("#frmBbs").attr("action", reqUrl);
		$("#frmBbs").attr("target","_self");
		$("#frmBbs").submit();
		
	}
	/* 수정화면 */
	function fn_update(param,year){ 
		 
		$("#bbsNoticeId").val(param);
		$("#searchYear").val(year);
		
		var reqUrl = "/la/community/goUpdateCommunity";
		$("#frmBbs").attr("action", reqUrl);
		$("#frmBbs").attr("target","_self");
		$("#frmBbs").submit();
	}
	/* 삭제 */
	function fn_delete(param){
		if(confirm("해당 글을 삭제하시겠습니까?")){ 
			$("#deleteYn").val("Y");
			$("#bbsNoticeId").val(param);
			var reqUrl = "/la/community/updateCommunity";
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

//-->
</script>
	<c:set var="now" value="<%=new java.util.Date()%>"/>
	<fmt:formatDate var="nowDate" value="${now}" pattern="yyyy"/>
    <fmt:formatNumber value="${nowDate}" type="number" pattern="0000" var="nowDateNumberType" />
<form id="frmBbs" name="frmBbs" method="post" enctype="multipart/form-data">
	<input type="hidden" id="menuId" name="menuId" value="<c:out value='${menuId}'/>" /> 
	<input type="hidden" id="pageIndex" name="pageIndex" value="${pageIndex}" />
	<input type="hidden" id="pageSize" name="pageSize" value="${pageSize }" />
	<input type="hidden" id="deleteYn" name="deleteYn" value="N"/>
	<input type="hidden" id="bbsNoticeId" name="bbsNoticeId"  />
	<input type="hidden" id="checkList" name="checkList"  />
	<input type="hidden" id="searchType" name="searchType" value="SUB" />
	<div class="title-name-1">검색 조건</div>
	
	<ul class="search-list-1" style="margin-top:7px;">

		<li>
			<span>과정</span>
			<select name="searchYear" id="searchYear" class="selectype" onchange="javascript:fn_courseList(this.value);">
				<option value="" selected> 선택 </option>
			<c:forEach var="yearVal" begin="0" end="20" varStatus="status">
			    <c:set var="yearValStr" value="${nowDateNumberType-yearVal}" />
				<c:choose>
					<c:when test="${comBbsNoticeVO.searchYear eq yearValStr}">
						<option value="${yearValStr }" selected>${yearValStr }년</option>
					</c:when>
					<c:otherwise>
						<option value="${yearValStr }" >${yearValStr }년</option>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			</select> 년도
						
			<select name="searchCourseCd"  id="searchCourseCd">
				
				<option value="" ><c:if test="${fn:length(courseList) == 0 }">- 년도선택 -</c:if><c:if test="${fn:length(courseList) > 0 }">- 전체 -</c:if></option>				
				<c:forEach var="courseList" items="${courseList}" varStatus="status">
					<option value="${courseList.courseCd}" <c:if test="${courseList.courseCd eq comBbsNoticeVO.searchCourseCd}" >selected</c:if> >${courseList.title}</option>
				</c:forEach>
			</select>
		</li>

		<li>
			<span>제목</span>
			<input type="text" name="searchKeyword" id="searchKeyword" value="${comBbsNoticeVO.searchKeyword }" style="width:150px;" />
		</li>
		 
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
		<th width="20%">과정명</th>
		<th>제목</th>
		<th width="7%">작성자</th>
		<th width="7%">작성일</th>
		<th width="7%">조회수</th>
		<th width="7%">글상태</th>
		<th width="10%">관리</th>
	</tr>
	</thead>
	<tbody>
	<c:forEach var="result" items="${resultList}" varStatus="status">
		<tr>
			<td><input type="checkbox" name="bbsChk" value="<c:out value="${result.bbsNoticeId}" />" /></td>
			<td><c:out value="${totalCount - ((pageIndex-1) * pageSize + status.count)+1}"/></td>
			<td><c:out value="${result.courseNm }"/></td>	
			<td>
				<a href="#" onclick="javascript:fn_detail('${result.bbsNoticeId}','${result.searchYear}');" >
					<c:out value="${result.title }"/>
				</a>
			</td>
			<td><c:out value="${result.insertUser }"/></td>
			<td><c:out value="${result.insertDate }"/></td>
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
				<a href="#@" onclick="fn_update('${result.bbsNoticeId}','${result.searchYear}');" class="btn-1">수정</a>
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

<div class="page-btn">
	<a href="#" onclick="fn_write();">등록</a>
</div>

<div class="page-num">
	<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_search" /> 
</div><!-- E : page-num -->