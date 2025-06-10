package com.kh.teammovie.movie.model.vo;

import java.util.Date;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data  // @Getter, @Setter, @ToString, @EqualsAndHashCode 포함
@NoArgsConstructor // 기본 생성자
@AllArgsConstructor // 모든 필드 생성자
public class Movie {
    private int movieId;         // 예: 영화 고유 ID
    private String title;        // 영화 제목
    private String genre;        // 장르
    private int rate;            // 예매율
    private String releaseDate;  // 개봉일 (String 또는 Date)
    private String posterPath;   // 포스터 이미지 경로
    private String gifPath;      // GIF 이미지 경로 (hover용)
}
