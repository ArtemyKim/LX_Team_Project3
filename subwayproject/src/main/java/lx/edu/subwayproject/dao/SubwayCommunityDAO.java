package lx.edu.subwayproject.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import lx.edu.subwayproject.dto.CommunityPostDTO;

@Component
public class SubwayCommunityDAO {

    @Autowired
    private SqlSession sqlSession;

    // 게시글 전체 목록 조회
    public List<CommunityPostDTO> selectPostList() {
        return sqlSession.selectList(
            "lx.edu.subwayproject.dao.CommunityPostDAO.selectPostList"
        );
    }

    // 게시글 추가
    public void insertCommunityPost(CommunityPostDTO dto) {
        sqlSession.insert(
            "lx.edu.subwayproject.dao.CommunityPostDAO.insertPost",
            dto
        );
    }

    // 게시글 수정
    public int updateCommunityPost(CommunityPostDTO dto) {
        return sqlSession.update(
            "lx.edu.subwayproject.dao.CommunityPostDAO.updatePost",
            dto
        );
    }

    public int deleteCommunityPost(CommunityPostDTO dto) {
        return sqlSession.delete(
            "lx.edu.subwayproject.dao.CommunityPostDAO.deletePost",
            dto
        );
    }
    
    // 게시글 좋아요 (카운트 1 증가)
    public int likeCommunityPost(int postId) {
        return sqlSession.update(
            "lx.edu.subwayproject.dao.CommunityPostDAO.likePost",
            postId
        );
    }
    
    
    
}