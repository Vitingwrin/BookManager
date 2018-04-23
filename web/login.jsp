<%--
  Created by IntelliJ IDEA.
  User: CHIU
  Date: 2018/4/20
  Time: 8:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

  <link rel="stylesheet" href="css/bootstrap.css">
  <link rel="stylesheet" href="css/fontawesome-all.min.css">

  <script type="text/javascript" src="js/jquery-3.3.1.min.js"></script>
  <script type="text/javascript" src="js/popper.min.js"></script>
  <script type="text/javascript" src="js/bootstrap.min.js"></script>
  <title>登录</title>
  <style>
    .tips{
      margin-top: -0.8rem;
      padding-bottom: 0.8rem;
      margin-left: 2.5rem;
    }
  </style>
</head>
<body>
<div class="modal fade" id="login" data-backdrop="static" data-keyboard="false">
  <div class="modal-dialog modal-dialog-centered" tabindex="-1">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="mx-auto">登录</h5>
      </div>
      <div class="modal-body">
        <nav>
          <div class="nav nav-tabs">
            <a class="nav-item nav-link active" href="#user_login" data-toggle="tab" onclick="setFocus('userLogin')">用户</a>
            <a class="nav-item nav-link" href="#admin_login" data-toggle="tab" onclick="setFocus('adminLogin')">管理员</a>
          </div>
        </nav>
        <div class="tab-content" style="padding-left: 15px; padding-right: 15px;">
          <div id="user_login" class="tab-pane fade show active" style="padding-top: 30px;">
            <form id="userLogin" action="login.user" method="post">
              <div class="form-group">
                <div class="input-group">
                  <div class="input-group-prepend">
                    <span class="input-group-text"><i class="fas fa-user"></i></span>
                  </div>
                  <input id="userInput" type="text" class="form-control" placeholder="请输入用户名..." name="userName" required autocomplete="username" onfocus="clearTips(0)" autofocus>
                </div>
              </div>
              <div class="form-group" style="padding-top: 10px;">
                <div class="input-group">
                  <div class="input-group-prepend">
                    <span class="input-group-text"><i class="fas fa-lock"></i></span>
                  </div>
                  <input type="password" class="form-control" placeholder="请输入密码..." name="userPwd" required autocomplete="current-password" onfocus="clearTips(0)">
                </div>
              </div>
              <div class="tips tipsUser text-danger">

              </div>
              <div class="form-group" style="padding-top: 5px; margin-left: 2.5rem;">
                <div class="custom-control custom-checkbox mr-sm-2">
                  <input type="checkbox" class="custom-control-input" id="autoLogin" name="autoLogin" value="yes">
                  <label class="custom-control-label" for="autoLogin">7天内自动登录</label>
                </div>
              </div>
              <div class="container" style="padding-top: 10px;">
                <div class="row">
                  <div class="col-6">
                    <input class="btn btn-outline-primary btn-block" name="register" type="button" value="注册" onclick="goRegister()">
                  </div>
                  <div class="col-6">
                    <input type="hidden" name="user" value="登录">
                    <input class="btn btn-primary btn-block" type="button" value="登录" onclick="login('#userLogin', 0)">
                  </div>
                </div>
              </div>
            </form>
          </div>
          <div id="admin_login" class="tab-pane fade" style="padding-top: 30px;">
            <form id="adminLogin" action="login.user" method="post">
              <div class="form-group">
                <div class="input-group">
                  <div class="input-group-prepend">
                    <span class="input-group-text"><i class="fas fa-user"></i></span>
                  </div>
                  <input id="adminInput" type="text" class="form-control" placeholder="请输入管理员名..." name="userName" required autocomplete="username" onfocus="clearTips(1)">
                </div>
              </div>
              <div class="form-group" style="padding-top: 10px;">
                <div class="input-group">
                  <div class="input-group-prepend">
                    <span class="input-group-text"><i class="fas fa-lock"></i></span>
                  </div>
                  <input type="password" class="form-control" placeholder="请输入密码..." name="userPwd" required autocomplete="current-password" onfocus="clearTips(1)">
                </div>
              </div>
              <div class="tips tipsAdmin text-danger">

              </div>
              <div class="container" style="padding-top: 10px;">
                <div class="row">
                  <div class="col-6">
                    <button class="btn btn-outline-secondary btn-block disabled" data-toggle="tooltip"
                            name="register" type="button" data-placement="bottom" title="不存在的，请联系管理员">
                      注册
                    </button>
                  </div>
                  <div class="col-6">
                    <input type="hidden" name="admin" value="登录">
                    <input class="btn btn-primary btn-block" type="button" value="登录" onclick="login('#adminLogin', 1);">
                  </div>
                </div>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<div class="modal fade" id="register" data-backdrop="static" data-keyboard="false">
  <div class="modal-dialog modal-dialog-centered" tabindex="-1">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="mx-auto">注册</h5>
      </div>
      <div class="modal-body">
        <div id="user_register" class="tab-pane fade show active" style="padding-top: 30px;padding-left: 15px; padding-right: 15px;">
          <form id="userRegister" action="register.user" method="post">
            <div class="form-group">
              <div class="input-group">
                <div class="input-group-prepend">
                  <span class="input-group-text"><i class="fas fa-user"></i></span>
                </div>
                <input id="regName" type="text" class="form-control" placeholder="请输入用户名..." name="userName" required autocomplete="username" onblur="checkName()" onkeyup="checkName()">
              </div>
            </div>
            <div id="regNameTips" class="tips text-danger" style="padding-top: -10px;">

            </div>
            <div class="form-group" style="padding-top: 10px;">
              <div class="input-group">
                <div class="input-group-prepend">
                  <span class="input-group-text"><i class="fas fa-lock"></i></span>
                </div>
                <input type="password" class="form-control" id="regPwd1" placeholder="请输入密码..." name="userPwd" required autocomplete="current-password">
              </div>
            </div>
            <div class="form-group" style="padding-top: 10px;">
              <div class="input-group">
                <div class="input-group-prepend">
                  <span class="input-group-text"><i class="fas fa-lock"></i></span>
                </div>
                <input type="password" class="form-control" id="regPwd2" placeholder="再次输入密码..." required autocomplete="current-password" onblur="checkPwd()">
              </div>
            </div>
            <div id="regPwdTips" class="tips text-danger">

            </div>
            <div class="container" style="padding-top: 20px;">
              <div class="row">
                <div class="col-6">
                  <input class="btn btn-outline-primary btn-block" type="button" value="返回" onclick="goBack()">
                </div>
                <div class="col-6">
                  <input class="btn btn-primary btn-block" type="button" value="注册" onclick="register()">
                </div>
              </div>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
