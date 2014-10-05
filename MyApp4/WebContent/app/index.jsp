
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Index</title>
<%@ include file="head.jsp" %> 
 <style type="text/css">
<%@ include file="assets/strapped.css" %>
</style>


  </head>
  
  
  <body>

    <nav class="navbar navbar-default navbar-inverse navbar-fixed-top" role="navigation">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand nav-link" href="#top">Acme Corp</a>
        </div> <!-- /.navbar-header -->

        <div class="collapse navbar-collapse navbar-ex1-collapse">
          <ul class="nav navbar-nav navbar-right">
            <li><a href="#benefits" class="nav-link">Benefits</a></li>
            <li><a href="#tour" class="nav-link">Tour</a></li>
            <li><a href="#about" class="nav-link">About</a></li>
            <li><a href="#contact">Contact Us</a></li>
            <li><button class="btn btn-warning btn-sm navbar-btn">Sign Up</button></li>
          </ul>
        </div> <!-- /.navbar-collapse -->
      </div> <!-- /.container -->
    </nav> <!-- /.navbar -->

    <div id="top" class="jumbotron">
      <div class="container">
        <h1>Quick Brown Fox Jumps</h1>
        <h2>Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.</h2>
        <p><a class="btn btn-warning btn-lg">Sign Up Today <span class="glyphicon glyphicon-circle-arrow-right"></span></a></p>
      </div> <!-- /.container -->
    </div> <!-- /.jumbotron -->

    <div class="container">
	<img src="<c:url value="../app/images/noisy_net.png" />" alt="" />
      <h3 id="benefits" class="subhead">Why Use This Product</h3>
      <div class="row">
        <div class="col-md-4 col-sm-6 benefit">
          <div class="benefit-ball">
            <span class="glyphicon glyphicon-home"></span>
          </div>
          <h3>Benefit Title</h3>
          <p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna.</p>
        </div> <!-- /.benefit -->

        <div class="col-md-4 col-sm-6 benefit">
          <div class="benefit-ball">
            <span class="glyphicon glyphicon-cloud"></span>
          </div>
          <h3>Benefit Title</h3>
          <p>Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat.</p>
        </div> <!-- /.benefit -->

        <div class="col-md-4 col-sm-6 benefit">
          <div class="benefit-ball">
            <span class="glyphicon glyphicon-bell"></span>
          </div>
          <h3>Benefit Title</h3>
          <p>Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero.</p>
        </div> <!-- /.benefit -->

        <div class="col-md-4 col-sm-6 benefit">
          <div class="benefit-ball">
            <span class="glyphicon glyphicon-bullhorn"></span>
          </div>
          <h3>Benefit Title</h3>
          <p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna.</p>
        </div> <!-- /.benefit -->

        <div class="col-md-4 col-sm-6 benefit">
          <div class="benefit-ball">
            <span class="glyphicon glyphicon-cutlery"></span>
          </div>
          <h3>Benefit Title</h3>
          <p>Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat.</p>
        </div> <!-- /.benefit -->

        <div class="col-md-4 col-sm-6 benefit">
          <div class="benefit-ball">
            <span class="glyphicon glyphicon-fire"></span>
          </div>
          <h3>Benefit Title</h3>
          <p>Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero.</p>
        </div> <!-- /.benefit -->
      </div> <!-- /.row -->

      <div class="sect-border"></div>

      <h3 id="tour" class="subhead">Take A Tour Of This Product</h3>
      <div class="row">
        <div class="col-md-12">
          <div id="slideshow" class="carousel slide">
            <ol class="carousel-indicators">
              <li data-target="#slideshow" data-slide-to="0" class="active"></li>
              <li data-target="#slideshow" data-slide-to="1"></li>
              <li data-target="#slideshow" data-slide-to="2"></li>
              <li data-target="#slideshow" data-slide-to="3"></li>
              <li data-target="#slideshow" data-slide-to="4"></li>
            </ol>

            

            <a class="left carousel-control" href="#slideshow" data-slide="prev">
              <span class="glyphicon glyphicon-chevron-left"></span>
            </a>
            <a class="right carousel-control" href="#slideshow" data-slide="next">
              <span class="glyphicon glyphicon-chevron-right"></span>
            </a>
          </div> <!-- #slideshow -->
        </div> <!-- /.col-md-12 -->
      </div> <!-- /.row -->

      <div class="sect-border"></div>

      <h3 id="about" class="subhead">A Little More About Us</h3>
      <div class="row">
        <div class="col-md-10 col-md-offset-1 text-center">
          <p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna.  Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan.</p>
          <p>Nam liber tempor cum soluta nobis eleifend option congue nihil imperdiet doming id quod mazim placerat facer possim assum. Typi non habent claritatem insitam; est usus legentis in iis qui facit eorum claritatem. Investigationes demonstraverunt lectores legere me lius quod ii legunt saepius.</p>
        </div> <!-- /.col-md-10 -->
      </div> <!-- /.row -->

    </div> <!-- /.container -->

    <footer>
      <div class="container clearfix">
        <p class="pull-left">
          Copyright &copy; Acme Corp 2013
        </p>
        <p class="pull-right">
          a template from <a href="http://coverstrap.com">Coverstrap</a>
        </p>
      </div> <!-- /.container -->
    </footer>

    <script>
      $(".nav-link").click(function(e) {
        e.preventDefault();
        var link = $(this);
        var href = link.attr("href");
        $("html,body").animate({scrollTop: $(href).offset().top - 80}, 500);
        link.closest(".navbar").find(".navbar-toggle:not(.collapsed)").click();
      });
    </script>
  </body>
</html>
</div>
</body>
</html>