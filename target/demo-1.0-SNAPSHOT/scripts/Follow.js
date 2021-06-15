var follower = document.getElementsByClassName("btn-follow");
    for (var i = 0; i < follower.length; i++) {
        follower[i].onclick = function(event) {
        	
            var iduser = event.target.parentElement.getElementsByClassName("id-author")[0].value;
            var mainuser = event.target.parentElement.getElementsByClassName("mainuser")[0].value;
            if (mainuser == null) window.location.href = "../login/login.jsp";
            if(event.target.innerHTML=="Following")
        	{
        		deleteFollowing(event.target, iduser, mainuser);	
        	}
            else
          		 addfollowing(event.target, iduser, mainuser);
        }
    }
        
    function deleteFollowing(element, iduser, mainuser){
    	var xhttp;
        xhttp = new XMLHttpRequest();
        xhttp.onreadystatechange = function () {
            if (this.readyState === 4 && this.status === 200) {
            	
            	element.style.background = 'white';
            	element.style.color= 'blue';
            	element.innerHTML= "Follow+"
            }
        };
        var url ="followAnUser"+"?iduser="+iduser+"&mainuser="+mainuser+"&delete=true";
        xhttp.open("GET", url, true);
        var fd = new FormData();
    	fd.append("iduser", iduser);
    	fd.append("mainuser",mainuser);
      
        xhttp.send(fd);
    }
    
    function addfollowing(element,iduser, mainuser) {
        var xhttp;
        xhttp = new XMLHttpRequest();
        xhttp.onreadystatechange = function () {
            if (this.readyState === 4 && this.status === 200) {
            	
            	element.style.background = '#333399';
            	element.style.color= 'white';
            	element.innerHTML= "Following"
            }
        };
        var url ="followAnUser"+"?iduser="+iduser+"&mainuser="+mainuser;
        xhttp.open("GET", url, true);
        var fd = new FormData();
    	fd.append("iduser", iduser);
    	fd.append("mainuser",mainuser);
      
        xhttp.send(fd);
    }