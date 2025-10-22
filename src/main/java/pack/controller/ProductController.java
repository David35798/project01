package pack.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.List;
import pack.model.Product;
import pack.service.ProductService;

@RestController
@RequestMapping("/api/products")
@CrossOrigin(origins = "*")  // 프론트(React 등)에서 접근 가능하게 허용
public class ProductController {

    @Autowired
    private ProductService productService;

    @GetMapping
    public List<Product> getAllProducts() {
        return productService.getAllProducts();
    }
}
