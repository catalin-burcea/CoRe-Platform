<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%@ include file="../head.jsp"%>
<script>

function startRead(evt) {
    var file = document.getElementById('file').files[0];
    if (file) {
          getAsText(file);
        //alert("Name: " + file.name + "\n" + "Last Modified Date :" + file.lastModifiedDate);
    }
}
function getAsText(readFile) {
    var reader = new FileReader();
    reader.readAsText(readFile, "UTF-8");
    reader.onload = loaded;
}
function loaded(evt) {
   // alert("File Loaded Successfully");
    var fileString = evt.target.result;
    $("#op").text(fileString);
}

</script>

<style>
#op{
  width:900px;
  height:600px;
  overflow:auto;
  background-color:rgba(221,214,221,0.3);
  border:1px dashed black;
}
</style>
</head>
<body>
	<input type="file" id="file" name="files[]" multiple onchange="startRead()">
	<pre id="op"></pre>
</body>
</html>