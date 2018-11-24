<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<h2>Ajax Test Page</h2>
	
	<div>
		<div>
		작성자<input type="text" name="replyer" id="newReplyWriter">
		</div>
		<div>
		내용<input type="text" name="replytext" id="newReplyText">
		</div>
		<button id="replyAddBtn">댓글 등록</button>
	</div>
	
	<ul id="replies">
	</ul>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
	<script>
		var bno = 16372;
		
		function getAllList(){
			$.getJSON("/replies/all/" + bno, function(data) {
				
				var str = "";
				console.log(data.length);
				
				$(data).each(
					function() {
						str += "<li data-rno'" + this.rno +"' class='replyLi'>"
							+ this.rno + ":" + this.replytext
							+ "</li>";
					});
				$("#replies").html(str);
			});
		}
		
		$("#replyAddBtn").on("click", function(){
			
			var replyer = $("#newReplyWriter").val();
			var replytext = $("#newReplyText").val();
			
			$.ajax({
				type : "post",
				url : "/replies",
				headers : {
					"Content-Type" : "application/json",
					"X-HTTP-Method-Override" : "POST"
				},
				dataType : "text",
				data : JSON.stringify({
					bno : bno,
					replyer : replyer,
					replytext : replytext
				}),
				success : function(result) {
					if(result == 'SUCCESS') {
						alert("등록 되었습니다.");
						getAllList();
					}
				}
			});
		});
	</script>
</body>
</html>