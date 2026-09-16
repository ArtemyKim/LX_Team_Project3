package lx.edu.subwayproject.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import jakarta.servlet.http.HttpSession;
import lx.edu.subwayproject.dto.CommunityCommentDTO;
import lx.edu.subwayproject.dto.CommunityPostDTO;
import lx.edu.subwayproject.dto.UserDTO;
import lx.edu.subwayproject.service.CommunityService;

@Controller
@RequestMapping("/community")
public class CommunityController {

	@Autowired
	CommunityService communityService;

	// 1. 커뮤니티 메인 목록 화면 (전체 게시글 아코디언 리스트 조회)
	@GetMapping("")
	public String communityList(Model model, HttpSession session) {
	    List<CommunityPostDTO> postList = communityService.getPostList();

	    // 게시글마다 댓글 목록을 채워넣기
	    for (CommunityPostDTO post : postList) {
	        post.setCommentList(communityService.getCommentList(post.getPostId()));
	    }

	    model.addAttribute("postList", postList);
	    return "community";
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
	
	// 3. 실제 글 등록 처리 (로그인한 유저의 ID와 이름을 DB에 기록)
	@PostMapping("/write")
	public String writePost(CommunityPostDTO post, HttpSession session) {
		UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");
		
		if (loginUser != null) {
			post.setUserId(loginUser.getUserId());
			post.setUserName(loginUser.getUserName());
			communityService.writePost(post);
		}
		return "redirect:/community"; // 등록 후 다시 목록으로
	}
	
	// 4. 글 수정 처리 (Ajax)
	@PostMapping("/editPost")
	@ResponseBody
	public String editPost(CommunityPostDTO post, HttpSession session) {
	    UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");
	    if (loginUser == null) {
	        return "fail";
	    }
	    post.setUserId(loginUser.getUserId());
	    int result = communityService.updatePost(post);
	    return result > 0 ? "success" : "fail"; // 0건이면 내 글이 아니라는 뜻
	}

	// 5. 글 삭제 (Ajax)
	@GetMapping("/deletePost")
	@ResponseBody
	public String deletePost(@RequestParam("postId") int postId, HttpSession session) {
	    UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");
	    if (loginUser == null) {
	        return "fail";
	    }
	    CommunityPostDTO post = new CommunityPostDTO();
	    post.setPostId(postId);
	    post.setUserId(loginUser.getUserId());
	    int result = communityService.removePost(post);
	    return result > 0 ? "success" : "fail";
	}

	// 6. 댓글 작성 (Ajax) - 지금까지 아예 없던 엔드포인트
	@PostMapping("/submitComment")
	@ResponseBody
	public String submitComment(CommunityCommentDTO comment, HttpSession session) {
	    UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");
	    if (loginUser == null) {
	        return "fail";
	    }
	    comment.setUserId(loginUser.getUserId());
	    comment.setUserName(loginUser.getUserName());
	    communityService.writeComment(comment);
	    return "success";
	}

	// 7. 댓글 삭제 (Ajax)
	@GetMapping("/deleteComment")
	@ResponseBody
	public String deleteComment(@RequestParam("commentId") int commentId, HttpSession session) {
	    UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");
	    if (loginUser == null) {
	        return "fail";
	    }
	    CommunityCommentDTO comment = new CommunityCommentDTO();
	    comment.setCommentId(commentId);
	    comment.setUserId(loginUser.getUserId());
	    int result = communityService.removeComment(comment);
	    return result > 0 ? "success" : "fail";
	}

	// 8. 댓글 수정 (Ajax)
	@PostMapping("/editComment")
	@ResponseBody
	public String editComment(CommunityCommentDTO comment, HttpSession session) {
	    UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");
	    if (loginUser == null) {
	        return "fail";
	    }
	    comment.setUserId(loginUser.getUserId());
	    int result = communityService.updateComment(comment);
	    return result > 0 ? "success" : "fail";
	}
	
	@PostMapping("/likePost")
	@ResponseBody
	public String likePost(@RequestParam("postId") int postId, HttpSession session) {
	    UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");
	    if (loginUser == null) {
	        return "fail";
	    }
	    communityService.likePost(postId);
	    return "success";
	}
	
}