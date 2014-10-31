<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Diff Mode</title>

<link rel="stylesheet" type="text/css" href="http://eclipse.org/orion/compare/releases/3.0/built-compare.css"/>

<%@ include file="head.jsp"%>
	<style type="text/css">
		.compareContainer {
			position: absolute;
			top: 36px;
			bottom: 0;
			width: 99%;
			overflow-y: auto;
			margin-left:5px;
			border:1px solid #bebebe;
		}
	

	</style>
	
<script src="http://requirejs.org/docs/release/2.1.4/minified/require.js"></script>
<script type="text/javascript"><%@ include file="assets/diffMode.js" %> </script>

</head>
<body>
	<%@ include file="header.jsp"%>
	<div class="my-container">
		<div class="row">
			<div class="col-md-12 pull-left">
				<a href="" id="backButton"><button class="btn btn-primary">
						Back
				</button></a>
			</div>
		</div>

		<div class="row">
		  <div style="display:none">
				<span id="compareCommandHolder"></span>
		  </div>
			 <hr>
			 <div>
				<div id="compareParentDiv" class="compareContainer" ></div>
			 </div>		
		</div>
	</div>

</body>
</html>