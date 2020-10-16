package com.shans.kaluhin.controller;

import com.shans.kaluhin.entity.Order;
import com.shans.kaluhin.entity.User;
import com.shans.kaluhin.entity.enums.OrderStatus;
import com.shans.kaluhin.service.OrderService;
import com.shans.kaluhin.service.UserService;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ManagerServlet")
public class ManagerServlet extends HttpServlet {
    int totalOrders = 6;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = (User) req.getSession().getAttribute("user");
        if (!user.isManager()) {
            resp.sendRedirect(req.getContextPath() + "/orders");
            return;
        }
        pagination(req);
        UserService userService = new UserService();
        List<User> masters = userService.getAllMasters();
        req.setAttribute("masters", masters);
        RequestDispatcher view = req.getRequestDispatcher("/WEB-INF/jsp/manager.jsp");
        view.forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int masterId = Integer.parseInt(req.getParameter("selectedMaster"));
        int orderId = Integer.parseInt(req.getParameter("orderId"));
        int price = Integer.parseInt(req.getParameter("price"));
        OrderService orderService = new OrderService();
        orderService.saveManagerAnswer(price, masterId, orderId);

        resp.sendRedirect(req.getContextPath() + "/ordersList");
    }

    private void pagination(HttpServletRequest req) {
        String spage = req.getParameter("page");
        int page = 1;

        if (spage != null) {
            page = Integer.parseInt(spage);
        }

        int startPosition = page * totalOrders - totalOrders;
        req.setAttribute("page", page);

        filterOrders(req, startPosition);
    }

    private void filterOrders(HttpServletRequest req, int startPosition) {
        List<Order> orders;
        String masterId = req.getParameter("searchByMaster");
        String status = req.getParameter("searchByStatus");

        OrderService orderService = new OrderService();
        if (masterId == null || status == null) {
            orders = orderService.getOrdersByStatus(OrderStatus.VERIFICATION, startPosition, totalOrders);
        } else if (masterId.equals("-1")) {
            if (status.equals("ALL")) {
                orders = orderService.getAllOrders(startPosition, totalOrders);
            } else {
                orders = orderService.getOrdersByStatus(OrderStatus.valueOf(status), startPosition, totalOrders);
            }
        } else if (status.equals("ALL")) {
            orders = orderService.getOrdersByMaster(Integer.parseInt(masterId), startPosition, totalOrders);
        } else {
            orders = orderService.getOrdersByStatusAndMaster(OrderStatus.valueOf(status), Integer.parseInt(masterId), startPosition, totalOrders);
        }

        int nOfPages = orderService.getNumberOfRows() / totalOrders;

        if (nOfPages % totalOrders > 0) {
            nOfPages++;
        }

        req.setAttribute("orders", orders);

        req.setAttribute("nOfPages", nOfPages);
    }
}
