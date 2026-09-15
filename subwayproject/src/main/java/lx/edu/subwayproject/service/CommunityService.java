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
	
		
	// 게시글기능
	public List<CommunityPostDTO> getPostList(){
		return postDao.selectPostList();
	}
	
	
	public void writePost(CommunityPostDTO post) {
		postDao.insertCommunityPost(post);
	}
	
	public void modifyPost(CommunityPostDTO post) {
		postDao.updateCommunityPost(post);
	}


	public void removePost(CommunityPostDTO post) {
		postDao.deleteCommunityPost(post);
	}
	
	
	
	
	
	// 댓글기능
	public List<CommunityCommentDTO> getCommentList(int postId){
		return commentDao.selectCommentListByPostId(postId);
	}
	
	public void writeComment(CommunityCommentDTO comment) {
		commentDao.insertCommunityComment(comment);
	}
	
	public void modifyComment(CommunityCommentDTO comment) {
		commentDao.updateCommunityComment(comment);
	}
	
	public void removeComment(CommunityCommentDTO comment) {
		commentDao.deleteCommunityComment(comment);
	}
		
	
	
}
