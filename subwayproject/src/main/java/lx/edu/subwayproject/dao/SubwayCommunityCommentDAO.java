package lx.edu.subwayproject.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import lx.edu.subwayproject.dto.CommunityCommentDTO;

@Component
public class SubwayCommunityCommentDAO {

    @Autowired
    private SqlSession sqlSession;

    // 특정 게시글의 댓글 목록 조회
    public List<CommunityCommentDTO> selectCommentListByPostId(int postId) {
        return sqlSession.selectList(
            "lx.edu.subwayproject.dao.CommunityCommentDAO.selectCommentListByPostId",
            postId
        );
    }

    // 댓글 추가
    public void insertCommunityComment(CommunityCommentDTO dto) {
        sqlSession.insert(
            "lx.edu.subwayproject.dao.CommunityCommentDAO.insertComment",
            dto
        );
    }

    // 댓글 수정 (영향받은 행 수 리턴)
    public int updateCommunityComment(CommunityCommentDTO dto) {
        return sqlSession.update(
            "lx.edu.subwayproject.dao.CommunityCommentDAO.updateComment",
            dto
        );
    }

    // 댓글 삭제 (영향받은 행 수 리턴)
    public int deleteCommunityComment(CommunityCommentDTO dto) {
        return sqlSession.delete(
            "lx.edu.subwayproject.dao.CommunityCommentDAO.deleteComment",
            dto
        );
    }
}