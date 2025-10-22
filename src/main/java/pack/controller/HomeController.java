package pack.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HomeController {

    @GetMapping("/")
    public String home() {
        return "서버 정상 작동 중입니다. (Spring Boot 8090)";
    }

    @GetMapping("/api/test")
    public String apiTest() {
        return "API 연결 테스트 성공!";
    }
}
