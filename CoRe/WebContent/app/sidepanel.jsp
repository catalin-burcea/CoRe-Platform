<%@ include file="head.jsp"%>
<script>

$(function () {
    if (window.location == window.parent.location) {

        $('#fullscreen').attr('href', 'http://bootsnipp.com/mouse0270/snippets/846vX');
        $('#fullscreen').css('margin-left','-391.5px');
    }    
    $('#fullscreen').on('click', function(event) {
        event.preventDefault();
        window.parent.location =  $('#fullscreen').attr('href');
    });
    
    
    $('#toggle_posts').on('click', function(event) {
		event.preventDefault();
		$('#posts').toggleClass('open');
	});

	$('a[href^="#post-"]').on('click', function(event) {
		event.preventDefault();
		$('article.active').removeClass('active');
		$('#comments').removeClass('active');

		var percentage = parseInt($(window).width()) - parseInt($(this).css('width'));
		percentage = percentage / parseInt($(window).width());
		percentage = percentage * 100;

		if (percentage <= 20) {
			$('#posts').removeClass('open');
		}

		// THIS IS WHERE AJAX CODE WOULD GO TO LOAD ARTICLES DYNAMICALLY
		$($(this).attr('href')).addClass('active');
	});

	$('a[href^="#comments-"]').on('click', function(event) {
		event.preventDefault();

		// THIS IS WHERE AJAX CODE WOULD GO TO LOAD ARTICLES DYNAMICALLY
		$('#comments').toggleClass('active');
	});

	$('article > .title > .close').on('click', function(event) {
		event.preventDefault();
		$('#comments').removeClass('active');
		$(this).closest('article').removeClass('active');
	});
	$('#comments > .title > .close').on('click', function(event) {
		event.preventDefault();
		$(this).closest('#comments').removeClass('active');
	});   
});

</script>



<style>
	body {
		min-height: 420px;
	}
    
   
	#posts {
		position: fixed;
		top: 45px;
		left: 0px;
		height: 100%;
		background-color: rgba(102, 150, 162, 1);
		overflow: auto;
		-webkit-transition: all 0.5s ease-in-out;
		-moz-transition: all 0.5s ease-in-out;
		-o-transition: all 0.5s ease-in-out;
		-ms-transition: all 0.5s ease-in-out;
		transition: all 0.5s ease-in-out;
		z-index: 100;
		padding: 0px;
	}

	#posts a {
		display: block;
		padding: 20px 30px;
		color: rgb(51, 51, 51);
		text-decoration: none;
	}

	#posts a:hover {
		background-color: rgba(255, 255, 255, 0.8);
	}

	#toggle_posts {
		position: fixed;
		top: 0px;
		left: 0px;
		width: 30px;
		height: 100%;
		background-color: rgb(51, 51, 51);
		color: rgb(255, 255, 255);
		text-align: center;
		cursor: pointer;
		-webkit-transition: all 0.5s ease-in-out;
		-moz-transition: all 0.5s ease-in-out;
		-o-transition: all 0.5s ease-in-out;
		-ms-transition: all 0.5s ease-in-out;
		transition: all 0.5s ease-in-out;
		z-index: 100;
	}
	#toggle_posts h1 {
		position: absolute;
		top: 50%;
		left: -63px;
		font-size: 1.2em;
		margin: 0px;
		line-height: 1.1px;
		letter-spacing: 9px;
		font-weight: 700;
		margin-top: -68px;
		-webkit-transform: rotate(-90deg);
		-moz-transform: rotate(-90deg);
		-ms-transform: rotate(-90deg);
		-o-transform: rotate(-90deg);
		transform: rotate(-90deg);
	}
	#toggle_posts h1 .glyphicon.arrow-left {
		position: absolute;
		top: 0;
		left: -40px;
		margin-top: -8px;
	}
	#toggle_posts h1 .glyphicon.arrow-right {
		position: absolute;
		top: 0;
		left: 156px;
		margin-top: -8px;
	}

	#post article {
		position: absolute;
		top: 0px;
		background-color: rgba(255, 255, 255, 0.8); 
		border: 1px solid rgba(51, 51, 51, 0.3);
		padding: 0px;
		-webkit-transition: all 0.5s ease-in-out;
		-moz-transition: all 0.5s ease-in-out;
		-o-transition: all 0.5s ease-in-out;
		-ms-transition: all 0.5s ease-in-out;
		transition: all 0.5s ease-in-out;

		-webkit-transform: scale(0,0);
		-moz-transform: scale(0,0);
		-o-transform: scale(0,0);
		-ms-transform: scale(0,0);
		transform: scale(0,0);
	}
	#post article.active {
        margin-top: 60px;
		-webkit-transform: scale(1, 1);
		-moz-transform: scale(1, 1);
		-o-transform: scale(1, 1);
		-ms-transform: scale(1, 1);
		transform: scale(1, 1);
	}

	#post article .title,
	#comments .title {
		font-family: "Oswald", Arial, sans-serif;
		text-transform: uppercase;
		margin: 0;
		padding: 25px 30px;
		display: block;
		border-bottom: 1px solid rgb(160, 160, 160);
	}

	#post article .title .close,
	#comments .title .close  {
		position: absolute;
		top: 0px;
		right: 0px;
		font-size: inherit;
		font-weight: normal;
		padding: 0px 13px 5px;
		opacity: 1;
	}

	#post article .title .close:hover,
	#comments .title .close:hover {
		background-color: rgba(51, 51, 51, 0.1);
	}

	#post article .post {
		padding: 20px 30px;
		margin: 0;
		margin-top: 0;
		height: 250px;
		position: relative;
		overflow: auto;
	}

	#post article .post .post-img {
		width: 100%;
	}

	#post article .post img {
		max-width: 100%; 
	}

	#post article .post p {
		margin: 20px 0px;
	}

	#post .info {
		display: block;
		background-color: rgb(51, 51, 51);
	}

	#post .info a {
		float: left;
		display: inline-block;
		padding: 20px 30px;
		color: rgb(255, 255, 255);
		text-decoration: none;
		border-right: 1px solid rgb(81, 81, 81);
	}

	#post .info a:hover {
		background-color: rgb(81, 81, 81);
	}

	#comments {
		position: fixed;
        top: 60px;
		background-color: rgb(255, 255, 255);
		border: 1px solid rgba(51, 51, 51, 0.3);
		max-height: 75%;
		overflow: auto;
		-webkit-transition: all 0.5s ease-in-out;
		-moz-transition: all 0.5s ease-in-out;
		-o-transition: all 0.5s ease-in-out;
		-ms-transition: all 0.5s ease-in-out;
		transition: all 0.5s ease-in-out;

		-webkit-transform: translate(1000px,0px) scale(0,0);
		-moz-transform: translate(1000px,0px) scale(0,0);
		-o-transform: translate(1000px,0px) scale(0,0);
		-ms-transform: translate(1000px,0px) scale(0,0);
		transform: translate(1000px,0px) scale(0,0);
	}

	#comments.active {
		-webkit-transform: translate(-0px,0px) scale(1,1);
		-moz-transform: translate(-0px,0px) scale(1,1);
		-o-transform: translate(-0px,0px) scale(1,1);
		-ms-transform: translate(-0px,0px) scale(1,1);
		transform: translate(-0px,0px) scale(1,1);
	}

	#posts.col-xs-11 { left: -91.66666667%; }	
	#posts.col-xs-11.open ~ #toggle_posts { left: 91.66666667%; }

	@media (min-width: 768px) {
		#posts.col-sm-4 { left: -33.33333333%; }
		#posts.col-sm-4.open ~ #toggle_posts { left: 33.33333333%; }
		#comments { right: 8.33333333%; }
	}

	@media (min-width: 992px) {
		#posts.col-md-3 { left: -25%; }
		#posts.col-md-3.open ~ #toggle_posts { left: 25%; }
		#comments { background-color: rgba(255, 255, 255, 0.8); right: 0px; }
	}


	#posts.open { left: 0px; }
	</style>
	   

