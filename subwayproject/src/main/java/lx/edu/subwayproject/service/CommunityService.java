package lx.edu.subwayproject.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lx.edu.subwayproject.dao.SubwayCommunityCommentDAO;
import lx.edu.subwayproject.dao.SubwayCommunityDAO;
import lx.edu.subwayproject.dto.CommunityCommentDTO;
import lx.edu.subwayproject.dto.CommunityPostDTO;

@Service
public class CommunityService {

    @Autowired
    SubwayCommunityDAO postDao;

    @Autowired
    SubwayCommunityCommentDAO commentDao;


    // ===== 게시글 기능 =====
    public List<CommunityPostDTO> getPostList(){
        return postDao.selectPostList();
    }

    public void writePost(CommunityPostDTO post) {
        postDao.insertCommunityPost(post);
    }

    public int updatePost(CommunityPostDTO post) {
        return postDao.updateCommunityPost(post);
    }

    public int removePost(CommunityPostDTO post) {
        return postDao.deleteCommunityPost(post);
    }

    // 게시글 좋아요
    public int likePost(int postId) {
        return postDao.likeCommunityPost(postId);
    }

    // ===== 댓글 기능 =====
    public List<CommunityCommentDTO> getCommentList(int postId){
        return commentDao.selectCommentListByPostId(postId);
    }

    public void writeComment(CommunityCommentDTO comment) {
        commentDao.insertCommunityComment(comment);
    }

    public int updateComment(CommunityCommentDTO comment) {
        return commentDao.updateCommunityComment(comment);
    }

    public int removeComment(CommunityCommentDTO comment) {
        return commentDao.deleteCommunityComment(comment);
    }
}