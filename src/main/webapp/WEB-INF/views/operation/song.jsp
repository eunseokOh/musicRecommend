
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE>
<html lang="ko">
<head>
<meta charset=UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css"
	href="/www/resources/sweetalert-master/sweetalert.css">
<link rel="stylesheet"
	href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
<script src="<c:url value='/resources/js/jquery-2.2.2.js'/>"></script>
<script src="<c:url value='/resources/js/jquery-form.js'/>"></script>
<script src="<c:url value='/resources/numberFormat/jquery.number.js'/>"></script>
<script src='<c:url value="/resources/js/jquery-form.js"/>'></script>
<script src='<c:url value="/resources/sweetalert-master/sweetalert-dev.js"/>'></script>


<script
	src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>

<script src="/www/resources/js/star-rating.js"></script>
<link rel="stylesheet"
	href="http://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css"
	href="/www/resources/css/rating/star-rating.css" />




<script type="text/javascript">
$(document).ready(function(){
		$('#btnMore').hide();
		$('#loadimg').hide();
	
		var $maxPage = 1;
		var $nowPage = 1;
		var $searchKeyword = "";
		var $id_key = 0;
		
		var makerInput = function(name, value){
			var makeInput = $("<input />",{
				'type' : "hidden",
				'name' : name,
				'value' : value
			})
			
			return makeInput;
		}
		
		
		var insertSong = function(idx){
			
				$('#insertSong_'+idx).ajaxSubmit({
					success : function(data){
						
					}
			});
		}
		
		var insertRecommend = function(idx, starValue){
			
			insertSong(idx);
			
			var album_key = $('#insertSong_'+idx).find("[name=album_key]").val()
			var song_key = $('#insertSong_'+idx).find("[name=song_key]").val()
			var artist_key = $('#insertSong_'+idx).find("[name=artist_key]").val()
			var star_point = starValue;
			
			$.ajax({
				url : "/www/recommend",
				type : "post",
				data : {
					'album_key' : album_key,
					'song_key' : song_key,
					'artist_key' : artist_key,
					'star_point' : star_point
				}
			}).done(function(data){
				swal({   title: data,   
						 timer: 700,   
						 showConfirmButton: false
				});
			})
		}
		
		var makeHiddenForm = function(val){
			
			var inputHidden_1 = makerInput('song_key',val.song_key)
			var inputHidden_2 = makerInput('play_time',val.play_time)
			var inputHidden_3 = makerInput('artist_key',val.artist_key)
			var inputHidden_4 = makerInput('song_name',val.song_name)
			var inputHidden_5 = makerInput('album_key',val.album_key)
			var inputHidden_6 = makerInput('artist_name',val.artist_name)
			var inputHidden_7 = makerInput('issue_date',val.issue_date)
			var inputHidden_8 = makerInput('is_title_song',val.is_title_song)
			var inputHidden_9 = makerInput('is_hit_song',val.is_hit_song)
			var inputHidden_10 = makerInput('is_adult',val.is_adult)
			var inputHidden_11 = makerInput('is_free',val.is_free)
			var inputHidden_12 = makerInput('composition',val.composition)
			var inputHidden_13 = makerInput('lyricist',val.lyricist)
			var inputHidden_14 = makerInput('album_name',val.album_name)
			var inputHidden_15 = makerInput('album_img',val.album_img)
				
			var inputHidden_submit = $('<input />',{
				type : "button",
				value :val.artist_name.substring(0,23),
				id : "btnInsert_"+$id_key,
				click: function() {
					insertSong((this.id).substring(10));
				}
			}).addClass('btn btn-link');
				
			var inputForm = $("<form />", {
				id : "insertSong_"+$id_key,
				method : "post",
				action : "song/insert"
				
			}).append(inputHidden_1).append(inputHidden_2).append(inputHidden_3).append(inputHidden_4).append(inputHidden_5).append(inputHidden_6).append(inputHidden_7).append(inputHidden_8).append(inputHidden_9).append(inputHidden_10).append(inputHidden_11).append(inputHidden_12).append(inputHidden_13).append(inputHidden_14).append(inputHidden_15).append(inputHidden_submit);
			
			
			return inputForm;
			
			
			
		}
		
		
		
	
	
		
		var makeHtml = function(key, val){

			
			
			var div2 = $("<div />", {
				id : 'caption_div'+$id_key
			});
			
			var p2 = $("<p />", {
				id : 'input-id'+$id_key
				
			});
			
			var strong = $("<strong />", {
				
				text : val.song_name.substring(0,21)
			});
			
			var p1 = $("<p>", {
			}).append(strong);
			
			var img = $("<img >",{
				src : val.album_img,
				id : "album_img_"+$id_key,
				height : "300",
				width : "400",
				click : function(){
					swal({   
						title: "Auto close alert!",   
						text: "I will close in 2 seconds.",   
						timer: 2000,   
						showConfirmButton: false });
				}
				
			})
			
			var thumb = $("<div />",{
			}).addClass('thumbnail').append(img).append(p1).append(p2).append(div2).append(makeHiddenForm(val));
			
			var sm_4 = $("<div />",{
				id : 'sm_4_'+$id_key
				
			}).addClass('col-sm-4').append(thumb);
			
			$('#rtc').append(sm_4);
			
			$('#input-id'+$id_key).rating({min:0, max:5, step:0.5, size:6,
				captionElement: '#caption_div'+$id_key,
				showClear: false,
				starCaptions:{
				'0': '평가없음',
			    '0.5': '재앙이에요',
			    '1': '듣기싫어요',
			    '1.5': '안좋아요',
			    '2': '글쎄요',
			    '2.5': '뭐 그럭저럭',
			    '3': '들을만 해요',
			    '3.5': '괜찮은 노래',
			    '4': '좋아해요',
			    '4.5': '정말 좋은 곡',
			    '5': '전설의 레전드'
			}}).on('rating.change', function(event, value, caption) {
				var idx = (this.id).substring(8);
				insertRecommend(idx, value);

			}).rating('update',3);
			
			
			$id_key++;
	}; // end makeHtml();
	
	
	
	
	
		
	var goAjax = function(page, searchKeyword){
				$.ajax({
				url : "song/"+searchKeyword,
				type : 'post',
				data : {
						'page' : page
				}
			}).done(function(data){
					$('#total_article').text(searchKeyword+" 관련된 곡은 총 "+$.number(data.pgNation.total_article_count)+"개 입니다.");
					$maxPage = data.pgNation.total_page_count;
					$('#loadimg').hide();
					if( data.pgNation.total_page_count <= $nowPage ){
						$('#btnMore').hide();
					} else {
						$('#btnMore').show();
					}
				$.each(data.list, function(key,val){
					makeHtml(key, val);
				})
				
				
					
				
			});
		} // end goAjax()
	
	
	$(document).on("click",".btn btn-link ",function(){
		alert(this.id);
	});
 	
	$('#btnSearch').click(function(){
		$('#btnMore').hide();
		$('#loadimg').show();
		$('#rtc').html("");
		$nowPage = 1;
		$id_key = 0;
		$searchKeyword = $('#txtSearchKeyWord').val();
		
		goAjax(1, $searchKeyword);
		
		
		
		
	})
	
	$('#btnMore').click(function(){
		
    	if( $maxPage >= $nowPage ){
		   $nowPage = $nowPage + 1;
		   goAjax($nowPage, $searchKeyword);
	   } 
    	$('#btnMore').hide();
    	$('#loadimg').show();
	})
	
		
	
	


});

