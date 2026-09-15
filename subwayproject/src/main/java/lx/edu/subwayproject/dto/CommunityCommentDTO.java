package lx.edu.subwayproject.dto;

import java.time.LocalDateTime;
import lombok.Data;


@Data 
public class CommunityCommentDTO {

    private int commentId; 
    private String content; 
    private LocalDateTime createdTime; 
    private int postId; 
    private String userName; 
    private int userId;     

}