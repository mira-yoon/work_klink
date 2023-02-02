<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%@ 
taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@ 
taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%><%@ 
taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%@ 
taglib prefix="spring" uri="http://www.springframework.org/tags"%><%@ 
taglib prefix="form" uri="http://www.springframework.org/tags/form"%><%@ 
taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script type="text/javascript">
	$(document).ready(function(){
		$("#proMgt").addClass("on");
		$("#left25").addClass("on");
		//페이지 표시 스크립트.
	});

	/**
	 * 전체선택
	 */
	function doChkAll(obj) {
	    $("input[name=targetList]").attr("checked",obj.checked);
	}

	/**
	 * 연수설문 상세보기
	 */
	function goView(pollCd){
		$("#mode", "#pollListFrm").val("PV");
		$("#pollCd", "#pollListFrm").val(pollCd);
		$("#pollListFrm").attr("action","/pages/admin/poll/pollMasterView.jsp");
		$("#pollListFrm").submit();
	}

	/**
	 * 연수설문 변경 
	 */
	function goProc() {
		if ( $("input:checkbox[name=targetList]:checked").length == 0 ) {
			alert("연수설문을 선택하세요.");
			return false;
		}
		if ( confirm("선택한 연수설문을 '"+$("#typeCd option:selected", "#pollListFrm").text()+"' (으)로 변경 하시겠습니까?") ) {
			$("#mode", "#pollListFrm").val("PC");
			$.ajax({
				type: "POST",
				contentType: "application/x-www-form-urlencoded",
				dataType: "json",
				url: "/pages/admin/poll/proc.jsp",
				data: $("#pollListFrm").serialize(),
				error: function (jqXHR, textStatus, errorThrown) {
					alert(textStatus + " / " +errorThrown);
				},
				success: function (data){
					alert(data.msg);
					if( data.result == 'true' ) {
						$("#searchFrm").submit();
					}
				}
			});
		}
	}
	
	//검색
	function goSearch() {
		$("#pageIndex", "#searchFrm").val("1");
		$("#searchFrm").submit();
	}
	
	// 페이징
	function goPaging(pageIndex) {
		$("#pageIndex", "#searchFrm").val(pageIndex);
		$("#searchFrm").submit();
	}
</script>

<div id="adWrap">
	<div id="adContaner">
		<jsp:include page="/pages/admin/common/left20.jsp" />
		<div class="adContent">
			<jsp:include page="/pages/admin/common/top.jsp" />
			<div class="topTitle">
				<h2 class="title">연수설문 관리</h2>
			</div>
			<form name="searchFrm" id="searchFrm" method="post" target="_self" action="/pages/admin/poll/list.jsp">
			<input type="hidden" name="pageIndex" id="pageIndex" value="<%=pollMasterDTO.getPageIndex()%>" />
            <div class="tableTop">
            	<ul class="tableUpLine">
               		<li class="lineLeft">
					<b>※ 연수설문은 사용여부가 1개만 가능합니다.</b>
					</li>
                	<li class="lineRight">
					<select name="useYn" id="useYn" onchange="goSearch();" style="width: 100px;">
					    <option value="" <%= "".equals(pollMasterDTO.getUseYn()) ? "selected":"" %>>사용여부</option>
					    <option value="Y" <%= "Y".equals(pollMasterDTO.getUseYn()) ? "selected":"" %>>사용</option>
					    <option value="N" <%= "N".equals(pollMasterDTO.getUseYn()) ? "selected":"" %>>미사용</option>
					</select>
					<select name="pageRow" id="pageRow" onchange="goSearch();" style="width: 100px;">
					    <option value="10" <%= pollMasterDTO.getPageRow() == 10 ? "selected":"" %>>10줄 보기</option>
					    <option value="15" <%= pollMasterDTO.getPageRow() == 15 ? "selected":"" %>>15줄 보기</option>
					    <option value="20" <%= pollMasterDTO.getPageRow() == 20 ? "selected":"" %>>20줄 보기</option>
					</select>
					</li>
				</ul>
			</div>
			</form>
			<form id="pollListFrm" name="pollListFrm" method="post" target="_self" >
			<input type="hidden" id="mode" name="mode" />
			<input type="hidden" id="pollCd" name="pollCd" />
			<input type="hidden" name="useYn" id="useYn" value="<%= StringUtil.nvl(pollMasterDTO.getUseYn()) %>" />
			<input type="hidden" name="pageIndex" id="pageIndex" value="<%= pollMasterDTO.getPageIndex() %>" />
			<input type="hidden" name="pageRow" id="pageRow" value="<%= pollMasterDTO.getPageRow() %>" />
            <div class="tableType">
				<table cellspacing="0" cellpadding="0" border="0" summary="">
					<caption>연수설문 관리</caption>
					<colgroup>
						<col style="width:4%" />
						<col style="width:6%" />
						<col />
						<col style="width:10%" />
						<col style="width:10%" />
						<col style="width:12%" />
					</colgroup>
					<thead>
						<tr>
							<th scope="col"><input type="checkbox" onclick="doChkAll(this)"/></th>
							<th scope="col">No</th>
							<th scope="col">제목</th>
							<th scope="col">사용여부</th>
							<th scope="col">등록자</th>
							<th scope="col">최종수정일</th>
						</tr>
					</thead>
					<tbody>
<%
	if ( list!=null && !list.isEmpty() ) {
		int i=0;
		for(PollMasterDTO pollMaster : list){
%>
						<tr>
							<td><input type="checkbox" id="targetList" name="targetList" value="<%= pollMaster.getPollCd() %>"/></td>
							<td><%= totalcnt - (pollMasterDTO.getPageRow()*pollMasterDTO.getPageIndex() - (pollMasterDTO.getPageRow()-i)) %></td>
							<td class="title"><a href="#" onclick="goView('<%= pollMaster.getPollCd() %>')"><%= pollMaster.getTitle() %></a></td>
							<td><%= "Y".equals(pollMaster.getUseYn()) ? "사용":"미사용" %></td>
							<td><a href="#" onclick="viewUserInfo('<%= pollMaster.getRegId() %>','userInfo')"><%= pollMaster.getRegId() %></a></td>
							<td><%=StringUtil.nvl(DateUtil.convertFormat(pollMaster.getModDate(), "MM-dd-yyyy")) %></td>
						</tr>
<%
			i++;
		}
	} else {
%>
						<tr>
							<td align="center" colspan="9"> 등록된 설문이 없습니다. </td>
						</tr>
<%
	}
%>
					</tbody>
				</table>
			</div><!-- // tableType -->
			<div class="paginate_complex">
				<%=paging %>
			</div>
			<div class="btnCont">
				<p><span style="vertical-align:middle;">선택한 설문을
				<select name="typeCd" id="typeCd" style="width: 100px;">
					<option value="useYn:Y">사용</option>
					<option value="useYn:N">미사용</option>
					<option value="delete:N">삭제</option>
				</select>
				</span>
				<span class="blackLbtnl"><a href="#" onclick="goProc();">변경</a></span></p>
				<p class="btnR"><a href="/pages/admin/poll/pollMasterForm.jsp"><img src="/pages/admin/images/btn_regi.gif" alt="등록" /></a></p>
			</div>
			</form>
		</div><!-- // adContent -->
	</div><!-- // adContaner -->
</div><!-- // adWrap -->
<div id="userInfo"></div>