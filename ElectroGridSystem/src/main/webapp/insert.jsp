<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta charset="UTF-8">
	<title>Title</title>
	
    <script src="assets/js/croppie.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.0/jquery.validate.js"></script>
	
</head>
<body>
	
    <div class="container">
		
<br>
<p></p>

	                    <div>User Register</div>
	                        <form id="add_units">
	                            <div>
	                                <label>ID :</label>
	                                <div>
	                                    <input type="text" id="id" class="form-control" name="id">
	                                </div>
	                            </div>
	                            
	                            <div>
	                                <label>Start :</label>
	                                <div>
	                                    <input type="text" id="start" class="form-control" name="start">
	                                </div>
	                            </div>
	                            
	                            <div>
	                                <label>End :</label>
	                                <div>
	                                    <input type="text" id="end" class="form-control" name="end">
	                                </div>
	                            </div>	                          
	                            
	                            <div>
	                                <button type="submit" class="btn btn-success">
	                                    Add
	                                </button>
	                                <a href="edit_n_delete.jsp" class="btn btn-success">
	                                    List
	                                </a>
	                            </div>
	                    	</form>
	                    </div>

</body>
</html>
<script>

$(document).ready(function () {

    $("#add_units").validate({
        rules: {
        	id: "required",
        	start: "required",
        	end: "required"

        },
        messages: {
        	id: "N Required!",
            start: "N Required!",
            end: "N Required!"
        },
        submitHandler: function () {
        	var fromData = JSON.stringify({
                "id" : $('#id').val(),
                "start" : $('#start').val(),
                "end" : $('#end').val()
            });
        	
        	console.log(fromData);

            $.ajax({
                type: "POST",
                url: 'app/pricing',
                dataType : 'json',
				contentType : 'application/json',
				data: fromData,
                success: function(data){
                	console.log(data);
                	if(data['success']=="success"){
                		alert("Added Successfull!");
                        $("#add_units")[0].reset();
					}else{
						alert("Unsuccessfull!");
					}
                },
                failure: function(errMsg) {
                	alert("Connection Error!");
                }
            });
        }
    });

    $("#add_units").submit(function(e) {
        e.preventDefault();
    });

});

</script>