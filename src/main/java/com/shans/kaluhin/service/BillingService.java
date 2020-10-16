package com.shans.kaluhin.service;

import com.shans.kaluhin.DAO.BillingDao;
import com.shans.kaluhin.DAO.UserDao;
import com.shans.kaluhin.entity.Billing;
import com.shans.kaluhin.entity.Order;
import com.shans.kaluhin.entity.User;
import com.shans.kaluhin.entity.enums.OrderStatus;
import org.apache.log4j.Logger;

import java.util.List;

public class BillingService {
    BillingDao billingDao = new BillingDao();
    private final Logger log = Logger.getLogger(UserService.class);
    public String error;

    public List<Billing> getUserBillings(int userId, int startPosition, int total) {
        return billingDao.findUserBilling(userId, startPosition, total);
    }

    public boolean topUpBalance(User user, int sum, String card) {
        user.setBalance(user.getBalance() + sum);
        Billing billing = new Billing();
        billing.setReminder(user.getBalance());
        billing.setUserId(user.getId());
        billing.setCard(card);
        billing.setAmount(sum);

        billingDao.insert(billing);
        UserDao userDao = new UserDao();
        userDao.setVariable("balance", user.getId(), user.getBalance());

        MailSenderService.sendTopUpBalance(user, sum);
        return true;
    }

    public boolean payForOrder(User user, int orderId) {
        OrderService orderService = new OrderService();
        Order order = orderService.getByID(orderId);
        if (user.getId() != order.getUserId()) {
            error = "notUsersOrderError";
            return false;
        }

        int sum = user.getBalance() - order.getPrice();

        if (sum < 0) {
            error = "notEnoughMoneyError";
            return false;
        } else {
            user.setBalance(sum);
            Billing billing = new Billing();
            billing.setOrderId(orderId);
            billing.setUserId(user.getId());
            billing.setAmount(-order.getPrice());
            billing.setReminder(sum);
            billingDao.insert(billing);
            orderService.setOrderStatus(orderId, OrderStatus.PENDING);

            MailSenderService.sendOrderPayment(user, order);
            return true;
        }
    }

    public boolean withdrawBalance(User user, int sum, String card) {
        user.setBalance(user.getBalance() - sum);
        Billing billing = new Billing();
        billing.setReminder(user.getBalance());
        billing.setUserId(user.getId());
        billing.setCard(card);
        billing.setAmount(-sum);

        billingDao.insert(billing);
        UserDao userDao = new UserDao();
        userDao.setVariable("balance", user.getId(), user.getBalance());

        MailSenderService.sendWithdrawBalance(user, sum, card);
        return true;
    }

    public int getNumberOfRows() {
        if (billingDao.totalRows == 0) {
            return 1;
        }
        return billingDao.totalRows;
    }
}
