<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><%@ 
page import="kr.co.wizi.wizilearn.comm.service.Globals" %><%@ 
page import="kr.co.wizi.wizilearn.comm.vo.LoginInfo" %><%@ 
page import="kr.co.wizi.wizilearn.comm.service.EgovProperties" %><%@ 
taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
		<script type="text/javascript">

		$(document).ready(function(){
			
			if (document.location.protocol == 'http:' && document.location.hostname !=  'localhost') {
			//	document.location.href = document.location.href.replace('http:', 'https:');
			}
			fn_egov_init_PopupManage();

			function fn_egov_init_PopupManage(){
				<c:forEach items="${resultPopupList}" var="resultInfo" varStatus="status">
				<c:if test="${resultInfo.useYn eq 'Y'}">
				if(fnGetCookie('${resultInfo.popupId}') == null ){
					fn_egov_popupOpen_PopupManage('${resultInfo.popupId}',
							'${resultInfo.popupWidthSize}',
							'${resultInfo.popupHeightSize}',
							'${resultInfo.popupHeightPosi}',
							'${resultInfo.popupWidthPosi}',
							'${resultInfo.stopviewYn}');
				}
				</c:if>
				</c:forEach>
			}
			function fn_egov_popupOpen_PopupManage(popupId,width,height,top,left,stopviewYn){

				var url = "<c:url value='/lu/popup/openPopupManage.do' />?";
				url = url + "stopviewYn=" + stopviewYn;
				url = url + "&popupId=" + popupId;
				var name = popupId;
				var openWindows = window.open(url,name,"width="+width+",height="+height+",top="+top+",left="+left+",toolbar=no,status=no,location=no,scrollbars=yes,menubar=no,resizable=yes");

				openWindows.focus();
			}
			function fnGetCookie(name) {
				var prefix = name + "=";

				var cookieStartIndex = document.cookie.indexOf(prefix);
				if (cookieStartIndex == -1) return null;
				var cookieEndIndex = document.cookie.indexOf(";", cookieStartIndex + prefix.length);
				if (cookieEndIndex == -1) cookieEndIndex = document.cookie.length;

				return unescape(document.cookie.substring(cookieStartIndex + prefix.length, cookieEndIndex));
			}
			/* ********************************************************
			* 팝업창  오픈 END
			******************************************************** */

			function date() {
					/* var date = new Date();
					var year = date.getFullYear(); // 년
					var month = date.getMonth()+1; //달
					var monthStr ="";
					var day = date.getDate();  //일
				var dayStr ="";
					var hours = date.getHours();  //시
					var hoursStr= "";
					var minutes = date.getMinutes(); //분
					var minutesStr="";
					var a = "AM";
					var h = hours;
					var hstr ="";
					
					if (hours >= 12){
						h=hours-12
						a = "PM"
				}
					
					if (hours == 0) {
						hours = 12;
					}
					
					if(month<10){
						monthStr="0"+month;
					}else{
						monthStr= month;
					}
					if(day<10){
						dayStr="0"+day;
					}else{
						dayStr= day;
					}
					$("#date").html(monthStr+"/"+dayStr+"/"+year);
					
					if(h<10){
						hstr = "0"+h;
					}else{
						hstr = h;
					}
					if(minutes<10){
						minutesStr="0"+minutes;
					}else{
						minutesStr= minutes;
					}
					$("#time").html(hstr+":"+minutesStr+" "+ a); */
					
				var reqUrl = "/lu/index/getDateTime.json";
				$.ajax({
					url : reqUrl,
					type : "POST",
					contentType : "application/json",
					async : false,
					success : function(data) {
						var nowTime = data.nowTime;
						var nowDate = data.nowDate;
						$("#time").html(nowTime);
						$("#date").html(nowDate);
					},
					error : function(xhr, status, error) {
						alert("시스템관리자에게 문의하세요.");
					}
				});
			}
			
			function init() {
				date();
				setInterval(date, 1000 * 60); //1분마다 리로딩
			}
			
			init();
			
			//슬라이드
			
			
			// $('.banner-open ul').bxSlider({
			//   	auto: true, 
			//   	speed: 600, 
			//   	pause: 4000, 
			//   	mode:'horizontal', 
			//   	autoControls: false, 
			//   	pager:true,
			//   	touchEnabled : (navigator.maxTouchPoints > 0),
			//   });
			
			$('.banner-close ul').bxSlider({
					auto: false, 
					speed: 600, 
					pause: 4000, 
					mode:'horizontal', 
					autoControls: false, 
					pager: true,
					touchEnabled : (navigator.maxTouchPoints > 0),
				});

			// $('.banner-close ul').bxSlider({
			// 	auto: true, 
			// 	speed: 600, 
			// 	pause: 4000, 
			// 	mode:'horizontal', 
			// 	autoControls: false, 
			// 	pager:true,
			// 	touchEnabled : (navigator.maxTouchPoints > 0),
			// });	
	
			$("nav ul li a").click(function(){
				$("nav li ul").removeClass("menu-on");
				$(this).next().addClass("menu-on");
				
			});
			$("nav ul li ul").mouseleave(function(){
				$("nav li ul").removeClass("menu-on");
			}); 
			/* 모바일 메뉴 */
			$(".m-open").click(function(){
				$("nav").addClass("m-on");
				$(".m-bg").show();
			});
			
			$(".m-bg").click(function(){
				$("nav").removeClass("m-on");
				$(".m-bg").hide();
				$("nav li ul.menu-on").removeClass("menu-on");
			});
			
		});

		/* 상세 조회 */
		function fn_detail(type,seq){ 
			
			$("#bbsNoticeId").val(seq);
			var reqUrl = "/lu/"+type+"/detailBbs";
			$("#frmBbs").attr("action", reqUrl);
			$("#frmBbs").submit();
		}
		/* 커뮤니티로 이동 */
		function fn_comdetail(courseCd,bbsNoticeId){ 
			$("#course").val(courseCd);  
			$("#bbsNoticeId").val(bbsNoticeId);
			var reqUrl = "/lu/community/communityList";
			$("#frmBbs").attr("action", reqUrl);
			$("#frmBbs").submit();
		
		}
		/* 상세 조회 */
		function fn_course(seq){ 

			$("#courseCd").val(seq);
			
			if(seq==null||seq==''){
				return false;
			}else{
				var reqUrl = "/lu/course/courseDetail";
				$("#frmCourse").attr("action", reqUrl);
				$("#frmCourse").submit();
			}
		}

		/* 신청 */
		function fn_apply(){		
			var reqUrl = "/lu/apply/goApply";
			$("#frmCourse").attr("action", reqUrl);
			$("#frmCourse").attr("target","_self");
			$("#frmCourse").submit();
		}
		</script>
		<div id="container" tabindex="-1" style="outline:0;">
			<!-- S: main-visual -->
			<section id="visual">
				<div class="box-area">
					<div class="text-box">
						<h2><strong>ICT Experts Training</strong> Program</h2>
						<p>
							ICT Experts Training Program offers you chance to learn and experience the latest ICT technologies and Global ICT Trends​
							Join the program for the expansion of your ICT Knowledge and experience
						</p>
					</div>
					<div class="btn-annual">
						<a href="/lu/course/courseSchedule">Annual <strong> Schedule </strong></a>
					</div>
				</div>
			</section>
			<!-- E: main-visual -->

			<!-- S: main-contents -->
			<section id="main-contents" class="main-section-02">
				<div class="box-area">
					<div id="main-link">
					<div class="banner-open">
						<ul>
						<c:if test="${empty courseList}">
								<li>
									<span></span>
									<p></p>
								</li>
							</c:if>
							
							<c:if test="${not empty courseList}">
									<c:set var="checkStr" value="true"/>
									<c:forEach var="courseList" items="${courseList}" varStatus="status1">
									<c:if test="${courseList.todayType eq 'A'}" >
									<c:set var="checkStr" value="false"/>
								<li>
									<span>${courseList.dayStart} ~ ${courseList.dayEnd}</span>
									<h3>[${courseList.orgName}] ${courseList.titleStr}</h3>
									<p>Application Period <strong>${courseList.applyStart} ~ ${courseList.applyEnd}</strong></p>
									<a href="#" onclick="javascript:fn_apply();" class="btn-a">APPLY</a>
								</li>
							</c:if>	
							</c:forEach>
								<c:if test="${checkStr}">
									<li>
										<span></span>
										<p></p>
									</li>
								</c:if>
								</c:if>
						</ul>
					</div>
						
					<div class="banner-close">
						<ul>
						<c:if test="${empty courseList}">
								<li class="close">
									<span></span>

									<p></p>
								</li>
							</c:if>
							
							<c:if test="${not empty courseList}">
							<c:set var="checkStr" value="true"/>
							<c:forEach var="courseList" items="${courseList}" varStatus="status1"> 
								<c:if test="${courseList.todayType ne 'A'}" >
								<c:set var="checkStr" value="false"/>
							<li>
								<span>${courseList.applyStart} ~ ${courseList.applyEnd}</span>
								<h3>[${courseList.orgName}] ${courseList.titleStr}</h3>
								<p>Application Period <strong>${courseList.applyStart} ~ ${courseList.applyEnd}</strong></p>
								<!-- <a href="#"  onclick="javascript:fn_course('${courseList.courseCd}');" class="btn-a">CLOSE</a>
								<a href="#"  onclick="javascript:fn_course('${courseList.courseCd}');" class="btn-a">CLOSE</a> -->
								<div class="btn-a">CLOSE</div>
							</li>
							</c:if> 
							</c:forEach>
								<c:if test="${checkStr}">
										<li class="close">
											<span></span>
											<p></p>
										</li>
								</c:if>
							</c:if>
							
						</ul>
					</div>
					</div>
				</div>
			</section>
			<!-- E : main-contents -->

			<!-- S : main-bottom -->
			<section id="main-bottom">
				<div class="box-area">
					<div class="main-board">
						<div class="notice">
							<h4><strong>N</strong>otice</h4>
							<ul>
								<c:forEach var="result" items="${noticebbs}" varStatus="status">
								<li>
									<a href="javascript:void(0);" onclick="javascript:fn_detail('notice','${result.bbsNoticeId}');">
										<p style="cursor:pointer">${result.title}</p>
										<span><c:out value="${result.insertDate }"/></span>
									</a>
								</li>
							</c:forEach>
							</ul>
							<a href="/lu/notice/listBbs" class="btn-more" title="Go to Notice page." aria-label="Go to Notice page.">more</a>
						</div>
						<div class="faq">
							<h4><strong>F</strong>AQ</h4>
							<ul>
								<c:forEach var="result" items="${faqbbs}" varStatus="status">
								<li>
									<a href="javascript:void(0);" onclick="javascript:fn_detail('faq','${result.bbsNoticeId}');">
										<p style="cursor:pointer">${result.title}</p>
									</a>
								</li>
							</c:forEach>
							</ul>
							<a href="/lu/faq/listBbs" class="btn-more" title="Go to FAQ page." aria-label="Go to FAQ page.">more</a>
						</div>
					</div>
					<div class="right-con">
						<div class="time-area area">
							<h5><strong>Current Time</strong> in Korea</h5>
							<div class="time-box">
								<span id="date"></span>
								<div class="time"><span id="time"></span></div>
							</div>
						</div>
						<div class="apply-area area">
								<div class="apply-box">
									<h5>How to <strong>Apply</strong></h5>
									<p>Apply for Training Program</p>
								</div>
								<a href="#" onclick="javascript:fn_detail('faq','00001');" title="Go to how to apply page" aria-label="Go to how to apply page"><div class="fa fa-plus btn-more" aria-hidden="true"><span class="sr-only">Go to how to apply page</span></div></a>
						</div>
					</div>
				</div>
			</section>
			<!-- E : main-bottom -->    
		</div>

		<form id="frmBbs" name="frmBbs" method="post"  >
			<input type="hidden" name="bbsNoticeId" id="bbsNoticeId" />
			<input type="hidden" name="courseCd" id="course" /> 
		</form>
		<form id="frmCourse" name="frmCourse" method="post"  >
			<input type="hidden" name="courseCd" id="courseCd" /> 
		</form>