	//----
	function GetURLParameter(sParam){
	    var sURLVariables = window.location.href.split('/');
	    
	    for (var i = 0; i < sURLVariables.length; i++) {
	        if (sURLVariables[i] == sParam) {
	            return sURLVariables[i+1];
	        }
	    }
        return null;
	}
	
	function getRequestParameter(sParam){
	    var sPageURL = window.location.search.substring(1);
	    var sURLVariables = sPageURL.split('&');
	    for (var i = 0; i < sURLVariables.length; i++) {
	        var sParameterName = sURLVariables[i].split('=');
	        if (sParameterName[0] == sParam) 
	        {
	            return sParameterName[1];
	        }
	    }
        return null;
	}
	
	//--------get online users---------
	
	if (!!window.EventSource) {
			log.info("Event source available");
		    var source = new EventSource('/CoRe/getOnlineUsers');

 		    source.addEventListener('onlineUsers', function(e) { 
 		    	$(".offline-user").show();
 				$(".online-user").hide();
 				var data = e.data;
 				alert(data);
 				$.each(data, function( index, value ) {
 					alert(value);
 					$("#offline-user" + value).hide();
 					$("#online-user" + value).show();
 				});
		    });

		   source.addEventListener('open', function(e) {
		        console.log("Connection was opened.");
		   }, false);

		   source.addEventListener('error', function(e) {
		        if (e.readyState == EventSource.CLOSED) {
		            console.log("Connection was closed.");
		        } else {
		            console.log(e.readyState);   
		        }
		   }, false);
		} else {
			log.error("No SSE available");
		}
	
//	function getActiveUsers(handleActiveUsers){
//		$.ajax({
//	        url: path+"/getActiveUsers",
//	        method: "GET",
//	        contentType: 'application/json; charset=utf-8',
//	        dataType: "json",
//	        success: function(data){
//	        	handleActiveUsers(data);
//	        },
//	        error:function(msg,er,t){
//	        	log.error("Error getting online users" + er + t);
//	        } 
//	    });
//	};
	
//	setInterval(function(){
//		getActiveUsers(function(data){
//			$(".offline-user").show();
//			$(".online-user").hide();
//			data.forEach(function( item ) {
//				$("#offline-user"+item.id).hide();
//				$("#online-user"+item.id).show();
//			});
//		});
//	}, 1000);
	
	//-----upload a file-----------
	
	window.getAsText = function (readFile, editor) {
	    var reader = new FileReader();
	    reader.readAsText(readFile, "UTF-8");
	    reader.onload = function(evt) {
		    var fileString = evt.target.result;
		    editor.setValue(fileString);
		};
	};
	
	
