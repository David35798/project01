package pack.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import pack.model.Order;
import pack.model.OrderItem;
import pack.repository.OrderRepository;
import pack.repository.ProductRepository;

@Service
public class OrderService {

    @Autowired
    private OrderRepository orderRepository;

    @Autowired
    private ProductRepository productRepository;

    public Order createOrder(Order order) {
        double total = 0;
        for (OrderItem item : order.getItems()) {
            var product = productRepository.findById(item.getProductId()).orElseThrow();
            item.setUnitPrice(product.getPrice().doubleValue());
            item.setSubtotal(item.getUnitPrice() * item.getQuantity());
            item.setOrder(order);
            total += item.getSubtotal();
        }
        order.setTotalAmount(total);
        order.setStatus("AWAITING_APPROVAL");
        return orderRepository.save(order);
    }

    public List<Order> getOrdersByUser(Long userId) {
        return orderRepository.findByUserId(userId);
    }
}
