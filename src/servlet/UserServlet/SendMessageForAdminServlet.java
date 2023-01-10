package servlet.UserServlet;
;

import entity.Order;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import service.OrderService;
import util.JspHelper;

import java.io.IOException;

import static util.UrlPath.CANCEL_ORDER_MESSAGE;

@WebServlet(CANCEL_ORDER_MESSAGE)
public class SendMessageForAdminServlet extends HttpServlet {

    OrderService orderService = OrderService.getInstance();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        var orderId = Integer.valueOf(req.getParameter("id"));

        var order = orderService.findOrderById(orderId);
        forwardCheckedExistingOrder(req, resp, order);

//        (order -> {
//            forwardCheckedExistingOrder(req, resp, order);
//        }, () -> {
//            sendError(resp);
//        });
        req.getRequestDispatcher(JspHelper.getPath("checkorder"))
                .forward(req, resp);
    }

    private void sendError(HttpServletResponse resp) {
        resp.setStatus(400);
        try {
            resp.sendError(400, "No orders");
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    private void forwardCheckedExistingOrder(HttpServletRequest req, HttpServletResponse resp, Order order) {
        orderService.sendCancelMessage(order);
        req.setAttribute("orders", orderService.findAll());
        try {
            req.getRequestDispatcher(JspHelper.getPath("orders"))
                    .forward(req, resp);
        } catch (ServletException e) {
            throw new RuntimeException(e);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

}