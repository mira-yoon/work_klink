<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript">

  /* 타이틀 */
  $(document).ready(function() {
    $(document).attr("title","Memberships > Sign In : K-LINK");
  });

  function fnAfterCheckLogin() {

    if (!$('#memId').val()) {
      alert("아이디를 입력해 주세요.");
      $("#memId").focus();
      return false;
    } else if (!$('#memPasswordEncript').val()) {
      alert("패스워드를 입력해 주세요.");
      $("#memPasswordEncript").focus();
      return false;
    } else {
      fn_loginProc();
    }

  }

  function fn_loginProc() {

    var url = "/lu/login/loginProc";
    var $form = $("#loginProcForm");

    $form.submit();
  }

</script>
<div id="signIn">
  <div class="login-area">
    <div class="login-title">
      <span>You Have to Sign in.</span>
      <p>LEADERS’ INFORMATION NETWORK</p>
    </div>
    <form action="/lu/login/loginProc" id="loginProcForm" name="loginProcForm" method="post">

      <div class="login-box">
        <div class="user-id">
          <div class="input-box">
            <input type="text" title="Id" aria-label="Id" name="memId" id="memId" value="" placeholder="User ID" />
          </div>
        </div>
        <div class="password">
          <div class="input-box">
            <input type="password" title="password" aria-label="password" name="memPasswordEncript" value="" id="memPasswordEncript" placeholder="password" autocomplete="off" />
          </div>
        </div>
        <button type="submit" class="btn-blue btn-signin" onclick="javascript:fnAfterCheckLogin();">Sign In</button>
      </div>
    </form>

    <div class="btn-box">
      <ul>
        <li><a href="/stipulation.do">Sign up</a></li>
        <li>|</li>
        <li><a href="/forgot.do">Forgot ID</a></li>
        <li>|</li>
        <li><a href="/forgot.do">Forgot Password?</a></li>
      </ul>
    </div>
  </div>
</div><!-- E : signIn -->