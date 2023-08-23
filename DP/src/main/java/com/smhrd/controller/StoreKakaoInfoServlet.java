package com.smhrd.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.smhrd.dao.MemberDAO;
import com.smhrd.entity.Member;

@WebServlet("/StoreKakaoInfoServlet")
public class StoreKakaoInfoServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
    	 System.out.println("StoreKakaoInfoServlet가 불러와졌나?");
    	
    	request.setCharacterEncoding("UTF-8");
        String nickname = request.getParameter("nickname");
        String email = request.getParameter("email");
        String phone = "phone"; 
        String img = "img"; 
        String pw = "pw"; 
        
        
        
        HttpSession session = request.getSession();
        session.setAttribute("kakaoNickname", nickname);
        session.setAttribute("kakaoEmail", email);
        
        MemberDAO dao = new MemberDAO();
        
        Member existingUser = dao.getMemberByEmail(email);

        if (existingUser == null) {
            Member member = new Member();
            member.setMb_id(email); // Use email as the ID
            member.setMb_pw(pw); // You can generate a random password or leave it empty
            member.setMb_phone(phone); // Set phone number as needed
            member.setMb_nick(nickname); // Set nickname as needed
            member.setMb_img(img); // Set image URL as needed
            dao.insert(member); // Insert the new member into the database using the 'join' method
        }

        // Respond to the AJAX request (optional)
        response.getWriter().write("Data inserted successfully");
        
        // Redirect to the main page
        response.sendRedirect("goMain2.do");
    }
}
