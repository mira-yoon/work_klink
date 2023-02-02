<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<script type="text/javascript">
<!--
/**
 * browser 버전 체크 
 * @returns
 */   
 function browserVer(){

	var bwVer = "";
	var browserInfo = navigator.userAgent.toLowerCase();
	if( "Explorer" == browserType() ){
		bwVer = getIEVersion(); 
	}else if( "Chrome" == browserType() ){
		bwVer = getChromeVersion();
	}else{
		var bw = $.browser;
		if( undefined != bw ){
			bwVer = $.browser.version;
		}
	}
	return bwVer;
}

function getIEVersion() {
    var match = navigator.userAgent.match(/(?:MSIE |Trident\/.*; rv:)(\d+)/);
    return match ? parseInt(match[1]) : undefined;
}

function getChromeVersion() {
    var vMatch = navigator.userAgent.match(/(?:Chrome\/.*)(\d+)/);
    vMatch = vMatch + "";
    vMatch = vMatch.split(" ");
    return vMatch ? vMatch[0] : undefined;
}
/**
 * browser  타입 체크 
 * @returns
 */
 function browserType(){
	var browserInfo = navigator.userAgent.toLowerCase();
	var browser     = browserInfo;		
	
	if(browserInfo.indexOf('msie') != -1)    browser = "Explorer";
	if(browserInfo.indexOf('trident') != -1) browser = "Explorer";		
	if(browserInfo.indexOf('safari') != -1)  browser = "Safari";
	if(browserInfo.indexOf('chrome') != -1)  browser = "Chrome";
	if(browserInfo.indexOf('opr') != -1)     browser = "Opera";
	if(browserInfo.indexOf('firefox') != -1) browser = "Firefox";
	if(browserInfo == browser)               browser = "등록되지 않은 브라우저 입니다";		
	
	return  browser;
}


if( "Explorer" == browserType() && 10 > browserVer() ){
	//alert("Internet Explorer 10 이상 버전에 최적화 되어있으므로 업그레이드후 이용을 권장합니다.\n 브라우저 모드 : IE 10 , 문서 모드 : 표준");
	var trident = navigator.userAgent.match(/Trident\/(\d.\d)/i);
	if(trident != null && (trident[1] == "6.0" || trident[1] == "7.0" || trident[1] == "8.0"  )){
	 
	} else{
	  	alert("Internet Explorer 10 이상 버전에 최적화 되어있으므로 업그레이드후 이용을 권장합니다.\n 브라우저 모드 : IE 10 , 문서 모드 : 표준");	
	}
}

	function fn_loginProc(){
		
		
		var url = "/la/login/loginProc"; 
		var $form  = $("#loginProcForm");			
		
		$form.submit();
	}
	

	$(document).ready(function () {
		initEvent();
	});
	
	/* 각종 버튼에 대한 액션 초기화 */
	function initEvent() {
		
		// input Type이 Text인 경우 Enter Key 입력시 조회 
		$("#memId").keydown(function (key){
			if(key.keyCode == "13") {
				fnAfterCheckLogin();
			}
		});
		
		$("#memPasswordEncript").keydown(function (key){
			if(key.keyCode == "13") {
				fnAfterCheckLogin();
			}
		});
	}
	
	function fnAfterCheckLogin(){

		if( !$('#memId').val()){
			alert("아이디를 입력해 주세요.");
			$("#memId").focus();
			return false;
		}else if(!$('#memPasswordEncript').val()){
			alert("패스워드를 입력해 주세요.");
			$("#memPasswordEncript").focus();
			return false;
		}else{
			fn_loginProc();			
		}

	}
	//-->
</script>
	
		<div id="wrapper">
			<dl>
				<dt>
					<ul>
						<li class="type-02">ADMINISTRATOR</li>
					</ul>
				</dt>

				<dd class="log-area-1">
					<div id="login" class="gLogin">
						<form action="/la/login/loginProc" id="loginProcForm" method="post" class="gLogin" onSubmit="return fnAfterCheckLogin();">
							<input id="reqUri" name="reqUri" type="hidden" value="${reqUri }" />
							<input id="menuArea" name="menuArea" type="hidden" value="LA" />
							<fieldset>
								<legend>회원 로그인</legend>
								<ul>
									<li class="item"><input name="memId" type="text" value="" id="memId" placeholder="관리자 아이디" class="iText uid" /></li>
									<li class="item"><input name="memPasswordEncript" type="password" value="" placeholder="비밀번호" id="memPasswordEncript" class="iText upw" autocomplete="off"/></li>
								</ul>
								<span class="btn"><input type="submit" name=""  value="LOGIN" /></span>
							</fieldset>
						</form>
					</div>
				</dd>

				<dd class="log-area-2" style="display:none;">
					<span class="text">- 로그아웃 후 재접속 해주시기 바랍니다. -</span>
					<span class="btn"><input type="submit" name="" value="LOGOUT" /></span>
				</dd>

				<dd class="footer">COPYRIGHT ⓒ 2019. ALL RIGHTS RESERVED.</dd>
			</dl>
		</div><!-- wrapper --> 