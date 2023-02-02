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
				$("input[name=hisChk]").prop("checked", true);
			} else {
				$("input[name=hisChk]").prop("checked", false);
			}
		});
	});
	
	/* 삭제 */
	function fn_del() {
		if(!$("input[name=hisChk]").is(":checked")) {
			alert("삭제할 대상을 선택해주세요.");
			return false;
		}
		
		if(!confirm("삭제하시겠습니까?")) return false;
		
		var hisArr = [];
		
		$("input[name='hisChk']:checked").each(function() {
			hisArr.push($(this).val());
			console.log($(this).val());
		});
		
		var reqUrl = "/la/teacher/deleteTeacher";
		
		$.ajax({
			url:reqUrl,
			type:"post",
			data:{ hisArr:hisArr },
			dataType:"json",
			success:function(data){
				var result = data.msg;
				if(result == "success"){
					alert("삭제되었습니다."); 
					fn_search('1');
				}else{
					alert("작업 진행중 오류가 발행하였습니다.");
				}
			},
			error:function(e){
				console.log("ERROR!!!!!!!!!!!");
			}
		});
	}
	
	function fn_excel(){
		if(!$("input[name=hisChk]").is(":checked")) {
			alert("선택된 목록이 없습니다.");
			return false;
		}
		var reqUrl = "/la/teacher/listTeacherExcelDown";
		$("#frmTeacher").attr("action", reqUrl);
		$("#frmTeacher").attr("target", "_blank");
		$("#frmTeacher").submit();
	}
	
	/* 리스트 조회 */
	function fn_search( param1 ){
		$("#pageIndex").val( param1 );
		$("#pageSize").val($("#searchPageSize").val());
		var reqUrl = "/la/teacher/listTeacher";
		$("#frmTeacher").attr("action", reqUrl);
		$("#frmTeacher").attr("target","_self");
		$("#frmTeacher").submit();
	} 
	/* 상세 조회 */
	function fn_detail(param){
		document.frmTeacher.hisSeq.value=param;
		var reqUrl = "/la/teacher/goDetailTeacher";
		$("#frmTeacher").attr("action", reqUrl);
		$("#frmTeacher").attr("target","_self");
		$("#frmTeacher").submit();
	}
	/* 작성 화면 */
	function fn_write(){
		var reqUrl = "/la/teacher/goInsertTeacher";
		$("#frmTeacher").attr("action", reqUrl);
		$("#frmTeacher").attr("target","_self");
		$("#frmTeacher").submit();
		
	}
	/* 수정화면 */
	function fn_update(param){
		document.frmTeacher.hisSeq.value=param;
		var reqUrl = "/la/teacher/goUpdateTeacher";
		$("#frmTeacher").attr("action", reqUrl);
		$("#frmTeacher").attr("target","_self");
		$("#frmTeacher").submit();
	}
	/* 삭제 */
	function fn_delete(param){
		if(confirm("해당 회원을 삭제하시겠습니까?")){
			$("#deleteYn").val("Y");
			document.frmTeacher.hisSeq.value=param;
			var reqUrl = "/la/teacher/updateTeacher";
			$("#frmTeacher").attr("action", reqUrl);
			$("#frmTeacher").attr("target","_self");
			$("#frmTeacher").submit();
		}
	}
	
	function fn_chkList(){
		var chk = document.getElementsByName("hisChk");
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

<form id="frmTeacher" name="frmTeacher" method="post">
	<input type="hidden" id="menuId" name="menuId" value="<c:out value='${menuId}'/>"> 
	<input type="hidden" id="pageIndex" name="pageIndex" value="${pageIndex}" />
	<input type="hidden" id="pageSize" name="pageSize" value="${pageSize }" />
	<input type="hidden" id="deleteYn" name="deleteYn" value="N"/>
	<input type="hidden" id="hisSeq"  name="hisSeq" value=""/>
	<input type="hidden" id="checkList" name="checkList" value=""/>
	<input type="hidden" id="memType" name="memType" value=""/>
	<input type="hidden" id="authGroupId" name="authGroupId" value=""/>
	<input type="hidden" id="updateType" name="updateType" value=""/>
	
	<div class="title-name-1">검색 조건</div>
	
	<ul class="search-list-1" style="margin-top:7px;">
		<li>
			<span style="width: 5%;"> 검색</span>
			<select name="searchType" id="searchType">
				<option value="ALL" <c:if test="${'ALL' eq teacherHistoryVO.searchType}">selected</c:if> >전체</option>
				<option value="NAME" <c:if test="${'NAME' eq teacherHistoryVO.searchType}">selected</c:if> >강사 명</option>
				<option value="PROGRAM" <c:if test="${'PROGRAM' eq teacherHistoryVO.searchType}">selected</c:if> >프로그램 명</option>
				<option value="TEL" <c:if test="${'TEL' eq teacherHistoryVO.searchType}">selected</c:if> >연락처</option>
				<option value="EMAIL" <c:if test="${'EMAIL' eq teacherHistoryVO.searchType}">selected</c:if> >이메일</option>
			</select>
			<input type="text" name="searchKeyword" id="searchKeyword" class="typeTxt" style="width: 400px;" value="${teacherHistoryVO.searchKeyword }" />
		</li>
	</ul>
			
	<div class="search-btn-area"><a href="#" onclick="javascript:fn_search(1);">조회</a></div>
	
	<ul class="board-info">
		<li class="info-area">
			<span>전체 : </span> <c:out value="${totalCount}" /> 건
			<select style="width: 100px;margin-left:10px;" name="orderQuery" onchange="fn_search('1');">
				<option value="REGDATE" <c:if test="${'REGDATE' eq teacherHistoryVO.orderQuery}">selected</c:if> >등록순</option>
				<option value="RATING" <c:if test="${'RATING' eq teacherHistoryVO.orderQuery}">selected</c:if> >평가순</option>
				<option value="NAME" <c:if test="${'NAME' eq teacherHistoryVO.orderQuery}">selected</c:if> >이름순</option>
				<option value="COURSECNT" <c:if test="${'COURSECNT' eq teacherHistoryVO.orderQuery}">selected</c:if> >연수순</option>
				<option value="EVALUATIONCNT" <c:if test="${'EVALUATIONCNT' eq teacherHistoryVO.orderQuery}">selected</c:if> >강의순</option>
			</select><br/>
		</li>				
		<li class="btn-area">
			<a href="javascript:fn_excel();">엑셀다운</a>
			<a href="javascript:fn_excelFormat();">양식다운</a>
			<a href="javascript:fn_excelUpload();">엑셀업로드</a>
			<select name="searchPageSize" id="searchPageSize" title="목록 갯수 설정하기" onchange="javascript:fn_search(1)">
				<option value="10" <c:if test="${pageSize=='10' }" > selected</c:if> >10 개</option>
				<option value="20" <c:if test="${pageSize=='20' }" > selected</c:if> >20 개</option>
				<option value="30" <c:if test="${pageSize=='30' }" > selected</c:if> >30 개</option>
				<option value="50" <c:if test="${pageSize=='50' }" > selected</c:if> >50 개</option>
			</select>
		</li>
	</ul>

<table  border="0" cellpadding="0" cellspacing="0" class="list-1">
	<thead>
	<tr>
		<th width="30px;">
			<input id="allCheck" type="checkbox" title="회원 전체선택"alt="회원선택"> 
			<label for="allCheck"></label>
		</th>
		<th width="60px">No</th>
		<th width="100px">강사명</th>
		<th width="70px">연락처</th>
		<th>이메일</th>
		<th>연수 수</th>
		<th>강의 수</th>
		<th width="100px">평가결과</th>
	</tr>
	</thead> 
	<tbody>
	<c:forEach var="result" items="${resultList}" varStatus="status">
		<tr>
			<td><input type="checkbox" name="hisChk" value="<c:out value="${result.hisSeq}" />" /></td>
			<td>
				<c:out value="${totalCount - ((pageIndex-1) * pageSize + status.count)+1}"/>
			</td>	
			<td>
				<a href="javascript:fn_detail('${result.hisSeq }')">
					<c:out value="${result.name }"/>
				</a>
			</td>
			<td>${result.tel }</td> 
			<td>${result.email}</td>
			<td>${result.courseCnt}</td>
			<td>${result.evaluationCnt}</td>
			<td>
				<span class="star_rating">
                	<span style="width:${result.rating}0%"></span>
                </span>
				<span class="star-rating_score">${result.rating}</span>
			</td>
		</tr>							
	</c:forEach>
	<c:if test="${fn:length(resultList) == 0}">
			<tr>
				<td colspan="8">
					조회된 데이터가 없습니다.
				</td>
			</tr>
	</c:if>
	</tbody>
</table>
</form>

<div class="page-btn">
	<a href="#" onclick="fn_del();">삭제</a>
	<a href="#" onclick="fn_write();">등록</a>
</div>

<div class="page-num">
	<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_search" /> 
</div><!-- E : page-num -->