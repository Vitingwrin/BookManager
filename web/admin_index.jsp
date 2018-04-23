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
      <a name="add" class="nav-choice nav-link" href="#" onclick="show('addbook.jsp', this)"><i class="far fa-plus-square"></i>&nbsp;&nbsp;新增图书</a>
      <a name="del" class="nav-choice nav-link" href="#" onclick="show('delbook.jsp', this)"><i class="far fa-minus-square"></i>&nbsp;&nbsp;删除图书</a>
      <a name="find" class="nav-choice nav-link" href="#" onclick="show('findbook.jsp', this)"><i class="fas fa-search"></i>&nbsp;&nbsp;查询图书</a>
      <a name="edit" class="nav-choice nav-link" href="#" onclick="show('editbook.jsp', this)"><i class="far fa-edit"></i>&nbsp;&nbsp;修改图书</a>
      <div style="padding-bottom: 10px" ></div>
      <a name="user" class="nav-choice list-group-item list-group-item-action" data-toggle="collapse" data-target="#user_nav" href="#"><i class="far fa-user"></i>&nbsp;&nbsp;用户管理</a>
      <div id="user_nav" class="collapse second-item">
        <a name="userDel" class="nav-choice nav-link" href="#" onclick="show('null', this)"><i class="fas fa-user-times"></i>&nbsp;&nbsp;删除用户</a>
        <a name="adminAdd" class="nav-choice nav-link" href="#" onclick="show('null', this)"><i class="fas fa-user-plus"></i>&nbsp;&nbsp;新增管理员</a>
      </div>
    </div>

  </div>
</nav>

<div class="container-fluid">
  <div class="row">
    <div class="col-2 sidebar">
      <div id="left">
        <div class="sidebar-item list-group">
          <a name="add" class="nav-choice list-group-item list-group-item-action" href="#" onclick="show('addbook.jsp', this)"><i class="far fa-plus-square"></i>&nbsp;&nbsp;新增图书</a>
          <a name="del" class="nav-choice list-group-item list-group-item-action" href="#" onclick="show('delbook.jsp', this)"><i class="far fa-minus-square"></i>&nbsp;&nbsp;删除图书</a>
          <a name="find" class="nav-choice list-group-item list-group-item-action" href="#" onclick="show('findbook.jsp', this)"><i class="fas fa-search"></i>&nbsp;&nbsp;查询图书</a>
          <a name="edit" class="nav-choice list-group-item list-group-item-action" href="#" onclick="show('editbook.jsp', this)"><i class="far fa-edit"></i>&nbsp;&nbsp;修改图书</a>
          <div style="padding-bottom: 30px" ></div>
          <a name="user" class="nav-choice list-group-item list-group-item-action" data-toggle="collapse" data-target="#user_sidebar" href="#"><i class="far fa-user"></i>&nbsp;&nbsp;用户管理</a>
          <div id="user_sidebar" class="collapse second-item">
            <a name="userDel" class="nav-choice list-group-item list-group-item-action" href="#" onclick="show('null', this)"><i class="fas fa-user-times"></i>&nbsp;&nbsp;删除用户</a>
            <a name="adminAdd" class="nav-choice list-group-item list-group-item-action" href="#" onclick="show('null', this)"><i class="fas fa-user-plus"></i>&nbsp;&nbsp;新增管理员</a>
          </div>
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
                    if(result === "true" || result === "both"){
                        $("#welcome")[0].innerText = "管理员 - - - " + name;
                    }else if(result === "false"){
                        document.cookie = "userName=";
                        window.location.href = "login.jsp";
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
        //$(obj).addClass("active");
        $("[name=" + obj.name +"]").addClass("active");
        if(url !== "null"){
            $.ajax({
                type: "get",
                url: url,
                async: false,
                success: function(data){
                    console.log(url);
                    $("#content").html(data);

                }
            });
        }
    }

    function logout(){
        document.cookie = "userName=";
        window.location.href = "login.jsp";
    }

</script>

</body>
</html>