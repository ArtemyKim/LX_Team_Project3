package lx.edu.subwayproject.dto;

import java.time.LocalDateTime;
import java.util.List;
import lombok.Data;

@Data 
public class CommunityPostDTO {

    private int postId; 
    private String title;
    private String content; 
    private String userName; 
    private int userId;      
    private LocalDateTime createdTime; 
    private int likeCount; 
    private List<CommunityCommentDTO> commentList; 
}