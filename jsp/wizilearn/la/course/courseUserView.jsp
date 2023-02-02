<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><%@ 
taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@ 
taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%><%@ 
taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%@ 
taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<script type="text/javascript">
<!-- 
/* 리스트 조회 */
function fn_search( pageNo ){
	$("#pageIndex").val( pageNo );

	var reqUrl = CONTEXT_ROOT + "/la/course/courseUserList";
	$("#frmCourse").attr("action", reqUrl);
	$("#frmCourse").attr("target","_self");
	$("#frmCourse").submit();
} 

function goPopup(applyCd){
	popOpenWindow( "", "applyUser", 840, 860, 100, 100, ',scrollbars=yes' );

	$("#applyCd").val( applyCd );
	
	var reqUrl = CONTEXT_ROOT + "/la/apply/goPopupApplyUser.do";
	
	$("#frmCourse").attr("target","applyUser");
	$("#frmCourse").attr("action", reqUrl);
	$("#frmCourse").submit();
}

//-->
</script>
<form name="frmCourse" id="frmCourse"   > 

            	<input type="hidden" id="courseCd" name="courseCd" value="${courseVO.courseCd }"  />
            	<input type="hidden" id="menuId" name="menuId" value="${courseVO.menuId }" />
            	<input type="hidden" id="applyCd" name="applyCd"   />  
</form>            	 			
			
			<div class="tableType2">
				<table cellspacing="0" cellpadding="0" border="0"  class="view-1" summary="공개여부,등록일,조회수,상단고정,작성자 표입니다.">
			
					<caption>연수과정 상세페이지</caption>
					<colgroup>
						<col style="width:15%" />
						<col style="width:35%" />
						<col style="width:15%" />
						<col style="width:35%" />
					</colgroup>
					<tbody>
						<tr>
							<th class="view-th">ID</th>
							<td class="view-td">${result.memId}</td>
							<th class="view-th">First Name</th>
							<td class="view-td">${result.memNameStr}</td>
						</tr>
						
						<tr>
							<th class="view-th">Country</th>
							<td class="view-td">${result.natName}(${result.natNameKr })</td>
							<th class="view-th">Last Name</th>
							<td class="view-td">${result.memLastNameStr}</td>
						</tr>
						
						<tr>
							<th class="view-th">Phone</th>
							<td class="view-td">${result.telNoStr}</td>
							<th class="view-th">Mobile <br /> Phone</th>
							<td class="view-td">${result.hpNoStr}</td>
						</tr>
						
						<tr>
							<th class="view-th">Email</th>
							<td class="view-td">${result.emailStr}</td>
							<th class="view-th">subEmail</th>
							<td class="view-td">${result.emailSubStr}</td>
						</tr>

						<tr>
							<th class="view-th">Organization</th>
							<td class="view-td">${result.orgName}</td>
							<th class="view-th">organization Type</th>
							<td class="view-td">${result.orgGubunName}</td>
						</tr>
						
						<tr>
							<th class="view-th">Department</th>
							<td class="view-td">${result.depName}</td>
							<th class="view-th">Position</th>
							<td class="view-td">${result.memJob}</td>
						</tr>
						
					</tbody>
				</table>
			</div><!-- // tableType -->
			<div class="page-btn">
					<span class="redLbtnl"><a href="#" onclick="javascript:fn_excel();">엑셀다운로드</a></span>
					<span><a href="#search" onclick="javascript:fn_search(1);">목록</a></span>
			</div>
			
			<table cellspacing="0" cellpadding="0" border="0" summary="연수과정목록" class="list-1">
				<caption>연수과정목록</caption>
				<colgroup>
		
					<col style="width:5%" />
					<col style="width:10%" />
					<col style="width:15%" />
					<col style="width:20%" />

					<col style="width:10%" />
					<col style="width:10%" />
					<col style="width:10%" /> 
		
				</colgroup>
				<thead>
					<tr>
		
						<th scope="col">No</th>
						<th scope="col">Year</th>
						<th scope="col">Duration</th>
						<th scope="col">Course Title</th>
						
						<th scope="col">신청일</th>
						<th scope="col">참석일</th>
						<th scope="col">상세보기</th>	
					</tr>
				</thead>
				<tbody>				 
					<c:forEach var="resultList" items="${resultList}"  varStatus="status">
					<tr>
						<td>${status.count }</td>
						<td>${resultList.year}</td>
						<td>${resultList.dayStart}~${resultList.dayEnd}</td>
						<td>${resultList.title}</td>
						
						<td>${resultList.applyDate}</td>
						<td>${resultList.dayS}</td>
						<td><a href ="#!" onclick="javascript:goPopup('${resultList.applyCd}');" >상세보기</a></td>
					</tr>
					</c:forEach>
				</tbody>

			</table>