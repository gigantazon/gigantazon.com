$(document).ready(function(){

	$('#votes').click(function(){
 	var newsid;
 	newsid = $(this).attr("data-newsid");
 	$.get('/news/vote_item/', {newsitem_id: newsid}, function(data){
		$('#vote_count').html(data);
		$('#votes').hide();
	 	});

	});

});
