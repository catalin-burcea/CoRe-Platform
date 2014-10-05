<!doctype html>
<html>
<head>
	<title>Orion Compare Demo</title>
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
    <link rel="stylesheet" type="text/css" href="http://eclipse.org/orion/compare/releases/3.0/built-compare.css"/>
	<script src="http://requirejs.org/docs/release/2.1.4/minified/require.js"></script>
	<script>
	/*global require window */
	require(["http://eclipse.org/orion/compare/releases/3.0/built-compare.min.js"], function(Compare) {
	    var options = {
	        parentDivId: "compareParentDiv",
	        newFile: {
	        	Name: "left.js",
	            Content: "var left = something;\nvar same = 123;\nvar left1 = foo\n"
	        },
	        oldFile: {
	        	Name: "right.js",
	            Content: "var right = something;\nvar same = 123;\nvar right1 = bar\n"
	        }
	    };
	    //Constructing the Compare widget instance starts the compare view automatically
		var compare = new Compare(options, "compareCommandHolder", "twoWay", true/*toggleable*/); //$NON-NLS-1$ //$NON-NLS-0$
	});
</script>
</head>
<body>
    <div style="height:28px;width:99%; display:none">
		<span id="compareCommandHolder"></span>
    </div>
    <hr>
    <div>
        <div id="compareParentDiv" class="compareContainer"></div>
    </div>
</body>
</html>