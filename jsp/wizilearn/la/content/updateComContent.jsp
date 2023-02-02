<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%@ 
taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %><%@ 
taglib prefix="spring" uri="http://www.springframework.org/tags" %><%@ 
taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%><%@ 
taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@ 
taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%@ 
taglib prefix="spring" uri="http://www.springframework.org/tags"%> 
<script type="text/javascript" src="/smarteditor/js/HuskyEZCreator.js"></script>
<script type="text/javascript">
<!-- 

	var oEditors = [];

	$(document).ready(function() { 
		initEditor();
	});
 
	function fn_save(){
	
		var reqUrl = "/la/content/updateComContent";
		
		
		var data =oEditors.getById["contentDesc"].getIR();
		var text = data.replace(/[<][^>]*[>]/gi, "");
		if(text=="" && data.indexOf("img") <= 0){
			alert("내용은 필수 입력사항 입니다.");
			oEditors.getById["nttCn"].exec("FOCUS"); 
			return false;
		}
		$("#contentDesc").val(data);
		 
 
		$("#frmComContent").attr("action", reqUrl);
		$("#frmComContent").attr("target","_self");
		$("#frmComContent").submit();
		
	}
 
	/* 화면이 로드된후 에디터 기본옵션 설정 초기화 */ 
	function initEditor() {
		//Smart Editor
		nhn.husky.EZCreator.createInIFrame({
			oAppRef: oEditors,
			elPlaceHolder: "contentDesc",
			sSkinURI: "/smarteditor/SmartEditor2Skin.html",	
			htParams : {
				bUseToolbar : true,
				bUseVerticalResizer : true,
				bUseModeChanger : true,
				fOnBeforeUnload : function(){
				}
			}, 
			fOnAppLoad : function(){
				//oEditors.getById["textAreaContent"].exec("PASTE_HTML", ["로딩이 완료된 후에 본문에 삽입되는 text입니다."]);
			},
			fCreator: "createSEditor2"
		});
	} 	
	 
	/* 리스트 조회 */
	function fn_search(){		 
		var reqUrl = "/la/content/goDetailComContent";
		$("#frmComContent").attr("action", reqUrl);
		$("#frmComContent").attr("target","_self");
		$("#frmComContent").submit();
	}
  
//-->
</script>
<div class="write">
<form id="frmComContent" name="frmComContent" method="post"   >
	<input type="hidden" id="menuId" name="menuId" value="${comContentVO.menuId}" />  
	<input type="hidden" id="pageIndex" name="pageIndex" value="${comContentVO.pageIndex}" /> 	 
	<input type="hidden" id="contentSeq" name="contentSeq" value="${result.contentSeq}" />
	<input type="hidden" id="contentId"  name="contentId" value="${result.contentId}"  />
	<div class="data-table box-area">
				<table class="view-2">
					<colgroup>
						<col style="width:180px" />
						<col style="width:*" />
					</colgroup>
					<tbody>
					
						<tr>
							<th><label for="title">아이디</label></th>
							<td><c:out value="${result.contentId}"/>  </td>
						</tr> 
						
						<tr>
							<th><label for="title">제목</label></th>
							<td>
								<input type="text" class="form-control wid_full" name="contentName" value="${result.contentName}" style="width:70%;"/>
							</td>
						</tr> 

						<tr>
							<th><label for="title">등록일</label></th>
							<td>
								<c:out value="${result.insertDate}"/>
							</td>
						</tr> 
						
						<tr>
							<th><label for="content">내용</label></th>
							<td>						  
							  	<textarea id="contentDesc" name="contentDesc"   style="width:85%;">${result.contentDesc}</textarea>  
						 	
							</td>
						</tr>
						   
					</tbody>
				</table>
			</div>
</form>
 
						<div class="page-btn btn-box">
							<a  href="#!" class="btn-blue btn-lg-x2" onclick="fn_search();">이전</a>
							<a  href="#!" class="btn-white btn-lg-x2" onclick="fn_save();">저장</a>
						</div>
</div>					 