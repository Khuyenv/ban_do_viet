package com.example.ban_do_viet.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

/**
 * Controller điều hướng giao diện các trang JSP cho dự án Bản đồ Tết Việt
 * Đề tài: C05
 */
@Controller
public class HomeController {

    /**
     * Trang chủ: Bản đồ tương tác Tết Việt Nam
     * URL: / hoặc /index
     */
    @GetMapping({"/", "/index"})
    public String index(Model model) {
        model.addAttribute("pageTitle", "Bản Đồ Tết Việt - Khám Phá Văn Hóa Ba Miền");
        model.addAttribute("activeNav", "home");
        return "index";
    }

    /**
     * Trang So sánh phong tục Tết giữa các miền
     * URL: /compare
     */
    @GetMapping("/compare")
    public String compare(
            @RequestParam(name = "regions", defaultValue = "NORTH,CENTRAL,SOUTH") String regions,
            Model model) {
        model.addAttribute("pageTitle", "Đối Chiếu Văn Hóa Tết Ba Miền - Bắc • Trung • Nam");
        model.addAttribute("activeNav", "compare");
        model.addAttribute("selectedRegions", regions);
        return "compare";
    }
}