</div>


<script type="text/javascript">
    $("#login").modal();
    $("[data-toggle='tooltip']").tooltip();
    $('#login').on('hidden.bs.modal', function () {
        $("#register").modal('show');
    });

    $('#register').on('hidden.bs.modal', function () {
        $("#login").modal('show');
    });

    function goBack(){
        $("#register").modal('hide');
        setTimeout(function(){$("#userInput").focus();}, 500);
    }

    function goRegister(){
        $("#login").modal('hide');
        setTimeout(function(){$("#regName").focus();}, 500);
    }

    function checkName(){
        if($("#regName").val() === ""){
            $("#regNameTips")[0].innerText = "用户名不能为空";
            return false;
        }else{
            $.ajax({
                type: "GET",
                url: "checkName.user",
                data: {"userName":$("#regName").val()},
                async: true,
                success: function(result){
                    if(result === "exists"){
                        $("#regNameTips")[0].innerText = "用户名已被占用";
                        return false;
                    }else{
                        $("#regNameTips")[0].innerText = "";
                        return true;
                    }
                }
            });
        }
    }

    function checkPwd(){
        var pwd1 = $("#regPwd1").val();
        var pwd2 = $("#regPwd2").val();
        if(pwd1 !== pwd2){
            $("#regPwdTips")[0].innerText = "两次密码不一致";
            return false;
        }else if(pwd1 === ""){
            $("#regPwdTips")[0].innerText = "密码不能为空";
            return false;
        }else{
            $("#regPwdTips")[0].innerText = "";
            return true;
        }

    }

    function clearTips(who){
        if(who === 0){
            $(".tipsUser")[0].innerText = "";
        }else if(who === 1){
            $(".tipsAdmin")[0].innerText = "";
        }
    }

    function setFocus(which) {
        if(which === "userLogin"){
            setTimeout(function(){$("#userInput").focus();}, 200);
        }else if(which === "adminLogin"){
            setTimeout(function(){$("#adminInput").focus();}, 200);
        }
    }

    function login(id, who) {
        $.ajax({
            type: "POST",
            url: "login.user",
            data: $(id).serialize(),
            async: false,
            success: function (result) {
                if(result === "failed"){
                    if(who === 0){
                        $(".tipsUser")[0].innerText = "用户名或密码错误";
                    }else if(who === 1){
                        $(".tipsAdmin")[0].innerText = "管理员名或密码错误";
                    }
                }else if(result === "false"){
                    if(who === 0){
                        $(".tipsUser")[0].innerText = "请求错误,请刷新";
                    }else if(who === 1){
                        $(".tipsAdmin")[0].innerText = "请求错误,请刷新";
                    }
                }else {
                    if(who === 0){
                        if($("#autoLogin")[0].checked === true){
                            var date = new Date();
                            date.setTime(date.getTime() + (7 * 24 * 60 * 60 * 1000));
                            var expires = "expires=" + date.toUTCString();
                            document.cookie = "userName=" + result + ";" + expires;
                        }else{
                            document.cookie = "userName=" + result;
                        }
                        window.location.href = "user_index.jsp";
                    }else if(who === 1){
                        document.cookie = "userName=" + result;
                        window.location.href = "admin_index.jsp";
                    }
                }
            }
        });
    }

    function register(){
        if($("#regNameTips")[0].innerText === "" && checkPwd()){

            $.ajax({
                type: "POST",
                url: "register.user",
                data: $("#userRegister").serialize(),
                async: true,
                success: function(result){
                    if(result === "failed"){
                        $("#regPwdTips")[0].innerText = "新增用户失败";
                    } else if(result === "false"){
                        $("#regPwdTips")[0].innerText = "请求错误,请刷新";
                    }else{
                        document.cookie = "userName=" + result;
                        window.location.href = "user_index.jsp";
                    }
                }
            });
        }
    }

    $(document).ready(function (){
        if(getUserName() != null){
            window.location.href = "user_index.jsp";
        }
    });

    function getUserName(){
        var cookie = document.cookie;
        var array = cookie.split("=");
        if(array[0] === "userName"){
            if(array[1] !== ""){
                return array[1];
            }
        }

        return null;
    }
</script>
</body>
</html>