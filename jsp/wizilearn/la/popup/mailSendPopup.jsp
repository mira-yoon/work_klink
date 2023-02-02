<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%@ 
taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@ 
taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%><%@ 
taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%@ 
taglib prefix="spring" uri="http://www.springframework.org/tags"%><%@ 
taglib prefix="form" uri="http://www.springframework.org/tags/form"%><%@ 
taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<html xmlns="http://www.w3.org/1999/xhtml"><head>
<title>K-LINK ADMIN PAGE +:+:+:+:+:+:+</title>

</head>
<body>
<div>

<form name="popup12" id="popup12" method="post" action="/la/popup/doPopupApplyUserMailSend.do" enctype="multipart/form-data">
<input type="hidden" id="email" name="email" value="${totalEm}">
<input type="hidden" id="applyCd" name="applyCd" value="${applyVO.applyCd}">
<input type="hidden" id="courseCd" name="courseCd" value="${applyVO.courseCd}">

<input type="hidden" name="searchType" id="searchType" value="${applyVO.searchType }" />
<input type="hidden" name="searchKeyword" id="searchKeyword" value="${applyVO.searchKeyword }" /> 
<input type="hidden" name="pageIndex" id="pageIndex" value="${applyVO.pageIndex }" /> 

<div class="pop-area">
	<h2 class="subTxt1">연수생 메일발송</h2>
    <div class="tableType2">
		<table cellspacing="0" cellpadding="0" border="0" summary="" class="tableL">
        <caption>연수생 지원정보</caption>
            <colgroup>
                <col width="30%">
                <col width="*">
            </colgroup>
            <tbody>
                <tr>
                   <th>제목</th>
                   <td><input type="text" name="sendTitle" id="sendTitle" /></td>
                </tr>
                <tr>
                   <th>보내는 사람</th>
              <!--      <td><input type="text" name="sender" id="sender" style="ime-mode:disabled"/></td> -->
                   <td><input type="text" name="sendSender" id="sender" value="klink@nipa.kr" /></td>
                </tr>
                <tr>
                   <th>받는사람</th> 
                   <td><input type="text" name="recipient" id="recipient" value="${reciver}" readonly="readonly"/></td>
               </tr>
                <tr>
                   <th>첨부파일<br/>[최대20MB]</th>
                   <td><input type="file" name="sendfile" id="sendfile" style="width: 70%"/></td>
                </tr>
                <tr>
                	<td colspan="2" class="typeArea" >
                    	<textarea name="textarea" id="textarea"></textarea>
                    </td>
                </tr>
        </table> 
        <div class="btnArea">
            	<a href="#" onclick="javascript:send11()">발송</a>
	            <a href="#" onclick="javascript:doClose()">취소</a>
        </div>
    </div>
</div>
</form>
</div>
</body>

<script type="text/javascript" src="/js/jquery/jquery.form.js"></script>
 <link rel="stylesheet" href="/css/style.css" type="text/css">
 <script src="/js/jquery/jquery.bgiframe.js"></script>
<script type="text/javascript">


function test(){
	 $("#file0").replaceWith( $("#file0").clone(true) );
}
function test1(){
	 $("#file1").replaceWith( $("#file1").clone(true) );
}

function test2(){
	 $("#file2").replaceWith( $("#file2").clone(true) );
}

function test3(){
	 $("#file3").replaceWith( $("#file3").clone(true) );
}
function test4(){
	 $("#file4").replaceWith( $("#file4").clone(true) );
}



function doClose(){
	self.close();
}



 

/* 20140725 추가  */
function send11(){
	var f = document.popup12;

	if(f.sender.value==''){
		alert("보내는사람을 입력해주세요");
		return false;
	}
  
	if(confirm('발송 하시겠습니까?')){ 
        popup12.submit();
	}else{  
		return false;
	}    
}

	
	</script>
</html>


