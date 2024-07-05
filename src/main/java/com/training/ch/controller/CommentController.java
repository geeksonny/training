package com.training.ch.controller;

import com.training.ch.domain.CommentDto;
import com.training.ch.service.CommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;

@RestController
public class CommentController {
    @Autowired
    CommentService service;

    // 댓글을 수정하는 메서드
    @PatchMapping("/comments/{cno}")
    public ResponseEntity<String> modify(@PathVariable Integer cno, @RequestBody CommentDto commentDto, HttpSession session){
        String commenter=(String)session.getAttribute("id");
        commentDto.setCommenter(commenter);
        commentDto.setCno(cno);

        try {
            if(service.modify(commentDto)!=1)
                throw new Exception("Modify Failed");

            return new ResponseEntity<String>("MOD_OK",HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<String>("MOD_ERR",HttpStatus.BAD_REQUEST);
        }
    }
    // 댓글을 등록하는 메서드
    @PostMapping("/comments")   // /ch4/comments?bno=888 POST
    public ResponseEntity<String> write(@RequestBody CommentDto commentDto, Integer bno, HttpSession session){
        String commenter=(String)session.getAttribute("id");
        try {
            if(commenter==null){
                throw new Exception("WTR_ERR");
            }
            commentDto.setCommenter(commenter);
            commentDto.setBno(bno);
            if(service.write(commentDto)!=1)
                throw new Exception("Write Failed");

        return new ResponseEntity<String>("WRT_OK", HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<String>("WRT_ERR",HttpStatus.BAD_REQUEST);
        }
    }

    //지정된 댓글을 삭제하는 메서드
    @DeleteMapping("/comments/{cno}")  // /comments/1 <-- 삭제할 댓글 번호
    public ResponseEntity<String> remove(@PathVariable Integer cno, Integer bno, HttpSession session){
        String commenter = (String)session.getAttribute("id");
        try {
            int rowCnt = service.remove(cno,bno,commenter);
            if(rowCnt!=1)
                throw new Exception("Delete Failed");

            return new ResponseEntity<>("DEL_OK",HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>("DEL_ERR",HttpStatus.BAD_REQUEST);
        }
    }


    //지정된 게시물의 모든 댓글을 가져오는 메서드
    @GetMapping("/comments")    // comments?bno
    public ResponseEntity<List<CommentDto>> list(Integer bno){
        List<CommentDto> list =  null;
        try {
            list = service.getList(bno);
            return new ResponseEntity<List<CommentDto>>(list, HttpStatus.OK);    //200
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<List<CommentDto>>(HttpStatus.BAD_REQUEST); //400
        }
    }

}
