function getParameterByName(name) {
    name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
    var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
        results = regex.exec(location.search);
    return results === null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
}

//댓 edit
$(".reply_edit").click(function(){

	$("#reply-edit").remove();
	var replyseq = $(this).data("replyseq");
	var oldmsg = $(this).parent().find("b").first();
	var btag = $(this).parent();
	$(this).parent().find("b").first().append (
			"<div id='reply-edit' style='width:100%'><textarea class='reply-edit-text' type='text' style='width: 100%;height: 50px;word-wrap: break-word;'></textarea><br><button type='button' class='btn-reply_edit'"+
			"data-replyseq_c='"+replyseq+"' "+
	"style='width: 100%; color: #fff; background-color: #f5a623; border: 2px solid #f5a623;' >댓글수정</button></div>");

	$(".btn-reply_edit").click(function(event) {

		var reply_seq = $(this).data("replyseq_c");
		var survey_seq = getParameterByName("survey_seq");
		var reply_msg = $(".reply-edit-text").val();

		$.ajax({
			url: "replyUpdate",
			method: 'post',
			dataType: 'json',
			data: {
				"reply_seq": reply_seq,
				"survey_seq": survey_seq,
				"reply_msg": reply_msg
			},
			success: function (res) {
				if (res) {
					noticePopupInit({
						message : "댓글이 수정되었습니다."
					});
					$("#reply-edit").remove();
					var x = btag.find("b");
					$(x).first().html(reply_msg);
				}
			}
		});	
	}); 
});

$(".btn-reply").click(function(event) {
	var username = '${pageContext.request.userPrincipal.name}';
	var reply_msg = $(".reply-text").val();
	var survey_seq = getParameterByName("survey_seq");

	var posting = $.post("replyInsert", {
		username : username,
		reply_msg : reply_msg,
		survey_seq : survey_seq
	});
	location.reload();
});

//댓 삭제
$(".reply_del").click(function(event) {
	if (confirm("해당 댓글을 삭제하시겠습니까?")){
		var reply_seq = $(this).data("replyseq");
		var survey_seq = getParameterByName("survey_seq");
		var del = $(this);
		$.ajax({
			url: "replyDel",
			method: 'post',
			dataType: 'json',
			data: {
				"reply_seq": reply_seq,
				"survey_seq": survey_seq 
			},
			success: function (res) {
				if (res) {
					noticePopupInit({
						message : "댓글이 삭제되었습니다."
					});
					del.parent().parent().remove();
				}
			}
		});	
	}
}); 
