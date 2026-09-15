package lx.edu.subwayproject.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import jakarta.servlet.http.HttpSession;
import lx.edu.subwayproject.dto.CommunityCommentDTO;
import lx.edu.subwayproject.dto.CommunityPostDTO;
import lx.edu.subwayproject.dto.UserDTO;
import lx.edu.subwayproject.service.CommunityService;

@Controller
@RequestMapping("/community")
public class CommunityController{

@Autowired
CommunityService communityService;

// 1. 커뮤니티 메인 목록 화면 (아코디언 리스트)

		@GetMapping("/community.do")
		public String communityList(Model model) {
			// DB에서 최신 게시글 목록 가져오기
			List<CommunityPostDTO> postList = communityService.getPostList();
			
			model.addAttribute("postList", postList);
			return "community"; // community.jsp 렌더링
		}
		
		
		// 2. 글 작성 폼으로 이동 (+ 글 추가하기 버튼 클릭 시)
		
		@GetMapping("/write")
		public String writeForm(HttpSession session) {
			// 로그인 안 했으면 로그인 창으로 튕겨냄
			if (session.getAttribute("loginUser") == null) {
				return "redirect:/login";
			}
			return "communityWriteForm"; // 새로 만들 글쓰기 jsp 이름
		}
		
		
		// 3. 실제 글 등록 처리
		
		@PostMapping("/write")
		public String writePost(CommunityPostDTO post, HttpSession session) {
			UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");
			
			if (loginUser != null) {
				post.setUserId(loginUser.getUserId());
				post.setUserName(loginUser.getUserName());
				communityService.writePost(post);
			}
			return "redirect:/community/community.do"; // 등록 후 다시 목록으로
		}
		
		
		// 4. 글 수정 폼으로 이동
		
		@GetMapping("/editPost")
		public String editForm(int postId, Model model, HttpSession session) {
			if (session.getAttribute("loginUser") == null) return "redirect:/login";
			
			return "communityEditForm"; 
		}
		
		// 글 수정
		@PostMapping("/editPost")
		public String editPost(CommunityPostDTO post, HttpSession session) {
			UserDTO loginUser = (UserDTO) session.getAttribute("LoginUser");
			
			if(loginUser != null) {
				post.setUserId(loginUser.getUserId());
				communityService.modifyPost(post);
			}
			return "redirect:/community/community.do";
		}
		
		// 글 삭제
		@GetMapping("/deletePost")
		public String deletePost(int postId, HttpSession session) {
			UserDTO loginUser = (UserDTO) session.getAttribute("LoginUser");
			
			if(loginUser !=null) {
				CommunityPostDTO post = new CommunityPostDTO();
				post.setPostId(postId);
				post.setUserId(loginUser.getUserId());
				communityService.removePost(post);
				
			}
			return "redirect:/community/community.do";
		}
		
		
		// 댓글 등록
		@PostMapping("/submitComment")
		public String submitComment(CommunityCommentDTO comment, HttpSession session) {
			UserDTO loginUser = (UserDTO) session.getAttribute("LoginUser");
			
			if(loginUser != null) {
				comment.setUserId(loginUser.getUserId());
				comment.setUserName(loginUser.getUserName());
				communityService.writeComment(comment);
			}
			return "redirect:/community/community.do";
		}
		
		// 댓글 삭제
		@GetMapping("/deleteComment")
		public String deleteComment(int commentId, HttpSession session) {
			UserDTO LoginUser = (UserDTO) session.getAttribute("LoginUser");
			
			if(LoginUser != null) {
				CommunityCommentDTO comment = new CommunityCommentDTO();
				comment.setCommentId(commentId);
				comment.setUserId(LoginUser.getUserId());
				communityService.removeComment(comment);
				
			}
			
			return "redirect:/community/community.do";
		}
		

}
