<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%@ 
taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@ 
taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%><%@ 
taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%@ 
taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%><%@ 
taglib prefix="spring" uri="http://www.springframework.org/tags"%>  
<script type="text/javascript">
<!-- 

	$(document).ready(function() {

		$("#allCheck").on("click", function() {
			if ($(this).is(":checked")) {
				$("input[name=checkBox]").prop("checked", true);
			} else {
				$("input[name=checkBox]").prop("checked", false);
			}
		});
	});

 
	/* 리스트 조회 */
	function fn_search( pageNo ){
		$("#pageIndex").val( pageNo );

		var reqUrl = CONTEXT_ROOT + "/la/course/courseUserList";
		$("#frmCourse").attr("action", reqUrl);
		$("#frmCourse").submit();
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
						$("#searchType3 option:first").remove();
						$("#searchType3").html("<option value='' >선택</option> ");
						for(var i=0; resultLists.length>i ; i++){
							$("#searchType3").append("<option value='"+resultLists[i].courseCd+"' >"+resultLists[i].title+"</option> ");
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
	
	function fn_detail(id){
		
		$("#userId").val(id);
		
		var reqUrl = CONTEXT_ROOT + "/la/course/courseUserView";
		$("#frmCourse").attr("action", reqUrl);
		$("#frmCourse").submit();
	}
//-->
</script> 
    <c:set var="now" value="<%=new java.util.Date()%>"/>
	<fmt:formatDate var="nowDate" value="${now}" pattern="yyyy"/>
    <fmt:formatNumber value="${nowDate}" type="number" pattern="0000" var="nowDateNumberType" />
<form name="frmCourse" id="frmCourse"  target="_self" method="post" >
   	<input type="hidden" name="pageIndex" id="pageIndex" value="${pageIndex}"/>
	<input type="hidden" name="userId" id="userId"/>
 	<ul class="search-list-1" style="margin-top:7px;">
		<li>
			<span style="width: 15%;">국적</span>
			<select id="searchType" name="searchType">
				<option value="">--선택--</option>
			<c:forEach var="nation" items="${nation}">
				<option value="${nation.natCd}" <c:if test="${applyUserInfoVO.searchType eq nation.natCd}" > selected </c:if> >${nation.natName }(${nation.natNameKr})</option>
			</c:forEach>
			</select>
 		</li>
		<li>
			<span style="width: 15%;">수료 연수과정</span>
			<select name="searchType2" id="searchType2" class="selectype" onchange="javascript:fn_courseList(this.value);">
				<option value="" selected> 선택 </option>
			<c:forEach var="yearVal" begin="0" end="20" varStatus="status">
			    <c:set var="yearValStr" value="${nowDateNumberType-yearVal}" />
				<c:choose>
					<c:when test="${applyUserInfoVO.searchType2 eq yearValStr}">
						<option value="${yearValStr }" selected>${yearValStr }년</option>
					</c:when>
					<c:otherwise>
						<option value="${yearValStr }" >${yearValStr }년</option>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			</select> 년도
						
			<select name="searchType3"  id="searchType3">
				<c:if test="${fn:length(courseList) == 0 }">
				<option value="" >- 년도선택 -</option>
				</c:if>				 
				<c:forEach var="courseList" items="${courseList}" varStatus="status">
					<option value="${courseList.courseCd}" <c:if test="${courseList.courseCd eq applyUserInfoVO.searchType3}" >selected</c:if> >${courseList.title}</option>
				</c:forEach>
			</select>
		</li>
		<li>
			<span style="width: 15%;">검색</span>
			<select name="searchType4" id="searchType4" style="width:120px;">
				<option value="all">전체</option>
				<option value="firstName"  <c:if test="${applyUserInfoVO.searchType4 eq 'firstName' }" >selected</c:if> >성</option>
				<option value="lastName"  <c:if test="${applyUserInfoVO.searchType4 eq 'lastName' }" >selected</c:if>>이름</option>
			</select>
			<input type="text" name="searchKeyword" id="searchKeyword" value="" class="typeTxt" style="width: 400px;" />
		</li>
	</ul>
	
   	<div class="search-btn-area"><a href="#" onclick="javascript:fn_search(1);">조회</a></div>
   	<ul class="board-info">
		<li class="info-area"><span>전체 : </span> <c:out value="${totalCount}" /> 건</li>
		<li class="btn-area">
			<select name="pageSize" id="pageSize" title="목록 갯수 설정하기" onchange="javascript:fn_search(1)">
				<option value="10" <c:if test="${pageSize=='10' }" > selected</c:if> >10 개</option>
				<option value="20" <c:if test="${pageSize=='20' }" > selected</c:if> >20 개</option>
				<option value="30" <c:if test="${pageSize=='30' }" > selected</c:if> >30 개</option>
				<option value="50" <c:if test="${pageSize=='50' }" > selected</c:if> >50 개</option>
			</select>
		</li>
	</ul>
	 
	<table cellspacing="0" cellpadding="0" border="0" summary="연수관리목록" class="list-1">
		<caption>연수 관리</caption>
		<colgroup>

			<col style="width:5%" />
			<col style="width:10%" />
			<col style="width:15%" />
			<col style="width:5%" />

			<col style="width:*" />
			<col style="width:15%" />
			<col style="width:10%" />
			<col style="width:5%" />

		</colgroup>
		<thead>
			<tr>

				<th scope="col">No</th>
				<th scope="col">국가</th>
				<th scope="col">이름</th>
				<th scope="col">연도</th>
				<th scope="col">과정명</th>
				<th scope="col">연수기간</th>
				<th scope="col">최종방문일</th>
				<th scope="col">방문수</th>

			</tr>
		</thead>
		<tbody>
			 <c:forEach var="resultList" items="${resultList}"  varStatus="status">
			 	<tr onclick="javascript:fn_detail('${resultList.userId}');">
				 	<td>${totalCount-((pageIndex-1) * pageSize + status.count)+1}</td>
				 	<td>
				 	<a href="#" >
				 	<c:if test="${empty resultList.natName}">
				 		<c:if test="${not empty resultList.natCd }">${resultList.natCd }</c:if>
				 	</c:if>
				 	<c:if test="${not empty resultList.natName}">
				 		${resultList.natName }
				 	</c:if>
				 	</a>
				 	</td>
				 	<td><a href="#" >${resultList.firstNameStr} ${resultList.lastNameStr}</a></td>
				 	<td><a href="#" >${resultList.year}</a></td>
				 	
				 	<td><a href="#" >${resultList.title}</a></td>
				 	<td><a href="#" >${resultList.dayStart}~${resultList.dayEnd}</a></td>
				 	<td>${resultList.loginDate}</td>
				 	<td>${resultList.loginCnt}</td>
			 	</tr>
			 </c:forEach>
			 <c:if test="${empty resultList}">
			 	<tr><td colspan="8" >데이터가 없습니다.</td></tr>
			 </c:if>
		</tbody>
	</table>
	
	<div class="page-num">
		<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_search" /> 
	</div>
</form>