<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%@ 
taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@ 
taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%><%@ 
taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%@ 
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

	/*====================================================================
		화면 초기화 
	====================================================================*/
	function loadPage() {
		initEvent();
		initHtml();
	}

	/* 각종 버튼에 대한 액션 초기화 */
	function initEvent() {
		
	}

	/* 리스트 조회 */
	function fn_search( pageNo ){
		$("#pageIndex").val( pageNo );

		var reqUrl = CONTEXT_ROOT + "/la/course/courseList";
		$("#frmCourse").attr("action", reqUrl);
		$("#frmCourse").submit();
	}
	
	function fn_view( param){

			var reqUrl = CONTEXT_ROOT + "/la/course/courseView";
			$("#courseCd").val( param );
			$("#frmCourse").attr("action", reqUrl);
			$("#frmCourse").submit();		 
	 }

	 function fn_insert(){
		 
			var reqUrl = CONTEXT_ROOT + "/la/course/goCourseInsert";
			$("#frmCourse").attr("action", reqUrl);
			$("#frmCourse").submit();		 
	 }
	 	 
	 function fn_update(){
		    var check = true;
			$("input[name='checkBox']:checked").each(function() {
				check=false; 
			});
			if(check){
				alert("대상을 선택하세요.");
				return;
			}else{
				var reqUrl = CONTEXT_ROOT + "/la/course/courseSelectedChange";
				$("#frmCourse").attr("action", reqUrl);
				$("#frmCourse").submit();				
			}
	 
	 }
//-->
</script> 
           		<form name="frmCourse" id="frmCourse"  method="post" >
            	<input type="hidden" name="pageIndex" id="pageIndex" value="${pageIndex}"/>
            	<input type="hidden" id="menuId" name="menuId" value="${courseVO.menuId }" />
            	<input type="hidden" id="courseCd" name="courseCd"  />
            	
 
 
				
			  	<ul class="search-list-1" style="margin-top:7px;">
					<li>
						<span style="width: 7%;"> 과정 상태</span>
										<select name="searchStatusCd" onchange="goSearch(1)" class="selectype">
											${selectBox}
										</select>
						<span style="width: 5%; margin-left:2%;">수행 기관</span>
										<select name="searchOrgCd" onchange="goSearch(1)" class="selectype">
											${orgBox}
										</select>
					</li>
					<li>
						<span style="width: 7%;">과정명 검색</span>
										<input type="hidden" name="searchType" value="TITLE"/>
										<input type="text" name="searchKeyword" id="searchKeyword" value="${courseVO.searchKeyword }" class="typeTxt" style="width: 400px;" />
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
				<table cellspacing="0" cellpadding="0" border="0" summary="" class="list-1">
					<caption>연수 관리</caption>
					<colgroup>
						<col style="width:5%" />
						<col style="width:5%" />
						<col style="width:32%" />
						<col style="width:13%" />
						<col style="width:8%" />
						<col style="width:8%" />
						<col style="width:8%" />
						<col style="width:8%" />
						<col style="width:13%" />
					</colgroup>
					<thead>
						<tr>
							<th scope="col"><input type="checkbox" id="allCheck" /></th>
							<th scope="col">No</th>
							<th scope="col">과정명</th>
							<th scope="col">기간</th>
							<th scope="col">모집인원</th>
							<th scope="col">상태</th>
							<th scope="col">메인등록</th>
							<th scope="col">등록자</th>
							<th scope="col">등록일자</th>
						</tr>
					</thead>
					<tbody>
					    <c:choose>
					        <c:when test="${!empty resultList}">
					        	<c:forEach var="resultList" items="${resultList}"  varStatus="status">
											<tr>
												<td><input type="checkbox" name="checkBox" class="typeCheck" value="${resultList.courseCd}" /></td>
												<td>${totalCount-((pageIndex-1) * pageSize + status.count)+1}</td>
												<td class="title">
													<a href="#" onclick="javascript:fn_view('${resultList.courseCd}')">
													<c:if test="${resultList.todayType eq 'A'}"><font color="blue">[모집중]</font></c:if>
													[${resultList.orgName}]${resultList.title}
													</a>												
												</td>
												<td>${resultList.dayStart}
													<br/>~ <span style="color: blue;">${resultList.dayEnd}</span>
												</td>
												<td>${resultList.participant}명</td>
												<td>${resultList.statusName}</td>
												<td>
													<c:if test="${resultList.mainYn eq 'Y' }">사용</c:if>
								 					<c:if test="${resultList.mainYn eq 'N' }">미사용</c:if>
												</td>
												<td>${resultList.regId}</td>
												<td>${resultList.regDate}</td>
											</tr>
					        	</c:forEach>
					        </c:when>
					        <c:otherwise>
					          <tr>
					            <td colspan="9">등록된 과정이 없습니다.</td>
					          </tr>
					        </c:otherwise>
					    </c:choose>
					</tbody>
				</table> 
				
			<div class="page-num">
				<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_search" />
			</div><!-- E : page-num -->

			<div class="page-btn">
				<select name="changeCdsel" id="changeCdsel" >
				${selectBox2}
				</select>
				<a href="#update" onclick="javascript:fn_update();">선택 수정</a>  
				<a href="#insert" onclick="javascript:fn_insert();">등록</a>				
			</div>
		 	
	 	 </form>