<div id="posts" class="col-xs-11 col-sm-4 col-md-3">
	<%-- 	<%for(UserGroup ug:groupMembers){ %> --%>
		<c:forEach items="${groupMembers}" var="ug">
		<a>
			<div class="well span6">
<%-- 				<%if (ug.getOwnership().equals("yes")==true){ %>
 --%>				<c:choose>
						 <c:when test="${ug.getOwnership().equals('yes') == true}">
								<span class="label label-primary">Owner</span>					
			<%-- 				<%}else if(isOwner==true){ %>
	 --%>				</c:when>
						<c:when test="${isOwner==true}">
								<form action="${ projectPath }/removeUserFromGroup" method="post">			
									<button type="submit" class="btn btn-danger glyphicon glyphicon-remove pull-right" data-toggle="tooltip" data-placement="top" title="Remove from group"></button>
									<input type="hidden" name="userId" value="${ug.getUser().getId()}">
									<input type="hidden" name="groupId" value="${ug.getGroup().getId()}">
								</form>
						</c:when>
				</c:choose>
<%-- 				<%} %>
 --%>					<span id="online-user${ug.getUser().getId()}" class="label label-success online-user" style="display:none">online</span>
					<span id="offline-user${ug.getUser().getId()}" class="label label-warning offline-user" style="display:none">offline</span>

			        <div class="span8">
			            <h3><span class="glyphicon glyphicon-user"></span>${ug.getUser().getLastName()} ${ug.getUser().getFirstName()}</h3>
			        </div>
			</div>
			
		</a>
		</c:forEach>
		
	</div> 

	<div id="toggle_posts">
		<h1>
			<span class="glyphicon arrow-left glyphicon-chevron-up"></span>
			<span>MEMBERS</span>
			<span class="glyphicon arrow-right glyphicon-chevron-up"></span>
		</h1>
	</div>

