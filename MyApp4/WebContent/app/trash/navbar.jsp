<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
	<%@ include file="../head.jsp"%>
<style>@import url(//netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.css);
body {
    padding-top: 15px;
    padding-left: 65px;
}
.navbar-twitch {
	position: fixed;
	top: 0px;
	left: 0px;
	width: 50px;
	height: 100%;
	border-radius: 0px;
	border: 0px;
    z-index: 1030;
}
.navbar-twitch.open {
	width: 240px;
}
.navbar-twitch > .container {
	padding: 0px;
	width: 100%;
}
.navbar-twitch .navbar-header,
.navbar-twitch .navbar-brand {
	float: none;
	display: block;
	width: 100%;
	margin: 0px;
}
.navbar-twitch .navbar-brand {
    height: 50px;   
}
.navbar-twitch > .container .navbar-brand {
	padding: 0px;
	margin: 0px;
}
.navbar-twitch > .container .navbar-brand > .small-nav {
	display: block;
}
.navbar-twitch > .container .navbar-brand > .small-nav > span.logo,	
.navbar-twitch.open > .container .navbar-brand > .full-nav {
    display: block;
	font-weight: bold;
	padding: 15px 2px 15px 3px;
	font-size: 18pt;
}
.navbar-twitch.open > .container .navbar-brand {
	width: 100%;
	padding: 15px 15px 60px;
	text-align: center;
}
.navbar-twitch.navbar-inverse > .container .navbar-brand > .small-nav > span.logo {
	/*color: rgb(255, 255, 255);*/
}
.navbar-twitch .navbar-nav > li {
	float: none;
}
.navbar-twitch > .container .full-nav {
	display: none;
}
.navbar-twitch.open > .container .full-nav {
	display: block;
}
.navbar-twitch.open > .container .small-nav {
	display: none;
}
.navbar-twitch .navbar-collapse {
	padding: 0px;
}
.navbar-twitch .navbar-nav {
	float: none;
	margin: 0px;
}
.navbar-twitch .navbar-nav > li > a {
	padding: 0px;
}
.navbar-twitch .navbar-nav > li > a > span {
	display: block;
	font-size: 16pt;
	padding: 13px 15px 13px 12px;
}
.navbar-twitch .tooltip,
.navbar-twitch .tooltip .tooltip-inner {
	max-width: auto;
	white-space:nowrap;
}
.navbar-twitch-toggle {
	position: fixed;
	top: 5px;
	left: 55px;
}
.navbar-twitch ~ .navbar-twitch-toggle > .nav-open {
	display: inline-block;
}
.navbar-twitch ~ .navbar-twitch-toggle > .nav-close {
	display: none;
}
.navbar-twitch.open ~ .navbar-twitch-toggle {
	left: 245px;
}
.navbar-twitch.open ~ .navbar-twitch-toggle > .nav-open {
	display: none;
}
.navbar-twitch.open ~ .navbar-twitch-toggle > .nav-close {
	display: inline-block;
}


.btn-purple,
.btn-purple:hover,
.btn-purple:focus,
.btn-purple:Active {
    color: rgb(255, 255, 255);
    background-color: rgb(86, 61, 124);
    border-color: rgb(111, 84, 153);
}
.btn-purple:hover,
.btn-purple:focus,
.btn-purple:Active {
    background-color: rgb(111, 84, 153);
    border-color: rgb(86, 61, 124);   
}

.navbar {
    background-image: none !important;
}
.navbar-purple {
    background-color: rgb(86, 61, 124);
    border-color: rgb(111, 84, 153);
}
.navbar-purple .navbar-brand, 
.navbar-purple .navbar-nav > li > a, 
.navbar-purple .navbar-brand:hover, 
.navbar-purple .navbar-nav > li > a:hover, 
.navbar-purple .navbar-brand:focus, 
.navbar-purple .navbar-nav > li > a:focus {
    color: rgb(205, 191, 227);;
}
.navbar-purple .navbar-brand:hover, 
.navbar-purple .navbar-nav > li > a:hover, 
.navbar-purple .navbar-brand:focus, 
.navbar-purple .navbar-nav > li > a:focus,
.navbar-purple .navbar-nav > .active > a, 
.navbar-purple .navbar-nav > .active > a:hover, 
.navbar-purple .navbar-nav > .active > a:focus {
    background-color: rgb(111, 84, 153);
    color: rgb(255, 255, 255);
}</style>

<script>$(document).ready(function() {
    $('.navbar-nav [data-toggle="tooltip"]').tooltip();
    $('.navbar-twitch-toggle').on('click', function(event) {
        event.preventDefault();
        $('.navbar-twitch').toggleClass('open');
    });
    
    $('.nav-style-toggle').on('click', function(event) {
        event.preventDefault();
        var $current = $('.nav-style-toggle.disabled');
        $(this).addClass('disabled');
        $current.removeClass('disabled');
        $('.navbar-twitch').removeClass('navbar-'+$current.data('type'));
        $('.navbar-twitch').addClass('navbar-'+$(this).data('type'));
    });
});</script>

</head>
<body>
<div class="navbar navbar-inverse navbar-twitch" role="navigation">
	<div class="container">
		<div class="navbar-header">
			<a class="navbar-brand" href="#">
				<span class="small-nav"> <span class="logo"> <B> </span> </span>
				<span class="full-nav"> < Bootsnipp > </span>
			</a>
		</div>
		<div class="">
			<ul class="nav navbar-nav">
				<li class="active">
					<a href="#">
						<span class="small-nav" data-toggle="tooltip" data-placement="right" title="Home"> 
							<span class="glyphicon glyphicon-home"></span> 
						</span>
						<span class="full-nav"> Home </span>
					</a>
				</li>
				<li>
					<a href="#about-us">
						<span class="small-nav" data-toggle="tooltip" data-placement="right" title="About Us"> 
							<span class="fa fa-users"></span> 
						</span>
						<span class="full-nav"> About Us </span>
					</a>
				</li>
				<li>
					<a href="#contact-us">
						<span class="small-nav" data-toggle="tooltip" data-placement="right" title="Contact Us"> 
							<span class="glyphicon glyphicon-comment"></span> 
						</span>
						<span class="full-nav"> Contact Us </span>
					</a>
				</li>
			</ul>
		</div><!--/.nav-collapse -->
	</div>
</div>
<button type="button" class="btn btn-default btn-xs navbar-twitch-toggle">
	<span class="glyphicon glyphicon-chevron-right nav-open"></span>		
	<span class="glyphicon glyphicon-chevron-left nav-close"></span>
</button>

<div class="container">
	<div class="row">
		<h2>Bootstrap Navigation meets Twitch Navigation</h2>
        <p>This is just a quick and dirty example I made to show off to a friend. Don't forget to change the theme using the dropdown above.</p>
	</div>
    <div class="row">
        <h2>Navbar Styles</h2>
        <p>Just to show off how easy it is to theme!</p>
        <button type="button" class="btn btn-inverse nav-style-toggle disabled" data-type="inverse"> Inverse</button>
        <button type="button" class="btn btn-default nav-style-toggle" data-type="default"> Default</button>
        <button type="button" class="btn btn-purple nav-style-toggle" data-type="purple"> Purple</button>
    </div>
</body>
</html>