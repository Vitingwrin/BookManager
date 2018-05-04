<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <title>还书</title>
</head>
<body>

<div class="container-fluid">
  <div id="tips" class="alert alert-danger hidden"></div>
  <div id="resultInfo" class="alert alert-success hidden"></div>
  <div id="form" class="hidden">
    <form id="returnBook">
      <div class="row">
        <div id="lentBook">

        </div>
      </div>
    </form>
    <div class="container">
      <div class="row">
        <div class="col-6">
          <input class="btn btn-outline-primary btn-block" type="button" value="还书" onclick="showResult()">
        </div>
        <div class="col-6">
          <input class="btn btn-outline-primary btn-block" type="button" value="清空选择" onclick="clearAll()">
        </div>
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

    $(document).ready(function () {
        check();
        $.ajax({
            type: "get",
            url: "getBook.status",
            async: true,
            success: function (result) {
                if(result === "null"){
                    $("#tips")[0].innerHTML = "无借书记录";
                    $("#tips").removeClass("hidden");
                }else{
                    var jsonArray = parseJson(result);
                    var json;
                    for(var i=0;i<jsonArray.length;i++){
                        json = JSON.parse(jsonArray[i]);
                        $("#lentBook").after(createDiv(json.bookId, json.bookName, json.author, json.price, json.ps));
                    }
                    if(i === 1){
                        $(".customDiv").removeClass("col-lg-3 col-sm-6");
                        $(".customDiv").addClass("col");
                    }else if(i === 2){
                        $(".customDiv").removeClass("col-lg-3");
                    }
                    $("#form").removeClass("hidden");
                }
            }
        });
    });

    function mouseOver(obj){
        $(obj).addClass("border-primary");
    }
    function mouseOut(obj){
        $(obj).removeClass("border-primary");
    }
    function choose(obj){
        var checkbox = obj.firstElementChild;
        var id = obj.id;
        checkbox.checked = !checkbox.checked;
        console.log(checkbox.checked);
        if(checkbox.checked){
            $(obj).addClass("text-white bg-primary");
            $("#"+ id +" div h5").removeClass("text-muted");
        }else{
            $(obj).removeClass("text-white bg-primary");
            $("#"+ id +" div h5").addClass("text-muted");
        }
    }
    function clearAll(){
        //console.log("clicked");
        $(".card").each(function () {
            //console.log("remove class");
            $(this).removeClass("bg-primary text-white")
        });
        $(".card div h5").each(function () {
            //console.log("add class");
            $(this).addClass("text-muted");
        });
        $(".card input").each(function(){
            //console.log("changed false");
            this.checked = false;
        });
    }

    function parseJson(data){
        var jsonArray = [];
        var temp = "";
        for(var i=0;i<data.length;i++){
            if(data[i] !== '}'){
                temp += data[i];
            }else{
                temp += '}';
                jsonArray.push(temp);
                temp = "";
                i++;
            }
        }
        return jsonArray;
    }

    function createDiv(bookId, bookName, author, price, ps) {
        return "<div class=\"customDiv col-lg-3 col-sm-6\">" +
            "<div id=\"" + "card" + bookId + "\" class=\"card\" style=\"margin-bottom: 20px;\" onmouseover='mouseOver(this);' onmouseout='mouseOut(this);' onmouseup='choose(this);'>\n" +
            "          <input type=\"checkbox\" class=\"custom-control-input invisible\"  name=\"return_checkbox\" value=\"" + bookId + "\">\n" +
            "          <div class=\"card-body \">\n" +
            "            <h3 class=\"card-title mb-3\">书名： <span id=\"bookName\">" + bookName + "</span></h3>\n" +
            "            <h5 class=\"card-subtitle  mb-4 text-muted\">作者： <span id=\"author\">" + author + "</span></h5>\n" +
            "            <h5 class=\"card-subtitle  mb-3 text-muted\">价格： <span id=\"price\">" + price + "</span></h5>\n" +
            "            <p class=\"card-text\">备注： <span id=\"ps\">" + ps + "</span></p>\n" +
            "          </div>\n" +
            "        </div>" +
            "       </div>";
    }
    function showResult(){
        $.ajax({
            type: "get",
            url: "returnBook.status",
            data: $("#returnBook").serialize(),
            async: true,
            success: function(result){
                $("#form").addClass("hidden");
                $("#resultInfo").removeClass("hidden");
                if(result === "successful"){
                    $("#resultInfo")[0].innerHTML = "还书成功!";
                }else{
                    $("#resultInfo").removeClass("alert-success");
                    $("#resultInfo").addClass("alert-warnning");
                    $("#resultInfo")[0].innerHTML = "部分图书归还成功，但有失败记录，请检查并重试!";
                }
            }
        });
    }
</script>
</body>
</html>