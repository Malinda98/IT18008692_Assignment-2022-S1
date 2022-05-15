<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta charset="UTF-8">
	<title>Title</title>
	<!-- CSS only -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor" crossorigin="anonymous">
    <!-- JavaScript Bundle with Popper -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2" crossorigin="anonymous"></script>	
    <script src="assets/js/croppie.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.0/jquery.validate.js"></script>
	
	<style type="text/css">

label {
 font-family: Verdana, Arial, Helvetica, sans-serif;
 font-size: xx-small;
}


</style>
</head>
<body>
	
    <div class="container">
		
<br>
<p></p>

	                    <h2  font-family: "Times New Roman", Times, serif;>Units Adding Page</h2><br>
	                        <form id="add_units">
	                            <div class="form-group row">
	                                <label for="colFormLabelSm" class="col-sm-2 col-form-label col-form-label-sm" align="center" font-weight: bold>ID:</label>
	                                <div class="col-sm-3">
	                                    <input type="text" id="id" class="form-control" name="id" class="form-control form-control-sm" placeholder="Please enter id">
	                                </div>
	                            </div>
	                            <br>
	                            <div class="form-group row">
	                                <label for="colFormLabelSm" class="col-sm-2 col-form-label col-form-label-sm" align="center">Start Units :</label>
	                                <div class="col-sm-3">
	                                    <input type="text" id="start" class="form-control" name="start" class="form-control form-control-sm" placeholder="Please enter Start units">
	                                </div>
	                            </div>
	                            <br>
	                            <div class="form-group row">
	                                <label for="colFormLabelSm" class="col-sm-2 col-form-label col-form-label-sm" align="center">End Units :</label>
	                                <div class="col-sm-3">
	                                    <input type="text" id="end" class="form-control" name="end" class="form-control form-control-sm" placeholder="Please enter End units">
	                                </div>
	                            </div>	                          
	                            <br>
	                            <div>
	                                <button type="submit" class="btn btn-success btn-lg">
	                                    Add
	                                </button>
	                                
	                                <a href="edit_n_delete.jsp" class="btn btn-primary btn-lg">
	                                    List
	                                </a>
	                            </div>
	                            <br>
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
        	id: "Id Required!",
            start: "Start Unit Required!",
            end: "End Unit Required!"
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