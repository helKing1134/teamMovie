<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>배우 선택 모달</title>
</head>
<body>

<div class="modal fade" id="actorModal" tabindex="-1" role="dialog">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">배우 선택하기</h5>
        <button type="button" class="close" data-dismiss="modal">
          <span>&times;</span>
        </button>
      </div>
      <div class="modal-body d-flex">
        <!-- 왼쪽 배우 리스트 -->
		<div class="w-50 pr-3 border-right">
		  <!-- 검색 영역 -->
		  <div class="input-group mb-3">
		    <input type="text" id="actorSearch" class="form-control" placeholder="배우 검색">
		    <div class="input-group-append">
		      <button class="btn btn-outline-secondary" type="button" id="searchBtn">검색</button>
		    </div>
		  </div>
		
		  <!-- 배우 리스트 출력 영역 -->
		  <div id="actorList" class="overflow-auto" style="max-height: 400px;">
		    <!-- 배우 항목들 JavaScript로 생성 -->
		    <c:forEach var="actor" items="${currentActors}">
			  <div class="form-check actor-item d-flex align-items-center mb-2" data-id="${actor.actorId}">
			    <input class="form-check-input actor-checkbox mr-2" type="checkbox" data-id="${actor.actorId}">
			    <label class="form-check-label d-flex align-items-center">
			      <img src="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBxAQEBUPDw8QFRAQEA8VFRUQDw8VFRUVFRUWFxgWFhUYHSggGBolHRUVITEhJSkrLi4uFx8zODMsNygtLisBCgoKDg0OGA8QFy0dHx0tLSsrKy0tLS0tKy0tLS0tLS0rLSsrKy0tLS0tKystLS0tKystLSstLS0rLS0tLS0tLf/AABEIALcBEwMBIgACEQEDEQH/xAAbAAACAgMBAAAAAAAAAAAAAAAAAQIGAwQFB//EAD8QAAIBAgMFBQYEBAMJAAAAAAABAgMRBCExBRJBUXEGImGBoRMykbHR8EJScsEUI6LhM2KCBxUkQ2OSssLx/8QAGQEBAQEBAQEAAAAAAAAAAAAAAAECAwQF/8QAHxEBAQEBAAMBAQEBAQAAAAAAAAECEQMhMRJBE2EE/9oADAMBAAIRAxEAPwDiDQIZ2czsOwDQBYaQDAQWGMBAMAhBYYAIYDsAgsSsK4BYLGpW2nRhk6kbp2spLJ+L0XmzFLbNHVTpu/D2sL+SWXqTq8roCMGHxtOfuyTubNgiNgJWFYoiBKwgqNgJCAjYViQWAiKxKwmgqIDsJgJiYwsERAdgAlYYJEkgoQwGECGAwhDAYCAY7AICVgsAkgsM421dsTpO1OEWouzcpNZ2vZWTvkTq8dOtWUVd6LXT9ynbf7QSbdOm2knZ56+af36Bj9sOvSvCLU1upq/K+9Z8blcqRb1eduPqYtbmWaEHPWUW+ClLJeRljhqy0t1VrGhFeHkb08Qod1aLlzazdvMy02KdOos/aJv9L/sdHBbSmnac53yteW9887eq58Vz8PUjLS7bWW8m318TJurR2d73lxtfRWKcWnZ23oTe5P3lbOOjXBpa/fQ7EZJq6aafFHmdXepzUqbtJabuqLJ2a205SdOrZOWa4Jvjl9PE1NMXK02FYmKxthAVibQgIiJABEViQrBUbCsTEBCwrGQi0FRsA7ABJIkgQ7BAAxhCAdgSAB2GACSGMAAB2AAPNNu4z29WU72pxk4xXN6N28l5JHoG2Ku5h6slqqVRrrus8vjSdkne3Lr9oxpvMbuFrtaq/B5ar6ka0Vey5+X9iNGlvWitfNln2L2SqVbSlJpdMzndSOucXXxUqtPO9ic8I3FT1u36WL/X7DTbtFXXlyOts3sC9y02lrklfW1jP7jf+VeStySsrpcbcepP271ebv8Abseu4v8A2d093utp+RTNvdjZ0VvJX6D9w/yqtwxDlF3WXhl6j2bXUK8J6KM4t+CvnqZ8PUj7rya1vc05U4qeWj+7G3J6pHTLQdjg9lMZKVN05Xbgo665/tlqd86xys4iJokIqINASsFgIBYlYQEQZIQVERITAjYBjAaGgGEA0hEgAAGFAAMIB2AYCGA7Aau0qHtKM6f54Sj5tWXqeZ7y1fD56fseq1VeL6Hk+Mi4TlGWqk7/ABf1Mbbws/Y3A796jWd7I9F2dTcc7ZIouydpRwlGMd3em0m/MsOA7XqLSnQnayzXkeXUtr3+PUzOL1g6tzoU5crGhsfa1CvG8cm1o1mSxmKjRW+ryV1ktSNX23KzvwNLFYKM4tSV7o5GI7UVpZUsI3fS+9f4JGjU7T4im/51BqOeieRbGf0867Y7I/h8RJW7ss1yaZVYyz10eR7V2twEMZhnOC/mRi5wfHS9meK7veyVn+50xexw8mfzXo+wMJu0oTtaTpq/nn9DrGHZ9LcpQjZq0Y3T1TtmZ7HpkeW/UWIkJhCESEAhWJCsBGwNEgAxiJtCaCoASsICQ0hEkggQwGAhgAAMBgAwQwBAAwE0Uvtns1KtRqR/5s3GXlutel/gXU5HaaipU4StnCtBrzTj+6Jr41n60cLTpwnGU4qz3rt20VvgXPDdpdmxW7VlBrdVo7rldXS7u6nxZp7L2XSrqO/GLaVlvRT+ZZcFsOdP3FS3esvk0/mePvX0pnkcmti8O5Qq4Wb3N/da5XdmvJ8Ds7W/lR35XcbK+XM19qx3alKk3e9SLlyy0VvM7WMhvPcl7rjuvzX/AMM8a6qUe2dGlJQVGtJSluuUKd1vJN21T4GxPbtGvZbs4TsnuVoOnOz8Ja/E6OG2U4SvvW113jqUdnJRcrK/RF/iX1euJWi1DLjyVlbnfieRvZC/3nKj+H2jqLwWU/m7Hsm0pJRfRlCwOFc8biK7WUKNOC/VJwk7dIxa/wBSNeO+3PyzuXUCwwPY+cjYTRIAIWETaIsBCJCAQDACImiQmBGwDAKSJISGEMAAAGAAMEgGgGMQwAEMAA19o0d+lOPHduuse8vVGyCCxi7J4u9lc9Bo46MYXk+B5PstulVlHlJr4PL0LWsXdd991K/U8N9V9PPNZbOMxarYmnOPu3kvG8XZ3LTin301xjH5HmFeNeFb22Hkmt5vclo762fC/mWbAVsXiWo1f5MIpNunLelLw3mu6umefAsLXTq7WjCr7Oppwdu63yvzOl/HxcLLQ5eOwtGdL2UsktG27p80+ficnDQq03uN7y4NcV4+JPi+q29pT3rrwZyMErU6mSSk5eb7i+K3To14vccnyOPTk91K7tm7dXc1483VY8u5nIAYrHsfNIBiAQrEhARaESCwERErCYCExiYCGAAIYhgAwAAABoAJCSGgGMQwAAQwABgBzMZR3aqqLSS/qX1Vvgyw4rBwxGGjuO07WunY5WKkt1pq/gvrwMezNobklG/dbtnwfJnl8uffY9vg32crR2XRVKpKliv4mo4uSXsp04yetrpuK4riXKnSwrjaNDGzs1Z1sQoQStmrqTvnno+phxuy41mqqWbVnkjd2dsucJe893lb78Tn16OTn2uc9gRxFozpbkYuL7tao25JfnyyvZ6fE7eGoKnHcu3uq1222/M31BQVuJysbWs8tSWkYdqd5bi1k0vNuy9WcrFYCrS/xINJ6PJxfSSyO/sLBuviYXzhSftJPxj7q/7rfBl0ezYWlFxTjPNxeaz1y8T0eH1LXl/9F7ZHkdgLhtvse097DacYSl/4t/JlXxeBq0narTlHqsvJ6M7y9eWxriGAQhDABCGAXiImSEERESsKwCAAAQAADABgAANAMYkMAGEVfJa+Bbtk9k04qddtt57qdkur1Yt4vFUp05SdoxbfJJv5G9Q2NXn+C36svQv2G2ZCGUVFLko/uZ6WGSbduLM3S/lR6PZyf45LyyMj2FBJt52vz4FwdFa21ba+/M1sTHutWM/qtcUbEbPSTsuXDw5+fArO1cJKnF1Yp2hNqSz93Jej4no1fDXbXR+noaM9nRd4SjeNS6aaXFaW8cxJ30svPav7D260kpO65/XkWvDbZhJfTQ882nsipgav4nRk+5P/ANZP8y9Vnztu4PESytLLojzalzePbizUXHF7QUvdNXD0pVZqEE5Tm7ffJeJg2XhqmIkoU05S48ornJ8Eeh7C2NDDRy71SS707f0x5R+ZcYuvaeTcxOf1k2NsuOGp7qs5POcub5dEb6Q27jSO/wDyPH233Ud3iYq+HjNWlFSjykk18DPIjICt7S7JYaq96KdN/wDTtZ/6Xl8CtbS7I4innTtUj4ZS+D18mekJXzIyV+GRZqpx4zUpSi3GSaktU1ZryIHrmN2bRrK1SlCXi0t5dHqiibb7L1aN5Urzp9O8l0XvLoblZsV4RIRUKwiQgEJokIHEbASAoxDAERAMEMAQwSBAMAJQi20lq2kvMDu9ksPCU5SnbKNlzSesl0yL9s9Xp2eqck/JlUw+wJ04KUZOM42d7fmyt98yxbAqNprlCnf9TTv8kc9VuOk6eXmRlTNhIjKBlpq1YZroateld+Fv3N96XMdSnklzeYHDr0c72yVk8vg+mYlQWvBXa00X1Z1Zws5cu6YZYW1nFrvPNPTW+XIo06uChUi6dSnGUZWTjJJp8dHy5nFj2Iw++nH28ad7uKqwat4OUXLlqy1U4tPOLveT56mzQhpk/da0ZL7+tZtz8qOzMFSoQ9nRpqEdeLbfOTecn4tm8kRpLTwMsYhAiQ0yL0CCRjmrvoZH6kL2v4fMBt5ePAEvHq/oQp58TLp0QEdz7Zhmo3tqOpJyyTt0J0qKiB5x2z2V7Gs6sV/LqSenCX99fiVw9Q7V4RVMNVb1UHJeTvf0t5nmB1l9MUgACoQAAUgGAGIAAMmhoSGgGMQAM3th0VPEU4u9t/edtbRTl+xonV7N1Ixr701dKnPyvZX+DYqx6TRhvRSebtvS662NHZS9lWnDhPdcfi7r1N3Z7V91O9oxd+t2zWx0N2rTqf53F+NzjXSO1+4rZdRX06EkBja1S4EbXs/AyLi+pC2XTUDFu5/quyChfLjCRsS95eCMcYXv4vLyyAahrLyRPc0fiOOcVYyNaASSGK/qSABPkAnLICMmrp9eZB8PFilno9Ptk5arwQEkYqzb7sWr8fAJVM8unn92JUKe7d8ZNXfkQZYQUVZCYWYPUo1cVSUoOEtJwnF9GmePVI2bXJtfA9ixs7KXR+p47WtvO2m87dLnTLOkAADTIEMQAAAFYgAAyY0xABK4riACVzvdj8M5Vt78Ftx+Llnb+kr51ezeOdLEQd3uXvJcMsrvom35C/Fi/U8LKk96mu7G8GkuCzi/vmbDl7Wi/wA1nJeD4GfZs96C5yc3/UyFamqclJRW7K8ZW9PU410bGFq71NS5pGy3ocjAJQvTX4akvNSvJeuXkdSTy6ASUle30EuPmDlZrk8hJarmwMaqZK+rWpk/HbgkiEtHb8OfwJXz3lxQDpO1+W8zKncxwyy6k09VyAk9CRET58gJMxSlw/zOxOTz6IxRXhmvtgSprvNeCFOWWeqJW71+DSNbE3lONNK6vvTedklourdvgyUZaas82tFZJZ+LZsXXAhFZ6ksgG2Y5VUsyclzITisr8LlHO2zX9nRqSf4YOT68DyZnpfa3EbmFqZXc1n4J91P4s8zOmWdAAA0yBMYgAAAKwjAAyAAAGIAADsdmf8VvdTdrWeneUl9AAVYvGy8VFRpqN0lvQa5NO+R3ppSyayeowONdHFrQlSrKz3lPJXtk0m/rmdVTbhfLMQEi1Kq8o9R0m766ptABUK/dl43+YldJZ6WTyYgAzy1XT6DfveQABOLfETfdfQQARbd0rcgo+9Lr+yAAI1Km5GTekVJ+SFSbef5kn8VoAEX+MsY8ySiAFQ2jHVbeStlzAAKp23f/AA13rKcL6c39Dz8AOufjFAABUIAAKAAAj//Z" alt="${actor.actorName}" width="40" height="50" class="mr-2">
			      <div>
			        <div>${actor.actorName}</div>
			        <small>${actor.birthDate}</small>
			      </div>
			    </label>
			  </div>
			</c:forEach>
		  </div>
		</div>

        <!-- 오른쪽 선택된 배우 -->
        <div class="w-50 pl-3">
          <h6>선택된 배우</h6>
          <div id="selectedActors" class="overflow-auto" style="max-height: 400px;">
            <!-- 선택된 배우들이 들어옴 -->
          </div>
        </div>
      </div>
      
      <div class="modal-footer">
	  	<button type="button" class="btn btn-primary" id="addActorsBtn">추가하기</button>
	  	<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
	  </div>
    </div>
  </div>
