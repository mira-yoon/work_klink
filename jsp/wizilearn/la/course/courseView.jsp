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

	var reqUrl = CONTEXT_ROOT + "/la/course/courseList";
	$("#frmCourse").attr("action", reqUrl);
	$("#frmCourse").submit();
}
/* 수정 */
function fn_update(){

	var reqUrl = CONTEXT_ROOT + "/la/course/goCourseUpdate";
	$("#frmCourse").attr("action", reqUrl);
	$("#frmCourse").submit();
}
/* 삭제 */
function fn_delete(){
	if(confirm("과정을 삭제하시겠습니까?")){
		var reqUrl = CONTEXT_ROOT + "/la/course/courseDelete";	
		$("#frmCourse").attr("action", reqUrl);
		$("#frmCourse").submit();
	}
}
function goUserList(){
	var reqUrl = "/la/apply/listApplyUser";	
	$("#frmCourse").attr("action", reqUrl);
	$("#frmCourse").submit();
}

//-->
</script>
<form name="frmCourse" id="frmCourse"   > 

            	<input type="hidden" id="courseCd" name="courseCd" value="${courseVO.courseCd }"  />
            	<input type="hidden" id="menuId" name="menuId" value="${courseVO.menuId }" />
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
							<th class="view-th">과정 상태</th>
							<td class="view-td" colspan="3">${result.statusName }</td>
						</tr>
						<tr>
							<th class="view-th">메인 등록</th>
							<td class="view-td"colspan="3">
								 <c:if test="${result.mainYn eq 'Y' }">사용</c:if>
								 <c:if test="${result.mainYn eq 'N' }">미사용</c:if>
							</td>
						</tr>
						<tr>
							<th class="view-th">과정명</th>
							<td class="view-td" colspan="3" style="word-break:break-all">
								 ${result.title}
							</td>
						</tr>
						<tr>
							<th class="view-th">간략 설명</th>
							<td class="view-td" colspan="3" style="word-break:break-all">
								 ${result.curriculum}
							</td>
						</tr>
						<tr>
							<th class="view-th">교육 시작일자</th>
							<td class="view-td">
								${result.dayStart}
							</td>
							<th class="view-th">교육 종료일자</th>
							<td class="view-td">
								${result.dayEnd}
							</td>
						</tr>
						<tr>
							<th class="view-th">접수 시작일자</th>
							<td class="view-td">
								${result.applyStart}
							</td>
							<th class="view-th">접수 종료일자</th>
							<td class="view-td">
								${result.applyEnd}
							</td>
						</tr>
						<tr>
							<th class="view-th">모집인원</th>
							<td class="view-td" >
								${result.participant}
							</td>
							<th class="view-th">교육 수행기관</th>
							<td class="view-td">
								${orgName}
							</td>
						</tr>
						<tr>
							<th class="view-th">STEP 3 양식 (*)</th>
							<td class="view-td">
								<c:if test="${!empty courseFormFile_Step3File01 and !empty courseFormFile_Step3File01.courseFormFileName  }"><a href="/la/course/getFile?courseCd=${ result.courseCd}&downFileNo=3" >${courseFormFile_Step3File01.courseFormFileName}</a></c:if>
							</td>
							<th class="view-th">STEP 4 양식 (*)</th>
							<td class="view-td">				
								<c:if test="${!empty courseFormFile_Step4File01 and !empty courseFormFile_Step4File01.courseFormFileName   }"><a href="/la/course/getFile?courseCd=${ result.courseCd}&downFileNo=4" >${courseFormFile_Step4File01.courseFormFileName}</a></c:if>
							</td>
						</tr>
						<tr>
							<th colspan="4" class="view-th" >과정소개</th>
						</tr>
						<tr>
							<td colspan="4"   style="word-break:break-all">
								${result.courseText}
							</td>
						</tr>
						<tr>
							<th colspan="4" class="view-th">과정 스케쥴</th>
						</tr>
						<tr>
							<td colspan="4"  >
								${result.scheduleText}
							</td>
						</tr>
						<tr>
							<th colspan="4" class="view-th" class="txtCont">주요일정 및 강사</th>
						</tr>
						<tr>
							<td colspan="4" class="txtCont">
								${result.lecturerText}
							</td>
						</tr>
					</tbody>
				</table>
			</div><!-- // tableType -->
			<div class="page-btn">
					<!--span class="redLbtnl"><a href="#" onclick="goApply()">신청자 등록</a></span-->
					<span class="redLbtnl"><a href="#" onclick="javascript:goUserList();">신청자 보기</a></span>
				 
						<a href="#update" onclick="javascript:fn_update();">수정</a></span>
						<a href="#delete" onclick="javascript:fn_delete();">삭제</a></span>
						<a href="#search" onclick="javascript:fn_search(1);">목록</a></span>
			</div>
			  