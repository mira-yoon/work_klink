<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%@ 
taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@ 
taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%><%@ 
taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%@ 
taglib prefix="spring" uri="http://www.springframework.org/tags"%><%@ 
taglib prefix="form" uri="http://www.springframework.org/tags/form"%><%@ 
taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<meta http-equiv="Cache-Control" content="no-cache"/>
<meta http-equiv="Expires" content="0"/>
<meta http-equiv="Pragma" content="no-cache"/>
<!-- <meta http-equiv="Content-Security-Policy" content="default-src https:; script-src https: 'unsafe-inline' 'unsafe-eval'; style-src https: 'unsafe-inline'; img-src * 'self' data: https:;" /> -->
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="keywords" content="K-LINK, 케이링크" />

<title>K-LINK</title>

<!-- 공통 css -->
<link rel="stylesheet" href="/css/import.css">

<script type="text/javascript" src="/js/jquery-3.1.1.min.js"></script>
<style>
  .pop-area{padding:20px;}
  .subTxt1 {font-size:14pt; font-weight:bold; margin-bottom:10px;}
  .pop-area table {margin-bottom:40px; border-top:2px solid #525F78;}
  .pop-area table:last-child{margin-bottom:0;}
  .pop-area table th{border-right: 1px solid #ddd;}
  .pop-area table th, .pop-area table td{padding:10px 0; border-left:1px solid #ddd; border-bottom:1px solid #ddd;}
  .pop-area table td { border-right:1px solid #ddd; padding:10px; }
  .pop-area table td.course{font-weight:bold; text-overflow:ellipsis; white-space:nowrap; word-wrap:normal; overflow:hidden;}
  .pop-area table.td-cen td{text-align:center;}
  .btnArea{text-align: center;}
  .btnArea a{color:#fff; padding:10px 20px; background:#525F78; border-radius:4px;}
  .pop-area h1{font: 20px nbgM; color: #FFF; line-height: 25px; border-top: 5px solid black; padding:13px; border-bottom: 10px solid #E5E5E5; background:#2A91D4;}
</style>
<script type="text/javascript">
	function view(code){
		opener.goUserList(code);
		self.close();
	}
</script>
</head>
<body>	
    <div class="pop-area" style="padding:0">
      <h1><img src="/images/wizilearn/adm/inc/pop_border_02.png" alt="">지원정보</h1>
      <table>
        <colgroup>
          <col width="7%">
          <col width="18%">
          <col width="18%">
          <col width="*">
          <col width="10%">
        </colgroup>
        <thead>
          <tr>
            <th>No.</th>
            <th>Duration</th>
            <th>Date</th>
            <th>Course</th>
            <th>Status</th>
           </tr>
        </thead>
        <tbody>
	<c:forEach var="result" items="${resultList}" varStatus="status">
		<tr>
			<td>${status.count}</td>
			<td>${result.dayStart} - ${result.dayEnd}</td>
			<td>${result.applyDate}</td>
			<td class="course"><a href="#" onclick="javascript:view('${result.courseCd }');">${result.title}</a></td>
			<td>${result.statusCdName}</td>
		</tr>         
	</c:forEach>
	<c:if test="${empty resultList}">
		<tr>
			<td colspan="5"> 등록된 이력이 없습니다.</td>
		</tr>
	</c:if>
         </tbody>

      </table>
      <div class="btnArea">
        <a href="javascript:self.close();">닫기</a>
      </div>
    </div>   
</body>
</html>