</div>

<script>
  $(function() {
    var selectedMap = {}; //선택된 배우들을 담을 객체 (키(actorId)-벨류(actor))
    // 체크박스 선택/해제 시
    $(document).on('change', '.actor-checkbox', function() {
      var id = $(this).data('id'); //선택/해제된 배우의 actorId
      var $item = $('.actor-item[data-id="' + id + '"]');
      var actor = { //선택/해제된 배우에 대한 정보(배우아이디,이름,프로필이미지 경로)
        actorId: id,
        actorName: $item.find('div > div').text().trim(),
        birthDate: $item.find('small').text().trim(),
        imagePath: $item.find('img').attr('src')
      };

      if ($(this).is(':checked')) {//만약 체크박스가 체크되었다면
    	  selectedMap[id] = actor; //선택된 배우 목록에 추가
        
      } else {//만약 체크박스가 체크해제되었다면
    	  delete selectedMap[id];//선택된 배우 목록에서 제거
      }

      renderSelected();
    });

    // 선택된 배우 보여주기
    function renderSelected() {
      $('#selectedActors').empty();

      for (var id in selectedMap) {
        var actor = selectedMap[id];

        var html = '';
        html += '<div class="d-flex align-items-center mb-2">';
        html += '  <img src="' + actor.imagePath + '" alt="' + actor.actorName + '" width="40" height="50" class="mr-2">';
        html += '  <div>';
        html += '    <div>' + actor.actorName + '</div>';
        html += '    <small>' + actor.birthDate + '</small>';
        html += '  </div>';
        html += '</div>';

        $('#selectedActors').append(html); //선택된 배우 항목에 배우들 추가
      }
    }
    
    $('#addActorsBtn').on('click', function() {
    	  console.log("선택된 배우 목록:");
    	  console.log(selectedMap);

    	  // 예: form이나 ajax로 서버에 보낼 수도 있음
    	  // 또는 선택된 actorId만 hidden input에 넣을 수도 있고
    	});
  	});
  
  //검색 버튼 클릭 시 배우 리스트 필터링
  $('#searchBtn').click(function() {
    let keyword = $('#actorSearch').val().toLowerCase(); // 검색어 소문자 변환

    $('#actorList .form-check').each(function() { //#actorList는 배우리스트 나올 하나의 큰 틀, .form-check은 한 명의 배우를 담을 틀
      let name = $(this).find('div > div').text().toLowerCase(); // 배우 이름 추출
      if (name.includes(keyword)) { //이름이 관리자가 입력한 검색어를 포함한다면
        $(this).show(); //필터링된 배우 보여주기
      } else {
        $(this).hide(); //필터링된 배우 숨기기
      }
    });
  });
  
});

</script>

</body>
</html>
