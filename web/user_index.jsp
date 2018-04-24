<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

  <link rel="stylesheet" href="css/bootstrap.css">
  <link rel="stylesheet" href="css/index.css">
  <link rel="stylesheet" href="css/fontawesome-all.min.css">

  <script type="text/javascript" src="js/jquery-3.3.1.min.js"></script>
  <script type="text/javascript" src="js/popper.min.js"></script>
  <script type="text/javascript" src="js/bootstrap.min.js"></script>

  <title>图书管理系统</title>
</head>
<body>

<nav class="navbar navbar-expand-md navbar-dark bg-primary" style="z-index: 1;">
  <div class="container-fluid">
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar">
      <span class="navbar-toggler-icon"></span>
    </button>

    <a class="navbar-brand mx-auto" href="admin_index.jsp">图书管理系统</a>
    <a class="text-white nav-link" href="#" onclick="logout()" ><i class="fas fa-sign-out-alt"></i>&nbsp;退出</a>

    <div id="navbar" class="collapse navbar-collapse navbar-item">
      <a name="lend" class="nav-choice nav-link" href="#" onclick="show('lendbook.jsp', this)"><i class="fas fa-book"></i>&nbsp;&nbsp;借书</a>
      <a name="return" class="nav-choice nav-link" href="#" onclick="show('returnbook.jsp', this)"><i class="fas fa-undo-alt"></i>&nbsp;&nbsp;还书</a>
    </div>

  </div>
</nav>

<div class="container-fluid">
  <div class="row">
    <div class="col-2 sidebar">
      <div id="left">
        <div class="sidebar-item list-group">
          <a name="lend" class="nav-choice list-group-item list-group-item-action" href="#" onclick="show('lendbook.jsp', this)"><i class="fas fa-book"></i>&nbsp;&nbsp;借书</a>
          <a name="return" class="nav-choice list-group-item list-group-item-action" href="#" onclick="show('returnbook.jsp', this)"><i class="fas fa-undo-alt"></i>&nbsp;&nbsp;还书</a>
        </div>
      </div>
    </div>
    <div id="right" class="col-md-10 offset-md-2">
      <div class="container-fluid">
        <div class="row" >
          <div class="col">
            <h1>&nbsp;<i class="far fa-smile"></i>&nbsp;&nbsp;欢迎光临&nbsp;&nbsp;<span id="welcome"></span></h1>
          </div>

        </div>
      </div>
      <div id="content">

      </div>
    </div>
  </div>
</div>

<script type="text/javascript">

    function check() {
        console.log(document.referrer);
        if (document.referrer === "") {
            window.location.href = "login.jsp";
        }
    }

    $(document).ready(function (){
        check();
        var name = getUserName();
        if(name === null){
            window.location.href = "login.jsp";
        }else{
            $.ajax({
                type: "GET",
                url: "checkIsAdmin.user",
                data: {"userName":name},
                async: false,
                success: function (result) {
                    if(result === "true"){
                        document.cookie = "userName=";
                        window.location.href = "login.jsp";
                    }else if(result === "false" || result === "both"){
                        $("#welcome")[0].innerText = "普通用户 - - - " + name;
                    }
                }
            });
        }
    });

    function getUserName(){
        var cookie = document.cookie;
        var array = cookie.split("=");
        if(array[0] === "userName"){
            return array[1];
        }
        return null;
    }

    function show(url, obj){
        $("#navbar a").removeClass("active");
        $("#left a").removeClass("active");
        $(obj).addClass("active");
        $.ajax({
            type: "get",
            url: url,
            async: true,
            success: function(data){
                console.log(url);
                $("#content").html(data);

            }
        });
    }

    function logout(){
        document.cookie = "userName=";
        window.location.href = "login.jsp";
    }
</script>

</body>
</html>