<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%><%@ 
taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%><%@ 
taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@ 
taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%@ 
taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<script type="text/javascript">

	/* 타이틀 */
	$(document).ready(function() {
		$(document).attr("title","My Page > My Desk : K-LINK");
	});

	function fn_modify(seq) {
		$("#applyCd").val(seq);
		var reqUrl = "/lu/apply/goUpdateApply";
		$("#frmApplyUserInfo").attr("action", reqUrl);
		$("#frmApplyUserInfo").submit();
	}

	function fn_delete(seq) {

		if (confirm("Are you sure you want to cancel your application?\nAll information entered will not be restored.")) {
			$("#applyCd").val(seq);
			var reqUrl = "/lu/apply/deleteApply";
			$("#frmApplyUserInfo").attr("action", reqUrl);
			$("#frmApplyUserInfo").submit();
		} else {
			return;
		}

	}

	function fn_view(seq) {
		$("#applyCd").val(seq);
		var reqUrl = "/lu/mypage/mydeskView";
		$("#frmApplyUserInfo").attr("action", reqUrl);
		$("#frmApplyUserInfo").submit();
	}

</script>
<div id="myDesk">
	<h5>Click on the courses below to see details.</h5>
	<table>
		<caption class="sr-only">My Desk List</caption>
		<thead>
			<tr>
				<th scope="col" class="num">No.</th>
				<th scope="col" class="duration">Duration</th>
				<th scope="col" class="date">Date</th>
				<th scope="col">Course</th>
				<th scope="col" class="status-1">Application <br />Status</th>
				<th scope="col" class="status-2">Status of <br /> approval</th>
				<th scope="col" class="view">View</th>
			</tr>
		</thead>
		<tbody>

			<c:forEach var="result" items="${resultList }" varStatus="status">
				<tr>
					<td>${status.count}</td>
					<td>${result.dayStart} - ${result.dayEnd}</td>
					<td>${result.applyDate}</td>
					<td><a href="/lu/course/courseDetail?courseCd=${result.courseCd }">${result.title}</a></td>

					<td>
						<c:if test="${result.stepCd ne 'SS'}">Application not completed</c:if>
						<c:if test="${result.stepCd eq 'SS'}">Application completed</c:if>
					</td>
					<td>
						${result.statusCdName}
					</td>
					<td>
						<!-- <div class="btn-white" onclick="javascript:fn_view('${result.applyCd}');">VIEW</div> -->
						<c:if test="${result.ctStatusCd ne 'CT03'}">
							<c:if test="${result.todayType eq 'A'}">
								<button type="button" class="btn-white" onclick="javascript:fn_modify('${result.applyCd}');">UPDATE</button>
							</c:if>
							<c:if test="${result.todayType ne 'A'}">
								<button type="button" class="btn-white" onclick="javascript:fn_view('${result.applyCd}');">VIEW</button>
							</c:if>
						</c:if>
						<c:if test="${result.ctStatusCd eq 'CT03'}">
							<button type="button" class="btn-white" onclick="javascript:fn_view('${result.applyCd}');">VIEW</button>
						</c:if>
					</td>
				</tr>
			</c:forEach>

		</tbody>
		<tbody>
			<tr>

				<c:forEach var="result" items="${resultList }" varStatus="status">

					<td colspan="7" class="mobile-on">
						<span>No.${status.count}</span>
						<span>Duration:${result.dayStart} - ${result.dayEnd}</span>
						<span>Date:${result.applyDate}</span>
						<span><a href="/lu/course/courseDetail?courseCd=${result.courseCd }">${result.title}</a></span>

						<span>
							<c:if test="${result.stepCd ne 'SS'}">Application not completed</c:if>
							<c:if test="${result.stepCd eq 'SS'}">Application completed</c:if>
						</span>
						<span>
							${result.statusCdName}
						</span>
						<c:if test="${result.ctStatusCd ne 'CT03'}">
							<button type="button" class="btn-white" onclick="javascript:fn_modify('${result.applyCd}');">UPDATE</button>
						</c:if>
						<c:if test="${result.ctStatusCd eq 'CT03'}">
							<button type="button" class="btn-white" onclick="javascript:fn_view('${result.applyCd}');">VIEW</button>
						</c:if>
					</td>

				</c:forEach>

			</tr>

		</tbody>
	</table>
</div><!-- E: myDesk -->
<form id="frmApplyUserInfo" name="frmApplyUserInfo" method="post">
	<input type="hidden" name="applyCd" id="applyCd" />
</form>