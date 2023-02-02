<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%@ 
taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %><%@ 
taglib prefix="spring" uri="http://www.springframework.org/tags" %><%@ 
taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%><%@ 
taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@ 
taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%@ 
taglib prefix="double-submit" uri="http://www.egovframe.go.kr/tags/double-submit/jsp" %><%@ 
taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script type="text/javascript" src="/smarteditor/js/HuskyEZCreator.js"></script>
<script type="text/javascript">
<!--

	var oEditors = [];
	
	$(document).ready(function() { 
		initEditor();
	});
 
	function fn_save(){
		if($("#contentId").val()==""){
			alert("아이디를 입력해주세요.");
		}else if($("#contentName").val()==""){
			alert("제목을 입력해주세요.");
		}else if($("#contentIdChk").val()==""){
			alert("아이디를 확인해주세요.");
		}else{

			var reqUrl = "/la/content/insertComContent";
			
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
		var reqUrl = "/la/content/listComContent";
		$("#frmComContent").attr("action", reqUrl);
		$("#frmComContent").attr("target","_self");
		$("#frmComContent").submit();
	} 
  
  	function selectContentId(){
  		
		if($("#contentId").val()==""){
			alert("이이디를 입력하세요");
			return;
		}
		// 공백제거
		var tempStr = $("#contentId").val();
		tempStr = tempStr.replace(/\s/gi, ""); 
		$("#contentId").val(tempStr);
		
		var reqUrl = "/la/content/comContentCheck.json";
		var param = {"contentId":$("#contentId").val()}; 
		
			$.ajax({
				url:reqUrl,
				type:"POST",
				data:param,
				success:function(data){
					var retCd = data.retCd;				
 					 
					if(retCd=="200"){
						alert(data.retMsg);
						$("#contentIdChk").val("Y");
					}else if(retCd=="400"){
						alert(data.retMsg);
						$("#contentId").val("");
						$("#contentIdChk").val("");
					}
					
				},error:function(xhr,status,error){
					alert("시스템관리자에게 문의하세요.");
				}
			});

	}
//-->
</script>
<div class="write">
<form id="frmComContent" name="frmComContent" method="post"   >
	<double-submit:preventer tokenKey="frmComContentToken"/>
 
	<input type="hidden" id="menuId" name="menuId" value="${comContentVO.menuId}" />  
	<input type="hidden" id="pageIndex" name="pageIndex" value="${comContentVO.pageIndex}" />
	<input type="hidden" id="contentIdChk" name="contentIdChk"  value="" />
			<div class="data-table box-area">
			<h3>기본정보</h3>
				<table class="view-2">
					<colgroup>
						<col style="width:180px" />
						<col style="width:*" />
					</colgroup>
					<tbody>
					
						<tr>
							<th><label for="title">아이디</label></th>
							<td><input type="text" class="form-control wid_full" name="contentId" id="contentId" value="" style="width:70%;ime-mode:Disabled;"/><a href="#" onclick="javascript:selectContentId();" title="아이디체크" class="btn">확인</a></td>
						</tr> 
						
						<tr>
							<th><label for="title">제목</label></th>
							<td><input type="text" class="form-control wid_full" name="contentName" id="contentName" value="" style="width:100%;"/></td>
						</tr> 
						
						<tr>
							<th><label for="content">내용</label></th>
							<td>
							 
					<textarea id="contentDesc" name="contentDesc"   style="width:85%;"></textarea>  
				  	 	
				
				
							</td>
						</tr>
						   
					</tbody>
				</table>
			</div>
</form>
 
						<div class="page-btn btn-box">
							<a href="#!" class="btn-blue btn-lg-x2" onclick="javascript:fn_search();">목록</a>
							<a href="#!" class="btn-white btn-lg-x2" onclick="javascript:fn_save();">등록</a>
						</div>
</div>					 