</script>
<style>
body {
	font: 400 15px/1.8 Lato, sans-serif;
	color: #777;
}

h3, h4 {
	margin: 10px 0 30px 0;
	letter-spacing: 10px;
	font-size: 20px;
	color: #111;
}

.container {
	padding: 80px 120px;
}

.bg-1 {
	background: #2d2d30;
	color: #bdbdbd;
}

.bg-1 h3 {
	color: #fff;
}

.bg-1 p {
	font-style: italic;
}



.thumbnail {
	padding: 0 0 15px 0;
	border: none;
	border-radius: 0;
}

.thumbnail p {
	margin-top: 15px;
	color: #555;
}

.btn {
	padding: 10px 20px;
	background-color: #333;
	color: #f1f1f1;
	border-radius: 0;
	transition: .2s;
}

.btn:hover, .btn:focus {
	border: 1px solid #333;
	background-color: #fff;
	color: #000;
}



</style>
</head>
<body>

		
	<div class="bg-1">
	
	<div class="container" style="height: 10%">
	
			      <form class="form-inline">
				    <input type="text" class="form-control" id="txtSearchKeyWord" size="30" placeholder="Song Keyword" required>
				    <button type="button" class="btn btn-danger" id="btnSearch">Search♬</button>
				  </form>
			   <hr/>   
			   <p><strong id="total_article"></strong></p>
	</div>
		<div class="container" >
			
			<div class="row text-center" id="rtc">
			
			</div>
				<div align="center">
				<button type="button" class="btn btn-default" id="btnMore" style="width: 60%">More</button>
			</div>
			<br/>
				<div align="center" id="loadimg">
					<img src= '<c:url value="/resources/loading/img-loading.gif"/>' width="20%"/>
				</div>
			</div>
		
			

	</div>

</body>
</html>