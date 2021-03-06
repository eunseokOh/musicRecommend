
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE>
<html lang ="ko">
<head>
<meta charset=UTF-8">
<title>Insert title here</title>
<script src='<c:url value="/resources/js/jquery-2.2.2.js"/>'></script>

<script src='<c:url value="/resources/js/jquery-form.js"/>'></script>
<script type="text/javascript">

$(document).ready(function(){
	
	$('#btnSearch').click(function(){
		$('#searchForm').attr('action',"/www/operation/song/"+$('#searchKeyword').val()+"/1").submit();
	});
	
// 	$('#searchKeyword').keypress(function(event){
// 	    var keycode = (event.keyCode ? event.keyCode : event.which);
// 	    if(keycode == '13'){
// 	    	$('#searchForm').attr('action',"/www/operation/song/"+$('#searchKeyword').val()+"/1").submit();  
// 	    }
// 	    event.stopPropagation();
// 	});
	
	$('.btn').click(function(){
		var idx = this.id;
		idx = idx.substr(4);
		
		$('#songInfo_'+idx).ajaxForm({
			success : function(data){
				console.log(data);
			}
		});
		
	});
	
	
});				
</script>
</head>
<body>

<form id="searchForm" action="#">
노래제목 : <input type="text"  width="500" id="searchKeyword"/>
<input type="button" value="검색" id="btnSearch"/>
</form>


<hr/>
<div id="songList">


<c:if test="${getData != null}">
<a href="1">〈〈</a>
<c:choose>
	<c:when test="${getData.pgNation.start_page == 1}">
		[이전]
	</c:when>
	<c:otherwise>
	<a href="${getData.pgNation.start_page-1}">[이전]</a>
	</c:otherwise>
</c:choose>

	<c:forEach begin="${getData.pgNation.start_page}" end="${getData.pgNation.end_page}"  step="1" varStatus="idx">
		<a href="${idx.index}" >${idx.index}</a>
	</c:forEach>

<c:choose>
	<c:when test="${getData.pgNation.end_page == getData.pgNation.total_page_count}">
		[다음]
	</c:when>
	
	<c:otherwise>
	<a href="${getData.pgNation.end_page+1}">[다음]</a>
	</c:otherwise>
</c:choose>
<a href="${getData.pgNation.total_page_count}">〉〉</a>
	<hr/>
</c:if>

<c:forEach items="${getData.list}" var="vo" varStatus="idx">
<form id="songInfo_${idx.index}" method="POST" action="../insert">
	song_key 	 <input type="text" name="song_key"value="${vo.song_key}"/>  <br/>
	album_key    <input type="text" name="album_key"  value="${vo.album_key}"/> <br/>    
	song_name    <input type="text" name="song_name"  value="${vo.song_name}"/> <br/>    
	play_time    <input type="text" name="play_time"  value="${vo.play_time}"/> <br/>    
	issue_date   <input type="text" name="issue_date"  value="${vo.issue_date}"/> <br/>   
	is_title_song<input type="text" name="is_title_song"  value="${vo.is_title_song}"/> <br/>
	is_adult     <input type="text" name="is_adult"  value="${vo.is_adult}"/> <br/>     
	is_hit_song  <input type="text" name="is_hit_song"  value="${vo.is_hit_song}"/> <br/>  
	is_free      <input type="text" name="is_free"  value="${vo.is_free}"/> <br/>
	artist_key	 <input type="text" name="artist_key"  value="${vo.artist_key}"/>   <br/>
	artist_name	 <input type="text" name="artist_name"  value="${vo.artist_name}"/>  <br/>
	composition	 <input type="text" name="composition"  value="${vo.composition}"/>  <br/>
	lyricist	 <input type="text" name="lyricist"  value="${vo.lyricist}"/>     <br/>
	<input type="submit" class="btn" id="btn_${idx.index}" value="저장"/>    
</form>
<hr/> 
</c:forEach>


</div>
</body>
</html>


